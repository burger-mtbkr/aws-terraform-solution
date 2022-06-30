using Amazon.Lambda.Core;
using Amazon.SQS;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace CreatorFunction
{
    public class Function
    {
        private readonly string _queueName = Environment.GetEnvironmentVariable("QueueName");
        private readonly string _dlqNName = Environment.GetEnvironmentVariable("DLQName");

        private static AmazonSQSClient _sqsClient = null;

        public Function()
        {
            _sqsClient = new AmazonSQSClient();
        }

        public Function(AmazonSQSClient client)
        {
            _sqsClient = client;
        }

        public async Task FunctionHandler(IEnumerable<MessageSchema> messages, ILambdaContext context)
        {
            var validMessages = await ReadMessages(messages, context);
            if (validMessages?.Any() == true) await ProcessMessages(validMessages, context);
        }

        public async Task<IList<MessageSchema>> ReadMessages(IEnumerable<MessageSchema> messages, ILambdaContext context)
        {
            try
            {
                var dlqUrl = await GetQueueURL(_dlqNName);

                var validMessages = new List<MessageSchema>();

                foreach (var m in messages)
                {
                    switch (m.EventType)
                    {
                        case MessageType.CREATE:
                        case MessageType.UPDATE:
                            {
                                context.Logger.Log($"valid event read {m.EventType}:{m.Message}");
                                validMessages.Add(m);
                            }
                            break;
                        case MessageType.DLQ:
                            {
                                context.Logger.Log($"DLQ event read {m.EventType}:{m.Message}");
                                await _sqsClient.SendMessageAsync(dlqUrl, JsonConvert.SerializeObject(m));
                            }
                            break;
                        case MessageType.ERROR:
                        default:
                            throw new Exception($" {m.EventType} is an invalid event type");
                    }
                }

                return validMessages;
            }
            catch (Exception e)
            {
                context.Logger.Log($"Error: {e.Message}");
                throw;
            }
        }    

        public async Task ProcessMessages(IList<MessageSchema> message, ILambdaContext context)
        {
            var jsonMessage = JsonConvert.SerializeObject(message);

            var sqsUrl = await GetQueueURL(_queueName);

            await _sqsClient.SendMessageAsync(sqsUrl, jsonMessage);
        }

        private async Task<string> GetQueueURL(string queueName)
        {
            var queueUrlResponse = await _sqsClient.GetQueueUrlAsync(queueName);
            return queueUrlResponse.QueueUrl;
        }
    }

    public class MessageSchema
    {
        public string EventType { get; set; }
        public string Message { get; set; }
    }

    public class MessageType
    {
        public const string CREATE = "CREATE";
        public const string UPDATE = "UPDATE";
        public const string DLQ = "DLQ";
        public const string ERROR = "ERROR";
    }
}


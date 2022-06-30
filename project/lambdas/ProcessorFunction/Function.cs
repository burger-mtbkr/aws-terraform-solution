using System;
using System.Text;
using System.Threading.Tasks;
using Amazon.Lambda.Core;
using Amazon.Lambda.SQSEvents;
using Amazon.SimpleNotificationService;
using Amazon.SQS;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace ProcessorFunction
{
    public class Function
    {      
        private static string queueName = Environment.GetEnvironmentVariable("QueueName");    
        private static string topicArn = Environment.GetEnvironmentVariable("JogDayTopicArn");
        private static string emailSubject = "Jog Day SNS EMail";
        private static string emailMessage = "New message from JogDay:";

        private static AmazonSimpleNotificationServiceClient _snsClient = null;
        private static AmazonSQSClient _sqsClient = null;
     
        public Function()
        {
            _sqsClient = new AmazonSQSClient();
            _snsClient = new AmazonSimpleNotificationServiceClient();
        }

        /// <summary>
        /// Constructs an instance with a preconfigured SQS client. This can be used for testing the outside of the Lambda environment.
        /// </summary>
        /// <param name="s3Client"></param>
        public Function(AmazonSQSClient sqs, AmazonSimpleNotificationServiceClient sns)
        {
            _sqsClient = sqs;
            _snsClient = sns;
        }

        public async Task FunctionHandler(SQSEvent evnt, ILambdaContext context)
        {
            foreach (var message in evnt.Records)
            {
                await ProcessMessageAsync(message, context);
            }
        }

        private async Task ProcessMessageAsync(SQSEvent.SQSMessage message, ILambdaContext context)
        {
            context.Logger.LogLine($"Processing message {message.Body}");
  
            await SendMessagesToSnS(message, context);
   
            await DeleteMessages(message, context);

            await Task.CompletedTask;
        }

        /// <summary>
        /// Send Message To SnS
        /// </summary>
        /// <param name="messages"></param>
        /// <returns></returns>
        private async Task SendMessagesToSnS(SQSEvent.SQSMessage message,ILambdaContext context)
        {
            var sb = new StringBuilder();
            sb.AppendLine(emailMessage);

            sb.AppendLine("________________");
            sb.AppendLine(message.Body);
            sb.AppendLine("________________");

            context.Logger.LogLine($"Sending message {message.Body}");
            await _snsClient.PublishAsync(topicArn, sb.ToString(), emailSubject);
        }

        /// <summary>
        /// Get the Url of the SQS Queue
        /// </summary>
        /// <returns></returns>
        private async Task<string> GetURL()
        {
            var queueUrlResponse = await _sqsClient.GetQueueUrlAsync(queueName);
            return queueUrlResponse.QueueUrl;
        }

        /// <summary>
        /// Delete the message from the que
        /// </summary>
        /// <param name="queueUrl"></param>
        /// <param name="message"></param>
        /// <returns></returns>
        private async Task DeleteMessages(SQSEvent.SQSMessage message, ILambdaContext context)
        {
            var queueUrl = await GetURL();
   
            string messageReceiptHandle = message.ReceiptHandle;
          
            context.Logger.LogLine($"Deleting message {message.Body}");
            await _sqsClient.DeleteMessageAsync(queueUrl, messageReceiptHandle);
        }
    }
}

using Amazon.Lambda.Core;
using Amazon.Lambda.SQSEvents;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.SimpleNotificationService;
using Amazon.SQS;
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;


// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace IntergrationFunction
{
	public class Function
    {
        private static string intergrationQueueName = Environment.GetEnvironmentVariable("QueueName");     
        private static string storageBucketName = Environment.GetEnvironmentVariable("StorageBucketName");   

        private static AmazonSQSClient _sqsClient = null;
        private static AmazonS3Client _s3CLient = null;

        public Function()
        {
            _sqsClient = new AmazonSQSClient();
            _s3CLient = new AmazonS3Client();
        }

        public Function(AmazonSQSClient sqs, AmazonSimpleNotificationServiceClient sns, AmazonS3Client s3CLient)
        {
            _sqsClient = sqs;
            _s3CLient = s3CLient;
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
            context.Logger.LogLine($"Processing MessageId {message.MessageId}");       

            await SendMessagesToSS3Bucket(message, context);
      
          //  await DeleteMessages(message, context);

            await Task.CompletedTask;
        }

      

        private async Task SendMessagesToSS3Bucket(SQSEvent.SQSMessage message, ILambdaContext context)
        {
            var messageDate = DateTime.UtcNow.ToShortTimeString();
            var keyName = $"JogDayMessage_{ message.MessageId}-{messageDate}";
            context.Logger.LogLine($"Key: {keyName}");            
            Stream fileStream = null;
  
            try
            {
               
               fileStream = new MemoryStream(Encoding.UTF8.GetBytes(message.Body));
                PutObjectRequest putRequest = new PutObjectRequest
                {
                    BucketName = storageBucketName,
                    Key = keyName,
                    InputStream = fileStream,
                    StorageClass = S3StorageClass.Standard,
                    ServerSideEncryptionMethod = ServerSideEncryptionMethod.AES256
                };

                var response = await _s3CLient.PutObjectAsync(putRequest);
               var  success = (int)response.HttpStatusCode >= 200 && (int)response.HttpStatusCode <= 399;

                if (!success)
                {
                    throw new WebException(
                        $"Error occurred when writing an object with Key = {keyName}, BucketName = {putRequest.BucketName}, " +
                        $"StorageClass = {putRequest.StorageClass.Value}, ServerSideEncryptionMethod = {putRequest.ServerSideEncryptionMethod.Value}" +
                        $": HTTP status code {response.HttpStatusCode} returned from PutObjectRequest.");
                }
            }
            catch (AmazonS3Exception amazonS3Exception)
            {
                string msg;
                if (amazonS3Exception.ErrorCode != null && (amazonS3Exception.ErrorCode.Equals("InvalidAccessKeyId") ||
                                                            amazonS3Exception.ErrorCode.Equals("InvalidSecurity")))
                {
                    msg = "Check the provided AWS Credentials.";
                    context.Logger.LogLine(msg);
                }
                else
                {
                    msg = $"Error occurred when writing an object with key = {keyName}";
                    context.Logger.LogLine(msg);
                }               
            }
            catch (Exception ex)
            {
                string msg = $"Unexpected error trying to upload {keyName} to AWS S3: {ex.Message}";
                context.Logger.LogLine(msg);               
            }
            finally
            {
                fileStream?.Dispose();             
            }
        }

        private async Task<string> GetURL()
        {
            var queueUrlResponse = await _sqsClient.GetQueueUrlAsync(intergrationQueueName);
            return queueUrlResponse.QueueUrl;
        }

        //private async Task DeleteMessages(SQSEvent.SQSMessage message, ILambdaContext context)
        //{
        //    var queueUrl = await GetURL();
        
        //    string messageReceiptHandle = message.ReceiptHandle;

        //    context.Logger.LogLine($"Deleting MessageId {message.MessageId} from Intergration Queue");
        //    await _sqsClient.DeleteMessageAsync(queueUrl, messageReceiptHandle);
        //}
    }
}

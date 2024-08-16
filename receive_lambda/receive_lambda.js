const AWS = require('aws-sdk');
const sqs = new AWS.SQS();

exports.handler = async (event) => {
    const body = JSON.parse(event.body);
   
    const params = {
        QueueUrl: process.env.QUEUE_URL,
        MessageBody: JSON.stringify(body)
    };
   
    try {
        await sqs.sendMessage(params).promise();
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Data received successfully' })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error sending data to SQS', error })
        };
    }
};
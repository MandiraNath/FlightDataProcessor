const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient();

const params = {
    TableName : 'flight-data'
  }
  
  exports.handler = async (event, context) => {
    try {
        const data = await docClient.scan(params).promise()
    return { body: JSON.stringify(data) }
    } catch (err) {
        console.error('Error executing query', err.stack);
        await client.end();
        return {
            statusCode: 500,
            body: JSON.stringify({
                message: 'Internal Server Error'
            }),
        };
    }
};
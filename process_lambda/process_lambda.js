const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient();


exports.handler = async (event) => {
    console.log(event);
    
        const body = JSON.parse(event.body);
        const NUM_OF_RETRIES = 3;
       
        // Processing the message and persist it to the second service
        try {
            // adding persistence data to DB
            const params = {
                TableName : 'flight-data',
                Item: {
                    "id": body.id,
                    "airline": body.airline,
                    "flightNumber": body.flightNumber,
                    "flightDate": body.flightDate,
                    "message": body.message,
                    "version": body.version
                  }
                }
            const data = await docClient.scan(params).promise()
    return { body: JSON.stringify(data) }
            console.log("Successfully created Persisting data:", body);
        } catch (error) {
            console.error("Error while processing persisting data:", error);
            // coe for handle retries or dead-letter queues

        // we will send new message with incremented count, if below retry limit, otherwise exit with status code 200
        // to allow AWS to remove SQS message, but return status message.
        var message = JSON.parse(event.body); // message boody arrives as string JSON
        var retried =  message.retryCount | 0; // we've set batchSize=1 in sls config so it's save to get by index.
        if (retried > NUM_OF_RETRIES-1) {
            const response = "Failed after retries";
            console.log(response);
            callback(null, response);
        } else {
            retried++;
            message.retryCount = retried;

            // send a new message which is a copy of received message but with incremender retry counter.
            var accountId = context.invokedFunctionArn.split(":")[4];
            var dqueueUrl = process.env.DQUEUE_URL;

            var params = {
                MessageBody: JSON.stringify(message),
                QueueUrl: dqueueUrl,
                DelaySeconds: 10
            };

            sqs.sendMessage(params, function (err, data) {
                if (err) {
                    console.log(err);
                    callback( "Failed to retry after error" );
                } else {
                    const response =  "Failed, but will retry " + retried + " time";
                    console.log(response);
                    callback(null,response);
                }

            });
        }
    }


        
    }


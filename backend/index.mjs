
import { DynamoDBClient, GetItemCommand, UpdateItemCommand, PutItemCommand } from '@aws-sdk/client-dynamodb';

// Create DynamoDB client
const dynamoDB = new DynamoDBClient();

export const handler = async (event) => {
    const tableName = "dagmarlewis-table"; 
    const ip = event.requestContext?.identity?.sourceIp || 'unknown';

    if (ip === 'unknown') {
        try {
            const result = await dynamoDB.send(new GetItemCommand({
                TableName: tableName,
                Key: { id: { S: 'visitCount' } }
            }));
            const count = result.Item ? parseInt(result.Item.count.N, 10) : 0;
            return {
                statusCode: 200,
                body: JSON.stringify({ count })
            };
        } catch (error) {
            console.error('Error fetching current count for unknown IP:', error);
            return {
                statusCode: 500,
                body: JSON.stringify({ message: 'Error fetching current count' })
            };
        }
    }

    let isNewVisitor = false;
    try {
        
        await dynamoDB.send(new PutItemCommand({
            TableName: tableName,
            Item: {
                id: { S: ip }, 
                timestamp: { S: new Date().toISOString() }
            },
            ConditionExpression: 'attribute_not_exists(id)'
        }));
        isNewVisitor = true;
    } catch (error) {
        if (error.name === 'ConditionalCheckFailedException') {
            
            isNewVisitor = false;
        } else {
            
            console.error('Error checking/adding visitor IP:', error);
            return {
                statusCode: 500,
                body: JSON.stringify({ message: 'Error processing visitor IP' })
            };
        }
    }

    let finalCount;

    if (isNewVisitor) {
        // If it's a new visitor, atomically increment the global count.
        try {
            const result = await dynamoDB.send(new UpdateItemCommand({
                TableName: tableName,
                Key: { id: { S: 'visitCount' } },
                UpdateExpression: 'ADD #c :val',
                ExpressionAttributeNames: { '#c': 'count' },
                ExpressionAttributeValues: { ':val': { N: '1' } },
                ReturnValues: 'UPDATED_NEW'
            }));
            finalCount = parseInt(result.Attributes.count.N, 10);
        } catch (error) {
            console.error('Error updating visit count:', error);
            return { statusCode: 500, body: JSON.stringify({ message: 'Error updating visit count' }) };
        }
    } else {
        // For returning visitors, just fetch the current count.
        try {
            const result = await dynamoDB.send(new GetItemCommand({ TableName: tableName, Key: { id: { S: 'visitCount' } } }));
            finalCount = result.Item ? parseInt(result.Item.count.N, 10) : 0;
        } catch (error) {
            console.error('Error fetching current count for returning visitor:', error);
            return { statusCode: 500, body: JSON.stringify({ message: 'Error fetching current count' }) };
        }
    }

    // Return the count to the client
    return {
        statusCode: 200,
        body: JSON.stringify({ count: finalCount })
    };
};

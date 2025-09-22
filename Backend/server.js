// index.mjs - Using ES Modules with AWS SDK v3 (Node.js 3.x)
import { DynamoDBClient, GetItemCommand, UpdateItemCommand, PutItemCommand } from '@aws-sdk/client-dynamodb';

// Create DynamoDB client
const dynamoDB = new DynamoDBClient();

export const handler = async (event) => {
    const tableName = "visit-counter-table"; // Your DynamoDB table name

    let currentCount = 0;

    try {
        // Fetch the current count from DynamoDB (the specific row with id: 'visitCount')
        const result = await dynamoDB.send(new GetItemCommand({
            TableName: tableName,
            Key: {
                id: { S: 'visitCount' }  // Fetching the row with id: 'visitCount'
            }
        }));

        if (result.Item) {
            currentCount = parseInt(result.Item.count.N); // Get the current count from the result
        } else {
            // If the item doesn't exist, initialize it with count = 0
            await dynamoDB.send(new PutItemCommand({
                TableName: tableName,
                Item: {
                    id: { S: 'visitCount' },
                    count: { N: '0' }  // Initialize count if it doesn't exist
                }
            }));
        }
    } catch (error) {
        console.error('Error fetching current count:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error fetching current count' })
        };
    }

    // Increment the current count by 1
    const updatedCount = currentCount + 1;

    try {
        // Use an Expression Attribute Name to avoid the reserved keyword "count"
        await dynamoDB.send(new UpdateItemCommand({
            TableName: tableName,
            Key: {
                id: { S: 'visitCount' }  // Update the row with id: 'visitCount'
            },
            UpdateExpression: 'SET #count = :count',
            ExpressionAttributeNames: {
                '#count': 'count'  // Use a placeholder for "count"
            },
            ExpressionAttributeValues: {
                ':count': { N: updatedCount.toString() }
            }
        }));
    } catch (error) {
        console.error('Error updating visit count:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error updating visit count' })
        };
    }

    // Return the updated count to the client (Next.js app)
    return {
        statusCode: 200,
        body: JSON.stringify({ count: updatedCount })
    };
};

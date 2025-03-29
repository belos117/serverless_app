import json
import boto3

# Create a DynamoDB object using the AWS SDK
dynamodb = boto3.resource('dynamodb')
# Use the DynamoDB object to select our table
table = dynamodb.Table('studentData')

# Define the handler function that the Lambda service will use as an entry point
def lambda_handler(event, context):
    # Extract values from the event object we got from the Lambda service and store in variables
    studentid = event['studentid']
    name = event['name']
    programme = event['programme']
    level = event['level']
    
    # Write student data to the DynamoDB table and save the response in a variable
    response = table.put_item(
        Item={
            'studentid': studentid,
            'name': name,
            'programme': programme,
            'level': level
        }
    )
    
    # Return a properly formatted JSON object
    return {
        'statusCode': 200,
        'body': json.dumps('Student data saved successfully!')
    }import json
import boto3
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Create a DynamoDB object using the AWS SDK
dynamodb = boto3.resource('dynamodb')
# Use the DynamoDB object to select our table
table = dynamodb.Table('studentData')

def lambda_handler(event, context):
    try:
        # Log the incoming event for debugging
        logger.info(f"Received event: {json.dumps(event)}")
        
        # Parse the body if it exists
        if 'body' in event:
            body = json.loads(event['body'])
        else:
            body = event  # If no body, use event directly
            
        # Extract values from the body
        student_data = {
            'studentid': body['studentid'],
            'name': body['name'],
            'programme': body['programme'],
            'level': body['level']
        }
        
        # Write to DynamoDB
        response = table.put_item(Item=student_data)
        
        # Return success response
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps('Student data saved successfully!')
        }
        
    except KeyError as e:
        logger.error(f"Missing required field: {str(e)}")
        return {
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps(f'Missing required field: {str(e)}')
        }
        
    except Exception as e:
        logger.error(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps(f'Internal server error: {str(e)}')
        }
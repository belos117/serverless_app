import json
import boto3
import os
from decimal import Decimal

def lambda_handler(event, context):
    try:
        print("Received event:", json.dumps(event))  # Log the incoming event

        # Parse the incoming JSON body from the API Gateway event
        body = json.loads(event['body'])
        
        # Extract values from the parsed JSON
        student_id = body['studentid']
        name = body['name']
        programme = body['programme']
        level = body['level']
        
        # Create DynamoDB resource
        dynamodb = boto3.resource('dynamodb')
        table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])
        
        # Write to DynamoDB
        response = table.put_item(
            Item={
                'studentid': student_id,
                'name': name,
                'programme': programme,
                'level': level
            }
        )
        
        # Return success response with CORS headers
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST,OPTIONS'
            },
            'body': json.dumps({'message': 'Student data saved successfully'})
        }
        
    except Exception as e:
        print(f"Error: {str(e)}")  # This will log to CloudWatch
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST,OPTIONS'
            },
            'body': json.dumps({'error': str(e)})
        }

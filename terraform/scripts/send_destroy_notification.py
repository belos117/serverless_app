import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime

def send_destroy_notification(recipient, environment):
    # Email configuration
    sender_email = os.environ.get('SMTP_USERNAME')
    password = os.environ.get('SMTP_PASSWORD')
    
    if not all([sender_email, password, recipient]):
        raise ValueError("Missing required email configuration")
    
    # Create message
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = recipient
    msg['Subject'] = f"Terraform Destroy Completed - {environment}"
    
    # Create email body
    body = f"""
    Terraform Destroy Notification
    
    Environment: {environment}
    Timestamp: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
    
    All AWS resources have been successfully destroyed.
    
    Resources cleaned up:
    - S3 Buckets, static website content and Cloudtrail logs
    - CloudFront distribution
    - API Gateway endpoints
    - Lambda functions
    - DynamoDB table
    - IAM roles and policies
    - CloudWatch alarms
    - SNS topics
    - Cloudtrail logs
    
    This is an automated message.
    """
    
    msg.attach(MIMEText(body, 'plain'))
    
    # Send email
    try:
        with smtplib.SMTP('smtp.gmail.com', 587) as server:
            server.ehlo()
            server.starttls()
            server.ehlo()
            server.login(sender_email, password)
            server.send_message(msg)
        print("Destroy notification email sent successfully!")
    except Exception as e:
        raise Exception(f"Failed to send destroy notification: {str(e)}")

def main():
    try:
        # Get recipient email
        recipient = os.environ.get('ALARM_EMAIL')
        if not recipient:
            raise ValueError("ALARM_EMAIL environment variable not set")
        
        # Get environment
        environment = os.environ.get('TF_WORKSPACE', 'default')
        
        # Send notification
        send_destroy_notification(recipient, environment)
        
    except Exception as e:
        print(f"Error: {str(e)}")
        exit(1)

if __name__ == "__main__":
    main()
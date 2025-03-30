import json
import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import subprocess

def get_terraform_output():
    try:
        result = subprocess.run(['terraform', 'output', '-json'], 
                              capture_output=True, text=True, check=True)
        outputs = json.loads(result.stdout)
        
        formatted_output = "Terraform Deployment Details:\n\n"
        for key, value in outputs.items():
            formatted_output += f"{key}: {value['value']}\n"
        
        return formatted_output
    except subprocess.CalledProcessError as e:
        raise Exception(f"Failed to get terraform output: {e.stderr}")
    except json.JSONDecodeError as e:
        raise Exception(f"Failed to parse terraform output: {str(e)}")

def send_email(recipient, subject, body):
    # Email configuration
    sender_email = os.environ.get('SMTP_USERNAME')
    password = os.environ.get('SMTP_PASSWORD')
    
    if not all([sender_email, password, recipient]):
        raise ValueError("Missing required email configuration")
    
    # Create message
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = recipient
    msg['Subject'] = subject
    
    # Add body
    msg.attach(MIMEText(body, 'plain'))
    
    # Send email
    try:
        with smtplib.SMTP('smtp.gmail.com', 587) as server:
            server.ehlo()
            server.starttls()
            server.ehlo()
            server.login(sender_email, password)
            server.send_message(msg)
        print("Email sent successfully!")
    except Exception as e:
        raise Exception(f"Failed to send email: {str(e)}")

def main():
    try:
        # Get recipient email
        recipient = os.environ.get('ALARM_EMAIL')
        if not recipient:
            raise ValueError("ALARM_EMAIL environment variable not set")
        
        # Get Terraform output
        tf_output = get_terraform_output()
        
        # Send email
        subject = "Terraform Deployment Details"
        send_email(recipient, subject, tf_output)
        
    except Exception as e:
        print(f"Error: {str(e)}")
        exit(1)

if __name__ == "__main__":
    main()
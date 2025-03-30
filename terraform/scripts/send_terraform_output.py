import json
import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import subprocess

def get_terraform_output():
    # Change to terraform directory
    os.chdir('../terraform')
    
    # Run terraform output command
    result = subprocess.run(['terraform', 'output', '-json'], 
                          capture_output=True, text=True)
    
    if result.returncode != 0:
        raise Exception(f"Failed to get terraform output: {result.stderr}")
    
    # Parse JSON output
    outputs = json.loads(result.stdout)
    
    # Format the output nicely
    formatted_output = "Terraform Deployment Details:\n\n"
    for key, value in outputs.items():
        formatted_output += f"{key}: {value['value']}\n"
    
    return formatted_output

def send_email(recipient, subject, body):
    # Email configuration
    sender = os.environ['SMTP_USERNAME']
    password = os.environ['SMTP_PASSWORD']
    
    # Create message
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = recipient
    msg['Subject'] = subject
    
    # Add body
    msg.attach(MIMEText(body, 'plain'))
    
    # Send email using Gmail SMTP
    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(sender, password)
        server.send_message(msg)
        server.quit()
        print("Email sent successfully!")
    except Exception as e:
        raise Exception(f"Failed to send email: {str(e)}")

if __name__ == "__main__":
    try:
        # Get Terraform output
        tf_output = get_terraform_output()
        
        # Send email
        recipient = os.environ['ALARM_EMAIL']
        subject = "Terraform Deployment Details"
        send_email(recipient, subject, tf_output)
        
    except Exception as e:
        print(f"Error: {str(e)}")
        exit(1)
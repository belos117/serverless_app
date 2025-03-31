# Serverless Student Management System

A secure, scalable serverless application built on AWS for managing student data. The application provides a web interface for saving and retrieving student information, with automated deployment using GitHub Actions and infrastructure as code using Terraform.

### Features

- ✅ Secure static website hosting with CloudFront and HTTPS
- 📝 Hashicorp Backend to store Terraform state files
- 🔒 API Gateway with CORS protection 
- 📝 Student data management (Create & Read operations)
- 📊 Real-time monitoring with CloudWatch
- 🚨 Automated alerts via SNS and E-mail
- 🚀 CI/CD pipeline with GitHub Actions and integrated DevSecOps best practices


### AWS Services Used

- **Amazon S3**: Hosts the static website
- **CloudFront**: Provides secure content delivery
- **API Gateway**: Manages REST API endpoints
- **Lambda**: Runs serverless business logic
- **DynamoDB**: Stores student data
- **CloudWatch**: Monitors application performance
- **SNS**: Handles alarm notifications
- **IAM**: Handles Roles and Policies

## Prerequisites

- AWS Account with administrative access
- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0.0)
- [Python](https://www.python.org/downloads/) (>= 3.12)
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials
- [Hashicorp Cloud](https://app.terraform.io/) for storing terraform state files

## Quick Start

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/serverless_app.git
   cd serverless_app
   ```

2. **Set Up Environment Variables**
   ```bash
   export AWS_ACCESS_KEY_ID="your_access_key"
   export AWS_SECRET_ACCESS_KEY="your_secret_key"
   export AWS_DEFAULT_REGION="us-east-1"
   export TERRAFORM_LOGIN="your_hccloud_token"
   ```

3. **Deploy Infrastructure**
   ```bash
   cd terraform
   terraform init
   terraform apply -auto-approve
   ```

4. **Access the Application**
   - The CloudFront URL will be displayed in the Terraform outputs
   - Use this URL to access the web interface

## Development

### Project Structure
```
.
├── .github/workflows/    # CI/CD pipeline configurations
├── src/                 # Lambda function source code
├── static/              # Web interface files
├── terraform/           # Infrastructure as code
└── tests/              # Unit and integration tests
```

### Adding a New Feature

1. Create a feature branch
2. Make changes and test locally
3. Submit a pull request
4. Automated tests will run via GitHub Actions

## Monitoring and Maintenance

### CloudWatch Dashboards
- Access performance metrics via AWS Console
- Monitor Lambda function execution times
- Track API Gateway requests

### Alerts
- Error rate exceeds threshold
- Lambda function failures
- API Gateway 5XX errors

## Security Features

- 🔐 HTTPS-only access via CloudFront
- 🛡️ Private S3 bucket with CloudFront origin access identity
- 🔒 Least privilege IAM roles
- 🌐 CORS configuration for API endpoints
- 📝 CloudWatch logging and monitoring

## Deployment Pipeline

1. Push to main branch triggers GitHub Actions
2. Automated tests run
3. Infrastructure changes applied via Terraform
4. Lambda functions updated

## Cleanup

Remove all AWS resources:
```bash
cd terraform
terraform destroy -auto-approve
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Support

For issues and feature requests, please create a GitHub issue.

# Serverless Application

This project is a serverless application that allows users to save and view student data using AWS services such as Lambda, API Gateway, DynamoDB, S3, and CloudWatch.

## Project Structure

```
.
├── .github/
│   └── workflows/
│       ├── deploy.yaml
│       └── tfdestroy.yaml
├── src/
│   ├── getStudents.py
│   ├── insertStudentData.py
│   └── test_getStudents.py
├── static/
│   ├── index.html
│   └── scripts.template.js
└── terraform/
    ├── 00-provider.tf
    ├── 01-variables.tf
    ├── 02-s3.tf
    ├── 03-dynamodb.tf
    ├── 04-iam.tf
    ├── 05-lambda.tf
    ├── 06-api.tf
    ├── 07-cloudwatch.tf
    ├── 08-sns.tf
    ├── 09-outputs.tf
    └── main.tf
```

## Prerequisites

- AWS account
- Terraform
- Python 3.12

## Setup

1. **Clone the repository:**

    ```sh
    git clone https://github.com/yourusername/serverless_app.git
    cd serverless_app
    ```

2. **Install dependencies:**

    ```sh
    npm install
    ```

3. **Configure AWS credentials:**

    Set up your AWS credentials in your environment or use the AWS CLI to configure them.

4. **Initialize Terraform:**

    ```sh
    cd terraform
    terraform init
    ```

## Deployment

1. **Deploy the application:**

    ```sh
    terraform apply -auto-approve
    ```

2. **Destroy the application:**

    ```sh
    terraform destroy -auto-approve
    ```

## Usage

- **Save Student Data:**

    Use the form on the static website to save student data.

- **View Student Data:**

    Use the "View all Students" button on the static website to retrieve and display all student data.

## Testing

Run the tests using pytest:

```sh
pytest ./src/
```

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.
```

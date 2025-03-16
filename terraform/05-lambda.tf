# Lambda Function for Inserting Student Data
resource "aws_lambda_function" "insert_student_data" {
  function_name = "insertStudentData"
  handler       = "insertStudentData.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "../src/insertStudentData.zip"

  source_code_hash = filebase64sha256("${path.module}/../src/insertStudentData.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
    }
  }
}

# Lambda Function for Retrieving Student Data
resource "aws_lambda_function" "get_students" {
  function_name = "getStudents"
  handler       = "getStudents.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "../src/getStudents.zip"

  source_code_hash = filebase64sha256("${path.module}/../src/getStudents.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
    }
  }
}
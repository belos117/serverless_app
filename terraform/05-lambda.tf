resource "aws_lambda_function" "insert_student_data" {
  function_name = "insertStudentData"
  handler       = "insertStudentData.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "./src/insertStudentData.zip" # Reference pre-existing ZIP file

  source_code_hash = "./src/insertStudentData.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
    }
  }
}

resource "aws_lambda_function" "get_students" {
  function_name = "getStudents"
  handler       = "getStudents.lambda_handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "./src/getStudents.zip" # Reference pre-existing ZIP file

  source_code_hash = "./src/getStudents.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
    }
  }
}
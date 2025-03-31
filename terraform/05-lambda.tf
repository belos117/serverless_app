resource "aws_lambda_function" "insert_student_data" {
  function_name = var.insert_student_data
  handler       = "${var.insert_student_data}.lambda_handler"
  runtime       = var.runtime
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = var.insert_student_data_hash 

  source_code_hash = var.insert_student_data_hash

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
    }
  }
}

resource "aws_lambda_function" "get_students" {
  function_name = var.get_students
  handler       = "${var.get_students}.lambda_handler"
  runtime       = var.runtime
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = var.get_students_hash 

  source_code_hash = var.get_students_hash

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.student_data.name
    }
  }
}
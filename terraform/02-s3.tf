# S3 Bucket for Static Website
resource "aws_s3_bucket" "static_website" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership_controls" {
  bucket = aws_s3_bucket.static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false // This allows public bucket policies
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership_controls,
    aws_s3_bucket_public_access_block.public_access_block,
  ]

  bucket = aws_s3_bucket.static_website.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "static_website_policy" {
  depends_on = [aws_s3_bucket_public_access_block.public_access_block] // Add this dependency
  bucket     = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      },
    ]
  })
}

resource "aws_s3_bucket_versioning" "static_website_versioning" {
  bucket = aws_s3_bucket.static_website.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Upload HTML file
resource "aws_s3_object" "html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "../static/index.html"
  content_type = "text/html"
}

# Generate JavaScript file with API endpoint
resource "local_file" "scripts_js" {
  content  = <<-EOT
const API_ENDPOINT = "${aws_api_gateway_stage.gateway_stage.invoke_url}/student";

async function getStudents() {
    try {
        const response = await fetch(API_ENDPOINT, {
            method: 'GET'
        });
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error:', error);
    }
}

async function insertStudent(studentData) {
    try {
        const response = await fetch(API_ENDPOINT, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(studentData)
        });
        return await response.json();
    } catch (error) {
        console.error('Error:', error);
    }
}
EOT
  filename = "../static/scripts.js"
}

# Update S3 object for JavaScript file to depend on the generated file
resource "aws_s3_object" "javascript" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "scripts.js"
  source       = local_file.scripts_js.filename
  content_type = "application/javascript"
}
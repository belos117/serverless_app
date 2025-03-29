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

resource "local_file" "index_html" {
  content  = <<-EOT
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Data</title>
    <style>
        body {
            background-color: #f0f0f0; /* Light gray background */
            color: #333; /* Dark gray text */
            font-family: Arial, sans-serif; /* Use Arial font */
        }

        h1 {
            color: #007bff; /* Blue heading text */
        }

        .container {
            max-width: 600px; /* Limit width to 600px */
            margin: 0 auto; /* Center the container */
            padding: 20px; /* Add padding */
            background-color: #fff; /* White background */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Add shadow */
        }

        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #007bff; /* Blue submit button */
            color: #fff; /* White text */
            cursor: pointer; /* Add pointer cursor */
        }

        input[type="submit"]:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2; /* Light gray header background */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Save and View Student Data</h1>
        <label for="studentid">Student ID:</label><br>
        <input type="text" name="studentid" id="studentid"><br>
        
        <label for="name">Name:</label><br>
        <input type="text" name="name" id="name"><br>
        
        <label for="class">Class:</label><br>
        <input type="text" name="class" id="class"><br>
        
        <label for="age">Age:</label><br>
        <input type="text" name="age" id="age"><br>
        
        <br>
        <input type="submit" id="savestudent" value="Save Student Data">
        <p id="studentSaved"></p>
        
        <br>
        <input type="submit" id="getstudents" value="View all Students">
        <br><br>
        <div id="showStudents">
            <table id="studentTable">
                <colgroup>
                    <col style="width:20%">
                    <col style="width:20%">
                    <col style="width:20%">
                    <col style="width:20%">
                </colgroup>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Class</th>
                        <th>Age</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Student data will be displayed here -->
                </tbody>
            </table>
        </div>
    </div>

    <script src="scripts.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
</body>
</html>
EOT
  filename = "../static/index.html"
}

# Upload HTML file
resource "aws_s3_object" "html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = local_file.index_html.filename
  content_type = "text/html"
}

# Generate JavaScript file with API endpoint
resource "local_file" "scripts_js" {
  content  = <<-EOT
const API_ENDPOINT = "${aws_api_gateway_stage.gateway_stage.invoke_url}/student";

// AJAX POST request to save student data
document.getElementById("savestudent").onclick = function(){
    var inputData = {
        "studentid": $('#studentid').val(),
        "name": $('#name').val(),
        "programme": $('#programme').val(),
        "level": $('#level').val()
    };
    $.ajax({
        url: API_ENDPOINT,
        type: 'POST',
        data:  JSON.stringify(inputData),
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            document.getElementById("studentSaved").innerHTML = "Student Data Saved!";
        },
        error: function () {
            alert("Error saving student data.");
        }
    });
}

// AJAX GET request to retrieve all students
document.getElementById("getstudents").onclick = function(){  
    $.ajax({
        url: API_ENDPOINT,
        type: 'GET',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            $('#studentTable tr').slice(1).remove();
            jQuery.each(response, function(i, data) {          
                $("#studentTable").append("<tr> \
                    <td>" + data['studentid'] + "</td> \
                    <td>" + data['name'] + "</td> \
                    <td>" + data['programme'] + "</td> \
                    <td>" + data['level'] + "</td> \
                    </tr>");
            });
        },
        error: function () {
            alert("Error retrieving student data.");
        }
    });
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
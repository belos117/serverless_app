// Add your API endpoint here
var API_ENDPOINT = "${api_endpoint}";

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
            // Clear the form
            $('#studentid').val('');
            $('#name').val('');
            $('#programme').val('');
            $('#level').val('');
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
            alert("Error saving student data: " + error);
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
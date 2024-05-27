<?php
// Connect to the database
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "your_database";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve form data
$date_of_shout = $_POST['date_of_shout'];
// Retrieve other form fields

// Insert data into the database
$sql = "INSERT INTO Shout (date_of_shout, ...) VALUES ('$date_of_shout', ...)";
if ($conn->query($sql) === TRUE) {
    echo "Shout submitted successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>

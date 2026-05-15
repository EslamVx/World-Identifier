<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'world_db';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    echo json_encode(['error' => 'Connection failed']);
    exit;
}

$code = isset($_GET['code']) ? $_GET['code'] : '';

if (empty($code)) {
    echo json_encode(['error' => 'Country code required']);
    exit;
}

$sql = "SELECT id, name, iso2, iso3, capital, population, currency, emoji 
        FROM countries WHERE id = '$code' OR iso2 = '$code'";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $country = $result->fetch_assoc();
    echo json_encode($country, JSON_UNESCAPED_UNICODE);
} else {
    echo json_encode(['error' => 'Country not found']);
}

$conn->close();
?>
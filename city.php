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

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($id == 0) {
    echo json_encode(['error' => 'City ID required']);
    exit;
}

$sql = "SELECT 
            c.id,
            c.name as city_name,
            c.country_id,
            c.country_code,
            c.latitude,
            c.longitude,
            c.population,
            c.timezone,
            co.name as country_name,
            co.emoji as country_emoji,
            co.currency,
            co.currency_symbol,
            co.phonecode as country_phonecode
        FROM cities c
        JOIN countries co ON c.country_id = co.id
        WHERE c.id = $id";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $city = $result->fetch_assoc();
    echo json_encode($city, JSON_UNESCAPED_UNICODE);
} else {
    echo json_encode(['error' => 'City not found']);
}

$conn->close();
?>
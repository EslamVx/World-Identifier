<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

require_once 'db.php';

$code = isset($_GET['code']) ? $_GET['code'] : '';

if (empty($code)) {
    echo json_encode(['error' => 'Country code required']);
    exit;
}

$code = $conn->real_escape_string($code);

$sql = "SELECT 
            id, 
            name, 
            population
        FROM cities 
        WHERE country_code = '$code'
        ORDER BY population DESC
        LIMIT 20";

$result = $conn->query($sql);
$cities = [];

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $cities[] = $row;
    }
}

echo json_encode($cities, JSON_UNESCAPED_UNICODE);
$conn->close();
?>
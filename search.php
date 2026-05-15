<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

require_once 'db.php';

$query = isset($_GET['q']) ? $_GET['q'] : '';

if (empty($query)) {
    echo json_encode([]);
    exit;
}

$search = $conn->real_escape_string($query);
$results = [];

$sqlCountries = "SELECT 
                    id, 
                    name, 
                    iso2 as code, 
                    'country' as type,
                    emoji,
                    capital
                FROM countries 
                WHERE name LIKE '%$search%' 
                   OR iso2 LIKE '%$search%'
                LIMIT 5";
$countryResult = $conn->query($sqlCountries);
if ($countryResult) {
    while ($row = $countryResult->fetch_assoc()) {
        $results[] = $row;
    }
}

$sqlCities = "SELECT 
                c.id,
                c.name,
                c.country_code,
                co.name as country_name,
                co.emoji as country_emoji,
                'city' as type
            FROM cities c
            JOIN countries co ON c.country_id = co.id
            WHERE c.name LIKE '%$search%'
            LIMIT 10";
$cityResult = $conn->query($sqlCities);
if ($cityResult) {
    while ($row = $cityResult->fetch_assoc()) {
        $results[] = $row;
    }
}

echo json_encode($results, JSON_UNESCAPED_UNICODE);
$conn->close();
?>
<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

require_once 'connection_api.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonResponse(['error' => 'Method not allowed'], 405);
}

// Get JSON input
$json_input = file_get_contents('php://input');
$data = json_decode($json_input, true);

if (!$data) {
    jsonResponse(['error' => 'Invalid JSON data'], 400);
}

// Validate required fields
$required_fields = ['name', 'email', 'password'];
foreach ($required_fields as $field) {
    if (empty($data[$field])) {
        jsonResponse(['error' => "Field '$field' is required"], 400);
    }
}

$name = trim($data['name']);
$email = trim($data['email']);
$password = $data['password'];

// Validate email format
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    jsonResponse(['error' => 'Invalid email format'], 400);
}

// Validate password length
if (strlen($password) < 6) {
    jsonResponse(['error' => 'Password must be at least 6 characters'], 400);
}

// Hash password
$password_hash = password_hash($password, PASSWORD_DEFAULT);

try {
    // Check if email already exists
    $stmt = executeQuery("SELECT id FROM users WHERE email = ?", [$email]);
    if ($stmt->fetch()) {
        jsonResponse(['error' => 'Email already exists'], 409);
    }

    // Insert new user
    $stmt = executeQuery(
        "INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)",
        [$name, $email, $password_hash]
    );

    jsonResponse([
        'success' => true,
        'message' => 'Registration successful',
        'user_id' => $conn->lastInsertId()
    ], 201);

} catch(PDOException $e) {
    jsonResponse(['error' => 'Registration failed: ' . $e->getMessage()], 500);
}
?>

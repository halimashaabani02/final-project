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
$required_fields = ['email', 'password'];
foreach ($required_fields as $field) {
    if (empty($data[$field])) {
        jsonResponse(['error' => "Field '$field' is required"], 400);
    }
}

$email = trim($data['email']);
$password = $data['password'];

// Validate email format
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    jsonResponse(['error' => 'Invalid email format'], 400);
}

try {
    // Find user by email
    $stmt = executeQuery("SELECT id, name, email, password_hash FROM users WHERE email = ?", [$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        jsonResponse(['error' => 'Invalid email or password'], 401);
    }

    // Verify password
    if (!password_verify($password, $user['password_hash'])) {
        jsonResponse(['error' => 'Invalid email or password'], 401);
    }

    // Remove password hash from response
    unset($user['password_hash']);

    // Return success with user data
    jsonResponse([
        'success' => true,
        'message' => 'Login successful',
        'user' => $user
    ], 200);

} catch(PDOException $e) {
    jsonResponse(['error' => 'Login failed: ' . $e->getMessage()], 500);
}
?>

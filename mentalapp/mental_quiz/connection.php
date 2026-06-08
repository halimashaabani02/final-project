<?php
// Database Configuration for WAMP64
define('DB_TYPE', 'sqlite'); // Change to 'mysql' for MySQL
define('SQLITE_DB_PATH', 'mental_health_quiz.db');

// MySQL Configuration (for WAMP64)
define('MYSQL_HOST', 'localhost');
define('MYSQL_USER', 'root');
define('MYSQL_PASS', '');
define('MYSQL_DB', 'mental_health_quiz');

// Create database connection based on DB_TYPE
if (DB_TYPE === 'mysql') {
    try {
        $conn = new PDO("mysql:host=".MYSQL_HOST.";dbname=".MYSQL_DB, MYSQL_USER, MYSQL_PASS);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        die("MySQL connection failed: " . $e->getMessage());
    }
} else {
    // SQLite connection (default)
    try {
        $conn = new PDO('sqlite:'.SQLITE_DB_PATH);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        die("SQLite connection failed: " . $e->getMessage());
    }
}

// Helper function for database queries
function executeQuery($sql, $params = []) {
    global $conn;
    try {
        $stmt = $conn->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    } catch(PDOException $e) {
        die("Query failed: " . $e->getMessage());
    }
}
?>

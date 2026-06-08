<?php
// Database Configuration Settings for WAMP64
// Change DB_TYPE to 'mysql' if you want to use MySQL instead of SQLite

// Database Type: 'sqlite' or 'mysql'
define('DB_TYPE', 'sqlite');

// SQLite Configuration
define('SQLITE_DB_PATH', 'mental_health_quiz.db');

// MySQL Configuration (for WAMP64)
define('MYSQL_HOST', 'localhost');
define('MYSQL_USER', 'root');
define('MYSQL_PASS', '');
define('MYSQL_DB', 'mental_health_quiz');

// Application Settings
define('APP_NAME', 'Mental Health Quiz');
define('APP_VERSION', '1.0');
define('TIMEZONE', 'Africa/Dar_es_Salaam');

// Set timezone
date_default_timezone_set(TIMEZONE);

// Error Reporting Settings
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Security Settings
define('HASH_ALGO', PASSWORD_DEFAULT);
define('SESSION_LIFETIME', 3600); // 1 hour

// Database Connection Helper
function getDatabaseConfig() {
    return [
        'type' => DB_TYPE,
        'sqlite' => [
            'path' => SQLITE_DB_PATH
        ],
        'mysql' => [
            'host' => MYSQL_HOST,
            'user' => MYSQL_USER,
            'pass' => MYSQL_PASS,
            'database' => MYSQL_DB
        ]
    ];
}

// Installation Instructions:
/*
WAMP64 SETUP INSTRUCTIONS:

1. Install WAMP64 on your Windows machine
2. Start WAMP64 services (Apache + MySQL)
3. Place this mental_quiz folder in: C:\wamp64\www\
4. Access via: http://localhost/mental_quiz/

FOR MYSQL SETUP:
1. Open phpMyAdmin (http://localhost/phpmyadmin/)
2. Create database: mental_health_quiz
3. Change DB_TYPE to 'mysql' in config.php
4. Run create_db.php to create tables

FOR SQLITE SETUP:
1. Keep DB_TYPE as 'sqlite' (default)
2. Run create_db.php to create database and tables
3. No additional setup required

FILE PERMISSIONS:
- Ensure write permissions for the web server on the mental_quiz folder
- SQLite database file will be created automatically
*/
?>

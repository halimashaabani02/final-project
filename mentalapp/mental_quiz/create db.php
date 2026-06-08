<?php
include "connection.php";

try {
    // Create questions table
    if (DB_TYPE === 'mysql') {
        $sql = "CREATE TABLE IF NOT EXISTS questions (
            id INT AUTO_INCREMENT PRIMARY KEY,
            question TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )";
    } else {
        $sql = "CREATE TABLE IF NOT EXISTS questions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question TEXT NOT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        )";
    }
    executeQuery($sql);

    // Create answers table
    if (DB_TYPE === 'mysql') {
        $sql = "CREATE TABLE IF NOT EXISTS answers (
            id INT AUTO_INCREMENT PRIMARY KEY,
            question_id INT NOT NULL,
            answer TEXT NOT NULL,
            is_correct TINYINT(1) NOT NULL DEFAULT 0,
            FOREIGN KEY (question_id) REFERENCES questions(id)
        )";
    } else {
        $sql = "CREATE TABLE IF NOT EXISTS answers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question_id INTEGER NOT NULL,
            answer TEXT NOT NULL,
            is_correct INTEGER NOT NULL DEFAULT 0,
            FOREIGN KEY (question_id) REFERENCES questions(id)
        )";
    }
    executeQuery($sql);

    // Create results table
    if (DB_TYPE === 'mysql') {
        $sql = "CREATE TABLE IF NOT EXISTS results (
            id INT AUTO_INCREMENT PRIMARY KEY,
            score INT NOT NULL,
            total INT NOT NULL,
            user_name VARCHAR(100),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )";
    } else {
        $sql = "CREATE TABLE IF NOT EXISTS results (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER NOT NULL,
            total INTEGER NOT NULL,
            user_name TEXT,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        )";
    }
    executeQuery($sql);

    // Create users table for mental health tracking
    if (DB_TYPE === 'mysql') {
        $sql = "CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(50) UNIQUE NOT NULL,
            email VARCHAR(100) UNIQUE NOT NULL,
            password_hash VARCHAR(255) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )";
    } else {
        $sql = "CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE NOT NULL,
            email TEXT UNIQUE NOT NULL,
            password_hash TEXT NOT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        )";
    }
    executeQuery($sql);

    // Insert sample mental health questions
    $sampleQuestions = [
        "How often have you been feeling down or depressed in the past two weeks?",
        "Do you find it difficult to enjoy activities that you used to find pleasurable?",
        "How often do you experience anxiety or worry about daily situations?",
        "Do you have trouble sleeping or staying asleep through the night?",
        "How would you rate your overall stress level on a scale of 1-10?"
    ];

    foreach ($sampleQuestions as $index => $question) {
        $sql = "INSERT OR IGNORE INTO questions (question) VALUES (?)";
        if (DB_TYPE === 'mysql') {
            $sql = "INSERT IGNORE INTO questions (question) VALUES (?)";
        }
        executeQuery($sql, [$question]);
    }

    // Insert sample answers for each question
    $sampleAnswers = [
        1 => [
            ["Never", 0], ["Rarely", 0], ["Sometimes", 1], ["Often", 1], ["Always", 1]
        ],
        2 => [
            ["Not at all", 0], ["A little bit", 0], ["Moderately", 1], ["Quite a bit", 1], ["Extremely", 1]
        ],
        3 => [
            ["Never", 0], ["Occasionally", 0], ["Sometimes", 1], ["Frequently", 1], ["Constantly", 1]
        ],
        4 => [
            ["Never", 0], ["Rarely", 0], ["Sometimes", 1], ["Often", 1], ["Every night", 1]
        ],
        5 => [
            ["1-2 (Very low)", 0], ["3-4 (Low)", 0], ["5-6 (Moderate)", 1], ["7-8 (High)", 1], ["9-10 (Very high)", 1]
        ]
    ];

    foreach ($sampleAnswers as $questionId => $answers) {
        foreach ($answers as $answer) {
            $sql = "INSERT OR IGNORE INTO answers (question_id, answer, is_correct) VALUES (?, ?, ?)";
            if (DB_TYPE === 'mysql') {
                $sql = "INSERT IGNORE INTO answers (question_id, answer, is_correct) VALUES (?, ?, ?)";
            }
            executeQuery($sql, [$questionId, $answer[0], $answer[1]]);
        }
    }

    echo "<h2>✅ Database na tables zimetengenezwa kwa mafanikio!</h2>";
    echo "<p>Aina ya database: " . (DB_TYPE === 'mysql' ? 'MySQL' : 'SQLite') . "</p>";
    echo "<p>Swali zimeongezwa: " . count($sampleQuestions) . "</p>";
    echo "<p><a href='quiz.php'>Anza Quiz</a></p>";

} catch(Exception $e) {
    echo "<h2>❌ Error: " . $e->getMessage() . "</h2>";
}
?>

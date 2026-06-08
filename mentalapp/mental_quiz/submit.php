<?php
include "connection.php";

$score = 0;
$total = 0;
$user_name = isset($_POST['user_name']) ? $_POST['user_name'] : 'Anonymous';

try {
    // Get all questions
    $questions = executeQuery("SELECT * FROM questions ORDER BY id");
    
    while ($q = $questions->fetch()) {
        $qid = $q['id'];
        $total++;

        if (isset($_POST['q'.$qid])) {
            if ($_POST['q'.$qid] == 1) {
                $score++;
            }
        }
    }

    // Save result to database
    $sql = "INSERT INTO results (score, total, user_name) VALUES (?, ?, ?)";
    executeQuery($sql, [$score, $total, $user_name]);

    // Redirect to result page
    header("Location: result.php?score=$score&total=$total&user=" . urlencode($user_name));
    exit();

} catch(Exception $e) {
    echo "<h2>❌ Error: " . $e->getMessage() . "</h2>";
    echo "<p><a href='quiz.php'>Rudi kwa Quiz</a></p>";
}
?>


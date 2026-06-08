
<?php include "connection.php"; ?>

<!DOCTYPE html>
<html lang="sw">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mental Health Quiz</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
        .question { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
        .answers { margin: 10px 0; }
        .answer { margin: 5px 0; }
        .submit-btn { background: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
        .submit-btn:hover { background: #45a049; }
        .user-info { background: #f9f9f9; padding: 10px; margin-bottom: 20px; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>🧠 Mental Health Assessment Quiz</h1>
    <p>Jibu maswali yafuatayo kwa kuonesha hali yako ya kiafya ya akili.</p>

    <form action="submit.php" method="POST">
        <div class="user-info">
            <label for="user_name">Jina lako (Optional):</label><br>
            <input type="text" id="user_name" name="user_name" placeholder="Andika jina lako">
        </div>

        <?php
        try {
            $questions = executeQuery("SELECT * FROM questions ORDER BY id");
            
            while ($q = $questions->fetch()) {
                echo "<div class='question'>";
                echo "<h3>Swali #" . $q['id'] . ": " . htmlspecialchars($q['question']) . "</h3>";
                
                $answers = executeQuery("SELECT * FROM answers WHERE question_id = ? ORDER BY id", [$q['id']]);
                
                echo "<div class='answers'>";
                while ($a = $answers->fetch()) {
                    echo "<div class='answer'>";
                    echo "<input type='radio' name='q".$q['id']."' value='".$a['is_correct']."' required>";
                    echo "<label>" . htmlspecialchars($a['answer']) . "</label>";
                    echo "</div>";
                }
                echo "</div>";
                echo "</div>";
            }
        } catch(Exception $e) {
            echo "<h2>❌ Error: " . $e->getMessage() . "</h2>";
        }
        ?>

        <br>
        <button type="submit" class="submit-btn">Wasilisha Majibu</button>
    </form>

    <p><a href="create db.php">Tengeneza Database</a> | <a href="view_results.php">Ona Matokeo</a></p>
</body>
</html>



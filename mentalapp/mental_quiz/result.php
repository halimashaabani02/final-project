<?php
$score = $_GET['score'];
$total = $_GET['total'];

echo "<h2>Your Score: $score / $total</h2>";

if ($score < 3) {
    echo "⚠️ You may need mental support";
} else {
    echo "😊 You are doing well";
}
?>

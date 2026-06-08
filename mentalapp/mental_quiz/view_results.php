<?php
include "connection.php";
?>

<!DOCTYPE html>
<html lang="sw">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Results - Mental Health</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 1000px; margin: 0 auto; padding: 20px; }
        .result-card { background: #f9f9f9; padding: 15px; margin: 10px 0; border-radius: 5px; border-left: 4px solid #4CAF50; }
        .result-card.high-risk { border-left-color: #f44336; }
        .result-card.medium-risk { border-left-color: #ff9800; }
        .result-card.low-risk { border-left-color: #4CAF50; }
        .score { font-size: 24px; font-weight: bold; }
        .percentage { font-size: 18px; color: #666; }
        .stats { background: #e3f2fd; padding: 15px; border-radius: 5px; margin: 20px 0; }
        .back-link { background: #2196F3; color: white; padding: 10px 15px; text-decoration: none; border-radius: 5px; }
        .back-link:hover { background: #1976D2; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #4CAF50; color: white; }
        tr:hover { background: #f5f5f5; }
    </style>
</head>
<body>
    <h1>📊 Mental Health Quiz Results</h1>
    
    <?php
    try {
        // Get all results with statistics
        $results = executeQuery("SELECT * FROM results ORDER BY created_at DESC");
        $totalResults = executeQuery("SELECT COUNT(*) as count FROM results")->fetch()['count'];
        
        if ($totalResults > 0) {
            $avgScore = executeQuery("SELECT AVG(score) as avg FROM results")->fetch()['avg'];
            $avgTotal = executeQuery("SELECT AVG(total) as avg FROM results")->fetch()['avg'];
            
            echo "<div class='stats'>";
            echo "<h3>📈 Statistics</h3>";
            echo "<p><strong>Jumla ya Majibu:</strong> $totalResults</p>";
            echo "<p><strong>Wastani wa Score:</strong> " . round($avgScore, 1) . "</p>";
            echo "<p><strong>Wastani wa Maswali:</strong> " . round($avgTotal, 1) . "</p>";
            echo "</div>";
            
            echo "<table>";
            echo "<tr><th>#</th><th>Jina</th><th>Score</th><th>Jumla</th><th>%</th><th>Hali</th><th>Tarehe</th></tr>";
            
            $counter = 1;
            while ($result = $results->fetch()) {
                $percentage = round(($result['score'] / $result['total']) * 100, 1);
                $riskLevel = '';
                $riskClass = '';
                
                if ($percentage < 40) {
                    $riskLevel = '⚠️ High Risk';
                    $riskClass = 'high-risk';
                } elseif ($percentage < 70) {
                    $riskLevel = '⚡ Medium Risk';
                    $riskClass = 'medium-risk';
                } else {
                    $riskLevel = '✅ Low Risk';
                    $riskClass = 'low-risk';
                }
                
                echo "<tr>";
                echo "<td>" . $counter++ . "</td>";
                echo "<td>" . htmlspecialchars($result['user_name'] ?? 'Anonymous') . "</td>";
                echo "<td class='score'>" . $result['score'] . "</td>";
                echo "<td>" . $result['total'] . "</td>";
                echo "<td class='percentage'>" . $percentage . "%</td>";
                echo "<td>" . $riskLevel . "</td>";
                echo "<td>" . date('M j, Y H:i', strtotime($result['created_at'])) . "</td>";
                echo "</tr>";
            }
            
            echo "</table>";
        } else {
            echo "<p>❌ Hakuna matokeo yaliyopatikana. <a href='quiz.php'>Anza Quiz</a></p>";
        }
        
    } catch(Exception $e) {
        echo "<h2>❌ Error: " . $e->getMessage() . "</h2>";
    }
    ?>
    
    <br>
    <a href="quiz.php" class="back-link">← Rudi kwa Quiz</a> |
    <a href="create db.php">Tengeneza Database</a>
    
    <br><br>
    <div style="background: #fff3cd; padding: 15px; border-radius: 5px; border-left: 4px solid #ffc107;">
        <h3>📋 Maelezo ya Risk Level</h3>
        <ul>
            <li><strong>High Risk (0-40%):</strong> Unahitaji msaada wa kiafya ya akili haraka</li>
            <li><strong>Medium Risk (40-70%):</strong> Chunguza na pata msaada ikiwa unahitaji</li>
            <li><strong>Low Risk (70-100%):</strong> Hali yako ni nzuri, endelea kujali afya yako</li>
        </ul>
    </div>
</body>
</html>

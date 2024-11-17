<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$competitor = $_GET['competitor'] ?? '';
$style = $_GET['style'] ?? '';
$judge = $_GET['judge'] ?? '';
$competition = $_GET['competition'] ?? ''; // This will be a comma-separated string of competition names
$scoreSearch = $_GET['score'] ?? ''; // Represents the score being searched for

// Split competition parameter into an array if it is not empty
$competitionFilter = !empty($competition) ? explode(',', $competition) : [];
$judgeFilter = !empty($judge);

// SQL query construction
$sql = "
    SELECT 
        scores.people_id, 
        style.id AS style_id,
        comp.id AS comp_id,
        people.name AS person_name,
        style.name AS style_name,
        comp.name AS comp_name,
        " . ($judgeFilter ? "scores.score AS judge_score," : "AVG(scores.score) AS avg_score,") . "
        judges.name AS judge_name
    FROM 
        scores
    LEFT JOIN 
        people ON scores.people_id = people.id
    LEFT JOIN 
        style ON scores.style_id = style.id
    LEFT JOIN 
        comp ON scores.comp_id = comp.id
    LEFT JOIN 
        judges ON scores.judge_id = judges.id
    WHERE 
        style.name LIKE ? " . 
        (count($competitionFilter) > 0 ? "AND comp.name IN (" . implode(',', array_fill(0, count($competitionFilter), '?')) . ")" : "") . "
        " . ($judgeFilter ? "AND judges.name LIKE ?" : "") . "
    " . ($judgeFilter ? "" : "GROUP BY scores.people_id, style.id, comp.id") . "
    ORDER BY 
        style.id, comp.id, " . ($judgeFilter ? "scores.score ASC" : "avg_score ASC");

$stmt = $conn->prepare($sql);

// Bind parameters for each filter
$params = ["%$style%"];
if (count($competitionFilter) > 0) {
    foreach ($competitionFilter as $comp) {
        $params[] = trim($comp); // Add each competition name
    }
}
if ($judgeFilter) {
    $params[] = "%$judge%";
}

// Dynamically bind parameters
$stmt->bind_param(str_repeat('s', count($params)), ...$params);

if (!$stmt->execute()) {
    error_log("Query execution failed: " . $stmt->error);
    die("An error occurred while executing the query.");
}

$result = $stmt->get_result();
$rankings = [];
$currentStyleComp = null;
$rank = 1;

// Calculate ranks if no specific judge is searched
if (!$judgeFilter) {
    while ($row = $result->fetch_assoc()) {
        $styleCompKey = $row['style_name'] . $row['comp_name'];
        if ($currentStyleComp !== $styleCompKey) {
            $currentStyleComp = $styleCompKey;
            $rank = 1;
        }
        $row['placement'] = $rank;
        $rankings[] = $row;
        $rank++;
    }
} else {
    while ($row = $result->fetch_assoc()) {
        $row['placement'] = $row['judge_score'];
        $rankings[] = $row;
    }
}

// Final filtering based on competitor name and score
$data = array_filter($rankings, function($entry) use ($competitor, $scoreSearch, $judgeFilter) {
    $nameMatches = empty($competitor) || stripos($entry['person_name'], $competitor) !== false;
    $scoreMatches = empty($scoreSearch) || ($judgeFilter ? $entry['placement'] == $scoreSearch : $entry['placement'] == $scoreSearch);
    return $nameMatches && $scoreMatches;
});

echo json_encode(array_values($data));

$stmt->close();
$conn->close();
?>

SELECT People.name, Judges.name, Style.name, Scores.score
FROM Scores
JOIN Judges ON Scores.judge_id = Judges.id
JOIN People ON Scores.people_id = People.id
JOIN Style ON Scores.style_id = Style.id
WHERE Judges.name LIKE '%Curtis%'
AND People.name LIKE '%Eythan%';
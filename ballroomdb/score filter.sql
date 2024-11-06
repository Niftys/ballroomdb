SELECT People.name, Judges.name, Style.name, Scores.score, Comp.name
FROM Scores
JOIN Judges ON Scores.judge_id = Judges.id
JOIN People ON Scores.people_id = People.id
JOIN Style ON Scores.style_id = Style.id
JOIN Comp ON Scores.comp_id = Comp.id
WHERE People.name LIKE '%Seth%'
AND Scores.score = 1;
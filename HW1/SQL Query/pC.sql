WITH 
    themes_cnt(name, total_set) AS(
        SELECT themes.name, COUNT(sets.name)
        FROM sets, themes
        WHERE themes.id = sets.theme_id
        GROUP BY themes.id)
SELECT 
    name, total_set as max_set
FROM 
    themes_cnt
WHERE 
    total_set = (
        SELECT MAX(total_set)
        FROM themes_cnt
    );
WITH 
    themes_avg(name, part) AS(
        SELECT themes.name, AVG(sets.num_parts)
        FROM sets, themes
        WHERE themes.id = sets.theme_id
        GROUP BY themes.name)
SELECT 
    name, part as avg_num_parts
FROM 
    themes_avg
ORDER BY
    avg_num_parts
SELECT 
    sets.name as Sets_name,
    themes.name as Themes_name
FROM 
    sets,
    themes
WHERE 
    themes.id = sets.theme_id AND
    sets.year = 2017
SELECT 
    COUNT(set_num) as Num_of_Set,
    year
FROM 
    sets
WHERE 
    year <= 2017 AND
    year >= 1950
GROUP BY 
    year
ORDER BY 
    Num_of_Set DESC
WITH
    color_use(name, num_use) AS(
        SELECT 
            colors.name,
            COUNT(DISTINCT inventory_parts.part_num)
        FROM 
            inventory_parts,
            colors
        WHERE 
            colors.id = inventory_parts.color_id
        GROUP BY 
            colors.id)
SELECT
    colors.name AS colors_name,
    color_use.num_use
FROM
    color_use,
    colors
WHERE 
	colors.name = color_use.name
ORDER BY
    num_use DESC
LIMIT 10;
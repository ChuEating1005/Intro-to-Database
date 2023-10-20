WITH
    -- to count the number of parts in each color and inventory
    quantity(color_name, inventory_id, quantity_sum, part_num) AS(

        SELECT 
            colors.name,
            inventory_id,
            SUM(inventory_parts.quantity),
            inventory_parts.part_num
        FROM 
            inventory_parts JOIN colors ON colors.id = inventory_parts.color_id
        GROUP BY 
            colors.id, inventory_id, inventory_parts.part_num
    ),
    total_quantity(themes_name, color_name, total_quantity) AS(
        SELECT 
            themes.name,
            quantity.color_name,
            SUM(quantity.quantity_sum)
        FROM 
            ((themes JOIN sets ON themes.id = sets.theme_id) 
            JOIN inventories ON sets.set_num = inventories.set_num) 
            JOIN quantity ON inventories.id = quantity.inventory_id
        GROUP BY
            themes.name, quantity.color_name
    )
SELECT
    Origin.themes_name AS Theme_name,
    Origin.color_name AS Most_used_color
FROM
    total_quantity AS Origin
    LEFT OUTER JOIN total_quantity AS Bigger
        ON Origin.themes_name = Bigger.themes_name AND Origin.total_quantity < Bigger.total_quantity
WHERE
    Bigger.themes_name IS NULL
ORDER BY
    Origin.themes_name
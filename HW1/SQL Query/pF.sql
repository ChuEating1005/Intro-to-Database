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
    total_quantity(theme_id, color_name, total_quantity) AS(
        SELECT 
            sets.theme_id,
            quantity.color_name,
            SUM(quantity.quantity_sum)
        FROM 
            (sets JOIN inventories ON sets.set_num = inventories.set_num) 
            JOIN quantity ON inventories.id = quantity.inventory_id
        GROUP BY
            sets.theme_id, quantity.color_name
    )
SELECT
    themes.name AS Theme_name,
    Origin.color_name AS Most_used_color
FROM
    themes,
    total_quantity AS Origin
    LEFT OUTER JOIN total_quantity AS Bigger
        ON Origin.theme_id = Bigger.theme_id AND Origin.total_quantity < Bigger.total_quantity
WHERE
    themes.id = Origin.theme_id AND
    Bigger.theme_id IS NULL
ORDER BY
    themes.name
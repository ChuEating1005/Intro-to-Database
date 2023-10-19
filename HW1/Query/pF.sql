WITH
    quantity(name, id, quantity_sum, part_num) AS(
        SELECT 
            colors.name,
            inventory_id,
            SUM(inventory_parts.quantity),
            inventory_parts.part_num
        FROM 
            inventory_parts,
            colors
        WHERE 
            colors.id = inventory_parts.color_id
        GROUP BY 
            colors.id, inventory_id, inventory_parts.part_num),
    color_use(color_name,  inventory_id, num_use) AS(
        SELECT 
            name,
            id,
            SUM(quantity_sum)
        FROM 
            quantity
        GROUP BY 
            name,
            id),
    set_color_use(set_num, color_name, num_use) AS(
        SELECT 
            set_num,
            color_name,
            num_use
        FROM 
            color_use,
            inventories
        WHERE 
            color_use.inventory_id = inventories.id),
    color_rank(theme_id, color_name, num_use) AS(
        SELECT 
            theme_id,
            color_name,
            SUM(num_use)
        FROM 
            set_color_use, sets
        WHERE 
            set_color_use.set_num = sets.set_num
        GROUP BY 
            theme_id, color_name),
    color_rank_max(theme_id, color_name) AS(
        SELECT 
            theme_id,
            color_name
        FROM
            color_rank
        WHERE
            (theme_id,num_use) in (
                SELECT 
                    theme_id,
                    MAX(num_use)
                FROM 
                    color_rank
                GROUP BY 
                    theme_id))
SELECT
    themes.name,
    color_rank_max.color_name
FROM
    color_rank_max,
    themes
WHERE
    color_rank_max.theme_id = themes.id;

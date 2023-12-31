CREATE TABLE public.colors
(
	id VARCHAR(15),
    name VARCHAR(50),
    rgb CHAR(6),
    is_trans BOOLEAN,
    primary key (id)
);

CREATE TABLE themes
(
	id VARCHAR(15),
    name VARCHAR(100),
    parent_id VARCHAR(15),
    primary key (id)
);

CREATE TABLE sets
(
	set_num VARCHAR(20),
    name VARCHAR(100),
    year INT,
    theme_id VARCHAR(15),
    num_parts INT,
    primary key (set_num),
    foreign key (theme_id) references themes(id)
);

CREATE TABLE public.inventories
(
	id VARCHAR(15),
    version INT,
    set_num VARCHAR(20),
    primary key (id),
    foreign key (set_num) references sets(set_num)
);

CREATE TABLE public.inventory_sets
(
	inventory_id VARCHAR(15),
    set_num VARCHAR(20),
    quantity INT,
    primary key (inventory_id, set_num),
    foreign key (inventory_id) references inventories(id),
    foreign key (set_num) references sets(set_num)
);

CREATE TABLE public.part_categories
(
    id VARCHAR(15),
    name VARCHAR(100),
    primary key (id)
);

CREATE TABLE public.parts
(
    part_num VARCHAR(20),
    name VARCHAR(300),
    part_cat_id VARCHAR(15),
    primary key (part_num),
    foreign key (part_cat_id) references part_categories(id)
);

CREATE TABLE public.inventory_parts
(
    inventory_id VARCHAR(15),
    part_num VARCHAR(20),
    color_id VARCHAR(15),
    quantity INT,
    is_spare BOOLEAN,
    foreign key (inventory_id) references inventories(id),
    foreign key (color_id) references colors(id)
);

COPY public.colors(id, name, rgb, is_trans)
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/colors.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.themes(id,name,parent_id)
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/themes.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.sets(set_num,name,year,theme_id,num_parts)
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/sets.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventories(id, version, set_num) 
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/inventories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_sets(inventory_id, set_num, quantity)
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/inventory_sets.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.part_categories(id, name)
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/part_categories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.parts(part_num, name, part_cat_id)
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/parts.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_parts(inventory_id, part_num, color_id, quantity, is_spare)
FROM '/Library/PostgreSQL/15/bin/HW1_Datas/inventory_parts.csv'
DELIMITER ',' 
CSV HEADER;
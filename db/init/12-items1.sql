CREATE TABLE item_fist
(
    character_id INT PRIMARY KEY,
    damage SMALLINT NOT NULL,

    FOREIGN KEY (character_id) REFERENCES characters (id)
);


CREATE TABLE item_bow
(
    character_id INT PRIMARY KEY,
    damage SMALLINT NOT NULL,
    durability SMALLINT NOT NULL,

    FOREIGN KEY (character_id) REFERENCES characters (id)
);

CREATE TABLE item_sword
(
    character_id INT PRIMARY KEY,
    damage SMALLINT NOT NULL,
    durability SMALLINT NOT NULL,

    FOREIGN KEY (character_id) REFERENCES characters (id)
);


INSERT INTO item_types
VALUES
    ('fist'),
    ('bow'),
    ('sword');

CALL update_item_type_constraint();
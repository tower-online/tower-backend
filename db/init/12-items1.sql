CREATE TABLE item_fist
(
    character_id INT,
    item_id INT,
    damage SMALLINT NOT NULL,

    PRIMARY KEY (character_id, item_id),
    FOREIGN KEY (character_id) REFERENCES characters (id),
    FOREIGN KEY (item_id) REFERENCES character_items (item_id)
);


INSERT INTO item_types
VALUES ('fist');

CALL update_item_type_constraint();
CREATE TABLE item_types
(
    type_name VARCHAR(16) PRIMARY KEY
);


DELIMITER //
CREATE PROCEDURE update_item_type_constraint()
BEGIN
    DECLARE types TEXT;

    -- Get the list of item types as a comma-separated string
    SELECT GROUP_CONCAT(CONCAT('''', type_name, ''''))
    INTO types
    FROM item_types;

    SET @drop_sql = 'ALTER TABLE character_items DROP CONSTRAINT IF EXISTS check_item_type;';
    PREPARE stmt FROM @drop_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET @add_sql = CONCAT('ALTER TABLE character_items ',
                    'ADD CONSTRAINT check_item_type ',
                    'CHECK (item_type IN (', types, '));');
    
    PREPARE stmt FROM @add_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE add_item_type_and_update(IN new_item_type VARCHAR(16))
BEGIN
    DECLARE type_exists INT;

    SELECT COUNT(*) INTO type_exists
    FROM item_types
    WHERE type_name = new_item_type;

    IF type_exists = 0 THEN
        INSERT INTO item_types (type_name) VALUES (new_item_type);

        CALL update_item_type_constraint();

        SELECT CONCAT('New item type "', new_item_type, '" added and constraint updated.') AS result;
    ELSE
        SELECT CONCAT('New item type "', new_item_type, '" already exists.') AS result;
    END IF;
END //
DELIMITER ;
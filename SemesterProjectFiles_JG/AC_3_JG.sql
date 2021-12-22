/*Objective: SP creation script w/call to procedure Utilizes dynamic SQL and includes two input parameters that will be used as WHERE conditions
  Description: */
  USE fp; 
  DELIMITER // 
  CREATE PROCEDURE select_products 
  (
	bike_id		INT,
    bike_cost	INT
  )
  BEGIN 
  DECLARE select_clause VARCHAR(200);
  DECLARE where_clause VARCHAR(200);

SET select_clause = "SELECT bike_id, bike_cost FROM bike_inventory ";
SET where_clause = "WHERE ";

IF bike_id IS NOT NULL THEN 
	SET where_clause = CONCAT(where_clause, "bike_id = '", bike_id, "'");
END IF; 
IF bike_cost IS NOT NULL THEN
	IF where_clause <> "WHERE " THEN
    SET where_clause = CONCAT(where_clause, "bike_cost = '", bike_cost, "'");
    END IF; 
END IF; 
IF where_clause = "WHERE " THEN 
	SET @dynamic_sql = select_clause; 
ELSE 
	SET @dynamic_sql = CONCAT(select_clause, and_clause, where_clause);
END IF; 
PREPARE select_products_statement
	FROM @dynamic_sql; 
EXECUTE select_products_statement; 
DEALLOCATE PREPARE select_products_statement; 
END //
  
  /*Fix this bug where it does not return the bike_id 
   It returns all 121 bike_ids no matter what input -- figure this out!*/
  USE fp; 
  CALL select_products(null, null);
  
  
-- Tarea #1 Segundo Parcial: Disparadores

--Ejercicio #1
CREATE OR REPLACE TRIGGER TAREA_TRIGGER#1 
BEFORE DELETE ON EMPLOYEES 
FOR EACH ROW

BEGIN
    IF :OLD.JOB_ID LIKE '%CLERK%' THEN
        raise_application_error(-20000,'No puedes borrar este job id: '||:OLD.JOB_ID );
    END IF;
END;

--Ejercicio #2
CREATE OR REPLACE TRIGGER TAREA_TRIGGER#2
BEFORE INSERT ON DEPARTMENTS
FOR EACH ROW
DECLARE
    idExists NUMBER;
BEGIN
  SELECT COUNT(DEPARTMENTS.DEPARTMENT_ID)
    INTO idExists
    FROM DEPARTMENTS
    WHERE DEPARTMENTS.DEPARTMENT_ID = :NEW.DEPARTMENT_ID;
    
    IF (idExists = 0) THEN
        IF :NEW.LOCATION_ID IS NULL THEN
            :NEW.LOCATION_ID := 1700;
        END IF;
        
        IF :NEW.MANAGER_ID IS NULL THEN
            :NEW.MANAGER_ID := 200;
        END IF;
    ELSE
        raise_application_error(-20000,'Ya existe el departamento con id: '||:NEW.DEPARTMENT_ID );
    END IF;
END;
INSERT INTO departments (
    department_id,
    department_name,
    manager_id,
    location_id
) VALUES (
    10,
    'admin',
    null,
    null
);


--Ejercicio #3


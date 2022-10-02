--EJERCICIO #1
SET SERVEROUTPUT ON
DECLARE
    Nombre VARCHAR2(50) := 'Andree';
    apellido1 VARCHAR2(50) := 'Hernandez';
    apellido2 VARCHAR2(50) := 'Velasquez';
    nombre_completo VARCHAR2(150);
BEGIN
    nombre_completo := UPPER(SUBSTR(Nombre,1,1)) ||'.'|| UPPER(SUBSTR(apellido1,1,1)) ||'.'|| UPPER(SUBSTR(apellido2,1,1)); 
    dbms_output.put_line('Iniciales: ' || nombre_completo); 
END;

--EJERCICIO #2
SET SERVEROUTPUT ON
DECLARE
    n NUMBER := 1634;

BEGIN
    IF MOD(n, 2) = 0 THEN
      dbms_output.put_line('Par');
    ELSE
      dbms_output.put_line('Impar');
    END IF;
END;

--EJERCICIO #3
SET SERVEROUTPUT ON
DECLARE
    salario_maximo EMPLOYEES.SALARY%TYPE:=0;
BEGIN
    SELECT MAX(SALARY) INTO salario_maximo FROM EMPLOYEES WHERE DEPARTMENT_ID=100;
    dbms_output.put_line(salario_maximo);
END;

--EJERCICIO #4
SET SERVEROUTPUT ON
DECLARE
    departamento EMPLOYEES.DEPARTMENT_ID%TYPE:=10;
    nombre_departamento VARCHAR2(100);
    numero_empleados NUMBER;
BEGIN
    SELECT DEPARTMENT_NAME INTO nombre_departamento FROM DEPARTMENTS WHERE DEPARTMENT_ID=departamento;
    SELECT COUNT(*) INTO numero_empleados FROM EMPLOYEES WHERE DEPARTMENT_ID=departamento;

    dbms_output.put_line(nombre_departamento);
    dbms_output.put_line(numero_empleados);
END;


--EJERCICIO #5
SET SERVEROUTPUT ON
DECLARE
    salario_maximo EMPLOYEES.SALARY%TYPE;
    salario_minimo EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT MAX(SALARY) INTO salario_maximo FROM EMPLOYEES;
    SELECT MIN(SALARY) INTO salario_minimo FROM EMPLOYEES;
    dbms_output.put_line('Salario MAX: ' || salario_maximo);
    dbms_output.put_line('Salario MIN: ' || salario_minimo);
    dbms_output.put_line('Diferencia: ' || (salario_maximo-salario_minimo));
END;

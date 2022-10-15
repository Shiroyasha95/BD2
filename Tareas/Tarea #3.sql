-- EJERCICIO 1 BLOQUES ANONIMOS

--a.
SET SERVEROUTPUT ON;
DECLARE
   -- cursor
  CURSOR c_empleados IS
  SELECT EMPLOYEES.FIRST_NAME,EMPLOYEES.LAST_NAME, EMPLOYEES.SALARY FROM EMPLOYEES;
   -- vars    
   e_nombre EMPLOYEES.FIRST_NAME%type;
   e_apellido EMPLOYEES.LAST_NAME%type;
   e_salario EMPLOYEES.SALARY%type;
BEGIN
   OPEN c_empleados;
    LOOP
        FETCH c_empleados into e_nombre, e_apellido, e_salario;
        IF e_nombre ='Peter' AND e_apellido = 'Tucker' THEN 
            RAISE_APPLICATION_ERROR(-20111,'EL SUELDO DEL JEFE NO ES VISIBLE');
        ELSE
            dbms_output.put_line(e_nombre || ' ' || e_apellido || ' - Sueldo:' || e_salario);
        END IF;
      EXIT WHEN c_empleados%notfound;
      
   END LOOP;
   CLOSE c_empleados;
END;


--b.
SET SERVEROUTPUT ON;
DECLARE
   -- cursor
  CURSOR c_departamentos (p_depid NUMBER) IS
  SELECT DEPARTMENTS.DEPARTMENT_NAME, COUNT(EMPLOYEES.EMPLOYEE_ID) FROM EMPLOYEES LEFT JOIN DEPARTMENTS ON EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID WHERE EMPLOYEES.DEPARTMENT_ID = p_depid GROUP BY DEPARTMENTS.DEPARTMENT_NAME;
   -- vars    
   e_num_empleados NUMBER;
   d_nombre DEPARTMENTS.DEPARTMENT_NAME%type;
BEGIN
   OPEN c_departamentos(10);
        FETCH c_departamentos into d_nombre, e_num_empleados;
        dbms_output.put_line(d_nombre || ' - Empleados:' || e_num_empleados);
      
   CLOSE c_departamentos;
END;

--C.
SET SERVEROUTPUT ON;
DECLARE
   -- cursor
  CURSOR c_empleados IS
  SELECT EMPLOYEES.FIRST_NAME,EMPLOYEES.LAST_NAME, EMPLOYEES.SALARY FROM EMPLOYEES;
   -- vars    
   e_nombre EMPLOYEES.FIRST_NAME%type;
   e_apellido EMPLOYEES.LAST_NAME%type;
   e_salario EMPLOYEES.SALARY%type;
BEGIN
   OPEN c_empleados;
    LOOP
        FETCH c_empleados into e_nombre, e_apellido, e_salario;
        IF  e_salario > 8000 THEN 
            e_salario:= e_salario + e_salario*0.02;
            dbms_output.put_line(e_nombre || ' ' || e_apellido || ' - Sueldo: ' || e_salario);
        ELSIF  e_salario < 8000 THEN
            e_salario:= e_salario + e_salario*0.03;
            dbms_output.put_line(e_nombre || ' ' || e_apellido || ' - Sueldo: ' || e_salario);
        END IF;
      EXIT WHEN c_empleados%notfound;
      
   END LOOP;
   CLOSE c_empleados;
END;

-----------------------------------------------------------------------------------
-- EJERCICIO 2 FUNCIONES
CREATE OR REPLACE FUNCTION CREAR_REGION 
    (REGION IN REGIONS.REGION_NAME%TYPE)
RETURN NUMBER
IS
  ultimo_codigo NUMBER;

    CURSOR c_region IS
    SELECT MAX(REGIONS.REGION_ID) FROM REGIONS;
    
BEGIN    
    OPEN c_region;
        FETCH c_region into ultimo_codigo;
    ultimo_codigo := ultimo_codigo + 1;
    BEGIN
    INSERT INTO regions (
        region_id,
        region_name
    ) VALUES (
        ultimo_codigo
        ,REGION
        
    );
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO se ha encontrado datos');
    WHEN OTHERS THEN 
      dbms_output.put_line('Error Insertando datos!'); 
    END;

   RETURN ultimo_codigo;
   CLOSE c_region;
   
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO se han encontrado datos');
    WHEN OTHERS THEN 
      dbms_output.put_line('Error!'); 
END;


SET SERVEROUTPUT ON;
DECLARE
  n_region REGIONS.REGION_NAME%TYPE;
  codigo NUMBER;
BEGIN
    n_region:='America Central';
    codigo:=CREAR_REGION(n_region);
    DBMS_OUTPUT.PUT_LINE('REGION: ' || n_region || ' Codigo: ' || codigo );
END;



-----------------------------------------------------------------------------------
-- EJERCICIO 3 Procedimientos

--A.
CREATE OR REPLACE PROCEDURE CALCULADORA 
(A IN NUMBER, B IN NUMBER, Operacion IN VARCHAR, Resultado OUT NUMBER)
IS
  OperacionElegida VARCHAR(20);
  operacion_incorrecta exception;

BEGIN
    OperacionElegida := LOWER(Operacion);
    CASE OperacionElegida 
    WHEN 'sumar' THEN Resultado:=A+B;
        dbms_output.put_line('La suma es: '||Resultado);
    WHEN 'restar' THEN Resultado:=A-B;
        dbms_output.put_line('La resta es: '||Resultado);
    WHEN 'multiplicar' THEN Resultado:=A*B;
        dbms_output.put_line('La Multiplicacion es: '||Resultado);
    WHEN 'dividir' THEN Resultado:=A/B;
        dbms_output.put_line('La Division es '||Resultado);
    ELSE
        RAISE operacion_incorrecta;
    END CASE;
    
    EXCEPTION 
    WHEN operacion_incorrecta THEN
        dbms_output.put_line('Por favor elija una operacion correcta. Operaciones: Sumar,Restar,Dividir,Multiplicar.');
    WHEN zero_divide THEN
        dbms_output.put_line('Error Division sobre cero');
END;


SET SERVEROUTPUT ON;
DECLARE
    NumeroA NUMBER:=2;
    NumeroB NUMBER:=0;
    Operacion VARCHAR(20):='dividir';
    RESULTADO NUMBER;
BEGIN
    CALCULADORA(NumeroA,NumeroB,Operacion,RESULTADO);
    DBMS_OUTPUT.PUT_LINE('Calculo Ejecutado. Resultado: ' || RESULTADO );
END;


------------------------------------------------------------------------------------------------------------------------------
-- B.

CREATE TABLE
EMPLOYEES_COPIA
 (EMPLOYEE_ID NUMBER (6,0) PRIMARY KEY,
FIRST_NAME VARCHAR2(20 BYTE),
LAST_NAME VARCHAR2(25 BYTE),
EMAIL VARCHAR2(25 BYTE),
PHONE_NUMBER VARCHAR2(20 BYTE),
HIRE_DATE DATE,
JOB_ID VARCHAR2(10 BYTE),
SALARY NUMBER(8,2),
COMMISSION_PCT NUMBER(2,2),
MANAGER_ID NUMBER(6,0),
DEPARTMENT_ID NUMBER(4,0)
 );

CREATE OR REPLACE PROCEDURE COPIA_TABLA_EMPLEADOS IS
    Tabla VARCHAR2 (30):= 'EMPLOYEES';
BEGIN
    execute immediate 'INSERT INTO EMPLOYEES_COPIA (SELECT * FROM '||Tabla||')';
    DBMS_OUTPUT.PUT_line('Carga Finalizada!');
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO se ha encontrado datos');
    WHEN OTHERS THEN 
      dbms_output.put_line('Error al copiar!'); 
    END;

BEGIN
    copia_tabla_empleados();
END;

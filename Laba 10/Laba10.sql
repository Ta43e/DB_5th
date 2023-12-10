-- Задание 1 --

alter table TEACHER
    add BIRTHDAY date;

alter table TEACHER
    add SALARY NUMBER(10, 3);

SELECT * FROM TEACHER;

declare
    cursor AAA is  select * from TEACHER
    for update;
    result TEACHER%rowtype;
    begin
    open AAA;
    fetch AAA into result;
    while AAA%FOUND
        LOOP
            result.BIRTHDAY :=  TO_DATE(
                   TRUNC(DBMS_RANDOM.VALUE(TO_NUMBER(TO_CHAR(DATE '1975-01-01', 'J')),
                                           TO_NUMBER(TO_CHAR(DATE '2000-12-31', 'J')))),
                   'J'
               );
            UPDATE TEACHER
                SET TEACHER.BIRTHDAY = result.BIRTHDAY,
                TEACHER.SALARY = DBMS_RANDOM.VALUE(999, 3000)
                WHERE CURRENT OF AAA;
                fetch AAA into result;
    end loop;
    CLOSE AAA;
end;

-- Задание 2 --

SELECT
  SUBSTR(TEACHER_NAME, 1, INSTR(TEACHER_NAME, ' '))  ||
  SUBSTR(SUBSTR(TEACHER_NAME, INSTR(TEACHER_NAME, ' ')+1), 1, 1) || '. ' ||
  SUBSTR(SUBSTR(TEACHER_NAME, INSTR(TEACHER_NAME, ' ', 1, 2)+1), 1, 1) || '.' AS "Фамилия И.О"
FROM TEACHER;

-- Задание 3 --

SELECT  TEACHER_NAME, BIRTHDAY  FROM TEACHER WHERE TO_CHAR(BIRTHDAY, 'DAY') = 'ПОНЕДЕЛЬНИК';

-- Задание 4 --

CREATE VIEW BIRTHDAY_NEXT_MONTH AS SELECT TEACHER_NAME, BIRTHDAY FROM TEACHER
WHERE EXTRACT(MONTH FROM BIRTHDAY) = EXTRACT(MONTH FROM ADD_MONTHS(CURRENT_DATE, 1));

SELECT * FROM BIRTHDAY_NEXT_MONTH;
DROP VIEW  BIRTHDAY_NEXT_MONTH;

-- Задание 5 --

CREATE VIEW TeacherBirthdaysCount AS
SELECT EXTRACT(MONTH FROM BIRTHDAY) AS BirthMonth, COUNT(*) AS TeachersCount
FROM TEACHER
GROUP BY EXTRACT(MONTH FROM BIRTHDAY) order by EXTRACT(MONTH FROM BIRTHDAY);

SELECT *  FROM TeacherBirthdaysCount;

DROP VIEW  TeacherBirthdaysCount;

-- Задание 6 --

declare
    cursor JUBILLE IS SELECT * FROM TEACHER;
    result TEACHER%rowtype;
    BEGIN
    FOR result IN JUBILLE
    loop
        IF MOD(EXTRACT(YEAR FROM result.BIRTHDAY) + 1, 5) = 0
            THEN DBMS_OUTPUT.PUT_LINE(result.TEACHER_NAME || ' ' || result.BIRTHDAY);
        end if;
        end loop;
end;

-- Задание 7 --

SELECT * FROM PULPIT;
SELECT * FROM TEACHER;

DECLARE
    CURSOR BUGALTER IS
    SELECT AVG(SALARY) AS AVG_SALARY_PULPIT, TEACHER.PULPIT, FACULTY
    FROM TEACHER join DB_USER.PULPIT P on P.PULPIT = TEACHER.PULPIT
    group by TEACHER.PULPIT, FACULTY order by FACULTY;

    RESULT BUGALTER%ROWTYPE;
    FULL_SALARY_AVG INTEGER;
    COUTROW INTEGER;
    COUTROW_FACULTY INTEGER;
    AVG_SALARY_BY_FACULTY NUMBER(10,3);
    FACULTI_TYPE FACULTY.FACULTY%TYPE;
    BEGIN
    OPEN BUGALTER;
    FULL_SALARY_AVG:= 0;
    COUTROW := 0;
    AVG_SALARY_BY_FACULTY := 0;
    COUTROW_FACULTY := 0;
        FETCH BUGALTER INTO RESULT;
        FACULTI_TYPE := RESULT.FACULTY;
        WHILE BUGALTER%FOUND
            LOOP
                IF FACULTI_TYPE = RESULT.FACULTY THEN
                    COUTROW_FACULTY := COUTROW_FACULTY + 1;
                    AVG_SALARY_BY_FACULTY := AVG_SALARY_BY_FACULTY + RESULT.AVG_SALARY_PULPIT;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('--------------------------');
                    DBMS_OUTPUT.PUT_LINE(FACULTI_TYPE ||' AVG: ' || FLOOR(AVG_SALARY_BY_FACULTY / COUTROW_FACULTY));
                    DBMS_OUTPUT.PUT_LINE('==========================');
                    AVG_SALARY_BY_FACULTY := RESULT.AVG_SALARY_PULPIT;
                    COUTROW_FACULTY := 1;
                end if;
                    DBMS_OUTPUT.PUT_LINE(RESULT.PULPIT ||'AVG: ' || FLOOR(RESULT.AVG_SALARY_PULPIT));
                    FULL_SALARY_AVG := FULL_SALARY_AVG + FLOOR(RESULT.AVG_SALARY_PULPIT);
                    COUTROW := COUTROW + 1;
                FACULTI_TYPE := RESULT.FACULTY;
                FETCH BUGALTER INTO RESULT;

            end loop;
        DBMS_OUTPUT.PUT_LINE('FULL AVG: ' || FLOOR(FULL_SALARY_AVG / COUTROW));
    CLOSE BUGALTER;
    EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;

-- Задание 8 --

DECLARE
    RECL TEACHER%ROWTYPE;
    TYPE ADDRESS IS RECORD
    (
        ADRESS1 VARCHAR2(100),
        ADRESS2 VARCHAR2(100),
        ADRESS3 VARCHAR2(100)
    );
    TYPE PERSON IS RECORD
    (
        CODE TEACHER.TEACHER%TYPE,
        NAME TEACHER.TEACHER_NAME%TYPE,
        HOMEADDRESS ADDRESS
    );
    REC2 PERSON;
    REC3 PERSON;
BEGIN
    RECL.TEACHER := 'СМЛВ';
    RECL.TEACHER_NAME := 'Смелов Владимир Владиславович';

    REC2.CODE := RECL.TEACHER;
    REC2.NAME := RECL.TEACHER_NAME;
    REC2.HOMEADDRESS.ADRESS1 := 'Belarus';
    REC2.HOMEADDRESS.ADRESS2 := 'Minsk';
    REC2.HOMEADDRESS.ADRESS3 := 'Bobruiskaya 25';

    REC3 := REC2;
    DBMS_OUTPUT.PUT_LINE('Code: ' || REC3.CODE);
    DBMS_OUTPUT.PUT_LINE('Name: ' || REC3.NAME);
    DBMS_OUTPUT.PUT_LINE('Address1: ' || REC3.HOMEADDRESS.ADRESS1);
    DBMS_OUTPUT.PUT_LINE('Address2: ' || REC3.HOMEADDRESS.ADRESS2);
    DBMS_OUTPUT.PUT_LINE('Address3: ' || REC3.HOMEADDRESS.ADRESS3);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' ' || SQLERRM);
END;
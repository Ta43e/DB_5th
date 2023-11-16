-- Задание 1 --
BEGIN
    NULL;
END;
-- Задание 2 --

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
end;
-- Задание 3 --

declare
    x number(3) := 19;
    y number(3) := 0;
    z number(3);
begin
    DBMS_OUTPUT.PUT_LINE('x = ' || x || ', y = ' || y);
    z := x / y;
    DBMS_OUTPUT.PUT_LINE('z = ' || z);
exception
    when others
        then dbms_output.put_line('error = ' || sqlerrm || ', error sqlcode = ' || sqlcode);
end;
-- Задание 4 --

declare
    x number(3) := 19;
    y number(3) := 0;
    z number(3);
begin
    DBMS_OUTPUT.PUT_LINE('x = ' || x || ', y = ' || y);
    begin
        z := x / y;
        DBMS_OUTPUT.PUT_LINE('z = ' || z);
    exception
        when others
            then dbms_output.put_line('error = ' || sqlerrm || ', error sqlcode = ' || sqlcode);
    end;
    DBMS_OUTPUT.PUT_LINE('z = ' || z);
end;

-- Задание 5 --
-- (В консоли) show parameter plsql_warnings;
SELECT NAME, VALUE
FROM V$PARAMETER
WHERE NAME = 'plsql_warnings';
-- Задание 6 --
SELECT KEYWORD
FROM V$RESERVED_WORDS
WHERE LENGTH = 1
  AND KEYWORD != 'A';

-- Задание 7 --
SELECT KEYWORD
FROM V$RESERVED_WORDS
WHERE LENGTH > 1
  AND KEYWORD != 'A'
ORDER BY KEYWORD;
-- Задание 8 --
-- (В консоли) show parameter plsql;
SELECT NAME, VALUE
FROM V$PARAMETER
WHERE NAME LIKE 'plsql%';
-- Задание 9-17 --
declare
    n1 number(10) := 21;
    n2 number(10) := 2;
    n3 number(10);
begin
    DBMS_OUTPUT.PUT_LINE('n1 = ' || n1);
    DBMS_OUTPUT.PUT_LINE('n2 = ' || n2);

    n3 := n1 + n2;
    DBMS_OUTPUT.PUT_LINE('Сложение n3 = ' || n3);
    n3 := n1 / n2;
    DBMS_OUTPUT.PUT_LINE('Деление с остатком n3 = ' || n3);

end;
declare
    n4 number(10, 5)  := 123.12;
    n5 number(10, -2) := 154.99;
    n6 number(10, -2) := 123.52;
    n7 number(6, 2)   := 1234.56 ;
begin
    DBMS_OUTPUT.PUT_LINE('n4 = ' || n4);
    DBMS_OUTPUT.PUT_LINE('n5 = ' || n5);
    DBMS_OUTPUT.PUT_LINE('n6 = ' || n6);
    DBMS_OUTPUT.PUT_LINE('n7 = ' || n7);
end;
DECLARE
    binary_float_number  binary_float  := 123456789.21414;
    binary_double_number binary_double := 123.12421541;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Binary float число: ' || binary_float_number);
    DBMS_OUTPUT.PUT_LINE('Binary double число: ' || binary_double_number);
end;

declare
    number_E number(10, 3) := 2E+2;
    b1       boolean       := true;
    b2       boolean       := false;
begin
    DBMS_OUTPUT.PUT_LINE('число с E: ' || number_E);
    IF b1 then DBMS_OUTPUT.PUT_LINE('b1: ' || 'true'); end if;
    IF not b1 then DBMS_OUTPUT.PUT_LINE('b1: ' || 'false'); end if;
    IF b2 then DBMS_OUTPUT.PUT_LINE('b2: ' || 'true'); end if;
    IF not b2 then DBMS_OUTPUT.PUT_LINE('b2: ' || 'false'); end if;
end;


-- Задание 18 --

declare
    const_number  constant number(5)    := 10;
    const_varchar constant varchar2(10) := 'dff';
    const_char    constant char(10)     := 'Oleg';
begin
    DBMS_OUTPUT.PUT_LINE('const_number: ' || const_number);
    DBMS_OUTPUT.PUT_LINE('const_number * 2: ' || const_number * 2);
    DBMS_OUTPUT.PUT_LINE('const_varchar: ' || const_varchar);
    DBMS_OUTPUT.PUT_LINE('const_char: ' || const_char);
end;
-- Задание 19 --
declare
    Name_Teacher TEACHER.TEACHER_NAME%type;
    Name_pulpit  FACULTY%rowtype;
begin
    Name_Teacher := 'Смелов Владимир Владиславович';
    Name_pulpit.FACULTY := 'ТТЛП';
    Name_pulpit.FACULTY_NAME := 'Технология и техника лесной промышленности';
    DBMS_OUTPUT.PUT_LINE('Name_Teacher: ' || Name_Teacher);
    DBMS_OUTPUT.PUT_LINE(RTRIM(Name_pulpit.FACULTY) || ':' || Name_pulpit.FACULTY_NAME);
end;
-- Задание 21-22 --


DECLARE
    number_test_if NUMBER(10) := 10;
BEGIN
    IF number_test_if > 11 THEN
        DBMS_OUTPUT.PUT_LINE('number_test_if > 11: ' || 'true');
    ELSIF number_test_if < 20 THEN
        DBMS_OUTPUT.PUT_LINE('number_test_if < 20: ' || 'true');
    ELSIF number_test_if = 10 THEN
        DBMS_OUTPUT.PUT_LINE('number_test_if = 10: ' || 'true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('None of the conditions are true');
    END IF;
END;

-- Задание 23 --
declare
    case_test number(10) := 10;
begin
    case case_test
        when 1 then DBMS_OUTPUT.PUT_LINE('case_test = 1');
        when 2 then DBMS_OUTPUT.PUT_LINE('case_test = 2');
        when 3 then DBMS_OUTPUT.PUT_LINE('case_test = 3');
        else DBMS_OUTPUT.PUT_LINE('else');
        end case;
    case
        when case_test > 11 then DBMS_OUTPUT.PUT_LINE('case_test > 11');
        when case_test = 11 then DBMS_OUTPUT.PUT_LINE('case_test = 11');
        when case_test < 11 then DBMS_OUTPUT.PUT_LINE('case_test < 11');
        else DBMS_OUTPUT.PUT_LINE('else');
        end case;
end;
-- Задание 24-26 --
DECLARE
    x NUMBER(10) := 1;
BEGIN
    -- First loop
    LOOP
        x := x + 1;
        DBMS_OUTPUT.PUT_LINE('x =' || x);
        EXIT WHEN x > 5;
    END LOOP;

    -- Second loop
    FOR k IN 1..5
        LOOP
            DBMS_OUTPUT.PUT_LINE('k =' || k);
        END LOOP;

    -- Third loop
    WHILE x > 0
        LOOP
            x := x - 1;
            DBMS_OUTPUT.PUT_LINE('x =' || x);
        END LOOP;
END;



declare
    str nvarchar2(2) := '';
begin
    str := 'aad';
    DBMS_OUTPUT.PUT_LINE(str);
exception
    when others
        then DBMS_OUTPUT.PUT_LINE('error' || sqlerrm || ' error code' || sqlcode);
end;
--- 1 ----
declare
    faculty_res FACULTY%rowtype;
begin
    select * into faculty_res from FACULTY WHERE FACULTY = 'ТОВ';
    DBMS_OUTPUT.PUT_LINE( faculty_res.FACULTY || faculty_res.FACULTY_NAME);
end;
--- 2 ----
declare
    a_res A%rowtype;
begin
    select * into a_res from A;
    DBMS_OUTPUT.PUT_LINE( a_res.VA || a_res.NA || a_res.XA);
    exception
        when others
            then DBMS_OUTPUT.PUT_LINE('error:' || SQLERRM || 'error code ' || sqlcode);
end;
--- 3 ----

declare
    pulpit_res PULPIT%rowtype;
begin

    select * into pulpit_res from PULPIT;
    DBMS_OUTPUT.PUT_LINE(pulpit_res.PULPIT_NAME );
    exception
        when too_many_rows
    then DBMS_OUTPUT.PUT_LINE(sqlcode || ' error ' || sqlerrm);
end;
--- 4 ----
declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n integer;
    subject_res SUBJECT%rowtype;
    begin
    select * into subject_res from SUBJECT where SUBJECT = 'СУБД';
    b1 := sql%found;
    b2 := sql%isopen;
    b3 := sql%notfound;
    n := sql%rowcount;

    if b1 then     DBMS_OUTPUT.PUT_LINE('b1 = true');
    else     DBMS_OUTPUT.PUT_LINE('b1 = false');
end if;
    if b2 then     DBMS_OUTPUT.PUT_LINE('b2 = true');
    else     DBMS_OUTPUT.PUT_LINE('b2 = false');
end if;
    if b3 then     DBMS_OUTPUT.PUT_LINE('b3 = true');
    else     DBMS_OUTPUT.PUT_LINE('b3 = false');
end if;
    DBMS_OUTPUT.PUT_LINE(n);
    DBMS_OUTPUT.PUT_LINE(subject_res.SUBJECT);
    exception
        when NO_DATA_FOUND
            then DBMS_OUTPUT.PUT_LINE('error' || sqlerrm || ' ' || sqlcode);
end;

--- 5 ----
select *
from TEACHER;
insert into TEACHER values ('КОД', 'Козак Олег Дмтриевич', 'ИСиТ');
delete from TEACHER where TEACHER like '%?%';

declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n integer;
    begin
    update TEACHER SET TEACHER = 'КОД' WHERE TEACHER = 'КЗК';

    b1 := sql%found;
    b2 := sql%isopen;
    b3 := sql%notfound;
    n := sql%rowcount;
commit ;
--rollback ;
    if b1 then     DBMS_OUTPUT.PUT_LINE('b1 = true');
    else     DBMS_OUTPUT.PUT_LINE('b1 = false');
end if;
    if b2 then     DBMS_OUTPUT.PUT_LINE('b2 = true');
    else     DBMS_OUTPUT.PUT_LINE('b2 = false');
end if;
    if b3 then     DBMS_OUTPUT.PUT_LINE('b3 = true');
    else     DBMS_OUTPUT.PUT_LINE('b3 = false');
end if;
        DBMS_OUTPUT.PUT_LINE(n);
    --rollback ;
    exception
        when others
            then DBMS_OUTPUT.PUT_LINE('error' || sqlerrm || ' ' || sqlcode);
end;


--- 6 ---
select *
from TEACHER;
insert into TEACHER values ('SSS', 'Sозак Sлег Sмтриевич', 'ИСиТ');
delete from TEACHER where TEACHER like '%?%';

declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n integer;
    begin
    update TEACHER SET TEACHER = 'КОД' WHERE TEACHER = 'SSS';
    b1 := sql%found;
    b2 := sql%isopen;
    b3 := sql%notfound;
    n := sql%rowcount;
commit ;
--rollback ;
    if b1 then     DBMS_OUTPUT.PUT_LINE('b1 = true');
    else     DBMS_OUTPUT.PUT_LINE('b1 = false');
end if;
    if b2 then     DBMS_OUTPUT.PUT_LINE('b2 = true');
    else     DBMS_OUTPUT.PUT_LINE('b2 = false');
end if;
    if b3 then     DBMS_OUTPUT.PUT_LINE('b3 = true');
    else     DBMS_OUTPUT.PUT_LINE('b3 = false');
end if;
        DBMS_OUTPUT.PUT_LINE(n);

    --rollback ;
    exception
        when others
            then DBMS_OUTPUT.PUT_LINE('error' || sqlerrm || ' ' || sqlcode);
end;

--- 7-8 ---
declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n integer;
    TEACHES_VAL TEACHER.TEACHER%TYPE := 'WWW';
    TEACHER_NAME_VAL TEACHER.TEACHER_NAME%TYPE := 'Wow Wowa Wowowech';
    PULPIT_VAL TEACHER.PULPIT%TYPE := 'ИСиТ';

    a1_TEACHER TEACHER.TEACHER%TYPE;
    a1_TEACHER_NAME TEACHER.TEACHER_NAME%TYPE;
    a1_PULPIT TEACHER.PULPIT%TYPE;

    begin
    insert into TEACHER values (TEACHES_VAL, TEACHER_NAME_VAL, PULPIT_VAL)
    returning TEACHER, TEACHER_NAME, PULPIT
    into a1_TEACHER, a1_TEACHER_NAME ,a1_PULPIT;
    DBMS_OUTPUT.PUT(a1_TEACHER || ' ' || a1_TEACHER_NAME || ' ' || a1_PULPIT || ' ');
/*    ROLLBACK;*/
/*    COMMIT;*/
    b1 := sql%found;
    b2 := sql%isopen;
    b3 := sql%notfound;
    n := sql%rowcount;

    if b1 then     DBMS_OUTPUT.PUT_LINE('b1 = true');
    else     DBMS_OUTPUT.PUT_LINE('b1 = false');
end if;
    if b2 then     DBMS_OUTPUT.PUT_LINE('b2 = true');
    else     DBMS_OUTPUT.PUT_LINE('b2 = false');
end if;
    if b3 then     DBMS_OUTPUT.PUT_LINE('b3 = true');
    else     DBMS_OUTPUT.PUT_LINE('b3 = false');
end if;
        DBMS_OUTPUT.PUT_LINE(n);

    --rollback ;
/*    commit ;*/
    exception
        when others
       then DBMS_OUTPUT.PUT_LINE('error' || sqlerrm || ' ' || sqlcode);
end;

select * from TEACHER;
delete from TEACHER where TEACHER like '%WWW%';
ROLLBACK ;

--- 9-10 ---- 10 ХЗ

declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n integer;
    TEACHES_VAL TEACHER.TEACHER%TYPE := 'WWW';

    begin
    delete from TEACHER where TEACHER = TEACHES_VAL;
/*    ROLLBACK;*/
/*    COMMIT;*/
    b1 := sql%found;
    b2 := sql%isopen;
    b3 := sql%notfound;
    n := sql%rowcount;

    if b1 then     DBMS_OUTPUT.PUT_LINE('b1 = true');
    else     DBMS_OUTPUT.PUT_LINE('b1 = false');
end if;
    if b2 then     DBMS_OUTPUT.PUT_LINE('b2 = true');
    else     DBMS_OUTPUT.PUT_LINE('b2 = false');
end if;
    if b3 then     DBMS_OUTPUT.PUT_LINE('b3 = true');
    else     DBMS_OUTPUT.PUT_LINE('b3 = false');
end if;
        DBMS_OUTPUT.PUT_LINE(n);

    --rollback ;
    exception
        when others
       then DBMS_OUTPUT.PUT_LINE('error' || sqlerrm || ' ' || sqlcode);
end;

select * from TEACHER;
insert into TEACHER values ('WWW', 'Wозак Wлег Wмтриевич', 'ИСиТ');

--RETURNING--
--- Явные курсоры 11 ---- NO
DECLARE
    CURSOR teacher_cursor IS SELECT TEACHER, TEACHER_NAME, PULPIT FROM TEACHER;
    a1_TEACHER TEACHER.TEACHER%TYPE;
    a1_TEACHER_NAME TEACHER.TEACHER_NAME%TYPE;
    a1_PULPIT TEACHER.PULPIT%TYPE;
BEGIN
    OPEN teacher_cursor;

    LOOP
        FETCH teacher_cursor INTO a1_TEACHER, a1_TEACHER_NAME, a1_PULPIT;
        EXIT WHEN teacher_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(a1_TEACHER || ' ' || a1_TEACHER_NAME || ' ' || a1_PULPIT || ' ');
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(teacher_cursor%rowcount); -- Переместил вывод после цикла FETCH

    CLOSE teacher_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('error ' || sqlerrm);
END;


--- 12 ---- YES
declare
    cursor SUBJECT_cur is select * from SUBJECT;
    RECORD SUBJECT%ROWTYPE;
begin
    OPEN SUBJECT_cur;
    fetch SUBJECT_cur into RECORD;
    WHILE SUBJECT_cur%FOUND
        LOOP
            DBMS_OUTPUT.PUT_LINE(RECORD.SUBJECT || ' ' || RECORD.PULPIT || ' ' || RECORD.SUBJECT_NAME || ' ');
            fetch SUBJECT_cur into RECORD;
        END LOOP;
    CLOSE SUBJECT_cur;
    exception
        when others
        then DBMS_OUTPUT.PUT('error ' || sqlerrm);
end;
--- 13 ---- YES
declare
    cursor RESULT_JOIN_PULPIT_AND_TEACHER is select PULPIT_NAME, TEACHER_NAME from PULPIT join DB_USER.TEACHER T on PULPIT.PULPIT = T.PULPIT;
    RECORD RESULT_JOIN_PULPIT_AND_TEACHER%ROWTYPE;
begin

/*OPEN RESULT_JOIN_PULPIT_AND_TEACHER;*/
    FOR RECORD IN RESULT_JOIN_PULPIT_AND_TEACHER
    LOOP
        DBMS_OUTPUT.PUT_LINE(
                        ' ' || RECORD.PULPIT_NAME ||
                        ' ' || RECORD.TEACHER_NAME);
        end loop;
/*    CLOSE RESULT_JOIN_PULPIT_AND_TEACHER;*/
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;

--- 14 ---- YES
DECLARE
    CURSOR AUDITORIUM_CUR (MIN_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE, MAX_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE)
            IS SELECT AUDITORIUM_NAME, AUDITORIUM_CAPACITY
            FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= MIN_CAPACITY AND AUDITORIUM_CAPACITY <= MAX_CAPACITY;
    RECORD AUDITORIUM_CUR%ROWTYPE;
BEGIN
    OPEN AUDITORIUM_CUR(0, 20);
    FETCH AUDITORIUM_CUR INTO RECORD;
    WHILE AUDITORIUM_CUR%FOUND
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        ' ' || RECORD.AUDITORIUM_NAME ||
        ' ' || RECORD.AUDITORIUM_CAPACITY);
        FETCH AUDITORIUM_CUR INTO RECORD;
    END LOOP;
    CLOSE AUDITORIUM_CUR;
DBMS_OUTPUT.PUT_LINE('------------------------------');
    OPEN AUDITORIUM_CUR(21, 30);
    FETCH AUDITORIUM_CUR INTO RECORD;
    WHILE AUDITORIUM_CUR%FOUND
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        ' ' || RECORD.AUDITORIUM_NAME ||
        ' ' || RECORD.AUDITORIUM_CAPACITY);
        FETCH AUDITORIUM_CUR INTO RECORD;
    END LOOP;
    CLOSE AUDITORIUM_CUR;
DBMS_OUTPUT.PUT_LINE('------------------------------');
    OPEN AUDITORIUM_CUR(31, 60);
    FETCH AUDITORIUM_CUR INTO RECORD;
    WHILE AUDITORIUM_CUR%FOUND
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        ' ' || RECORD.AUDITORIUM_NAME ||
        ' ' || RECORD.AUDITORIUM_CAPACITY);
        FETCH AUDITORIUM_CUR INTO RECORD;
    END LOOP;
    CLOSE AUDITORIUM_CUR;
    OPEN AUDITORIUM_CUR(61, 80);
    FETCH AUDITORIUM_CUR INTO RECORD;
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        ' ' || RECORD.AUDITORIUM_NAME ||
        ' ' || RECORD.AUDITORIUM_CAPACITY);
        FETCH AUDITORIUM_CUR INTO RECORD;
        EXIT WHEN AUDITORIUM_CUR%NOTFOUND;
    END LOOP;
    CLOSE AUDITORIUM_CUR;
DBMS_OUTPUT.PUT_LINE('------------------------------');
        FOR RECORD IN AUDITORIUM_CUR(81, 90)
            LOOP
            DBMS_OUTPUT.PUT_LINE(
            ' ' || RECORD.AUDITORIUM_NAME ||
            ' ' || RECORD.AUDITORIUM_CAPACITY);
            END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;


--- 15 ---- yes
DECLARE
    TYPE TEACH_TYPE IS REF CURSOR RETURN TEACHER%ROWTYPE;
    XCURS TEACH_TYPE;
    RES_TEACHER TEACHER%rowtype;
    BEGIN
    OPEN XCURS FOR SELECT * FROM TEACHER;
    FETCH XCURS INTO RES_TEACHER;
    WHILE (XCURS%FOUND)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
        ' ' || RES_TEACHER.PULPIT ||
        ' ' || RES_TEACHER.TEACHER_NAME);
        FETCH XCURS INTO RES_TEACHER;
        end loop;
    CLOSE XCURS;
    EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
--- 16 ----
declare
    CURSOR TWO_CURSOR(n integer, capacity AUDITORIUM.AUDITORIUM_CAPACITY%TYPE)
        IS SELECT AUDITORIUM_NAME, AUDITORIUM_CAPACITY FROM (
             SELECT * FROM AUDITORIUM
             WHERE AUDITORIUM_CAPACITY > capacity
             order by AUDITORIUM_CAPACITY desc
         )
        where ROWNUM < n;
        RESULT TWO_CURSOR%ROWTYPE;
begin
    OPEN TWO_CURSOR(10, 60);
        FETCH TWO_CURSOR INTO RESULT;
            WHILE TWO_CURSOR%FOUND
                 LOOP
                    DBMS_OUTPUT.PUT_LINE(
                    ' ' || RESULT.AUDITORIUM_NAME ||
                    ' ' || RESULT.AUDITORIUM_CAPACITY);
                FETCH TWO_CURSOR INTO RESULT;
                end loop;
    CLOSE TWO_CURSOR;
    EXCEPTION
    WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
--- 17 ----
DECLARE
    CURSOR AUDITORIUM_CAPACITY_DOWN_CUR(CAPACITY_MIN AUDITORIUM.AUDITORIUM_CAPACITY%TYPE,
                                        CAPACITY_MAX AUDITORIUM.AUDITORIUM_CAPACITY%TYPE ) IS
    SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY
    FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= CAPACITY_MIN AND AUDITORIUM_CAPACITY < CAPACITY_MAX
    FOR UPDATE;
    RESULT AUDITORIUM%ROWTYPE;
BEGIN
        FOR RESULT IN AUDITORIUM_CAPACITY_DOWN_CUR(40, 80)
            LOOP
                RESULT.AUDITORIUM_CAPACITY := RESULT.AUDITORIUM_CAPACITY * 0.9;
                UPDATE AUDITORIUM
                    SET AUDITORIUM_CAPACITY = RESULT.AUDITORIUM_CAPACITY
                    WHERE CURRENT OF AUDITORIUM_CAPACITY_DOWN_CUR;
                DBMS_OUTPUT.PUT_LINE(
                ' ' || RESULT.AUDITORIUM_NAME ||
                ' ' || RESULT.AUDITORIUM_CAPACITY);
            end loop;
        ROLLBACK;
        EXCEPTION
            WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY
    FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= 40 AND AUDITORIUM_CAPACITY < 80;


--- 18 ----
DECLARE
    CURSOR AUDITORIUM_CAPACITY_DOWN_CUR(CAPACITY_MIN AUDITORIUM.AUDITORIUM_CAPACITY%TYPE,
                                        CAPACITY_MAX AUDITORIUM.AUDITORIUM_CAPACITY%TYPE ) IS
    SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY
    FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= CAPACITY_MIN AND AUDITORIUM_CAPACITY < CAPACITY_MAX
    FOR UPDATE;
    RESULT_NAME AUDITORIUM.AUDITORIUM_NAME%TYPE;
    RESULT_CAP AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
    SELECT COUNT(*) INTO RESULT_CAP FROM  AUDITORIUM;
    DBMS_OUTPUT.PUT_LINE('Кол-во строк ' || RESULT_CAP);

    OPEN AUDITORIUM_CAPACITY_DOWN_CUR(0, 20);
        FETCH AUDITORIUM_CAPACITY_DOWN_CUR INTO RESULT_NAME, RESULT_CAP ;
        WHILE AUDITORIUM_CAPACITY_DOWN_CUR%FOUND
            LOOP
                DELETE AUDITORIUM
                WHERE CURRENT OF AUDITORIUM_CAPACITY_DOWN_CUR;
                DBMS_OUTPUT.PUT_LINE(
                ' ' || RESULT_NAME ||
                ' ' || RESULT_CAP);
                FETCH AUDITORIUM_CAPACITY_DOWN_CUR INTO RESULT_NAME, RESULT_CAP ;
            end loop;

        SELECT COUNT(*) INTO RESULT_CAP FROM  AUDITORIUM;
        DBMS_OUTPUT.PUT_LINE('Кол-во строк ' || RESULT_CAP);

        ROLLBACK;
    CLOSE AUDITORIUM_CAPACITY_DOWN_CUR;
        EXCEPTION
            WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;

--- 19 ----
DECLARE
    CURSOR AUDITORIUM_CAPACITY_DOWN_CUR(CAPACITY_MIN AUDITORIUM.AUDITORIUM_CAPACITY%TYPE,
                                        CAPACITY_MAX AUDITORIUM.AUDITORIUM_CAPACITY%TYPE ) IS
    SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY, ROWID
    FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= CAPACITY_MIN AND AUDITORIUM_CAPACITY < CAPACITY_MAX;
    RESULT_NAME AUDITORIUM.AUDITORIUM_NAME%TYPE;
    RESULT_CAP AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
    RESULT_XXX ROWID;
BEGIN
    SELECT COUNT(*) INTO RESULT_CAP FROM  AUDITORIUM;
    DBMS_OUTPUT.PUT_LINE('Кол-во строк ' || RESULT_CAP);

    OPEN AUDITORIUM_CAPACITY_DOWN_CUR(0, 20);
        FETCH AUDITORIUM_CAPACITY_DOWN_CUR INTO RESULT_NAME, RESULT_CAP, RESULT_XXX ;
        WHILE AUDITORIUM_CAPACITY_DOWN_CUR%FOUND
            LOOP
                if RESULT_CAP = 15
                then
                    RESULT_CAP := RESULT_CAP + 1;
                    UPDATE AUDITORIUM
                    SET AUDITORIUM_CAPACITY = RESULT_CAP
                    WHERE ROWID = RESULT_XXX;
                     DBMS_OUTPUT.PUT_LINE('UPDATE:  ' || RESULT_NAME || ' ' || RESULT_CAP);
                end if;
                if RESULT_CAP > 15
                then
                    DELETE AUDITORIUM
                    WHERE ROWID = RESULT_XXX;
                    DBMS_OUTPUT.PUT_LINE('DELETE:  ' || RESULT_NAME || ' ' || RESULT_CAP);
                end if;
                FETCH AUDITORIUM_CAPACITY_DOWN_CUR INTO RESULT_NAME, RESULT_CAP, RESULT_XXX ;
            END LOOP;

        SELECT COUNT(*) INTO RESULT_CAP FROM  AUDITORIUM;
        DBMS_OUTPUT.PUT_LINE('Кол-во строк ' || RESULT_CAP);

        ROLLBACK;
    CLOSE AUDITORIUM_CAPACITY_DOWN_CUR;
        EXCEPTION
            WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
--- 20 ----
DECLARE
    CURSOR ALL_TEACHER_CURS IS SELECT * FROM TEACHER;
    RESULT TEACHER%rowtype;
    N INTEGER := 0;
    BEGIN
    FOR RESULT IN ALL_TEACHER_CURS
        LOOP
            N := N + 1;
            DBMS_OUTPUT.PUT_LINE(RESULT.PULPIT || ' ' || RESULT.TEACHER || ' ' || RESULT.TEACHER_NAME);
            IF N = 3
                THEN
                N := 0;
                DBMS_OUTPUT.PUT_LINE('-------------');
            end if;
        end loop;
        EXCEPTION
            WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;
-- Задание 1 --
SELECT SUM(VALUE) FROM V$SGA;
-- Задание 2 --
SELECT * FROM V$SGA;
-- Задание 3 --
SELECT COMPONENT, GRANULE_SIZE, CURRENT_SIZE / GRANULE_SIZE AS RATIO FROM V$SGA_DYNAMIC_COMPONENTS;
-- Задание 4 --
SELECT CURRENT_SIZE FROM V$SGA_DYNAMIC_FREE_MEMORY;
-- Задание 5 --
SELECT COMPONENT, MIN_SIZE, CURRENT_SIZE FROM V$SGA_DYNAMIC_COMPONENTS;
--Задание 6 --
CREATE TABLE KOD_TABLE_KEEP (
    ID number(2)
)STORAGE ( BUFFER_POOL KEEP );
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (1);
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (2);
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (3);
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (4);
COMMIT;
SELECT SEGMENT_NAME, TABLESPACE_NAME, BUFFER_POOL FROM USER_SEGMENTS;
-- Задание 7 --
CREATE TABLE KOD_TABLE_KEEP2
(
    Id number(2)
)STORAGE ( BUFFER_POOL DEFAULT );
INSERT INTO KOD_TABLE_KEEP2 (ID) VALUES (1);
INSERT INTO KOD_TABLE_KEEP2 (ID) VALUES (2);
INSERT INTO KOD_TABLE_KEEP2 (ID) VALUES (3);
COMMIT;
SELECT SEGMENT_NAME, TABLESPACE_NAME, BUFFER_POOL FROM USER_SEGMENTS;
-- Задание 8 --
-- docker exec -it oracle_db bash -c "source /home/oracle/.bashrc; sqlplus /nolog"
-- В консоли: SHOW PARAMETER log_buffer;

-- Задание 9 --
SELECT COMPONENT, MIN_SIZE, MAX_SIZE, CURRENT_SIZE FROM V$SGA_DYNAMIC_COMPONENTS WHERE COMPONENT = 'shared pool' FETCH FIRST 10 ROWS ONLY;

-- Задание 10 --
SELECT (MAX_SIZE - CURRENT_SIZE) AS Free_space FROM V$SGA_DYNAMIC_COMPONENTS WHERE COMPONENT = 'large pool';

-- Задание 11 и 12 --
SELECT USERNAME, SID, SERVER, STATUS FROM V$SESSION WHERE USERNAME iS NOT NULL;
-- Задание 1 --
SELECT SUM(VALUE) FROM V$SGA;
-- Задание 2 --
SELECT * FROM V$SGA;
-- Задание 3 --
SELECT COMPONENT, GRANULE_SIZE, CURRENT_SIZE / GRANULE_SIZE AS RATIO FROM V$SGA_DYNAMIC_COMPONENTS;
-- Задание 4 --
SELECT CURRENT_SIZE FROM V$SGA_DYNAMIC_FREE_MEMORY;

-- Задание 5 --
SELECT NAME, HASH FROM v$parameter WHERE name = 'sga_max_size';
SELECT NAME, HASH  FROM v$parameter WHERE name = 'sga_target';

-- Задание 6 --

SELECT COMPONENT, MIN_SIZE, CURRENT_SIZE FROM V$SGA_DYNAMIC_COMPONENTS WHERE COMPONENT = 'DEFAULT buffer cache' or COMPONENT = 'KEEP buffer cache' or COMPONENT = 'RECYCLE buffer cache';

--Задание 7 --
CREATE TABLE KOD_TABLE_KEEP (
    ID number(2)
)STORAGE ( BUFFER_POOL KEEP );
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (1);
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (2);
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (3);
INSERT INTO KOD_TABLE_KEEP (ID) VALUES (4);
COMMIT;

drop  table  KOD_TABLE_KEEP purge;
FLASHBACK TABLE  KOD_TABLE_KEEP TO  BEFORE DROP;
SELECT * FROM  KOD_TABLE_KEEP;


SELECT SEGMENT_NAME, TABLESPACE_NAME, BUFFER_POOL FROM USER_SEGMENTS;
-- Задание 8 --
CREATE TABLE KOD_TABLE_KEEP2
(
    Id number(2)
)STORAGE ( BUFFER_POOL DEFAULT );
INSERT INTO KOD_TABLE_KEEP2 (ID) VALUES (1);
INSERT INTO KOD_TABLE_KEEP2 (ID) VALUES (2);
INSERT INTO KOD_TABLE_KEEP2 (ID) VALUES (3);
COMMIT;
SELECT SEGMENT_NAME, TABLESPACE_NAME, BUFFER_POOL FROM USER_SEGMENTS;
-- Задание 9 --
SELECT NAME, HASH  FROM v$parameter WHERE name = 'log_buffer';
-- Задание 10 --
SELECT *
FROM V$SGASTAT
WHERE NAME = 'free memory' AND POOL = 'large pool';
-- Задание 11 --
SELECT USERNAME, SID, SERVER, STATUS FROM V$SESSION WHERE USERNAME iS NOT NULL;
-- Задание 12 --
SELECT NAME, DESCRIPTION FROM V$BGPROCESS;
-- Задание 13 --
SELECT * FROM v$process;
-- Задание 14 --
SELECT COUNT(*) FROM V$BGPROCESS WHERE PADDR != '00' AND NAME LIKE 'DBW%';
-- Задание 15 --
SELECT * FROM V$SESSION where  USERNAME is not null;
-- Задание 16 --
SELECT * FROM V$DISPATCHER;
-- Задание 17 --
-- В докере нет такого сервиса, только если вы установили прямо на винду
-- Задание 18 --
 --find / -name listener.ora 2>/dev/null
 --cat /u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/listener.ora
-- Задание 20 --
SELECT SERVICE_NAME FROM V$SERVICE;

/*alter system set large_pool_size =2m;
alter system set sga_target =2m;
startup;
shutdown immediate;
startup;
SHOW PARAMETER log_buffer*/








-- Задание 9 --
SELECT COMPONENT, MIN_SIZE, MAX_SIZE, CURRENT_SIZE FROM V$SGA_DYNAMIC_COMPONENTS WHERE COMPONENT = 'shared pool' FETCH FIRST 10 ROWS ONLY;

SELECT *
FROM (
    SELECT pool, name, bytes, RANK() OVER (ORDER BY bytes DESC) AS rnk
    FROM V$SGASTAT
    WHERE pool = 'shared pool'
    AND name NOT LIKE 'free memory%'
    AND bytes > 0
)
WHERE rnk <= 10;

-- Задание 10 --
SELECT (MAX_SIZE - CURRENT_SIZE) AS Free_space FROM V$SGA_DYNAMIC_COMPONENTS WHERE COMPONENT = 'large pool';

-- Задание 11 и 12 --
SELECT USERNAME, SID, SERVER, STATUS FROM V$SESSION WHERE USERNAME iS NOT NULL;


alter system set large_pool_size =2m;
alter system set sga_target =2m;
startup;
shutdown immediate;
startup;
SHOW PARAMETER log_buffer


show parameter large_pool_size;
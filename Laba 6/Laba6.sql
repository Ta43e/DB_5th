-- Задание 1 --
-- В докере
-- docker exec -it oracle_db bash
-- find / -name sqlnet.ora 2>/dev/null
-- find / -name listener.ora 2>/dev/null
-- cat /u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/sqlnet.ora (после cat тот путь, который выдала первая команда, можно ещё vi)
-- cat /u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/tnsnames.ora
-- cat /u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/listener.ora
 alter pluggable database AllegroPDB open;
SELECT pdb_name, status FROM cdb_pdbs;
connect SYSTEM/Oracle_db1@KOD_PDB;
--find / -name tnsnames.ora 2>/dev/null
--vi  /u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/tnsnames.ora
-- Задание 2 --
-- dataa
-- Задание 3 --
SELECT * FROM V$PDBS; -- В консоли
SELECT * FROM V$TABLESPACE;
SELECT * FROM DBA_DATA_FILES;
SELECT * FROM ALL_USERS;
SELECT * FROM DBA_ROLE_PRIVS;


--Задание 4--
--HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE - это раздел в реестре операционной системы Windows, который используется для
-- хранения информации и настроек, связанных с установленными в системе продуктами Oracle. Реестр Windows - это центральное
--хранилище конфигурационных данных, используемое операционной системой и приложениями для хранения настроек и параметров.

--Когда вы устанавливаете Oracle Database или другие продукты Oracle на компьютере под
-- управлением Windows, соответствующие настройки и информация об установленных компонентах
-- сохраняются в реестре Windows в разделе HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE.
-- 5 задание --
--connect system/Oracle_db1@localhost:1521/ORCLCDB.localdomain;
connect pdb_user/12345@localhost:1521/KOD_PDB.localdomain


                                        connect sys/Oracle_db1@//localhost:1521/AllegroPDB.localdomain


  connect db_user/db_user_pass@//localhost:1521/KOD_PDB.localdomain
-- Задание 6 - 7 --
connect db_user/db_user_pass@ORCLCDB;
 connect db_user/db_user_pass@localhost:1521/ORCLCDB.localdomain
-- Задание 8 - 9 --
-- Включить измерение времени выполнения
--SET TIMING ON;
-- Выполнить SQL-запрос (например, SELECT)
--SELECT * FROM your_table_name;
-- Получить описание столбцов таблицы
--DESCRIBE your_table_name;


select * from KOD_TABLE_KEEP ;
-- Задание №10
SELECT * FROM DBA_SEGMENTS WHERE OWNER = 'DB_USER';
-- Задание 11
CREATE VIEW segment_info2 AS
SELECT
    COUNT(SEGMENT_NAME) AS total_segments,
    SUM(EXTENTS) AS total_extents,
    SUM(BLOCKS) AS total_blocks,
    SUM(BYTES) / 1000 AS size_in_kilobytes
FROM
    DBA_SEGMENTS;

SELECT * FROM segment_info2;

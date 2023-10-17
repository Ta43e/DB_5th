-- Задание 1 --
-- В докере
-- docker exec -it oracle_db bash
-- find / -name sqlnet.ora 2>/dev/null
-- cat /u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/sqlnet.ora (после cat тот путь, который выдала первая команда, можно ещё vi)
-- cat /u01/app/oracle/product/12.2.0/dbhome_1/network/admin/samples/tnsnames.ora

--vi  /u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/tnsnames.ora
-- Задание 2 --
-- show parameter instance
-- Задание 3 --
SELECT * FROM V$PDBS; -- В консоли
SELECT * FROM V$TABLESPACE;
SELECT * FROM DBA_DATA_FILES;
SELECT * FROM ALL_USERS;
SELECT * FROM DBA_ROLE_PRIVS;
-- Задание 6 - 7 --
connect db_user/db_user_pass@ORCLCDB;
select * from KOD_TABLE_KEEP ;
-- Задание №10
SELECT * FROM DBA_SEGMENTS WHERE OWNER = 'DB_USER';
-- Задание 11
CREATE VIEW All_extents AS SELECT EXTENTS, BLOCKS, BYTES FROM DBA_SEGMENTS;
SELECT * FROM All_extents;

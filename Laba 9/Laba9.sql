-- Задания 2 --
CREATE SEQUENCE S1
INCREMENT BY 10
START WITH 100
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE
NOORDER;
commit ;

select S1.currval from  DUAL;
select S1.nextval from  DUAL;
-- Задания 3 --

-- Задания 4 --

CREATE SEQUENCE S2
INCREMENT BY 10
START WITH 10
NOMINVALUE
maxvalue 100
NOCYCLE
NOCACHE
NOORDER;
commit ;

select S2.nextval from  DUAL;
select S2.currval from  DUAL;

-- Задания 5 --
CREATE SEQUENCE S3
INCREMENT BY -10
START WITH 10
MINVALUE -100
MAXVALUE 20
NOCYCLE
NOCACHE
ORDER;

SELECT  S3.nextval FROM  DUAL;
SELECT  S3.nextval FROM  DUAL;
SELECT  S3.currval FROM  DUAL;

-- Задания 6 --
CREATE SEQUENCE S4
INCREMENT BY 1
START WITH 1
NOMINVALUE
MAXVALUE 10
CYCLE
CACHE 5
NOORDER ;

SELECT  S4.nextval FROM  DUAL;
SELECT  S4.currval FROM  DUAL;

-- Задания 7 --
SELECT * FROM SYS.ALL_SEQUENCES WHERE SEQUENCE_OWNER = 'PDB_ADMIN';
-- Задания 8 --
CREATE TABLE T1
(
    N1 NUMBER(20),
    N2 NUMBER(20),
    N3 NUMBER(20),
    N4 NUMBER(20)
)CACHE STORAGE ( BUFFER_POOL KEEP );
COMMIT ;

ALTER SEQUENCE S1 RESTART;
ALTER SEQUENCE S2 RESTART;
ALTER SEQUENCE S3 RESTART;
ALTER SEQUENCE S4 RESTART;
commit ;


INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);

SELECT * FROM T1;
-- Задания 9 --
CREATE CLUSTER ABC
(
    X number(10),
    V varchar(12)
    )HASHKEYS 200;
COMMIT;

-- Задания 10 --
CREATE TABLE A (
    XA NUMBER(10),
    VA VARCHAR2(12),
    NA VARCHAR2(12)
) CLUSTER ABC(XA, VA);
-- Задания 11 --
CREATE TABLE B (
    XB NUMBER(10),
    VB VARCHAR2(12),
    NB VARCHAR2(12)
) CLUSTER ABC(XB, VB);
-- Задания 12 --
CREATE TABLE C (
    XC NUMBER(10),
    VC VARCHAR2(12),
    NC VARCHAR2(12)
) CLUSTER ABC(XC, VC);
-- Задания 13 --
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CLUSTERS;
-- Задания 14 --
create synonym SYNC for C;
select  * from  SYNC;
-- Задания 15 --
CREATE PUBLIC SYNONYM SYNONB FOR B;
COMMIT;

SELECT * FROM SYNONB;
-- Задания 16 --
CREATE TABLE TABLE1 (
    ID NUMBER(10) PRIMARY KEY,
    NAME VARCHAR2(12)
);
CREATE TABLE TABLE2 (
    ID_STUD NUMBER(10),
    CURSE NUMBER(10),
    CONSTRAINT ID_STUD_FK FOREIGN KEY (ID_STUD) REFERENCES TABLE1(ID)
);
COMMIT ;
INSERT INTO TABLE1 (ID, NAME) VALUES (1, 'Oleg');
INSERT INTO TABLE1 (ID, NAME) VALUES (2, 'Anton');
INSERT INTO TABLE2 (ID_STUD, CURSE) VALUES (1, 3);
INSERT INTO TABLE2 (ID_STUD, CURSE) VALUES (2, 4);

create view v1 as select * from TABLE1 T1 INNER JOIN TABLE2 T2 on T1.ID = T2.ID_STUD;
SELECT * FROM V1;
-- Задания 17 --
CREATE MATERIALIZED VIEW MV
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND NEXT SYSDATE+NUMTODSINTERVAL(2, 'minute')
AS SELECT * FROM TABLE1 RIGHT JOIN TABLE2 on ID = TABLE2.ID_STUD;

SELECT * FROM MV;
COMMIT;
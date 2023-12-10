CREATE OR REPLACE PACKAGE job_package AS
  PROCEDURE create_weekly_job;
  PROCEDURE job_procedure;
  PROCEDURE reschedule_job(new_execution_time VARCHAR2);
  PROCEDURE pause_job;
  PROCEDURE cancel_job;
END job_package;

CREATE OR REPLACE PACKAGE BODY job_package AS
  job_number NUMBER := 0;

  PROCEDURE job_procedure IS
  BEGIN
    INSERT INTO B_x (y, name)
    SELECT x, name
    FROM A_x
    WHERE x > 10;

    DELETE FROM A_x
    WHERE x > 10;
    COMMIT;
    BEGIN
      LOGOK(CURRENT_DATE, 'Completed');
    END;

    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
          LOGNO(CURRENT_DATE, 'PROBLEM');
        END;
  END job_procedure;

  PROCEDURE create_weekly_job IS
      job_number int;
  BEGIN
    -- Инициализация переменной job_number
    job_number := DBMS_JOB.SUBMIT(
      job        => 0,
      what       => 'BEGIN job_package.job_procedure; END;',
      next_date  => SYSTIMESTAMP + INTERVAL '7' DAY,
      interval   => 'SYSTIMESTAMP + INTERVAL ''7'' DAY',
      no_parse   => FALSE
    );
  END create_weekly_job;

  PROCEDURE reschedule_job(new_execution_time VARCHAR2) is
  BEGIN
    DBMS_JOB.BROKEN(
      job => job_number,
      broken => TRUE
    );

    DBMS_JOB.SUBMIT(
      job => job_number,
      what => 'BEGIN job_package.job_procedure; END;',
      next_date => TO_DATE(new_execution_time, 'YYYY-MM-DD HH24:MI'),
      interval => 'SYSTIMESTAMP + INTERVAL ''7'' DAY',
      no_parse => FALSE
    );
  END reschedule_job;

  PROCEDURE pause_job IS
  BEGIN
    DBMS_JOB.BROKEN(
      job => job_number,
      broken => TRUE
    );
  END pause_job;

  PROCEDURE cancel_job IS
  BEGIN
    DBMS_JOB.REMOVE(job_number);
  END cancel_job;
END job_package;
--=========================================================--

CREATE OR REPLACE PACKAGE job_package_SCHEDULER AS
  PROCEDURE create_weekly_job;
  PROCEDURE job_procedure;
  PROCEDURE reschedule_job(new_execution_time VARCHAR2);
  PROCEDURE pause_job;
  PROCEDURE cancel_job;
END job_package_SCHEDULER;

CREATE OR REPLACE PACKAGE BODY job_package_SCHEDULER AS
  job_name VARCHAR2(30) := 'WEEKLY_JOB';

  PROCEDURE job_procedure IS
  BEGIN
    INSERT INTO B_x (y, name)
    SELECT x, name
    FROM A_x
    WHERE x > 10;

    DELETE FROM A_x
    WHERE x > 10;
    COMMIT;
    BEGIN
      LOGOK(CURRENT_DATE, 'Completed');
    END;

    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
          LOGNO(CURRENT_DATE, 'PROBLEM');
        END;
  END job_procedure;

  PROCEDURE create_weekly_job IS
  BEGIN
    DBMS_SCHEDULER.create_job(
      job_name        => job_name,
      job_type        => 'PLSQL_BLOCK',
      job_action      => 'BEGIN job_package.job_procedure; END;',
      start_date      => SYSTIMESTAMP + INTERVAL '7' DAY,
      repeat_interval => 'FREQ=WEEKLY; BYDAY=SAT; BYHOUR=12; BYMINUTE=0; BYSECOND=0',
      enabled         => TRUE
    );
  END create_weekly_job;

  -- Изменение времени выполнения задачи
  PROCEDURE reschedule_job(new_execution_time VARCHAR2) IS
  BEGIN
    DBMS_SCHEDULER.set_attribute(
      name      => job_name,
      attribute => 'repeat_interval',
      value     => 'FREQ=WEEKLY; BYDAY=SAT; BYHOUR=' || TO_CHAR(TO_DATE(new_execution_time, 'YYYY-MM-DD HH24:MI'), 'HH') || '; BYMINUTE=' || TO_CHAR(TO_DATE(new_execution_time, 'YYYY-MM-DD HH24:MI'), 'MI') || '; BYSECOND=0'
    );
  END reschedule_job;

  -- Приостановка выполнения задачи
  PROCEDURE pause_job IS
  BEGIN
    DBMS_SCHEDULER.disable(job_name);
  END pause_job;

  -- Отмена выполнения задачи
  PROCEDURE cancel_job IS
  BEGIN
    DBMS_SCHEDULER.drop_job(job_name);
  END cancel_job;
END job_package_SCHEDULER;
--=============
BEGIN
  job_package.create_weekly_job;
  COMMIT;
END;

begin
    job_package.reschedule_job('2023-12-08 23:57');
end;

BEGIN
  job_package.cancel_job();
  COMMIT;
END;
--==========
BEGIN
  job_package_SCHEDULER.create_weekly_job;
  COMMIT;
END;

begin
    job_package_SCHEDULER.reschedule_job('2023-12-09 06:30');
end;

BEGIN
  job_package_SCHEDULER.cancel_job();
  COMMIT;
END;

SELECT * FROM OK;

SELECT * FROM  OK;
SELECT * FROM  NO;

begin
    job_procedure();
end;

--======
SELECT job_name, state
FROM user_scheduler_jobs
WHERE job_name like  '%WEEKLY_JOB%';

SELECT job, what
FROM user_jobs
WHERE what = 'BEGIN job_package.job_procedure; END;';

SELECT job, what
FROM dba_jobs
WHERE what = 'BEGIN job_package.job_procedure; END;';

SELECT JOB_NAME, STATE FROM DBA_SCHEDULER_JOBS;
SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Scheduler';













SELECT VALUE FROM V$OPTION WHERE PARAMETER like '%Processes%';
SELECT VALUE FROM V$OPTION WHERE PARAMETER like '%Job%';
SELECT * FROM DBA_REGISTRY WHERE COMP_ID = 'RDBMS' AND STATUS = 'VALID';







--=====ТЕСТ=====--
create table A_x (
    x int,
    name nvarchar2(20)
);

create table B_x (
    y int,
    name nvarchar2(20)
);

declare
    i int;
    begin
    for b in 1..20
    loop
        insert into A_X values (b, concat('STR', b));
        end loop;
end;

SELECT * FROM A_X;
SELECT * FROM B_x;
TRUNCATE TABLE A_X;

create table OK (
     DATA_JOB DATE,
     RESULT NVARCHAR2(20)
);

create table NO (
     DATA_JOB DATE,
     RESULT NVARCHAR2(20)
);

CREATE OR REPLACE PROCEDURE LOGOK(tine TIMESTAMP, res NVARCHAR2)
IS
BEGIN
    INSERT INTO OK VALUES (tine, res);
END LOGOK;

CREATE OR REPLACE PROCEDURE LOGNO(tine TIMESTAMP, res NVARCHAR2)
IS
BEGIN
    INSERT INTO NO VALUES (tine, res);
END LOGNO;

SELECT * FROM  OK;
SELECT * FROM  NO;

begin
    job_procedure();
end;

--================--
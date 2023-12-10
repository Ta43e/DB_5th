-- Slide 2: Пример создания задачи с DBMS_SCHEDULER
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name => 'my_daily_job',
    job_type => 'PLSQL_BLOCK',
    job_action => 'BEGIN my_procedure; END;',
    start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY; INTERVAL=1',
    enabled => TRUE,
    comments => 'Job scheduled to run daily at 8:30 AM'
  );
END;




-- Slide 5: Примеры расписания в DBMS_SCHEDULER
-- Запуск каждые 2 часа


-- Запуск каждый день в 4, 5, 6 часов утра
repeat_interval => 'FREQ=DAILY; BYHOUR=4,5,6',

-- Запуск каждую неделю в понедельник, среду и пятницу
repeat_interval => 'FREQ=WEEKLY; BYDAY=MON,WED,FRI',

-- Запуск каждый год в марте, июне, сентябре и декабре
repeat_interval => 'FREQ=YEARLY; BYMONTH=MAR,JUN,SEP,DEC; BYMONTHDAY=30',

-- Запуск с 5 февраля по 22 сентября в 8:00, 13:00 и 18:00
repeat_interval => 'FREQ=DAILY; BYHOUR=8,13,18; BYMINUTE=0; BYSECOND=0; BYDATE=0502,0922'



-- Пример изменения атрибута повторения задания
BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE (
    name => 'my_daily_job',
    attribute => 'repeat_interval',
    value => 'FREQ=DAILY; INTERVAL=2'
  );
END;

-- Пример включения задачи
BEGIN
  DBMS_SCHEDULER.ENABLE ('my_daily_job');
END;

-- Пример удаления задачи
BEGIN
  DBMS_SCHEDULER.DROP_JOB ('my_daily_job', force => TRUE);
END;


-- Пример 1: Запуск хранимой процедуры каждый час
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name => 'hourly_job',
    job_type => 'STORED_PROCEDURE',
    job_action => 'your_stored_procedure',
    start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQ=HOURLY; INTERVAL=1',
    enabled => TRUE
  );
END;

-- Пример 2: Запуск внешней программы каждый день в 3 часа после полуночи
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name => 'external_program_job',
    job_type => 'EXECUTABLE',
    job_action => '/path/to/your/external_program',
    start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY; BYHOUR=3',
    enabled => TRUE
  );
END;


-- Начать работу (включить несколько задач)
BEGIN
  DBMS_SCHEDULER.ENABLE (
    'my_daily_job'
  );
END;



-- Просмотр журналов работ
SELECT JOB_NAME, OPERATION, OWNER FROM DBA_SCHEDULER_JOB_LOG;

-- Просмотр сведений о работе задания
SELECT LOG_ID, JOB_NAME, STATUS, TO_CHAR(LOG_DATE, 'DD-MON-YYYY HH24:MI')
FROM DBA_SCHEDULER_JOB_RUN_DETAILS WHERE JOB_NAME = 'my_daily_job';


-- Полномочия по управлению запланированными задачами
GRANT SCHEDULER_ADMIN TO pdb_admin;
GRANT CREATE JOB TO pdb_admin;
GRANT ALTER my_daily_job TO pdb_admin;
GRANT MANAGE SCHEDULER TO pdb_admin;

-- Пример изменения атрибута для выполнения задания
BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE (
    name => 'my_daily_job',
    attribute => 'start_date',
    value => SYSTIMESTAMP + INTERVAL '1' HOUR
  );
END;

-- Удаление планировщика
BEGIN
  DBMS_SCHEDULER.DROP_SCHEDULE (
    schedule_name => 'my_schedule',
    force => TRUE
  );
END;

-- Изменение атрибутов задания
BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE (
    name => 'my_daily_job',
    attribute => 'repeat_interval',
    value => 'FREQ=DAILY; INTERVAL=3'
  );
END;

-- Создание планировщика с использованием DBMS_SCHEDULER.CREATE_SCHEDULE
BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE (
    schedule_name => 'my_schedule',
    repeat_interval => 'FREQ=MINUTELY; INTERVAL=5',
    comments => 'Every 5 MINUTES'
  );
END;



CREATE OR REPLACE PROCEDURE my_procedure AS
BEGIN
  -- Ваш код для выполнения в хранимой процедуре
  DBMS_OUTPUT.PUT_LINE('Процедура выполняется в ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
END my_procedure;


BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'my_job',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN my_procedure; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=SECONDLY; INTERVAL=1',
    enabled         => TRUE
  );
END;


BEGIN
  DBMS_SCHEDULER.ENABLE (
    'my_job'
  );
END;
-- Пример удаления задачи

-- Просмотр статуса работы
SELECT JOB_NAME, STATE FROM DBA_SCHEDULER_JOBS WHERE JOB_NAME IN ('MY_JOB');


SELECT JOB_NAME, SCHEDULE_NAME, REPEAT_INTERVAL
FROM DBA_SCHEDULER_JOBS;

SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Scheduler';

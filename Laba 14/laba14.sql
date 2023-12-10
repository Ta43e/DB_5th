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
TRUNCATE TABLE A_X;


CREATE OR REPLACE PROCEDURE COPY_TABLE AS
BEGIN
    INSERT INTO B_x (y, name)
    SELECT x, name
    FROM A_x
    WHERE x % 2 = 0;

    DELETE FROM A_x
    WHERE x % 2 = 0;

    COMMIT;
END COPY_TABLE;



begin
    COPY_TABLE();
end;



/

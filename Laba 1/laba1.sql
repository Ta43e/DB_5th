create table KOD_t (x number(3), s varchar2(50));

insert into KOD_t (x, s) values (1, 'Oleg');
insert into KOD_t (x, s) values (2, 'Anton');
insert into KOD_t (x, s) values (3, 'Masha');
insert into KOD_t (x, s) values (4, 'Egor');
insert into KOD_t (x, s) values (5, 'Nikita');
insert into KOD_t (x, s) values (6, 'Misha');
commit;

update KOD_t set s = 'Gleb' where  x = 1;
update KOD_t set s = 'Yan' where  x = 2;
commit;

select * from KOD_t;
select count(*) from KOD_t;

delete from  KOD_t
where x = 1;
commit;

alter table KOD_t
ADD CONSTRAINT PK_X
PRIMARY KEY (x);

create table KOD_t1
 (id number(3),
 constraint fk_id foreign key (id) references KOD_t(x));

insert into KOD_t1 (id) values (2);
insert into KOD_t1 (id) values (3);


select *
from KOD_t, KOD_t1;

select *
from KOD_t left join KOD_t1 on KOD_t.x = KOD_t1.id;

select *
from KOD_t right join KOD_t1 on KOD_t.x = KOD_t1.id;

select *
from  KOD_t full join KOD_t1 on KOD_t.x = KOD_t1.id;

drop TABLE KOD_t;
drop TABLE KOD_t1;
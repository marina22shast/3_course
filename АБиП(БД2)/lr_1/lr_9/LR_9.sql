--create user C##userSMS identified by 12345
--1.
grant create session to C##userSMS;
grant create table to C##userSMS;
grant select any table to C##userSMS;
grant insert any table to C##userSMS;
grant create view to C##userSMS;
grant create any sequence to C##userSMS;
grant select any sequence to C##userSMS;
grant create cluster to C##userSMS;
grant create public synonym to C##userSMS;
grant create synonym to C##userSMS;
grant create materialized view to C##userSMS;
grant drop public synonym to C##userSMS;
grant unlimited tablespace to C##userSMS ;--есть неограниченная квота на любое табличное пространство в бд
commit;

--2.послд
create sequence S1
    start with 1000
    increment by 10--приращение
    nominvalue
    nomaxvalue
    nocycle
    nocache
    noorder;--не гарант хронолог
commit;

select S1.nextval from dual;
select S1.currval from dual;

--drop sequence S1;

--3,4Попытайтесь получить значение, выходящее за максимальное значение.
create sequence S2
    start with 10
    increment by 10
    maxvalue 100
    nocycle;
commit;

select S2.nextval from dual;

alter sequence S2 increment by 90;
select S2.nextval from dual;    --x2
alter sequence S2 increment by 10;

--drop sequence S2;

--5.Попытайтесь получить значение, меньше минимального значения
create sequence S3
    start with 10
    increment by -10
    maxvalue 20
    minvalue -100
    nocycle
    order;
commit;

--Получите все значения последовательности:
select S3.nextval from dual;

--drop sequence S3;

-- получить значение меньше min
alter sequence S3 increment by -90;
select S3.nextval from dual;    ----x2
alter sequence S3 increment by -10;

--drop sequence S3;

--6циклич продемонстр

create sequence S4
    start with 1
    increment by 1
    maxvalue 10
    cycle
    cache 5-- 5 значений
    noorder;
commit;

select S4.nextval from dual;

--drop sequence S4;
---------7---------
select * from sys.dba_sequences where sequence_owner = 'C##USERSMS';

---------8---------
create table T1
(
    N1 number(20),
    N2 number(20),
    N3 number(20),
    N4 number(20)
) storage(buffer_pool KEEP);--кэшируемую и расположенную в буферном пуле KEEP
commit;
--сформировать вводимое значение из последовательностей S1, S2, S3, S4.
declare x number:=0;
begin
    loop
        insert into T1(N1,N2,N3,N4)
               values(S1.nextval,S2.nextval,S3.nextval,S4.nextval);
        x:= x + 1;
        exit when x = 7;--7 строк
    end loop;
    commit;
end;

select * from T1;

--drop table T1;

--9.Создать кластер
create cluster ABC
(
    X number(10),
    V varchar(12)
)hashkeys 200;--hash-тип

--drop cluster ABC;

--10-12.
create table A
(
    xa number(10),--столбцы для класт
    va varchar(12),
    ya int
)cluster ABC(xa,va);

--drop table A;

create table B
(
    xb number(10),
    vb varchar(12),
    yb int
)cluster ABC(xb,vb);

--drop table B;

create table C
(
    xc number(10),
    vc varchar(12),
    yc int
)cluster ABC(xc,vc);

--drop table C;

--13.найти в простр словаря
select cluster_name, owner, tablespace_name, cluster_type, cache from all_clusters;

select * from all_tables
  where table_name = 'A'
     OR table_name = 'B'
     OR table_name = 'C';

--14.частный

create synonym SYN1 for C;

insert into SYN1 values (10, 'sometext', 25);
select * from SYN1;

--drop synonym SYN1;

--15.

create public synonym SYN_G for B;

insert into SYN_G values (44, 'cfydckyrkyvg', 100);
select * from SYN_G;

--drop synonym SYN_G;

--16.
create table A1
(
    x number(10),
    y varchar(12),
    constraint x_pk primary key (x)-------------
);

insert into A1 (x, y) values (1,'a');
insert into A1 (x, y) values (2,'b');
insert into A1 (x, y) values (3,'c');
insert into A1 (x, y) values (4,'d');
insert into A1 (x, y) values (5,'e');
insert into A1 (x, y) values (6,'f');
insert into A1 (x, y) values (7,'g');
insert into A1 (x, y) values (8,'h');
insert into A1 (x, y) values (9,'i');
insert into A1 (x, y) values (10,'i7');

DELETE from A1  WHERE x = 10;
update A1 set x = 8  where y = 'hrrjh';
commit;

select * from A1;
--drop table A1;

create table B1
(
    xB number(10),
    yB varchar(12),
    constraint xB_fk foreign key (xB) references A1(x)-----------
);

insert into B1 (xB, yB) values (1,'one');
insert into B1 (xB, yB) values (2,'two');
insert into B1 (xB, yB) values (3,'three');
insert into B1 (xB, yB) values (4,'four');
insert into B1 (xB, yB) values (5,'five');
insert into B1 (xB, yB) values (6,'six');
insert into B1 (xB, yB) values (7,'seven');
insert into B1 (xB, yB) values (8,'eight');
insert into B1 (xB, yB) values (8,'eight');
insert into B1 (xB, yB) values (9,'eight');
insert into B1 (xB, yB) values (10,'e');
commit;
DELETE from  B1  WHERE xB = 10;

update B1 set xB = 9  where yB = 'hi!';

select * from B1;
drop table B1;

---представление
create view v1
    as select A1.x, A1.y, B1.yB
    from A1 inner join B1
      on A1.x = B1.xB;

select * from v1;

--drop view v1;

--17-готовая таблица с данными, которые были сформированы в момент создания самого Материализованного Представления

create materialized view MV
    build immediate--созд представл
    refresh complete --полное обновление данных из базовых таблиц
    start with sysdate
    next sysdate + Interval '1' minute
    as select A1.x, A1.y, B1.yB
    from A1 inner join B1 on A1.x = B1.xB;
commit;
select * from MV;
--drop materialized view MV;

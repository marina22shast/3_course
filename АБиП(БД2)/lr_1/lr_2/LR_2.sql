ƒЋя —ќ«ƒјЌ»я ѕќЋ№«ќ¬ј“≈Ћя
create user C##user identified by 12345;
alter user C##user quota unlimited on USERS;

grant create table to C##user;
grant create view to C##user;
grant create session to C##user container=all;
grant select any table to C##userSMS;
grant insert any table to C##userSMS;
grant create any sequence to C##userSMS;
grant select any sequence to C##userSMS;
grant create cluster to C##userSMS;
grant create public synonym to C##userSMS;
grant create synonym to C##userSMS;
grant create materialized view to C##userSMS;
grant drop public synonym to C##userSMS;
grant unlimited tablespace to C##userSMS ;--есть неограниченна€ квота на любое табличное пространство в бд
commit;



--1


create tablespace TS_SMS1
  datafile 'D:\3kr_5sem\јЅиѕ\lr_2\TS_SMS1.dbf'
  size 7M
  autoextend on next 5M
  maxsize 20M
 extent management local;
 
drop tablespace TS_SMS1 INCLUDING CONTENTS;

--2
 create temporary tablespace TS_SMSI_TEMP1
  tempfile 'D:\3kr_5sem\јЅиѕ\lr_2\TS_SMS_TEMP1.dbf'
  size 5M
  autoextend on next 3M
  maxsize 30M
 extent management local;
 
drop tablespace TS_SMSI_TEMP1 INCLUDING CONTENTS;

--3
select * from SYS.dba_tablespaces;

--4

create role C##mari_role;
commit;
drop role C##mari_role ;

grant create session,
      create table,
      create view,
      create procedure,
      drop any table,
      drop any view,
      drop any procedure 
to C##mari_role;

--5
select * from dba_roles;
select * from dba_roles where role = 'C##mari_role';
select * from dba_sys_privs where grantee = 'C##mari_role';

--6
create profile C##PF_SMSCORE limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30;
  
  drop  profile C##PF_SMSCORE CASCADE;
--7
select * from dba_profiles;
select * from dba_profiles where profile = 'C##PF_SMSCORE';
select * from dba_profiles where profile = 'DEFAULT';     

--8
create user C##mari identified by 12345
default tablespace TS_SMS1 quota unlimited on TS_SMS1
temporary tablespace TS_SMSI_TEMP1
profile C##PF_SMSCORE
account unlock
password expire;

grant C##mari_role to C##mari;
commit;

  drop  user C##mari CASCADE;
--новый пароль
-----------------------------------------------------------------------
--mari-sys
--marinka-пользов
-----------------------------------------------------------------------
--10--mari
create table Points(x number(2), y number(2));

create view Points_view as select * from Points;

drop  table Points ;drop  view Points_view ;


--11--mari 

grant create tablespace, alter tablespace to C##mari;



--marinka
create tablespace SMS_QDATA_m
datafile 'D:\3kr_5sem\јЅиѕ\SMS_QDATA_m.dbf'
size 10M
extent management local
offline;

alter tablespace SMS_QDATA_m online;
alter user C##mari quota 2M on SMS_QDATA_m;--mari
--marinka


insert into Points(x, y) values (1, 1);
insert into Points(x, y) values (1, 2);
insert into Points(x, y) values (1, 3);

select * from Points;
--------------------------------------
  drop  tablespace SMS_QDATA_m;
  drop table Points;


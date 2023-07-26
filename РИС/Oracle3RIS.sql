--PROFILE
create profile C##PFSMS limit
  password_life_time 180 
  sessions_per_user 3 
  failed_login_attempts 7 
  password_lock_time 1
  password_reuse_time 10 
  password_grace_time default 
  connect_time 180 
  idle_time 30; 

  select * from dba_profiles;
  select * from dba_profiles where profile='C##PFSMS';
--ROLE
 create role C##RL_SMS;
 select * from dba_roles where role like '%SMS%';
  GRANT CREATE SESSION TO C##RL_SMS;
  GRANT CREATE VIEW, DROP ANY VIEW TO C##RL_SMS;
  GRANT CREATE PROCEDURE, DROP ANY PROCEDURE TO C##RL_SMS;
  GRANT CREATE TABLE, DROP ANY TABLE TO C##RL_SMS;
 


select *from dba_sys_privs where grantee like '%C##RL_SMS';

--USER
  create user C##SMS identified by 12345
    profile C##PFSMS
    account unlock;
 GRANT CREATE DATABASE LINK TO C##SMS;

    select * from all_users where username like '%SMS%';
   alter user C##SMS identified by qwe; 
GRANT 
GRANT C##RL_SMS TO C##SMS;
GRANT ALL PRIVILEGES TO C##SMS;
---------------------------------------------------
CREATE DATABASE LINK COFFE
CONNECT TO GUS IDENTIFIED BY "12345"
USING 'COFFEE';
drop database link COFFE;
---------------------------------------
---------------------------------------
---------------------------------------

create table RIS(id int primary key,str varchar(20), numb NUMBER GENERATED ALWAYS AS IDENTITY);
--drop table RIS@COFFE;
select * from RIS@COFFE;
select * from RIS;
--delete RIS@COFFE;
--delete RIS;
commit;
rollback;---отмен комит
--«адание 1
begin
    insert into RIS(id,str) values(1,'222');
    insert into RIS@COFFE(id,str) values(2,'222');
commit;
end;

select * from RIS@COFFE;
select * from RIS;

begin
    insert into RIS(id,str) values(4,'222');
    update RIS@COFFE set str='23454' where str ='222';
commit;
end;

begin
    update RIS set str='23454' where str ='222';
    insert into RIS@COFFE(id,str) values(19,'222');
commit;
end;

--«адание 2 (нарушение ограничени€ целостности на стороне удаленного сервера)
insert into RIS@COFFE(id,str) values(2,'222', 45);
commit;

--«адание 3

select * from RIS@COFFE;
--2
begin
delete RIS@COFFE where ID=2;
end;

--3
begin



commit;
end;


begin



lock table RIS@COFFE in share mode;
SLEEP(30000);
commit;
end;

--таблица RIS в удаленной базе данных блокируетс€ в режиме общего доступа, затем выполн€етс€ пауза на 30000 миллисекунд (30 секунд), а затем транзакци€ фиксируетс€. 
--≈сли другие транзакции пытаютс€ изменить данные в таблице RIS во врем€ этой паузы, они будут заблокированы и будут ожидать освобождени€ ресурса.










--процедура задержки
create or replace procedure SLEEP(P_MILLI_SECONDS IN NUMBER)
AS LANGUAGE JAVA NAME 'java.lang.Thread.sleep(long)';


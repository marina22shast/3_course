alter session set "_ORACLE_SCRIPT" = true;
--              TASK 1
select name,open_mode from v$pdbs; 

--              TASK 2 
select INSTANCE_NAME from v$instance;

--              TASK 3
select * from PRODUCT_COMPONENT_VERSION;

--              TASK 4 
--коммандн строка создание собственного экземпляра PDB
--моя PDB_A

--              TASK 5 
select name,open_mode from v$pdbs;

--              TASK 6 
CREATE TABLESPACE C##TS_SMS
DATAFILE 'D:\3kr_5sem\АБиП\lr_4\TS_SMS.dbf' 
size 7M
REUSE AUTOEXTEND ON NEXT 5M 
MAXSIZE 20M
LOGGING
ONLINE;
commit;


DROP TABLESPACE TS_SMS INCLUDING CONTENTS AND DATAFILES;

select TABLESPACE_NAME, BLOCK_SIZE, MAX_SIZE from sys.dba_tablespaces order by tablespace_name;

CREATE TEMPORARY TABLESPACE TS_SMS_TEMP_1
TEMPFILE 'D:\3kr_5sem\АБиП\lr_4\TS_SMS_TEMP_1.dbf' size 5M
REUSE AUTOEXTEND ON NEXT 3M 
MAXSIZE 30M;
commit;

DROP TABLESPACE TS_SMS_TEMP_1 INCLUDING CONTENTS AND DATAFILES;

create role C##RL_SMS;
commit;

drop role C##RL_SMS;

grant create session, create any table, create any procedure,ALTER ANY SEQUENCE,CREATE SEQUENCE, create any view  to C##RL_SMS;
grant  create  view to C##RL_SMS;
grant drop any table, drop any view, drop any procedure to C##RL_SMS;
commit;


create profile C##PF_SMS limit
password_life_time 180
sessions_per_user 3
FAILED_LOGIN_ATTEMPTS 7 
PASSWORD_LOCK_TIME 1 
PASSWORD_Reuse_time 10 
password_grace_time default 
connect_time 180
idle_time 30;
commit;

drop profile C##PF_SMS ;

create user C##U1_SMS_PDB1 identified by 1234
default tablespace TS_SMS quota unlimited on TS_SMS
profile C##PF_SMS
account unlock;

drop user C##U1_SMS_PDB CASCADE;

grant C##RL_SMS to U1_SMS_PDB;
commit;

----
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS where GRANTEE='U1_BIO_PDB'; 

commit;

--              TASK 7 
DROP table U1BIOTABLE

CREATE TABLE U1BIOTABLE(
id number GENERATED ALWAYS AS IDENTITY primary key,
word varchar2(50)
);

INSERT into U1BIOTABLE(word) values('CHANGED');
INSERT into U1BIOTABLE(word) values('a');
INSERT into U1BIOTABLE(word) values('b');
commit;
SELECT * FROM U1BIOTABLE;
--              TASK 8
select * from DBA_USERS; 
select * from DBA_TABLESPACES; 
select * from DBA_DATA_FILES;   
select * from DBA_TEMP_FILES;  
select * from DBA_ROLES;
select * from DBA_ROLE_PRIVS t1 inner join DBA_SYS_PRIVS t2 on t1.GRANTED_ROLE = t2.GRANTEE where t1.GRANTEE='U1_BIO_PDB'; 

select * from DBA_PROFILES; 
--              TASK 9

create user C##BIO identified by 1234
account unlock;

--              TASK 10
grant create session to  C##BIO;

select * from v$session where USERNAME is not null;

select PRIVILEGE from USER_SYS_PRIVS; 



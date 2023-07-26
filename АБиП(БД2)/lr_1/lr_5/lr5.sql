alter session set "_ORACLE_SCRIPT"=true;
--              TASK 1
select tablespace_name, contents from DBA_TABLESPACES;

--              TASK 2
--DROP TABLESPACE NAP_QDATA5 INCLUDING CONTENTS AND DATAFILES;
create tablespace NAP_QDATA5
    datafile 'C:\app\Tablespaces\NAP_QDATA_lr5.dbf'
    size 10 M
    offline;
    
alter tablespace NAP_QDATA5 online; 

 --DROP USER NAP5;   
create user NAP5 identified by 1111
default tablespace NAP_QDATA5 
quota 2 m on NAP_QDATA5
account unlock;

grant all privileges to NAP5;

--DROP TABLE NAP_T1_5
create table NAP_T1_5(
    id number(15) PRIMARY KEY,
    name varchar2(10))
    tablespace NAP_QDATA5;
    
insert into NAP_T1_5 values(1, 'A');
insert into NAP_T1_5 values(2, 'B');
insert into NAP_T1_5 values(3, 'C');

SELECT * FROM NAP_T1_5;
    
--              TASK 3
select owner, segment_name, segment_type, tablespace_name, bytes, buffer_pool 
  from dba_segments where tablespace_name='NAP_QDATA5';

--              TASK 4
drop table NAP_T1_5;
select segment_name, segment_type, tablespace_name, 
      from DBA_SEGMENTS where tablespace_name='NAP_QDATA5';
select original_name from user_recyclebin;

--              TASK 5
flashback table NAP_T1_5 to before drop;

--              TASK 6
BEGIN
  FOR k IN 4..10004
  LOOP
    insert into NAP_T1_5 values(k, 'Nastya');
  END LOOP;
END;

SELECT * FROM NAP_T1_5 order by id;

--              TASK 7
select segment_name, segment_type, tablespace_name, bytes, blocks, extents, buffer_pool 
  from dba_segments where tablespace_name='NAP_QDATA5';

--              TASK 8
drop tablespace NAP_QDATA5 INCLUDING CONTENTS AND DATAFILES;

--              TASK 9
select * from v$log;

--              TASK 10
select * from v$logfile;

--              TASK 11
alter system switch logfile;
select * from v$log;

alter system switch logfile;
select * from v$log;

alter system switch logfile;
select * from v$log;

--              TASK 12
alter database add logfile group 4 'C:\app\lab5log\REDO4.log'
size 10m blocksize 512;

alter database add logfile member 'C:\app\lab5log\REDO41.log' to group 4;
alter database add logfile member 'C:\app\lab5log\REDO42.log' to group 4;

select * from v$log;
select * from v$logfile;

--              TASK 13
alter database clear logfile group 4;
alter database drop logfile group 4;

select * from v$log;
select * from v$logfile;

--              TASK 14
SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;

--              TASK 15
ALTER SYSTEM SWITCH LOGFILE;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

--              TASK 16

--connect /as sysdba
--shutdown immediate;
--startup mount;
--alter database archivelog;
--archive log list;
--alter database open;

--              TASK 17
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=C:\app\ora_install_user\oradata\orcl\archive';
ALTER SYSTEM SWITCH LOGFILE;
SELECT NAME, FIRST_CHANGE#, NEXT_CHANGE# FROM V$ARCHIVED_LOG;

--              TASK 18

--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--select name, log_mode from v$database;
--alter database open;

--              TASK 19
select name from v$controlfile;

--              TASK 20
show parameter control;

--              TASK 21
ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
show parameter spfile;

--              TASK 22
CREATE PFILE='user_pf.ora' FROM SPFILE;
--C:\app\ora_install_user\product\12.1.0\dbhome_1\database

--              TASK 23
SELECT * FROM V$PWFILE_USERS;
show parameter remote_login_passwordfile;

--              TASK 24
SELECT * FROM V$DIAG_INFO;

--              TASK 25
--C:\app\ora_install_user\diag\tnslsnr\WIN-D29HV8T7KD3\listener\alert
--C:\app\ora_install_user\diag\rdbms\orcl\orcl\alert

--              TASK 26
--        


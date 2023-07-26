--1.
select name, description from v$bgprocess order by 1;

--2.
SELECT *FROM v$process ;

--3.СКОЛЬКО ПРОЦЕССОВ DBW РАБОТАЮТ В НАСТОЯЩИЙ МОМЕНТ
SELECT *FROM v$process  where PNAME LIKE 'DBW%';

--4.
SELECT * FROM V$INSTANCE;

--5--настоящ ,режимы,ПИСАТЕЛЬ ДАННЫХ-из буф на диск
select paddr, username, status, server from v$session where username is not null;

--6.
select * from V$SERVICES ;--сервисы-точки подключ

--7.
SELECT * FROM V$DISPATCHER;

--9
--текущ соед с инстансом
select SID, STATUS, SERVER, LOGON_TIME, PROGRAM, OSUSER, MACHINE, USERNAME, STATE
from v$session
where STATUS = 'ACTIVE';



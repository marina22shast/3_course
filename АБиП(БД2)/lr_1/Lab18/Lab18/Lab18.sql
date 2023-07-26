--run cmd
--d:
--cd D:\DARIA\3course_sem1\database\Lab18
--sqlldr C##dsheibak/Mutabor2003@PDB_SH CONTROL=DataForLoad.ctl 

create table WORKERS_HIRING
(
  workerid int primary key,
  workername varchar2(255),
  hiringdate date,
  salary number(9, 5)
);

select * from WORKERS_HIRING;
delete from WORKERS_HIRING; commit;

--run cmd
--d:
--cd D:\DARIA\3course_sem1\database\Lab18
--sqlldr C##dsheibak/Mutabor2003@PDB_SH CONTROL=DataForLoadWithCurrentMonth.ctl external_table=generate_only
--создается log файл; в нем выбираем то, что нам нужно: скрипт для создания директории и самой внешней таблицы
--переименовываем директорию, таблицу и меняем указания на директории в определении таблицы - используем новое имя
--убираем графу с параметрами в определении таблицы и оставляем все самое базовое в ACCESS PARAMETERS - RECORDS DELIMITED BY NEWLINE и FIELDS

-- drop directory EXT_DIR;
--drop table EXT_WORKERS_HIRING;

CREATE DIRECTORY EXT_DIR AS 'D:\DARIA\3course_sem1\database\Lab18';

CREATE TABLE EXT_WORKERS_HIRING --поменяли имя (в файле было что-то системное)
(
  "WORKERID" NUMBER(38),
  "WORKERNAME" VARCHAR2(255),
  "HIRINGDATE" DATE,
  "SALARY" VARCHAR2(255)
)
ORGANIZATION external 
(
  TYPE oracle_loader
  DEFAULT DIRECTORY EXT_DIR
  ACCESS PARAMETERS 
  (
    RECORDS DELIMITED BY NEWLINE
    FIELDS 
    (
      "WORKERID" CHAR(255)
        TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"',
      "WORKERNAME" CHAR(255)
        TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"',
      "HIRINGDATE" CHAR(255)
        TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
        DATE_FORMAT DATE MASK 'DD-MM-YYYY',
      "SALARY" CHAR(255)
        TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
    )
  )
  location ('DataForLoad.txt')
) ;

INSERT INTO WORKERS_HIRING 
(
  WORKERID,
  WORKERNAME,
  HIRINGDATE,
  SALARY
) 
SELECT 
  cast("WORKERID" as int), 
  upper("WORKERNAME"), 
  "HIRINGDATE",
  round(to_number("SALARY", '9999.9999'), 2) 
FROM "EXT_WORKERS_HIRING"
WHERE to_char(HIRINGDATE, 'MM.YYYY') = to_char(sysdate, 'MM.YYYY'); 


commit;

select * from WORKERS_HIRING;
select * from EXT_WORKERS_HIRING;

--unload - выгрузка в файл

--connect c##dsheibak/Mutabor2003@PDB_SH;
--spool D:\DARIA\3course_sem1\database\Lab18\x.csv 
--select * from WORKERS_HIRING;
--spool off

--ИЛИ ЛУЧШЕ ТАК!!!!!!!!!
--connect c##dsheibak/Mutabor2003@PDB_SH;
--set serveroutput on;
--spool D:\DARIA\3course_sem1\database\Lab18\dataunload.csv;
--@D:\DARIA\3course_sem1\database\Lab18\Unload_Data; --это исполняемый sql файл с блоком PL/SQL
--spool off;


declare
cursor workers_hiring_cur is select workerid, workername, hiringdate, salary from WORKERS_HIRING;
wid WORKERS_HIRING.workerid%type;
wname WORKERS_HIRING.workername%type;
whdate WORKERS_HIRING.hiringdate%type;
wsalary WORKERS_HIRING.salary%type;
begin
dbms_output.enable(100000);
dbms_output.put_line('workerid,workername,hiringdate,salary');
open workers_hiring_cur;
        fetch workers_hiring_cur into wid, wname, whdate, wsalary;
        while workers_hiring_cur%found
          loop
            dbms_output.put_line(wid || ',' || wname || ',' || whdate || ',' || wsalary);
            fetch workers_hiring_cur into wid, wname, whdate, wsalary;
          end loop;
close workers_hiring_cur;
end;

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

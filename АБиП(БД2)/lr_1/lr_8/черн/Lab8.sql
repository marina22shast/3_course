--2
show parameter instance;

--3
sel
select * from ect * from v$tablespace;sys.dba_data_files;
select * from dba_role_privs;
select * from all_users;

--7
create table UserRoles(id number generated always as identity, 
                       role varchar2(100) not null unique,
                       constraint role_pk primary key(id));
                       
insert into UserRoles (role) values('Admin');
insert into UserRoles (role) values('User');
insert into UserRoles (role) values('VIP');
insert into UserRoles (role) values('Manager');
insert into UserRoles (role) values('System');
commit;                       

select * from UserRoles;

declare
    x number(10) := 1;
    string varchar(20);
begin

    while (x < 10000)
        loop
            x:= x + 1;
            string := concat('Name',to_char(x));
            insert into UserRoles (role) values(string);
        end loop;
    commit;    
end;

--11
create or replace view lab8 as
select count(*) as count,
        sum(extents) as sum_extents,
        sum(blocks) as sum_blocks,
        sum(bytes/1024) as Kb from user_segments;
        
select * from lab8;        
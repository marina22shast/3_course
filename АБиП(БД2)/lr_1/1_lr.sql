create table A_SMS_t
( 
  x number(3) primary key, 
  s number(4)
);

insert into A_SMS_t(x, s)
   values (101, 2001);
insert into A_SMS_t(x, s)
   values (102, 2002);
insert into A_SMS_t(x, s)
   values (103, 2003);
commit work;   

---------------------------

update A_SMS_t set x = 201 
  where s = 2001;
update A_SMS_t set x = 202 
  where s = 2002;
commit work;   

----------------------------

select * from A_SMS_t;

select sum(x) from A_SMS_t;
  
select x, s from A_SMS_t
  where x < 200;

---------------------------

delete from A_SMS_t where x = 201;
commit work;   

---------------------------
create table A_SMS_t1
(
  x1 number(3), 
  s1 number(5),
  foreign key (x1) references A_SMS_t(x)
);

insert into A_SMS_t1(x1, s1)
   values (202, 51234);
insert into A_SMS_t1(x1, s1)
   values (103, 95678);
commit work;

---------------------------

select x, s, x1, s1
  from  A_SMS_t left outer join A_SMS_t1
    on x = x1;
    
select x, s, x1, s1
  from A_SMS_t right outer join A_SMS_t1
    on x = x1;

select x, s, x1, s1
  from A_SMS_t full outer join A_SMS_t1
    on x = x1;
---------------------------

drop table A_SMS_T;
drop table A_SMS_t1;
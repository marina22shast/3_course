--set serveroutput on;--не работает
--1.простой АБ
begin
    null;
end;
---------2---------
begin
    dbms_output.put_line('Hello, world');
ENd;
---------3---------
--Продемонстр исключ SQLCODE  и встр.ф SQLERRM
declare
    x number(3) := 3;
    y number(3) := 0;
    z number (10,2);
begin
    dbms_output.put_line('x = '||x||', y = '||y);
    z:=x/y;
    exception
        when others
        then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
end;
--4
declare
    x number(3) := 3;
begin
    begin--влож
        declare x number(3) :=1;
        begin dbms_output.put_line('x = '||x); end;
    end;
    dbms_output.put_line('x = '||x);
end;
---------5-предупрежд--------

alter system set plsql_warnings = 'ENABLE:INFORMATIONAL';
select name, value from v$parameter where name = 'plsql_warnings';

--6-8 PL/SQL

---------6---------

select keyword from v$reserved_words
where length=1 and keyword!='A';
---------7---------

select keyword from v$reserved_words--кл сл
  where length > 2 and keyword!='A'
  order by keyword;
---------8---------

select name,value from v$parameter where name like 'plsql%';

---------9-17---------

declare
        c1 number(3):= 25;
        c2 number(3):= 10;
        div number(10,2);--для деление  с остатком
        fix number(10,2):= 3.12;
        otr number(4, -5):= 32.12345;
        bf binary_float:= 12345.6789;
        bd binary_double := 12345.6789;
        en number(6,2) := 1e3;
        b1 boolean:= true;

    begin
        div := mod(c1,c2);
        dbms_output.put_line('c1 = '||c1);
        dbms_output.put_line('c2 = '||c2);
        dbms_output.put_line('c1%c2 = '||div);--дел с остатком
        dbms_output.put_line('fix = '||fix);
        dbms_output.put_line('otr = '||otr);
        dbms_output.put_line('bf = '||bf);
        dbms_output.put_line('bd = '||bd);
        dbms_output.put_line('en = '||en);
        if b1 then dbms_output.put_line('b1 = '||'true'); end if;
    end;
---------17---------

declare
    String1 constant varchar2(10):='Shast4pr';
    String2 constant char(10):='Mari2000fx';
begin
    dbms_output.put_line('String1 = ' || String1 || ', length(String1) = ' || length(String1));
    dbms_output.put_line('String2 = ' || String2 || ', length(String2) = ' || length(String2));
end;

--ссылка %TYPE-пер, %ROWTYPE-тбл
---------18-19---------

 declare
        name varchar(25) := 'Smith';
        surname name%TYPE := 'Jones';--указ на столбец
        x  dual%ROWTYPE;--указ на стр
    begin
        select 'J' into x from dual;
        dbms_output.put_line('name = '||name);
        dbms_output.put_line(x.dummy);
    end;
--20-21--все возможн конструкц if

declare
    x int := 99;
begin
    if 50 > x
        then dbms_output.put_line('50 > ' || x);
    elsif 50 = x
        then dbms_output.put_line('50 = '||x);
    elsif 100 > x
        then dbms_output.put_line('100 > ' || x);
    elsif 100 = x
        then dbms_output.put_line('100 = ' || x);
    else dbms_output.put_line('100 <> ' || x);
    end if;
end;
---------23---------

declare
  x int := 99;
begin
    case--
        when 50 > x
            then dbms_output.put_line('100 > ' || x);
        when x between 50 and 100
            then dbms_output.put_line('50 =< ' || x || ' <= 100');
        else dbms_output.put_line('not of all');
    end case;
end;
--24-25
declare
x int := 0;
begin
    dbms_output.put_line('LOOP:');
    loop--------------
        x := x + 1;
        dbms_output.put_line(x);
        exit when x > 5;
    end loop;

    dbms_output.put_line('FOR:');
    for k in 1..5------
    loop
        dbms_output.put_line(k);
    end loop;

    dbms_output.put_line('WHILE:');
    while x > 0-------------
    loop
        x := x-1;
        dbms_output.put_line(x);
    end loop;
end;
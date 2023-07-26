---------1---------
--АБ, работа select с точной выборкой
 declare
        fac faculty%rowtype;--Используется для объявления типа строки на основе таблицы;
    begin
        select * into fac from faculty where faculty='ФИТ';
        dbms_output.put_line(fac.faculty||' '||fac.faculty_name);
    end;
---------2-4--------
--АБ, работа select с НЕточной выборкой
--
declare
        fac faculty%rowtype;
    begin
        select * into fac from faculty where faculty='XXX';
    exception
        when no_data_found
        then dbms_output.put_line('Данные не найдены');
        when too_many_rows--когда в исключении несколько строк, для диагностирования неточной выборки
        then dbms_output.put_line('В результате несколько строк');
        when others--конструкция секций исключений/возникновение и обраб исключ/неявный курсор
        then dbms_output.put_line('error' || sqlcode || ': ' || sqlerrm);
    end;
---------5-9---------
--АБ, с применением операторов update и rollback
select * from auditorium;
begin
    --измен сущ значений
        update auditorium set auditorium = '341-1' where auditorium = '211-1';
        --insert into auditorium values ('555-7', '266-1', 40, 'ЛК');
        --delete from auditorium where auditorium = '324-1';
        rollback;--чтобы отменять работу выполненную в текущей транзакции
    --определяет найдена ли строка зад усл
    if sql%found then dbms_output.put('found '); end if;
    --возращает знач тру если курсор открыт
    if sql%isopen then dbms_output.put('opened '); end if;
    --тру если строка не найдена
    if sql%notfound then dbms_output.put('not found '); end if;
        dbms_output.put_line('Измененных столбцов  '||sql%rowcount);
    exception
        when others then dbms_output.put_line('error = '||sqlerrm);
    end;

--обработка исключений
declare
        sub auditorium%rowtype;
     begin
        --update auditorium set auditorium_capacity='Z' where auditorium='301-1';
        --insert into auditorium values ('x', 'x', 'x', 'x');
        delete from auditorium where auditorium_capacity='x';
        select * into sub from auditorium where auditorium_name='301-1';
    exception
        when others then dbms_output.put_line(sqlerrm);
    end;
---ЯВНЫЕ КУРСОРЫ----
select * from TEACHER;
--11.АБ, распечатывающий таблицу TEACHER с применением явного курсора LOOP-цикла
declare
        cursor cur is select teacher_name, pulpit, salary from TEACHER;
        m_name      teacher.teacher_name%type;
        m_pulpit    teacher.pulpit%type;
        m_salary    teacher.salary%type;
    --Считанные данные должны быть записаны в переменные, объявленные с применением опции %TYPE
    begin
        open cur;
        dbms_output.put_line('rowcount = '||cur%rowcount);
        loop--явный курсор лоп цикл
            fetch cur into m_name, m_pulpit, m_salary;
            exit when cur%notfound;
            dbms_output.put_line(cur%rowcount||' '||m_name||' '||
                                 m_pulpit||' '|| m_salary);
        end loop;
        dbms_output.put_line('rowcount = '||cur%rowcount);
        close cur;
    exception
        when others then dbms_output.put_line(sqlerrm);
    end;



---------12---------
--распеч таблицу предметов, считанные данные должны быть записаны в запись record
--распеч табл SUBJECT
declare
        cursor cur is select subject, subject_name, pulpit from SUBJECT;
        record subject%rowtype;--Считанные данные должны быть записаны в запись (RECORD)
    begin
        open cur;
        dbms_output.put_line('rowcount = '||cur%rowcount);
        fetch cur into record;
        while cur%found--WHILE-цикл
            loop--явный курсор
            dbms_output.put_line(cur%rowcount||' '||record.subject||' '||
                                 record.subject_name||' '||record.pulpit);
            fetch cur into record;
            end loop;
        dbms_output.put_line('rowcount = '||cur%rowcount);
        close cur;
    end;

--разработка процед и функц
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--13
--распеч все кафедры и фамил препод
declare
        cursor cur--явн
            is select pulpit.pulpit, teacher.teacher_name
            from pulpit inner join teacher on pulpit.pulpit=teacher.pulpit;
        rec cur%rowtype;
    begin
        for rec in cur--цикл for
        loop
            dbms_output.put_line(cur%rowcount||' '||rec.teacher_name||' '||rec.pulpit);
        end loop;
    end;



--14.АБ распечатывающий следующие списки аудиторий
--Примените курсор с параметрами и три способа организации цикла по строкам курсора.
declare
      cursor cur(cap1 auditorium.auditorium%type,cap2 auditorium.auditorium%type)
        is select auditorium, auditorium_capacity
          from auditorium
          where auditorium_capacity >=cap1 and AUDITORIUM_CAPACITY <= cap2;
    begin
      dbms_output.put_line('Вместимость <20 :');
      for aum in cur(0,20)
      loop dbms_output.put(aum.auditorium||' '); end loop;
      dbms_output.put_line(chr(10)||'Вместимость 20-30 :');
      for aum in cur(21,30)
      loop dbms_output.put(aum.auditorium||' '); end loop;
       dbms_output.put_line(chr(10)||'Вместимость 30-60 :');
      for aum in cur(31,60)
      loop dbms_output.put(aum.auditorium||' '); end loop;
       dbms_output.put_line(chr(10)||'Вместимость 60-80 :');
      for aum in cur(61,80)
      loop dbms_output.put(aum.auditorium||' '); end loop;
       dbms_output.put_line(chr(10)||'Вместимость выше 80 :');
      for aum in cur(81,1000)
      loop dbms_output.put(aum.auditorium||' '); end loop;
    end;


--15.ref cursor-курсорная переменная применённая для курс с парам

declare
  type audcursref is ref cursor;
  current_curcsor audcursref;
  auditorium_rec AUDITORIUM%rowtype;
begin
  open current_curcsor for select * from AUDITORIUM;
  fetch current_curcsor into auditorium_rec;
  while current_curcsor%found
  loop
    dbms_output.put_line(auditorium_rec.AUDITORIUM || ' ' || auditorium_rec.AUDITORIUM_NAME || ' ' || auditorium_rec.AUDITORIUM_CAPACITY || ' ' || auditorium_rec.AUDITORIUM_TYPE);
    fetch current_curcsor into auditorium_rec;
  end loop;
  close current_curcsor;

   exception
  when others
    then dbms_output.put_line(sqlerrm);
end;



create or replace procedure proc_refcur (targetcapacity IN AUDITORIUM.AUDITORIUM_CAPACITY%type,--передача курсора как параметра
                      p_recordset OUT SYS_REFCURSOR) as
begin
  open p_recordset for
    select * from  AUDITORIUM where  AUDITORIUM_CAPACITY=targetcapacity;
end proc_refcur;
--drop procedure proc_refcur;


declare
  current_curcsor sys_refcursor; --переменная курсрного типа
  auditorium_rec AUDITORIUM%rowtype;
begin
  proc_refcur(90, current_curcsor);
  loop
    fetch current_curcsor into auditorium_rec;
    exit when current_curcsor%notfound;
    dbms_output.put_line(auditorium_rec.AUDITORIUM || ' ' || auditorium_rec.AUDITORIUM_CAPACITY);
  end loop;
close current_curcsor;
end;
---------16---------
--курсорный подзаппрос-влож подзапр
declare
  cursor curs_aut
    is select auditorium_type,
        cursor(select auditorium
        from auditorium aum
        where aut.auditorium_type = aum.auditorium_type)
        from auditorium_type aut;
    curs_aum sys_refcursor;
    aut auditorium_type.auditorium_type%TYPE;
    txt varchar2(1000);
    aum auditorium.auditorium%TYPE;
begin
    open curs_aut;
    fetch curs_aut into aut, curs_aum;
    while(curs_aut%found)
    loop
        txt := rtrim(aut)||':';
        loop
            fetch curs_aum into aum;
            exit when curs_aum%notfound;
            txt := txt||','||rtrim(aum);
        end loop;
        dbms_output.put_line(txt);
        fetch curs_aut into aut, curs_aum;
    end loop;
    close curs_aut;
    exception
        when others
            then dbms_output.put_line(sqlerrm);
end;




--17.Уменьшите вместимость всех аудиторий

declare
    cursor cur (min_bound auditorium.auditorium_capacity%type, max_bound auditorium.auditorium_capacity%type)
        is select auditorium_capacity
            from auditorium
            where auditorium_capacity between min_bound and max_bound
            for update;
begin
    for aum_capacity in cur(40, 80)--явный курс,Уменьшите вместимость на 10%
    loop
        update auditorium set auditorium_capacity = auditorium_capacity * 0.9 where current of cur;
    end loop;
    rollback;
end;
--current of-для обращения к последней просмотренной в курсоре строке с целью его изменения или удаления её из таблицы




--18.Удалите все аудитории вместимостью от 0 до 20.

declare
    cursor c_auditorum (min_bound auditorium.auditorium_capacity%type, max_bound auditorium.auditorium_capacity%type)--явн курс с пар
        is select auditorium_capacity
            from auditorium
            where auditorium_capacity between min_bound and max_bound
            for update;
begin
    for aum_capacity in c_auditorum(0, 20)
    loop
        delete auditorium where current of c_auditorum;-----------
    end loop;
    rollback;
end;


--19.Применение псевдостолбца ROWID в update, delete
 declare
    cursor cur(capacity auditorium.auditorium%type)
            is select auditorium, auditorium_capacity, rowid--вместимость
            from auditorium
            where auditorium_capacity >=capacity for update;
      aum auditorium.auditorium%type;
      cap auditorium.auditorium_capacity%type;
    begin
      for xxx in cur(80)
      loop
        if xxx.auditorium_capacity >=80
          then update auditorium
          set auditorium_capacity = auditorium_capacity+3
          where rowid = xxx.rowid;--псевдостолбец,уникален в рамках бд,он отсутствует в табл в явном виде,но может быть использ в запросах
        end if;
      end loop;
      for yyy in cur(80)
      loop
        dbms_output.put_line(yyy.auditorium||' '||yyy.auditorium_capacity);
      end loop; rollback;
   end;
  select * from auditorium;

--20.Распечатайте в одном цикле всех преподавателей,разделив группами по три (отделите группы линией -------------).
declare
    cursor teachers is select teacher_name from teacher;
    i numeric(5);
begin
    i := 0;
    for teacher in teachers
    loop
        dbms_output.put_line(teacher.teacher_name);
        i := i + 1;
        if mod(i, 3) = 0
            then dbms_output.put_line('-----------');
        end if;
    end loop;
end;

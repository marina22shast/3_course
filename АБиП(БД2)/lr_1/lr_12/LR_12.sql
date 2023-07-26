--встроенные функции
--1
alter table TEACHER add(BIRTHDAY DATE, SALARY INT);--добавить два столбца
--delete teacher;
select * from teacher;
--drop table teacher;
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, birthday, salary ) values  ('КБЛ',    'Кабайло Александр Серафимович',  'ИСиТ', to_date('13.02.1960', 'DD.MM.YYYY'), 530);
commit;

--2.
select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||--шаблон,выделяющий из строки подстроку
      substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'. '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'. ' Фамилия_И_О
    from teacher;

--3.список преподавателей, родившихся в понедельник
select teacher_name from teacher
    where TO_CHAR((birthday), 'd') = 2;-- возвращает строковое значение


--4.представление со списком преподавателей, родившихся в след месяце
create view NextMonthBirth as
    select * from teacher
     where to_char(birthday, 'mm') = to_char(add_months(sysdate, 1), 'mm');

select * from NextMonthBirth;
--drop view NextMonthBirth;

--5.представление с кол-вом преподавателей, родившихся в каждом месяце
create view NumberOfMonths as
     select to_char(birthday, 'Month') Месяц,
            count(*) Количество
            from teacher
            group by to_char(birthday, 'Month')--сбор данных по нескольким строкам,и группировки результата по одному или нескольким столбцам или выражениям.
            order by to_char(birthday, 'Month');--сортировка

select * from NumberOfMonths;
--drop view NumberOfMonths;

--6.преподаватели, у которых в след году юбелей
declare
    cursor teacher_anniversary is
        select *
        from teacher
        where mod((to_char(sysdate, 'yyyy') - to_char(birthday, 'yyyy') + 1),5) = 0;
    v_teacher teacher%rowtype;
begin
    open teacher_anniversary;
    loop
        fetch teacher_anniversary into v_teacher;
        exit when teacher_anniversary%notfound;
        dbms_output.put_line(v_teacher.teacher_name);
    end loop;
    close teacher_anniversary;
end;
--7-среднюю заработную плату с округлением вниз до целых
declare
    cursor teacher_avg_salary is
        select floor(avg(salary)) avg_salary,  pulpit--возвращает ср знач
        from teacher
        where salary is not null
        group by pulpit;
begin
    dbms_output.put_line('Average salary for pulpits:');
    for t in teacher_avg_salary
    loop
        dbms_output.put_line(t.pulpit || ' - ' || t.avg_salary);
    end loop;
end;
--8
--записи record,продемонстрируйте раб сним и с вложенными записями
declare
        type ADDRESS is record--составную структуру данных,сост из неск полей
        (
          town nvarchar2(20),
          country nvarchar2(20)
        );
        type PERSON is record
        (
          name teacher.teacher_name%type,
          pulp teacher.pulpit%type,
          homeAddress ADDRESS---
        );
      per1 PERSON;
      per2 PERSON;
    begin
      select teacher_name, pulpit into per1.name, per1.PULP
      from teacher
      where teacher='СМЛВ';
      per1.homeAddress.town := 'Минск';
      per1.homeAddress.country := 'Беларусь';
      per2 := per1;
      dbms_output.put_line( per2.name||' '|| per2.pulp||' из '||-- позволяет отправлять сообщения из хранимых процедур и пакетов
                            per2.homeAddress.town||', '|| per2.homeAddress.country);
    end;


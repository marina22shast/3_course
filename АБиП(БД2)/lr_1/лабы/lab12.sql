---------1---------
select * from teacher;    

--2 � 7 �������
---------2---------
--������� ������� �.�.
select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'. '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'. ' �������_�_�
    from teacher;



---------3---------
--������ ��������������, ���������� � �����������
select teacher_name from teacher
    where TO_CHAR((birthday), 'd') = 2;



---------4---------
--������������� �� ������� ��������������, ���������� � ���� ������
create view NextMonthBirth as
    select * from teacher
     where to_char(birthday, 'mm') = to_char(add_months(sysdate, 1), 'mm');
    
select * from NextMonthBirth;

drop view NextMonthBirth;



---------5---------
--������������� � ���-��� ��������������, ���������� � ������ ������
create view NumberOfMonths as
     select to_char(birthday, 'Month') �����,
            count(*) ����������
            from teacher
            group by to_char(birthday, 'Month')
            order by to_char(birthday, 'Month');
     
select * from NumberOfMonths;

drop view NumberOfMonths;


---------6---------
--�������������, � ������� � ���� ���� ������
cursor TeacherBirtday(teacher%rowtype) 
        return teacher%rowtype is
        select teacher_name, birthday from teacher
        where MOD((TO_CHAR(sysdate,'yyyy') - TO_CHAR(birthday, 'yyyy')+1), 5)=0;


---------7---------
--������� ���������� ����� �� �������� � ����������� ���� �� �����
cursor AvgSalary(teacher.salary%type,teacher.pulpit%type) 
      return teacher.salary%type,teacher.pulpit%type  is
        select floor(avg(salary)), pulpit
        from teacher
        group by pulpit;


--������� ������� �������� �������� ��� ������� ����������
cursor AvgSalaryFaculty(teacher.salary%type,pulpit.faculty%type)
return teacher.salary%type,pulpit.faculty%type  is
select round(AVG(T.salary),3)�������,P.faculty
    from teacher T
    inner join pulpit P
    on T.pulpit = P.pulpit
    group by P.faculty
    union
      select floor(avg(salary)), teacher.pulpit
        from teacher
        group by teacher.pulpit
    order by faculty;


--��� ���� ����������� � �����
cursor AvgSalaryUniver(teacher.salary%type)
return teacher.salary%type  is
select round(avg(salary),3) ������� 
  from teacher;



---------8---------
--�������� ����������� ��� PL/SQL-������ (record) � ����������������� ������ � ���. 
--����������������� ������ � ���������� ��������. 
--����������������� � ��������� �������� ����������
declare
        type ADDRESS is record
        (
          town nvarchar2(20),
          country nvarchar2(20)
        );
        type PERSON is record
        (
          name teacher.teacher_name%type,
          pulp teacher.pulpit%type,
          homeAddress ADDRESS
        );
      per1 PERSON;
      per2 PERSON;
    begin
      select teacher_name, pulpit into per1.name, per1.PULP
      from teacher
      where teacher='����';
      per1.homeAddress.town := '�����';
      per1.homeAddress.country := '��������';
      per2 := per1;
      dbms_output.put_line( per2.name||' '|| per2.pulp||' �� '||
                            per2.homeAddress.town||', '|| per2.homeAddress.country);
    end;



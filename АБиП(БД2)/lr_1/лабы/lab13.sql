---------1---------
--������ ��������������, ���������� �� ������� �������� ����� � ���������. 
--������������ ��������� ���� � ����������������� ���������� ���������.

create or replace procedure GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE) is
  cursor curs1 is select TEACHER_NAME, TEACHER 
    from TEACHER 
    where PULPIT = PCODE;
    t_name TEACHER.TEACHER_NAME%type;
    t_code TEACHER.TEACHER%type;
begin
  open curs1;
  loop
    dbms_output.put_line(t_code||' '||t_name);
    fetch curs1 into t_name, t_code;
    exit when curs1%notfound;
  end loop;
  close curs1;
end;


drop procedure GET_TEACHERS;

begin
    GET_TEACHERS('����');
end;




---------2---------
--��������� �������
--���������� ��������������, ���������� �� ������� �������� ����� � ���������
create or replace function GET_NUM_TEACHERS(PCODE TEACHER.PULPIT%TYPE)
  return number is
    tCount number;
begin
  select count(*) into tCount 
    from TEACHER 
     where PULPIT = PCODE;
  return tCount;
end;

drop function GET_NUM_TEACHERS;

begin
  dbms_output.put_line(GET_NUM_TEACHERS('����'));
end;



---------4---------
--c����� �������������� �� �������� ����� ���������� ����������
create or replace procedure GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE) is
  cursor curs3 is
    select T.TEACHER_NAME, T.TEACHER, P.FACULTY
    from TEACHER T
    inner join PULPIT P
    on T.PULPIT = P.PULPIT
    where P.FACULTY = FCODE;
  t_name TEACHER.TEACHER_NAME%type;
  t_code TEACHER.TEACHER%type;
  t_faculty PULPIT.FACULTY%type;
begin
  open curs3;
  loop
    dbms_output.put_line(t_name||' '||t_code||' '||t_faculty);
    fetch curs3 into t_name, t_code, t_faculty;
    exit when curs3%notfound;
  end loop;
  close curs3;
end;

drop procedure GET_TEACHERS;

begin
    GET_TEACHERS('����');
end;



--������ ��������� �� �������, �������� ����� ������� � ���������
create or replace procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) is
  cursor curs4 is
    select S.SUBJECT, S.SUBJECT_NAME, S.PULPIT
    from SUBJECT S
    where S.PULPIT = PCODE;
   s_subject SUBJECT.SUBJECT%type;
  s_subject_name SUBJECT.SUBJECT_NAME%type;
  s_pulpit SUBJECT.PULPIT%type;
begin
  open curs4;
  loop
    dbms_output.put_line(s_subject||' '||s_subject_name||' '||s_pulpit);
    fetch curs4 into s_subject, s_subject_name, s_pulpit;
    exit when curs4%notfound;
  end loop;
  close curs4;
end;

drop procedure GET_SUBJECTS;

begin
    GET_SUBJECTS('����');
end;



---------5---------
--��������� �������
--���������� ��������������, ���������� �� ����������, �������� ����� � ��������� 
create or replace function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE)
  return number is
    tCount number;
begin
  select count(*) into tCount 
    from TEACHER T
    inner join PULPIT P
    on T.PULPIT = P.PULPIT
    where P.FACULTY = FCODE;
  return tCount;
end;

drop function GET_NUM_TEACHERS;

begin
  dbms_output.put_line(GET_NUM_TEACHERS('���'));
end;

select * from faculty;

--���������� ��������� �� �������
create or replace function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
  return number is
    tCount number:=0;
begin
  select count(*) into tCount 
    from SUBJECT
    where SUBJECT.PULPIT = PCODE;
  return tCount;
end;

drop function GET_NUM_SUBJECTS;

begin
  dbms_output.put_line(GET_NUM_SUBJECTS('����'));
end;



---------6---------
--����� � ��������� � �����������
create or replace package TEACHERS as
    FCODE FACULTY.FACULTY%TYPE;
    PCODE SUBJECT.PULPIT%TYPE;
    procedure GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE);
    procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE);
    function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) return number;
    function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) return number;
end TEACHERS;

drop package TEACHERS;


create or replace package body TEACHERS as
  function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) return number
    is tCount number;
      begin
      select count(*) into tCount from TEACHER T
      inner join PULPIT P
      on T.PULPIT = P.PULPIT
      where P.FACULTY = FCODE;
        return tCount;
      end GET_NUM_TEACHERS;
      
  function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
     return number is
        tCount number:=0;
    begin
        select count(*) into tCount
          from SUBJECT
          where SUBJECT.PULPIT = PCODE;
        return tCount;
    end GET_NUM_SUBJECTS;
    
    
  procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) is
      cursor curs4 is
          select SUBJECT, SUBJECT_NAME, S.PULPIT
            from SUBJECT S
            where S.PULPIT = PCODE;
      s_subject SUBJECT.SUBJECT%TYPE;
      s_subject_name SUBJECT.SUBJECT_NAME%TYPE;
      s_pulpit SUBJECT.PULPIT%TYPE;
    begin
      open curs4;
      loop
        dbms_output.put_line(s_subject||' '||s_subject_name||' '||s_pulpit);
        fetch curs4 into s_subject, s_subject_name, s_pulpit;
        exit when curs4%notfound;
      end loop;
      close curs4;
    end GET_SUBJECTS;
    
    
  procedure GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE) is
      cursor curs4 is
        select T.TEACHER_NAME, T.TEACHER, P.FACULTY
        from TEACHER T
        inner join PULPIT P
        on T.PULPIT = P.PULPIT
        where P.FACULTY = FCODE;
      t_name TEACHER.TEACHER_NAME%type;
      t_code TEACHER.TEACHER%type;
      t_faculty PULPIT.FACULTY%type;
    begin
      open curs4;
      loop
        dbms_output.put_line(t_name||' '||t_code||' '||t_faculty);
        fetch curs4 into t_name, t_code, t_faculty;
         exit when curs4%notfound;
      end loop;
      close curs4;
    end GET_TEACHERS;
end TEACHERS;


begin
  dbms_output.put_line(TEACHERS.GET_NUM_TEACHERS('����'));
  dbms_output.put_line(TEACHERS.GET_NUM_SUBJECTS('����'));
  TEACHERS.GET_TEACHERS('����');
  TEACHERS.GET_SUBJECTS('����');
end;

drop package TEACHERS;




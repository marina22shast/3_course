---------1---------
--��, ������ select � ������ ��������
 declare
        fac faculty%rowtype;
    begin
        select * into fac from faculty where faculty='���';
        dbms_output.put_line(fac.faculty||' '||fac.faculty_name);
    end;


---------2-4--------
--��, ������ select � �������� ��������
declare
        fac faculty%rowtype;
    begin
        select * into fac from faculty where faculty='XXX';
    exception
        when no_data_found
        then dbms_output.put_line('������ �� �������');
        when too_many_rows
        then dbms_output.put_line('� ���������� ��������� �����');
        when others
        then dbms_output.put_line('error' || sqlcode || ': ' || sqlerrm);
    end;



---------5-9---------
--��, � ����������� ���������� update, commit/rollback
select * from auditorium;
begin
        update auditorium set auditorium = '341-1' where auditorium = '211-1';
        --insert into auditorium values ('555-7', '266-1', 40, '��');
        --delete from auditorium where auditorium = '324-1';
        rollback;
        if sql%found then dbms_output.put('found '); end if;
        if sql%isopen then dbms_output.put('opened '); end if;
        if sql%notfound then dbms_output.put('not found '); end if;
        dbms_output.put_line('���������� ��������  '||sql%rowcount);
    exception
        when others then dbms_output.put_line('error = '||sqlerrm);
    end;


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



---����� �������----
---------11---------
--select * from teacher
declare
        cursor cur is select teacher_name, pulpit, salary from TEACHER;
        m_name      teacher.teacher_name%type;
        m_pulpit    teacher.pulpit%type;
        m_salary    teacher.salary%type;
    begin
        open cur;
        dbms_output.put_line('rowcount = '||cur%rowcount);
        loop
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
--������ ������� ���������, ��������� ������ ������ ���� �������� � ������ record
declare
        cursor cur is select subject, subject_name, pulpit from SUBJECT;
        record subject%rowtype;
    begin
        open cur;
        dbms_output.put_line('rowcount = '||cur%rowcount);
        fetch cur into record;
        while cur%found
            loop
            dbms_output.put_line(cur%rowcount||' '||record.subject||' '||
                                 record.subject_name||' '||record.pulpit);
            fetch cur into record;
            end loop;
        dbms_output.put_line('rowcount = '||cur%rowcount);
        close cur;
    end;



---------13---------
--��������������� ��� ������� (������� PULPIT) � ������� ���� �������������� (TEACHER) 
--�����������, ���������� (JOIN) PULPIT � TEACHER � � ����������� ������ ������� � FOR-�����
declare
        cursor cur
            is select pulpit.pulpit, teacher.teacher_name
            from pulpit inner join teacher on pulpit.pulpit=teacher.pulpit;
        rec cur%rowtype;
    begin
        for rec in cur
        loop
            dbms_output.put_line(cur%rowcount||' '||rec.teacher_name||' '||rec.pulpit);
        end loop;
    end;



---------14---------
--������, ��� ��������� (������� AUDITORIUM) � ������������ 
--������ 20, �� 21-30, �� 31-60, �� 61 �� 80, �� 81 � ����. 
--��������� ������ � ����������� � ��� ������� ����������� ����� �� ������� �������.
declare 
      cursor cur(cap1 auditorium.auditorium%type,cap2 auditorium.auditorium%type)
        is select auditorium, auditorium_capacity
          from auditorium
          where auditorium_capacity >=cap1 and AUDITORIUM_CAPACITY <= cap2;
    begin
      dbms_output.put_line('����������� <20 :');
      for aum in cur(0,20)
      loop dbms_output.put(aum.auditorium||' '); end loop;   
      dbms_output.put_line(chr(10)||'����������� 20-30 :');
      for aum in cur(21,30)
      loop dbms_output.put(aum.auditorium||' '); end loop;    
       dbms_output.put_line(chr(10)||'����������� 30-60 :');
      for aum in cur(31,60)
      loop dbms_output.put(aum.auditorium||' '); end loop;   
       dbms_output.put_line(chr(10)||'����������� 60-80 :');
      for aum in cur(61,80)
      loop dbms_output.put(aum.auditorium||' '); end loop;  
       dbms_output.put_line(chr(10)||'����������� ���� 80 :');
      for aum in cur(81,1000)
      loop dbms_output.put(aum.auditorium||' '); end loop;  
    end;
    



---------15---------
--�������� ��������� ���������� � ������� ���������� 
--���� refcursor. ����������������� �� ���������� ��� ������� c �����������
declare
    type t_faculty is ref cursor;
    cur_faculty t_faculty;
    d_faculty faculty.faculty%type;
begin
    open cur_faculty for select faculty from faculty;
    loop
        fetch cur_faculty into d_faculty;
        exit when cur_faculty%notfound;
        dbms_output.put_line(d_faculty);
    end loop;
    close cur_faculty;
end;



---------16---------
--��������� ����������
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




---------17---------
--��������� ����������� ���� ��������� (������� AUDITORIUM) ������������ �� 40 �� 80 �� 10%. 
--����������� ����� ������ � �����������, ���� FOR, ����������� UPDATE CURRENT OF.
declare
    cursor cur (min_bound auditorium.auditorium_capacity%type, max_bound auditorium.auditorium_capacity%type)
        is select auditorium_capacity 
            from auditorium
            where auditorium_capacity between min_bound and max_bound
            for update;
begin
    for aum_capacity in cur(40, 80)
    loop
        update auditorium set auditorium_capacity = auditorium_capacity * 0.9 where current of cur;
    end loop;
    rollback;
end;




---------18---------
--������� ��� ��������� (������� AUDITORIUM) ������������ �� 0 �� 20. 
--����������� ����� ������ � �����������, ���� WHILE, ����������� UPDATE CURRENT OF
declare
    cursor c_auditorum (min_bound auditorium.auditorium_capacity%type, max_bound auditorium.auditorium_capacity%type)
        is select auditorium_capacity 
            from auditorium
            where auditorium_capacity between min_bound and max_bound
            for update;
begin
    for aum_capacity in c_auditorum(0, 20)
    loop
        delete auditorium where current of c_auditorum;
    end loop;
    rollback;
end;



---------19---------
--���������� ������������� ROWID � update, delete
 declare
    cursor cur(capacity auditorium.auditorium%type)
            is select auditorium, auditorium_capacity, rowid
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
          where rowid = xxx.rowid;
        end if;
      end loop;
      for yyy in cur(80)
      loop
        dbms_output.put_line(yyy.auditorium||' '||yyy.auditorium_capacity);
      end loop; rollback;
   end;
  select * from auditorium;

---------20---------
--������������ � ����� ����� ���� �������������� (TEACHER), 
--�������� �������� �� ��� (�������� ������ ������ -------------). 
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



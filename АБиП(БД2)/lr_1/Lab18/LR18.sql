CREATE TABLE ORDRS(
	ORDER_NUM INTEGER PRIMARY KEY,
	ORDER_DATE DATE,
	PRODUCT VARCHAR2(10),
	AMOUNT NUMBER,
    text CLOB,
    img BLOB,
    f_name VARCHAR2(30),
    i_name VARCHAR2(30) );

----------------------task3
-- update ORDRS set text = upper(text);

select * from ORDRS;

--sqlldr system/1111 CONTROL=ORDRS.ctl--1

--spool opt/oracle/1.txt--2
--select * from ORDRS;
--spool off




--drop table ORDRS;

--docker cp D:\3kr_5sem\lab18\ORDRS.ctl 57a276d55568493a0639a9f04355de7abb1ef3a5b60326ed1548e84f53a21f83:/opt/oracle
LOAD DATA
INFILE DataForLoad.txt	
INTO TABLE WORKERS_HIRING 
INSERT 
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"' 
(
workerid,
workername,
hiringdate date 'DD-MM-YYYY',
salary
)

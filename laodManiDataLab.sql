set echo on 
spool c:\cprg250s\LoadGHCOutput.txt
rem
-- Delete exiting data , childer followed by parent
Delete GHC_expertise;
delete GHC_faculty;
delete GHC_course;
delete GHC_department;
-- insert data , parent followed by children
rem 
insert into GHC_department(department_number,department_name) values(100,'Astrophysics');

rem
insert into GHC_course(course_code,course_title,course_credit) values('APHY202','The Solar System',5);
insert into GHC_course(course_code,course_title,course_credit) values('APHY203','Nebula',5);
insert into GHC_course(course_code,course_title,course_credit) values('APHY204','Web Global Clusters',5);

rem
insert into GHC_faculty(faculty_id,faculty_first_name,faculty_last_name,date_hire,date_fired,is_active,department_number) 
    values(1001,'Danny','Faulkner','1-Jan-22',NULL,1,100);

rem
insert into GHC_expertise(faculty_id,course_code) values(1001,'');
insert into GHC_expertise(faculty_id,course_code) values(1294,'APHY202');
insert into GHC_expertise(faculty_id,course_code) values(1294,'APHY203');

--verify the interstion worked
select * from GHC_department;
select * from GHC_faculty;
select * from GHC_course;
select * from GHC_expertise;
commit;
spool off



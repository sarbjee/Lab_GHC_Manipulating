set echo on 
spool c:\cprg250s\LoadGHCOutput.txt
rem
-- Delete exiting data , child  followed by parent
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
insert into GHC_expertise(faculty_id,course_code) values(1001,'APHY202');
insert into GHC_expertise(faculty_id,course_code) values(1001,'APHY203');
insert into GHC_expertise(faculty_id,course_code) values(1001,'APHY204');

-
--- update record question 4
insert into GHC_course(course_code,course_title,course_credit) values('APHY302','Nebula',5);
--remove 1001 to avoid reference key conflict first
DELETE GHC_expertise
WHERE faculty_id=1001;
-- delete the record 
DELETE GHC_course
WHERE course_code ='APHY203';



--verify the intersation worked
select * from GHC_department;
select * from GHC_faculty;
select * from GHC_course;
select * from GHC_expertise;
commit;
spool off



SET ECHO ON
SET FEEDBACK ON
spool c:\cprg250s\LoadGHCOutput.txt
-- drop child table first
DROP TABLE GHC_expertise cascade constraints;
DROP TABLE GHC_faculty cascade constraints;
DROP TABLE GHC_course cascade constraints;
DROP TABLE GHC_department cascade constraints;
--create table in reverse order 
rem create tables
CREATE TABLE GHC_department(
    department_number NUMBER,
    department_name VARCHAR2(100));

ALTER TABLE GHC_department
    ADD CONSTRAINT SYS_D_PK PRIMARY KEY(department_number)
    ADD CONSTRAINT SYS_DEPN_UK UNIQUE(department_name)
    MODIFY department_name CONSTRAINT SYS_DPN_NN NOT NULL;
rem 
insert into GHC_department(department_number,department_name) values(100,'Astrophysics');

CREATE TABLE GHC_course(
    course_code CHAR(7),
    course_title VARCHAR2(100),
    course_credit NUMBER,
    CONSTRAINT SYS_COUR_PK PRIMARY KEY(course_code));
rem
ALTER TABLE GHC_course
    MODIFY course_title CONSTRAINT SYS_COURTIT_NN NOT NULL
    MODIFY course_credit CONSTRAINT SYS_COUR_CR_NN NOT NULL
    ADD CONSTRAINT SYS_CC_CK CHECK(course_credit between 1 AND 9);
rem
insert into GHC_course(course_code,course_title,course_credit) values('APHY202','The Solar System',5);
insert into GHC_course(course_code,course_title,course_credit) values('APHY203','Nebula',5);
insert into GHC_course(course_code,course_title,course_credit) values('APHY204','Web Global Clusters',5);
rem
CREATE TABLE GHC_faculty(
    faculty_id NUMBER,
    faculty_first_name VARCHAR2(20),
    faculty_last_name VARCHAR2(20),
    date_hire DATE,
    date_fired DATE,
    is_active NUMBER,
    department_number NUMBER,
    CONSTRAINT SYS_F_PK PRIMARY KEY(faculty_id)
    );
rem

ALTER TABLE GHC_faculty
    ADD CONSTRAINT SYS_FAC_FK FOREIGN KEY(department_number) REFERENCES GHC_department(department_number)
    MODIFY faculty_first_name CONSTRAINT SYS_FFN_NN NOT NULL
    MODIFY faculty_last_name CONSTRAINT SYS_FLN_NN NOT NULL
    ADD CONSTRAINT SYS_FA_CK CHECK(is_active IN(0,1))
    MODIFY date_hire CONSTRAINT SYS_HRD_NN NOT NULL;
rem
rem
insert into GHC_faculty(faculty_id,faculty_first_name,faculty_last_name,date_hire,date_fired,is_active,department_number) 
    values(1001,'Danny','Faulkner','1-Jan-22',NULL,1,100);
CREATE TABLE GHC_expertise(
    faculty_id NUMBER CONSTRAINT SYS_EX_FK REFERENCES GHC_faculty(faculty_id),
    course_code CHAR(7) CONSTRAINT SYS_EXC_FK REFERENCES GHC_course(course_code),
    CONSTRAINT SYS_EXCF_PK PRIMARY KEY(faculty_id,course_code)
);
insert into GHC_expertise(faculty_id,course_code) values(1001,'APHY202');
insert into GHC_expertise(faculty_id,course_code) values(1001,'APHY203');
insert into GHC_expertise(faculty_id,course_code) values(1001,'APHY204');


--- update record question 3,4,5
insert into GHC_course(course_code,course_title,course_credit) values('APHY302','Nebula',5);
--remove 1001 to avoid reference key conflict first
DELETE GHC_expertise
WHERE faculty_id=1001;
-- delete the record from course table 
DELETE GHC_course
WHERE course_code IN ('APHY203','APHY202','APHY204');
rem
--verify 
select * from GHC_department;
select * from GHC_faculty;
select * from GHC_course;
select * from GHC_expertise;
commit;

spool off

set echo on
spool c:\cprg250s\LoadGHCOutput.txt
-- drop child table first
DROP TABLE GHC_expertise cascade constraints;
DROP TABLE GHC_faculty cascade constraints;
DROP TABLE GHC_course cascade constraints;
DROP TABLE GHC_department cascade constraints;
--create table in reverse order 
rem create table without  any constraints
CREATE TABLE GHC_department(
    department_number NUMBER,
    department_name VARCHAR2(100));
--ALTER TABLE TO ADD CONST

ALTER TABLE GHC_department
    ADD CONSTRAINT SYS_D_PK PRIMARY KEY(department_number)
    ADD CONSTRAINT SYS_DEPN_UK UNIQUE(department_name)
    MODIFY department_name CONSTRAINT SYS_DPN_NN NOT NULL;
--TABLE LEVEL CONST
CREATE TABLE GHC_course(
    course_code CHAR(7),
    course_title VARCHAR2(100),
    course_credit NUMBER,
    CONSTRAINT SYS_COUR_PK PRIMARY KEY(course_code));
ALTER TABLE GHC_course
    MODIFY course_title CONSTRAINT SYS_COURTIT_NN NOT NULL
    MODIFY course_credit CONSTRAINT SYS_COUR_CR_NN NOT NULL
    ADD CONSTRAINT SYS_CC_CK CHECK(course_credit between 1 AND 9);
CREATE TABLE GHC_faculty(
    faculty_id NUMBER,
    faculty_first_name VARCHAR2(20),
    faculty_last_name VARCHAR2(20),
    date_hire DATE,
    date_fired DATE,
    is_active NUMBER,
    department_number VARCHAR2(100),
    CONSTRAINT SYS_F_PK PRIMARY KEY(faculty_id)
    );
-- WHEN MAKE foreign key diff syntax than column level
ALTER TABLE GHC_faculty
    ADD CONSTRAINT SYS_FAC_FK FOREIGN KEY(department_number) REFERENCES GHC_department(department_number)
    MODIFY faculty_first_name CONSTRAINT SYS_FFN_NN NOT NULL
    MODIFY faculty_last_name CONSTRAINT SYS_FLN_NN NOT NULL
    ADD CONSTRAINT SYS_FA_CK CHECK(is_active IN(0,1))
    MODIFY date_hire CONSTRAINT SYS_HRD_NN NOT NULL;
--add conposit primary key in bridiging table 
CREATE TABLE GHC_expertise(
    faculty_id NUMBER CONSTRAINT SYS_EX_FK REFERENCES GHC_faculty(faculty_id),
    course_code CHAR(7) CONSTRAINT SYS_EXC_FK REFERENCES GHC_course(course_code),
    CONSTRAINT SYS_EXCF_PK PRIMARY KEY(faculty_id,course_code)
);

spool off
C:\cprg250s\Lab_GHC_Manipulatin\build_ManiDataLab.sql
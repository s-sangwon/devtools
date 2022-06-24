-- DAY8_DDL_DML2.sql
-- DDL ������ DML ����

-- ���������� ����ؼ� �� ���̺��� ���� �� ����
-- SELECT ���� ����� ���̺� �����Ѵٴ� �ǹ̰� ��

CREATE TABLE EMP_DEPT90
AS
SELECT * FROM EMPLOYEE
WHERE DEPT_ID = '90';

SELECT * FROM EMP_DEPT90;

-- ���̺� ���� Ȯ�� : DESC[RIBE] ���̺��;
DESCRIBE EMP_DEPT90;
DESC EMP_DEPT90;

-- �غ�� SQL ��ũ��Ʈ ���� ���� ��ɾ� : START ��θ�\\���ϸ�.sql
-- START => ����� : @ ��θ�\\���ϸ�.sql

-- ���������� �̿��ؼ� ������ ���̺��� ������ ���,
-- �÷���, �ڷ���, NOT NULL �������Ǹ� �״�� �����
-- ������ �������ǵ�� DEFAULT �� ���� �� ��

-- ���� ���̺� ���纻 ���� ���� �̿��� �� ����
CREATE TABLE EMP_COPY
AS
SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;
DESC EMP_COPY;

-- �ǽ� 1.
-- ���, �̸�, �޿�, ���޸�, �μ���, �ٹ�������, �Ҽӱ����� ��ȸ�� �����
-- EMP_LIST ���̺� ������. (��, ���� ��ü �������� ��)
CREATE TABLE EMP_LIST
AS 
SELECT EMP_ID, EMP_NAME, SALARY, JOB_TITLE, 
        DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING (COUNTRY_ID);

SELECT * FROM EMP_LIST;  -- Ȯ��
DESC EMP_LIST;  -- ���̺� ���� Ȯ��

-- �ǽ� 2.
-- EMPLOYEE ���̺��� ���� �������� ������ ��ȸ�ؼ�
-- EMP_MAN ���̺� ������
CREATE TABLE EMP_MAN
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

SELECT * FROM EMP_MAN;

-- ���� �������� ������ ��󳻼� EMP_FEMAIL ���̺� ������
CREATE TABLE EMP_FEMAIL
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT * FROM EMP_FEMAIL;

-- �ǽ� 3. 
-- �μ����� ���ĵ� ��� ������ ����� PART_LIST ���̺� ������
-- DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID �� ��ȸ��
-- ������ ���̺��� �� �÷��� ����(COMMENT) �ޱ�
-- �μ���, ���޸�, �̸�, ���

CREATE TABLE PART_LIST
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME;

SELECT * FROM PART_LIST;

COMMENT ON COLUMN PART_LIST.DEPT_NAME IS '�μ���';
COMMENT ON COLUMN PART_LIST.JOB_TITLE IS '���޸�';
COMMENT ON COLUMN PART_LIST.EMP_NAME IS '�̸�';
COMMENT ON COLUMN PART_LIST.EMP_ID IS '���';

DESC PART_LIST;

-- ���������� �� ���̺� ���� ��, �÷��� �ٲ� �� ����
-- ���ǻ��� : �������� SELECT ���� �÷� ������ �ٲ� �÷����� ������ �����ؾ� ��
/*
CREATE TABLE ���̺�� (�ٲ��÷���, ......)
AS ��������;
*/

CREATE TABLE PART_LIST2 (DNAME, JTITLE, ENAME, EID)
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME;

DESC PART_LIST2;

-- ���� ���� : 
CREATE TABLE PART_LIST3 (DNAME, JTITLE, ENAME)  -- �ٲ� �÷��� : 3��
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID  -- �÷� : 4��
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME;

-- �ذ��� : �Ϻ� �÷��� �ٲٷ���, SELECT ���� ��Ī(ALIAS) �����
CREATE TABLE PART_LIST3
AS
SELECT DEPT_NAME DNAME, JOB_TITLE JTITLE, EMP_NAME ENAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
ORDER BY DEPT_NAME;

DESC PART_LIST3;

-- �ǽ� : ���������� ������ ���̺� �����
-- ���̺�� : PHONEBOOK
-- �÷��� :  ID  CHAR(3) �⺻Ű(�����̸� : PK_PBID)
--         PNAME      VARCHAR2(20)  �� ������.
--                                 (NN_PBNAME) 
--         PHONE      VARCHAR2(15)  �� ������
--                                 (NN_PBPHONE)
--                                 �ߺ��� �Է¸���
--                                 (UN_PBPHONE)
--         ADDRESS    VARCHAR2(100) �⺻�� ������
--                                 '����� ���α�'

-- NOT NULL�� �����ϰ�, ��� ���̺� �������� ������.

CREATE TABLE PHONEBOOK (
       ID    CHAR(3),
       PNAME VARCHAR2(20) CONSTRAINT NN_PBNAME NOT NULL,
       PHONE VARCHAR2(15) CONSTRAINT NN_PBPHONE NOT NULL,
       ADDRESS VARCHAR2(100) DEFAULT '����� ���α�',
	   -- ���̺���
       CONSTRAINT PK_PBID PRIMARY KEY (ID),
       CONSTRAINT UN_PBPHONE UNIQUE (PHONE)       
);

INSERT INTO PHONEBOOK 
VALUES ('A01', 'ȫ�浿', '010-1234-5678', DEFAULT);

SELECT * FROM PHONEBOOK;

-- ���������� �� ���̺� ���� ��, �÷��� �ٲٸ鼭 �������ǵ� �߰��� �� ����
-- FOREIGN KEY ���������� �߰��� �� ����
-- ���ǻ��� : ���������� ��� �����Ϳ� ���������� �¾ƾ� �߰��� �� ����
CREATE TABLE TBL_SUBQUERY3 (
    EID PRIMARY KEY, -- OK
    ENAME,
    SAL CHECK (SAL > 2000000),  -- ERROR, ���ǿ� ���� �ʴ� ���� ��ϵǾ� ����
    DNAME,
    JTITLE NOT NULL  -- ERROR, NULL �� ���ԵǾ� ����
)
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, 
        -- JTITLE NOT NULL �ذ� 2
        NVL(JOB_TITLE, '������')
        JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
-- CHECK (SAL > 2000000) �ذ�
WHERE SALARY > 2000000
-- JTITLE NOT NULL �ذ� 1
-- AND JOB_TITLE IS NOT NULL;

-- ���̺� ���� ���� *********************
-- DROP TABLE ���������̺�� [CASCADE CONSTRAINTS];
-- ���������� ���� ���̺��� ������ �� ����
-- �������ǵ� �Բ� �����ϸ� ��
DROP TABLE EMPLOYEE;  -- �������� �ִ� ���̺���. ���� ���� : ERROR
DROP TABLE TBL_SUBQUERY3 CASCADE CONSTRAINTS;

-- ������ ��ųʸ� (������ ����) ********************************
-- ����ڰ� ������ 
-- ��� �����ͺ��̽� ��ü ������ ���̺� ���·� �ڵ� ��������ϴ� ����
-- ��ȸ�� �� �� �ְ�, ���� �� ��
-- DBMS �ý��ۿ� ���� �ڵ� �����ǰ� ����
-- ���� ���, ����ڰ� ���� ���̺�, ����ڰ� ������ �������ǵ鵵 �ڵ� ���� ������

-- �������� ���� ��ųʸ� : USER_CONSTRAINTS
DESC USER_CONSTRAINTS;

-- �������� ��ųʸ� ��ȸ
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, 
        TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'PHONEBOOK';

-- CONSTRINT_TYPE 
-- P : PRIMARY KEY
-- U : UNIQUE
-- R : FOREIGN KEY
-- C : CHECK, NOT NULL

-- ����ڰ� ������ ���̺� ��ü ���� : USER_TABLES
SELECT * FROM USER_TABLES;

-- ����ڰ� ���� �� ��ü ���� : USER_VIEWS
SELECT * FROM USER_VIEWS;

-- ����ڰ� ���� ������ ��ü ���� : USER_SEQUENCES
SELECT * FROM USER_SEQUENCES;

-- ����ڰ� ���� �ε��� ��ü ���� : USER_INDEXES
SELECT * FROM USER_INDEXES;

-- ���������� ������ ���̺��� ���� ��, �����ʹ� �����ϰ� ������ ������ �� ����
-- WHERE ���� 1 = 0 ǥ���ϸ� ��
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT
WHERE 1 = 0;

SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

-- DDL (Data Definition Language : ������ ���Ǿ�)
-- CREATE, ALTER, DROP
-- �����ͺ��̽� ��ü�� �����, �����ϰ�, �����ϴ� ������
-- ���̺� : CREATE TABLE, ALTER TABLE, DROP TABLE
-- �� : CREATE VIEW, DROP VIEW
-- ������ : CREATE SEQUENCE, ALTER SEQUENCE, DROP SEQUENCE
-- �ε��� : CREATE INDEX, DROP INDEX

-- ���̺� ���� (ALTER TABLE) ************************
-- �÷� �߰�/����, �������� �߰�/����
-- �÷� �ڷ��� ���� (�ڷ��� ũ�� ���� ����)
-- ���̺��, �÷���, �������� �̸� ����
-- DEFAULT �� ����

-- �׽�Ʈ�� ���̺� Ȯ��
DROP TABLE DEPT_COPY;

CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- �÷� �߰�
-- ���̺� ������ �÷� �ۼ��� �����ϰ� �ۼ��ϸ� ��
ALTER TABLE DEPT_COPY
ADD (LNAME  VARCHAR2(40));

-- Ȯ��
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

-- �÷� �߰��� DEFAULT ���� ���� ������ �� ����
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(30) DEFAULT '�ѱ�');

SELECT * FROM DEPT_COPY;

-- �������� �߰�
CREATE TABLE EMP2
AS
SELECT * FROM EMPLOYEE;

SELECT * FROM EMP2;
DESC EMP2;

-- NOT NULL �� ADD �� �߰��� �� ����
-- MODIFY �� NULLABLE ���¸� YES ���� NO �� �����ؾ� ��
ALTER TABLE EMP2
ADD NOT NULL (HIRE_DATE);  -- ERROR

ALTER TABLE EMP2
MODIFY (HIRE_DATE NOT NULL);

DESC EMP2;

ALTER TABLE EMP2
ADD PRIMARY KEY (EMP_ID);

ALTER TABLE EMP2
ADD CONSTRAINT E2_UNENO UNIQUE (EMP_NO);

-- �÷� �ڷ��� ����
CREATE TABLE EMP3
AS
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

SELECT * FROM EMP3;
DESC EMP3;

ALTER TABLE EMP3
MODIFY (EMP_ID VARCHAR2(5), 
         EMP_NAME CHAR(20));

DESC EMP3;

-- DEFAULT �� ����
CREATE TABLE EMP4 (
    EMP_ID  CHAR(3),
    EMP_NAME VARCHAR2(20),
    ADDR1  VARCHAR2(20)  DEFAULT '����',
    ADDR2  VARCHAR2(100)
);

INSERT INTO EMP4 
VALUES ('A10', '������', DEFAULT, 'û�㵿');

INSERT INTO EMP4 
VALUES ('B10', '�̺���', DEFAULT, '���ﵿ');

SELECT * FROM EMP4;

ALTER TABLE EMP4
MODIFY (ADDR1 DEFAULT '���');

INSERT INTO EMP4 
VALUES ('C10', '�ӽ¿�', DEFAULT, '���ڵ�');

SELECT * FROM EMP4;

-- �÷� ����
DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP COLUMN CNAME;  -- �÷� 1�� ����

DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP (LOC_ID, LNAME);  -- �÷� ���� �� ����

DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
DROP (DEPT_ID, DEPT_NAME);  -- ERROR
-- �����ͺ��̽����� ���̺��� �ּ� 1���� �÷��� ������ �־�� ��
-- �÷��� ���� ���̺��� ������ �� ���� : ��� �÷��� ������ �� ����
-- ���̺� �����ÿ��� ����������
CREATE TABLE TTT ();

-- ���������� ���� �÷��� �׳� ������ �� ����
-- FOREIGN KEY ������������ �����ǰ� �ִ� �÷�(�θ�Ű)�� �׳� ������ �� ����
-- �ذ� : �÷��� ���������� �Բ� ����(CASCADE)�ϸ� ��
-- CASCADE CONSTRAINTS �� ���� �ڿ� ǥ����

ALTER TABLE DEPARTMENT
DROP (DEPT_ID);  -- ERROR

CREATE TABLE TB1 (
    PK  NUMBER  PRIMARY KEY,  -- �θ�Ű
    FK  NUMBER  REFERENCES TB1,  -- �ڽķ��ڵ�
    COL1   NUMBER,
    CHECK (COL1 > 0 AND PK > 0)
);

ALTER TABLE TB1
DROP (PK);  -- ERROR

ALTER TABLE TB1
DROP (COL1); -- ERROR

-- �������ǵ� �Բ� �����ϸ� ��
ALTER TABLE TB1
DROP (PK) CASCADE CONSTRAINTS;

DESC TB1;

ALTER TABLE TB1
DROP (COL1) CASCADE CONSTRAINTS;

DESC TB1;

-- �������� ����
SELECT * FROM CONSTRAINT_EMP;
DESC CONSTRAINT_EMP;

-- �������� Ȯ��
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, 
        TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONSTRAINT_EMP';

-- ���̺� �̸� �ٲٱ�
RENAME CONSTRAINT_EMP TO CONST_EMP;

-- �������� ���� �� ����
ALTER TABLE CONST_EMP
DROP CONSTRAINT FKDID
DROP CONSTRAINT FKJID
DROP CONSTRAINT FKMID;

-- �������� Ȯ��
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, 
        TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONST_EMP';

-- NOT NULL ���������� ������ �ƴ϶� ������
-- NOT NULL �� NULL �� �ٲ�
ALTER TABLE CONST_EMP
MODIFY (ENAME NULL, ENO NULL);

-- �������� Ȯ��
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, 
        TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONST_EMP';

-- USER_CONSTRAINTS ��ųʸ� : �÷� ���� ����
-- �÷��� ���������� �����ϴ� ��ųʸ� : USER_CONS_COLUMNS
DESC USER_CONS_COLUMNS;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME,
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'CONST_EMP';

-- �������� ���� 2
ALTER TABLE CONST_EMP
DROP PRIMARY KEY;

ALTER TABLE CONST_EMP
DROP UNIQUE (ENO);

-- �̸� �ٲٱ� : ���̺��, �÷���, ���������̸�
-- �÷��� �ٲٱ�
DESC DEPT_COPY;

ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_ID TO DID;

DESC DEPT_COPY;

-- �������� �̸� �ٲٱ�
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME,
        DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'CONST_EMP';

ALTER TABLE CONST_EMP
RENAME CONSTRAINT CHK TO MRG_CHK;

-- ���̺�� �ٲٱ�
ALTER TABLE DEPT_COPY RENAME TO DPCOPY;
RENAME DPCOPY TO DEPT_COPY;

-- ���̺� �����ϱ� *****************
DROP TABLE DEPT_COPY;

DROP TABLE DEPARTMENT;  -- ERROR
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;

ROLLBACK;  -- DDL ������ ���� �� ��, DML ������ ������


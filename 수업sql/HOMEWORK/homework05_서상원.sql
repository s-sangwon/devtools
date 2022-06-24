-- homework05_�����.sql
-- DDL

--1. �迭 ������ ������ ī�װ� ���̺��� ������� ����. ������ ���� ���̺���
--�ۼ��Ͻÿ�.

CREATE TABLE TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);


--2. ���� ������ ������ ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CLASS_TYPE (
    NO      VARCHAR2(5) PRIMARY KEY,
    NAME    VARCHAR2(10)
);

--3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
--(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸��� �����ϰ��� ���ٸ� �̸��� ������
--�˾Ƽ� ������ �̸��� �������.)
ALTER TABLE TB_CATEGORY
ADD PRIMARY KEY (NAME);


--4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE
MODIFY (NAME NOT NULL);
DESC TB_CLASS_TYPE;


--5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
--NAME �� ���� ���C������ ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE
MODIFY (NO VARCHAR2(10))
MODIFY (NAME VARCHAR2(20));
DESC TB_CLASS_TYPE;

ALTER TABLE TB_CATEGORY
MODIFY (NAME VARCHAR2(20));
DESC TB_CATEGORY;

--6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ�
--���� ���·� ��������.
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;
DESC TB_CATEGORY;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;

DESC TB_CLASS_TYPE;

--7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ����
--�����Ͻÿ�.
--Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME,
            DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING(TABLE_NAME, CONSTRAINT_NAME)
WHERE TABLE_NAME = 'TB_CLASS_TYPE'; -- ���������̸� Ȯ��

ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT SYS_C007589 TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C007588 TO PK_CLASS_TYPE_NO;

--8. ������ ���� INSERT ���� ��������.
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;

--9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ�
--������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
--FK_���̺��̸�_�÷��̸����� ��������. (ex. FK_DEPARTMENT_CATEGORY )
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME,
            DELETE_RULE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING(TABLE_NAME, CONSTRAINT_NAME)
WHERE TABLE_NAME = 'TB_DEPARTMENT';


-- DML
--1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
--��ȣ, �����̸�
--------------
--01, �����ʼ�
--02, ��������
--03, �����ʼ�
--04, ���缱��
--05. ������
INSERT INTO TB_CLASS_TYPE VALUES ('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES ('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES ('05', '������');
SELECT * FROM TB_CLASS_TYPE;

--2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� ����. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
CREATE TABLE TB_�л��Ϲ�����
AS
SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, STUDENT_ADDRESS �ּ�
FROM TB_STUDENT;

SELECT * FROM TB_�л��Ϲ�����;

--3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� ����. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ�
--�ۼ��Ͻÿ�)
CREATE TABLE TB_������а�
AS
SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, 
                    --TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD'), 'YYYY'), 
                    EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) ����⵵, 
                    PROFESSOR_NAME �����̸�
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                            FROM TB_DEPARTMENT
                                            WHERE DEPARTMENT_NAME = '������а�');
                                            
                                            
                                    
SELECT * FROM TB_������а�;







SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, 
                    --TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD'), 'YYYY'), 
                    EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) ����⵵, 
                    PROFESSOR_NAME �����̸�
FROM TB_STUDENT
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE TB_STUDENT.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                            FROM TB_DEPARTMENT
                                            WHERE DEPARTMENT_NAME = '������а�')

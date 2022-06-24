-- DAY7_DDL_DML1.sql
-- DDL ������ DML ����

/*
DDL (Data Definition Language : ������ ���Ǿ�)
-- �����ͺ��̽� ��ü�� ���� �� ����ϴ� sql ����
-- ���� �����ͺ��̽����� ORDB (Object Relational DataBase) �̴�.
-- �����ͺ��̽� ��ü : TABLE, VIEW, SEQUENCE, INDEX, USER ��
-- ��ɾ� : CREATE(����), ALTER(����), DROP(����)

-- ���̺� ����� : CREATE TABLE
-- �ۼ����� : 
CREATE TABLE ���̺�� (
    �÷���  �ڷ���(����Ʈũ��) [DEFAULT �⺻��],
    �÷���  �ڷ���(ũ��) [��������],
    �÷���  �ڷ���,
    .......
);
*/

DROP TABLE TEST;

CREATE TABLE TEST (
    USERID      VARCHAR2(20),
    USERNAME    VARCHAR2(30),
    PASSWORD   VARCHAR2(20),
    AGE     NUMBER,
    ENROLL_DATE DATE
);

CREATE TABLE TEST2 (
    MEMBER_ID   VARCHAR2(15CHAR),
    MEMBER_PWD VARCHAR2(15),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE    DEFAULT SYSDATE,
    GENDER  CHAR(1)     DEFAULT 'M'
);

CREATE TABLE TEST3 (
    MEM_ID  VARCHAR2(15)  PRIMARY KEY,
    MEM_PWD  VARCHAR2(15) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_DATE  DATE  DEFAULT SYSDATE,
    GENDER   CHAR(1) DEFAULT 'M' CHECK (GENDER IN ('F', 'M'))
);

-- �÷��� ���� �ޱ� : COMMENT ON COLUMN ���� �����
-- COMMENT ON COLUMN [����ڰ���.]���̺��.�÷��� IS '����';
COMMENT ON COLUMN TEST3.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN TEST3.mem_pwd IS 'ȸ����ȣ';
COMMENT ON COLUMN TEST3.mem_name IS 'ȸ���̸�';
COMMENT ON COLUMN TEST3.mem_date IS 'ȸ�����Գ�¥';
COMMENT ON COLUMN TEST3.gender IS 'ȸ������';

CREATE TABLE ORDERS (
    ORDERNO     CHAR(4),
    CUSTNO      CHAR(4),
    ORDERDATE   DATE    DEFAULT SYSDATE,
    SHIPDATE    DATE,
    SHIPADDRESS VARCHAR2(40),
    QUANTITY    NUMBER
);

-- �÷� ���� �ޱ� : 
comment on column orders.orderno is '�ֹ���ȣ';
COMMENT ON COLUMN orders.CUSTNO IS '����ȣ';
COMMENT ON COLUMN orders.ORDERDATE IS '�ֹ�����';
COMMENT ON COLUMN orders.SHIPDATE IS '�������';
COMMENT ON COLUMN orders.SHIPADDRESS IS '����ּ�';
COMMENT ON COLUMN orders.QUANTITY IS '�ֹ�����';

-- ********************************************
/*
���Ἲ �������ǵ� (CONSTRAINTS)
-- ���̺� �����Ͱ� ��� �Ǵ� ������ �� �ùٸ� ���� ��ϵǵ��� �˻��ϴ� ���
-- ���̺��� ����� �������� �ŷڼ��� ���̱� ���� ����� : ������ ���Ἲ

�������� ���� ��� : 
1. ���̺� ���� �� �÷��� ������
2. ���̺� ���� �Ŀ� ���̺� ������ �������� �߰���

CREATE TABLE ���̺�� (
  �÷���  �ڷ���(ũ��) [DEFAULT �⺻��] ��������,
  �÷���  �ڷ���(ũ��) CONSTRAINT ���������̸� ��������,
  ........... �÷� ���� ���� : �÷����� ................ ,
  �÷��� �ڷ���,
  �÷��� �ڷ���,
  -- �÷� ���� �Ϸ� �Ŀ� �������ǵ��� ���� ��Ƽ� ������ ���� ����
  -- ���̺���
  �������� (�������÷���),
  CONSTRAINT ���������̸�  �������� (�������÷���)
);

-- ���̺��� �����Ǹ�, �������ǵ鵵 ���� ������
-- �̸� �������� ������ �������ǵ��� �ڵ����� �̸��� �ٿ��� : SYS_C000000 ����
-- �������� �۵���, ���̺� �����Ͱ� ��ϵ� �� �˻����� �۵���
-- ���������� ����� ���� ��ϵǸ� ���� �߻� : �� ��� �� ��
*/

-- DML (Data Manipulation Language : ������ ���۾�)
/*
��ɾ� : INSERT (���ο� �� �߰�), UPDATE (��ϵ� �� ����), DELETE (�� ����)

-- INSERT �� �ۼ����� : 
INSERT INTO ���̺�� [(�÷���, �÷���, �÷���, ......)]
VALUES (����� ��, ����� ��, ��, ....);

-- ���̺��� ���� ��� �÷��� ���� ����� ���� �÷��� ������ ������ �� ����
INSERT INOT ���̺��
VALUES (����� ��, ��, ....);
-- ���ǻ��� : �÷� ���� ������ ���缭 ���� ����ؾ� ��
*/

-- TEST ���̺� ������ ��� ����
INSERT INTO TEST
VALUES ('user007', 'ȫ�浿', 'pass007', 27, SYSDATE);

INSERT INTO TEST (USERID, USERNAME, PASSWORD, AGE, ENROLL_DATE)
VALUES ('user001', '������', 'pass001', 35, TO_DATE('20211030', 'RRRRMMDD'));

SELECT * FROM TEST;

-- �������� : NOT NULL ------------------------------
-- �ݵ�� ���� ��ϵǾ�� �ϴ� �÷��� �����
-- �ʼ��Է��׸��� ���� ����ϴ� �÷��� ������ �� ����
-- �÷��� NULL(��ĭ)�� ��� �� �Ѵٴ� �ǹ���
-- �÷����������� ������ �� ����. (���̺������� ���� �� ��)

CREATE TABLE TESTNN (
    NID NUMBER(5) NOT NULL, -- �÷�����, �������� �̸������� SYS_C.... �̸� �־���
    N_NAME VARCHAR2(20)
);

INSERT INTO TESTNN
VALUES (12, '����Ŭ');

INSERT INTO TESTNN
VALUES (NULL, '���̽�');  -- NOT NULL ERROR

INSERT INTO TESTNN (N_NAME)
VALUES ('���̽�');  -- ���ܵ� �÷��� NULL ó����, NOT NULL ERROR

INSERT INTO TESTNN
VALUES (23, NULL);

INSERT INTO TESTNN (NID)
VALUES (35);  -- ���ܵ� N_NAME �÷��� NULL ó����

SELECT * FROM TESTNN;

-- ���̺��� ���� Ȯ��
CREATE TABLE TESTNN2 (
    NID NUMBER(5),
    N_NAME VARCHAR2(20),
    -- ���̺���
    CONSTRAINT NN_T2_NID NOT NULL (NID)
);  -- ERROR

-- �������� : UNIQUE ---------------------------------
-- �÷��� �ߺ���(���� �� �ι� ���) ����� �˻��ϴ� ����������
-- �ߺ� ����� ���� �˻�����
-- �÷�����, ���̺��� �� �� ���� ������
-- NULL ����� �� ����

CREATE TABLE TESTUN (
    U_ID  CHAR(3)  UNIQUE,
    U_NAME VARCHAR2(10) NOT NULL
);

INSERT INTO TESTUN VALUES ('AAA', '����Ŭ');
INSERT INTO TESTUN VALUES ('AAA', '���̼�');  -- �ߺ� ����
INSERT INTO TESTUN VALUES (NULL, '���̼�');

SELECT * FROM TESTUN;

-- �������� ���ڿ�(CHAR)�� �������� ���ڿ�(VARCHAR2) ���� Ȯ��
CREATE TABLE TESTCHAR (
    TCH  CHAR(10),
    TVCH VARCHAR2(10)
);

INSERT INTO TESTCHAR VALUES ('ORACLE', 'ORACLE');
SELECT * FROM TESTCHAR;

SELECT LENGTH(TCH), LENGTH(TVCH)
FROM TESTCHAR;
-- CHAR Ÿ�� : ��ϰ��� ������ ����Ʈ ũ�⺸�� ������ �������� �������� ä��
-- ������ ������ ����Ʈ ũ�⸦ ���� => �������� ���ڿ�

-- CHAR Ÿ�԰� VARCHAR2 Ÿ�� ���� �񱳿����
SELECT *
FROM TESTCHAR
--WHERE TCH = TVCH;  -- �������� �� �� : ��ġ���� ����
--WHERE LENGTH(TCH) = LENGTH(TVCH);
WHERE TRIM(TCH) = TVCH;  -- ���� ���� �� �� : ��ġ��

-- �������ǿ� �̸� �ο� : �÷� ����
CREATE TABLE TESTUN2 (
    UN_ID  CHAR(3) CONSTRAINT UN_TUN2_ID UNIQUE,
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TUN2_NAME NOT NULL
);

-- �������ǿ� �̸� �ο� : ���̺� ����
CREATE TABLE TESTUN3 (
    UN_ID CHAR(3),
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TUN3_NAME NOT NULL,
    -- ���̺���
    CONSTRAINT UN_TUN3_ID UNIQUE (UN_ID)
);

-- UNIQUE ���������� ���̺������� ����Ű�� ������ ���� ����
-- ���� ���� �÷��� ��� �ϳ��� ���������� �����ϴ� �� : ����Ű
CREATE TABLE TESTUN4 (
    UN_ID  CHAR(3),
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TUN4_NAME NOT NULL,
    UN_CODE CHAR(2),
    -- ���̺���
    CONSTRAINT UN_TUN4_COMP UNIQUE (UN_ID, UN_NAME)  -- ����Ű
);

-- ���� ���� �÷��� ��� �ϳ��� ���������� ������ ���
-- ������ �÷������� �ϳ��� ������ ���� �ߺ��� �Ǵ���

INSERT INTO TESTUN4 VALUES ('100', '����Ŭ', '01');
INSERT INTO TESTUN4 VALUES ('200', '����Ŭ', '01');
-- UNIQUE �Ǵ� : '100 ����Ŭ' != '200 ����Ŭ'
INSERT INTO TESTUN4 VALUES ('200', '����Ŭ', '02');  -- ����
-- UNIQUE �Ǵ� : '200 ����Ŭ' = '200 ����Ŭ'

-- UNIQUE ����Ű�� ���� NULL ���
INSERT INTO TESTUN4 VALUES (NULL, '�ڹ�', '02');
INSERT INTO TESTUN4 VALUES ('300', NULL, '03');  -- NOT NULL ����

SELECT * FROM TESTUN4;

-- �������� : PRIMARY KEY ---------------------
-- �⺻Ű��� ��. (�����ͺ��̽� ����ȭ �������� IDENTIFIER(�ĺ�Ű)�� ����)
-- ���̺��� �� ���� ������ ã�Ƴ��� ���� ����� �� �ִ� �÷��� ���� �� �����
-- NOT NULL + UINQUE
-- �� ���̺� �� ���� ������ �� ����

CREATE TABLE TESTPK (
    PID  NUMBER  PRIMARY KEY,
    PNAME  VARCHAR2(15) NOT NULL,
    PDATE  DATE
);

INSERT INTO TESTPK VALUES (1, 'ȫ�浿', '15/03/15');
INSERT INTO TESTPK VALUES (2, '��ö��', TO_DATE('21/07/20'));
INSERT INTO TESTPK VALUES (NULL, '�̼���', SYSDATE);  -- NOT NULL ERROR
INSERT INTO TESTPK VALUES (2, '�̼���', SYSDATE);  -- UNIQUE ERROR

SELECT * FROM TESTPK;

CREATE TABLE TESTPK2 (
    PID  NUMBER CONSTRAINT PK_TPK2_PID PRIMARY KEY,
    PNAME VARCHAR2(15) PRIMARY KEY
);  -- PRIMARY KEY �� �� ���̺� �ѹ��� ������ �� ���� : ����

-- PRIMARY KEY ���������� �÷�����, ���̺��� �� �� ������ �� ����
CREATE TABLE TESTPK2 (
    PID NUMBER CONSTRAINT PK_TPK2_PID PRIMARY KEY, -- �÷�����
    PNAME VARCHAR2(15)
);

CREATE TABLE TESTPK3 (
    PID NUMBER,
    PNAME VARCHAR2(15),
    -- ���̺���
    CONSTRAINT PK_TPK3_PID PRIMARY KEY (PID)
);

-- PRIMARY KEY �� ����Ű�� ������ �� ����
-- ���̺������� ����Ű�� ������
CREATE TABLE TESTPK4 (
    PID NUMBER,
    PNAME VARCHAR2(15),
    PDATE DATE,
    -- ���̺���
    CONSTRAINT PK_TPK4_COMP PRIMARY KEY (PID, PNAME)
);

INSERT INTO TESTPK4 VALUES (100, 'ORACLE', SYSDATE);
INSERT INTO TESTPK4 VALUES (200, 'ORACLE', '22/06/21');
INSERT INTO TESTPK4 VALUES (100, 'ORACLE', '21/03/25'); -- ERROR
INSERT INTO TESTPK4 VALUES (NULL, 'JAVA', SYSDATE);  -- ERROR

SELECT * FROM TESTPK4;

-- �������� : CHECK -------------------------
-- �÷��� ��ϵǴ� ���� ������ ������ �� �����
-- �÷�����, ���̺��� �� �� ���� ������
-- [CONSTRAINT �̸�] CHECK (�÷��� ������ ���Ѱ�)
-- ���Ѱ��� �ݵ�� ���ͷ�(��)�� ����� �� ����
-- ���Ѱ��� �Լ� ��� �� �� (INSERT, UPDATE �� ������ �ٲ�� ���� ��� �� ��)

CREATE TABLE TESTCHK (
    C_NAME  VARCHAR2(15) CONSTRAINT NN_TCK_NAME NOT NULL,
    C_PRICE  NUMBER(5)  CHECK (C_PRICE BETWEEN 1 AND 99999),
    C_LEVEL  CHAR(1)  CHECK (C_LEVEL IN ('A', 'B', 'C'))
);

-- ��Ͻ� Ȯ��
INSERT INTO TESTCHK VALUES ('������', 65000, 'A');
INSERT INTO TESTCHK VALUES ('G7', 1250000, 'B');  -- C_PRICE : ERROR
INSERT INTO TESTCHK VALUES ('G7', 8700, 'a');  -- C_LEVEL : ERROR

SELECT * FROM TESTCHK;

CREATE TABLE TESTCHK2 (
    C_NAME  VARCHAR2(15 CHAR) PRIMARY KEY,
    C_PRICE  NUMBER(5) CHECK (C_PRICE > 0 AND C_PRICE < 1000000),
    C_LEVEL  CHAR(1) CHECK (C_LEVEL = 'A' 
                            OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
--    C_DATE   DATE  CHECK (C_DATE < SYSDATE)  -- ���Ѱ��� �ٲ�� �� ��� �� ��
--    C_DATE  DATE  CHECK (C_DATE > TO_DATE('16/01/01', 'RR/MM/DD'))  -- BUG
--    C_DATE  DATE  CHECK (C_DATE > '16/01/01')  -- BUG
    C_DATE  DATE  CHECK (C_DATE > TO_DATE('16/01/01', 'YYYY/MM/DD')) -- BUG
);

-- �������� : FOREIGN KEY (�ܷ�Ű | �ܺ�Ű) ---------------------
-- �ٸ�(����) ���̺��� �����ϴ� ���� ����� �� �ִ� �÷� ������ �̿���
-- FOREIGN KEY �������� �������� ���̺� ���̿� ����(Relational)�� �ξ���
-- �÷�����, ���̺��� �� �� ���� ������
-- �÷����� : 
-- �÷��� �ڷ��� [CONSTRAINT �̸�] REFERENCES ���������̺�� (�������÷���)
-- ���̺��� : 
-- [CONSTRAINT �̸�] FOREIGN KEY (�������÷���) REFERENCES ���̺�� (�÷�)
-- (�������÷���) �����Ǹ� �������̺��� �⺻Ű(PRIMARY KEY) �÷��� ����Ѵٴ� �ǹ���
-- �������÷�(�����÷�)�� PRIMARY KEY �̰ų� UNIQUE ���������� �����Ǿ�� ��
-- �����Ǵ� ���� ��Ͽ� ����� �� �ְ� �� => �������� �ʴ� �� ����ϸ� ������
-- NULL �� ����� �� ����

CREATE TABLE TESTFK (
    EMP_ID  CHAR(3)  REFERENCES EMPLOYEE,
    DEPT_ID CHAR(2) CONSTRAINT FK_TFK_DID REFERENCES DEPARTMENT (DEPT_ID),
    JOB_ID  CHAR(2),
    -- ���̺���
    CONSTRAINT FK_TFK_JID FOREIGN KEY (JOB_ID) REFERENCES JOB (JOB_ID)
);

-- ��� Ȯ�� : �����Ǵ� ���� ��Ͽ� ����� �� ����
INSERT INTO TESTFK VALUES ('100', '90', 'J4');
INSERT INTO TESTFK VALUES ('300', '90', 'J4'); -- ERROR : EMP_ID
INSERT INTO TESTFK VALUES ('200', '65', 'J7'); -- ERROR : DEPT_ID
INSERT INTO TESTFK VALUES ('200', '30', 'J9'); -- ERROR : JOB_ID
INSERT INTO TESTFK VALUES (NULL, '30', 'J7');
INSERT INTO TESTFK VALUES ('124', NULL, 'J7');
INSERT INTO TESTFK VALUES ('101', '50', NULL);
INSERT INTO TESTFK VALUES (NULL, NULL, NULL);

SELECT * FROM TESTFK;

-- �������̺��� �����÷��� �ݵ�� PK �̰ų� UNIQUE ������ �Ǿ� �־�� ��
CREATE TABLE TEST_NOPK (
    ID  CHAR(3),
    NAME VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID  CHAR(3) REFERENCES TEST_NOPK,  -- ERROR, PK�� ���� ���̺� ����
    FNAME VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID  CHAR(3) REFERENCES TEST_NOPK (ID),  -- ERROR
    FNAME VARCHAR2(15)
);  -- �����÷��� PK | UN ������ ����

CREATE TABLE TEST_YESPK (
    ID  CHAR(3)  PRIMARY KEY,
    NAME VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID CHAR(3) REFERENCES TEST_YESPK,  -- �����÷� ������ PK �÷� ������
    FNAME VARCHAR2(15)
);

CREATE TABLE TEST_YESPK2 (
    ID  CHAR(3)  PRIMARY KEY,
    NAME VARCHAR2(15) UNIQUE
);

CREATE TABLE TESTFK3 (
    FID CHAR(3) REFERENCES TEST_YESPK2 (ID),  
    FNAME VARCHAR2(15) REFERENCES TEST_YESPK2 (NAME)
);

-- �θ�Ű(�� ������)�� �ڽķ��ڵ�(�� �����)���� ����� �ǰ� ������,
-- �θ�Ű ������ �� ����

-- DML �� : DELETE ��
-- ���̺��� ���� ������ �����ϴ� ���� (�� ����)
-- �ۼ����� : 
-- DELETE [FROM] ���̺�� WHERE �÷��� ������ �񱳰�;
-- ���ǿ� �ش�Ǵ� ���� ã�Ƽ� �����ϰ� ��

DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90';  --ERROR

-- FOREIGN KEY �������� ������ �����ɼ����� �θ�Ű ���� �����ϰ� �� ���� ����
-- ���� �ɼ�(DELETION OPTION)�� �θ�Ű�� ������ ��, �ڽķ��ڵ带 ���
-- ó���� �������� �����ϴ� ����
-- ON DELETE SET NULL : �ڽķ��ڵ带 NULL �� �ٲ�
-- ON DELETE CASCADE : �ڽķ��ڵ嵵 �Բ� ���� (�� ����)

-- FOREIGN KEY ���������� �⺻ �����ɼ��� RESTRICTED �� : �����Ұ�����

CREATE TABLE PRODUCT_STATE (
    PSTATE  CHAR(1)  PRIMARY KEY,
    PCOMMENT  VARCHAR2(10)
);

INSERT INTO PRODUCT_STATE VALUES ('A', '�ְ��');
INSERT INTO PRODUCT_STATE VALUES ('B', '����');
INSERT INTO PRODUCT_STATE VALUES ('C', '����');

SELECT * FROM PRODUCT_STATE;

CREATE TABLE PRODUCT (
    PNAME  VARCHAR2(20)  PRIMARY KEY,
    PRICE  NUMBER  CHECK (PRICE > 0),
    PSTATE  CHAR(1) REFERENCES PRODUCT_STATE ON DELETE SET NULL
);

INSERT INTO PRODUCT VALUES ('�����ó�Ʈ', 1250000, 'A');
INSERT INTO PRODUCT VALUES ('G9', 850000, 'C');
INSERT INTO PRODUCT VALUES ('������S21', 1000000, 'B');

SELECT * FROM PRODUCT;

SELECT *
FROM PRODUCT
LEFT JOIN PRODUCT_STATE USING (PSTATE);

-- SET NULL Ȯ��
DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'C';  -- �θ�Ű ������

SELECT * FROM PRODUCT_STATE;
SELECT * FROM PRODUCT;

-- TCL (Transaction Controll Language : Ʈ����� �����)
-- ��ɾ� : ROLLBACK, COMMIT, SAVEPOINT

-- ��� ����� DELETE ��� ����
ROLLBACK;

-- CASCADE Ȯ�� : �θ�Ű�� �ڽķ��ڵ�(��) �Բ� ����
CREATE TABLE PRODUCT2 (
    PNAME  VARCHAR2(20)  PRIMARY KEY,
    PRICE  NUMBER  CHECK (PRICE > 0),
    PSTATE  CHAR(1) REFERENCES PRODUCT_STATE ON DELETE CASCADE
);

INSERT INTO PRODUCT2 VALUES ('�����ó�Ʈ', 1250000, 'A');
INSERT INTO PRODUCT2 VALUES ('G9', 850000, 'C');
INSERT INTO PRODUCT2 VALUES ('������S21', 1000000, 'B');

SELECT * FROM PRODUCT2;

COMMIT;  -- �����ϰ� Ʈ����� ������ (����Ϸ�)

-- �θ�Ű ����
SELECT * FROM PRODUCT_STATE;

DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'A';

-- �ڽķ��ڵ嵵 �Բ� ���� Ȯ��
SELECT * FROM PRODUCT2;  -- CASCADE
SELECT * FROM PRODUCT;  -- SET NULL

ROLLBACK;

-- �θ�Ű(�� �����÷�)�� ����Ű(���� ���� �÷��� �ϳ��� ���� ��)�̸�
-- FOREIGN KEY �������� �����ϴ� �÷�(�ڽķ��ڵ�)�� ���� ����Ű�� �����ؾ� ��

-- ���� ���̺�(�θ�Ű)
CREATE TABLE TEST_COMPLEX (
    ID NUMBER,
    NAME VARCHAR2(10),
    PRIMARY KEY (ID, NAME)  -- ����Ű
);

INSERT INTO TEST_COMPLEX VALUES (100, 'ORACLE');
INSERT INTO TEST_COMPLEX VALUES (100, 'PYTHON');
INSERT INTO TEST_COMPLEX VALUES (200, 'JAVA');

SELECT * FROM TEST_COMPLEX;

-- �ڽķ��ڵ�
CREATE TABLE TESTFK4 (
    FID  NUMBER,
    FNAME VARCHAR2(10),
    -- ���̺���
--    FOREIGN KEY (FID) REFERENCES TEST_COMPLEX (ID) -- ERROR
    -- ����Ű�� ���� �ϳ��� ��� �� ��
    FOREIGN KEY (FID, FNAME) REFERENCES TEST_COMPLEX
    -- ����Ű�� ����Ű�� �����Ǿ�� ��
);

-- �ǽ�
CREATE TABLE CONSTRAINT_EMP (
    EID CHAR(3) CONSTRAINT PKEID PRIMARY KEY,
    ENAME VARCHAR2(20) CONSTRAINT NENAME NOT NULL,
    ENO CHAR(14) CONSTRAINT NENO NOT NULL CONSTRAINT UENO UNIQUE,
    EMAIL VARCHAR2(25) CONSTRAINT UEMAIL UNIQUE,
    PHONE VARCHAR2(12),
    HIRE_DATE DATE DEFAULT SYSDATE,
    JID CHAR(2) CONSTRAINT FKJID REFERENCES JOB ON DELETE SET NULL,
    SALARY NUMBER,
    BONUS_PCT NUMBER,
    MARRIAGE CHAR(1) DEFAULT 'N' CONSTRAINT CHK CHECK (MARRIAGE IN ('Y','N')),
    MID CHAR(3) CONSTRAINT FKMID REFERENCES CONSTRAINT_EMP ON DELETE SET NULL,
    DID CHAR(2),
    CONSTRAINT FKDID FOREIGN KEY (DID) REFERENCES DEPARTMENT ON DELETE CASCADE
);

-- DAY10_DDL_TCL.sql
-- SEQUENCE, INDEX, TCL, LOCK

-- ������ (SEQUENCE) **
-- �ڵ� ���� �߻���
-- ���������� ���� �� �ڵ����� �߻��ϴ� ��ü �ַ� INSERT�Ҷ� ���

/*
�����ۼ� ���� :
CREATE SEQUENCE �������̸�
START WITH N
INCREMENT BY N
CHASH N         NOCHASH
CYCLE, NOCYCLE
MAXVALUE N      MINVALUE N, 
NOMAXVALUE  NOMINVALUE

* INCREMENT BY N
    : ������ ��ȣ ���� | ���� ���� (N�� ���� , �⺻�� 1

* START WITH N
    : ������ ���۰� (N�� ����, �⺻�� 1)
    
* MAXVALUE N | NOMAXVALUE
* MINVALUE N | NOMINVALUE
    - MAXVALUE N : �������� �ִ밪 ���� (N�� ����)
    - NOMAXVALUE : ������ �ִ밪 ����� �ǹ���
                (�������� : 10�� 27��, �������� : -1)
    - MINVALUE N : �������� �ּҰ� ���� (N�� ����)
    - NOMINVALUE : ������ �ּҰ� ����� �ǹ���
                (�������� : 1, �������� : -10�� 26��)
    - CYCLE | NOCYCLE
        : �ִ� �ּҰ��� ���޽�  �ݺ����� ����
        �ݺ��� ���۰��� ������ 1���� ���۵�
    - CACHE | NOCAHE
    : ������ n�� ������ �޸𸮿� �̸� �������� ���� ����
    (�ּ� 2���� ������ �� ���� �⺻�� 20)
*/
CREATE SEQUENCE SEQ_EMPID
START WITH 300  -- ���۰� : 300���� ����
INCREMENT BY 5     -- ������ : 5������
MAXVALUE 310    -- 310 ���� ���� 
NOCYCLE         -- 310���� ���� �� ���̻� ���� ����
NOCACHE;

-- ������ ��ųʸ� �����
DESC USER_SEQUENCES;
SELECT *FROM user_sequences;

-- ������ ��ųʸ����� ������ ���� Ȯ��
SELECT SEQUENCE_NAME, CACHE_SIZE, LAST_NUMBER
FROM USER_SEQUENCES;
-- LAST_NUMBER ����
-- NOCACHE �϶��� ���� ��ȯ��(�߻���) ������ ��
-- CACHE ��� : CACHE�� ����� ���������� �� ������ ��

-- ������ �� �߻� : ������.NEXTVAL �Ӽ� �����
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- MAXVALUE ���� �����߰� NOCYCLE �̱� ������
-- 4ȸ ���� ���� �߻�'


-- ������ ����� 2
CREATE SEQUENCE SEQ_EMPID2
START WITH 5
INCREMENT BY 5
MAXVALUE 15
CYCLE   -- MAXVALUE 15�� �߻��Ǹ� ���� ���� 1���� 
        -- �����ϸ鼭 �ݺ�
NOCACHE;

-- �߻� �� Ȯ��
SELECT SEQ_EMPID2.NEXTVAL FROM DUAL;
-- 4ȸ ������ 1, 6, 11�� �ݺ������� ������

-- ������ ��� �Ӽ�
/*
    NEXTVAL 
    : ���ο� ���ڸ� �߻���Ű�� �Ӽ�
        �������̸�.NEXTVAL ���·� �����
    CURRVAL
        : CURRENT VALUE �� �ǹ���
        ���� ������ ���� ��ȯ�ϴ� �Ӽ�
        �������̸�.CURRVAL ���·� �����
        ���ǻ��� : ������ ��ü �����Ŀ� NEXTVAL �� �ѹ� ���ǰ� ���� ����ؾ���
*/

CREATE SEQUENCE SEQ_EMPID03
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE NOCACHE;

SELECT SEQ_EMPID03.CURRVAL FROM DUAL;
-- ������ ��ü ������ NEXTVAL �� ����� �� �� ���¿�����
-- CURRVAL ��� �� �� (�߻����� ����)


SELECT SEQ_EMPID03.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID03.CURRVAL FROM DUAL; -- 300

-- ������ ��� : INSERT �������� �� ��Ͻ� ���
CREATE SEQUENCE SEQID
START WITH 300
INCREMENT BY 1
MAXVALUE 300
NOCYCLE NOCACHE;

ALTER SEQUENCE SEQID
MAXVALUE 310;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '951225-2345678', 'ȫ���');

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '931225-2345678', 'Ȳ����');

SELECT *
FROM EMPLOYEE WHERE EMP_ID = 301;

/*
ALTER SEQUENCE SEQID
INCREMENT BY N
CHASH N         NOCHASH
CYCLE, NOCYCLE
MAXVALUE N      MINVALUE N, 
NOMAXVALUE  NOMINVALUE

    START WITH �����Ұ�
    ���۰��� �����Ϸ��� ������ �����ϰ� �ٽ� �������
    �ѹ��� ������� ���� �������� ���� �Ұ�
    ����� ���� ���� ���Ŀ� ������ ���� ����
*/
CREATE SEQUENCE SEQID2
INCREMENT BY 1
START WITH 300
MAXVALUE 310
NOCYCLE NOCACHE;

ALTER SEQUENCE SEQID2
INCREMENT BY 5;

SELECT *
FROM SYS.user_sequences;


SELECT SEQID2.NEXTVAL FROM DUAL; -- �߻��� ���� : ����

-- ������ ����
-- DROP SEQUENCE �������̸�;
DROP SEQUENCE SEQID2;

-- SEQID2 �ٽ� ���f�����ϰ� ���� �� �߻� �ϤǤ���
SELECT SEQID2.NEXTVAL FROM DUAL;
SELECT SEQID2.CURRVAL FROM DUAL;
-- SEQID2 �����ϰ� ���� �� �߻� Ȯ��

-- ����1
SELECT EMP_NAME,
        MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID = '143';

UPDATE EMPLOYEE
SET MARRIAGE='N'
WHERE EMP_ID = '143';

COMMIT;

-- TCL (Transaction Coltroll Language : Ʈ����� �����)
-- COMMIT, ROLLBACK , SAVEPOINT

-- Ʈ����� ���� : DML ������ ó�� ���ɶ�(���� Ʈ����� ������)

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT FK_MGRID; -- �������� ��Ȱ��ȭ : DDL 
-- DDL ����, ���� Ʈ����� �ڵ� Ŀ���� (AUTO COMMIT) -- Ʈ����� ����

SAVEPOINT S0;

INSERT INTO DEPARTMENT
VALUES ('45', '��ȹ������', 'A1'); -- �� Ʈ������� ���۵�

SELECT * FROM DEPARTMENT;

SAVEPOINT S1;

UPDATE EMPLOYEE
SET DEPT_ID = '45'
WHERE DEPT_ID IS NULL;

SELECT * FROM EMPLOYEE
WHERE DEPT_ID = '45';

SAVEPOINT S2;

DELETE FROM EMPLOYEE;

SELECT COUNT(*) FROM EMPLOYEE;

--ROLLBACK; -- Ʈ����� ���� ��ġ���� ��� �۾��� ��ҵ�
ROLLBACK TO S2; -- S2 ��ġ������ ��ҵ�
ROLLBACK TO S1; -- S1 ��ġ������ ��ҵ�
ROLLBACK TO S0; -- S0 ��ġ������ ��ҵ�
SET AUTOCOMMIT ON;

-- *******************************
-- �ε��� (INDEX)

/*
SQL ��ɹ��� ó���ӵ��� ����Ű�� ���ؼ� �÷��� ���ؼ� �����ϴ� ��ü��
-- �ε����� ���� ���� B* Ʈ�� (����Ʈ�� : BINARY TREE) �������� ������
-- �÷��� �ε����� �����ϸ� �̸� ���� B* Ʈ���� �����ؾ� �ϱ� ������
    �ε����� �����ϱ� ���� �ð��� �ʿ��ϰ�, �ε����� ���� �߰� ��������� �ʿ���
        (�ݵ�� ���� ���� �ƴ�)
-- �ε��� ���� �Ŀ� DML �۾��� �����ϸ�, �ε����� ���� �÷����� ����ǹǷ�
    B* Ʈ�� ���� ���� ���� �Բ� �����ǹǷ�, DML �۾��� �ξ� ���ſ����� ��

* ����
    �˻��ӵ��� ������
    �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����Ŵ
* ����
    �ε����� ���� �߰����� ������ �ʿ���
    �ε����� �����ϴµ� �ð��� �ɸ�
    �������� ���� �۾� (INSERT, DELETE, UPDATE)�� ���� �߻��ϴ� ��쿡��
    ������ ������ ���ϵ�
    
-- Ű����(�÷���)�� �ش� ������(��) ��ϵ� ��ũ ��ġ(�������� ��ġ)�� �����
-- Ű����(�÷���)�� �̿��ؼ� �˻��� ��(SELECT) �ڵ� ����

-- �ε��� ���� :
    ���ĵ� Ư�� �÷���(KEY)�� �ش� �÷����� ��ϵ� ����ġ(ROWID)�� ������
    
-- �ε����� �ڵ� �����Ǵ� ��� :
    ���̺� �÷��� PRIMARY KEY �������� �Ǵ� UNIQUE �������� ������
    �ڵ����� UNIQUE INDEX �� ������ (�̸��� �������� �̸��� ����)
    * �������� ���Ž� �ش� �ε��� ��ü�� ���� ���ŵ�
    
-- �ε��� ���� ���� :
CREATE [UNIQUE] INDEX �ε����̸�
ON ���̺�� (������ �÷���, �Լ���);

-- �ε��� ����
1. ���� �ε���   unique index
2. ����� �ε��� nonunique index
3. ���� �ε��� ingle index
4. ���� �ε��� composite index
5. �Լ���� �ε��� function based index


-- UNIQUE INDEX, NONUNIQUE �� ���е�
- NONUNIQUE INDEX : ���� ���� ���� �� ��ϵ� �÷��� ����ϴ� �ε���
    �ַ� ��������� ���� �������� ����
    
- UNIQUE INDEX :
    UNIQUE INDEX �� ������ �÷����� ���� �� �ι� ��� ����
    UNIQUE �������� ������ ���� ������ �����
    PRIMARY KEY �� ������ �÷����� UNIQUE �ε����� �ڵ� ������
    => PK�� ������ �÷����� �̿��ϸ� �˻� �ӵ��� ���Ǵ� ȿ���� ����

*/

-- UNIQUE INDEX �����
CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);

-- NONUNIQUE INDEX �����
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);

-- �ε��� ���� �ǽ�
-- 1. EMPLOYEE ���̺��� EMP_NAME �÷��� 'IDX_ENM' �̸���
--  UNIQUE INDEX �����Ͻÿ�.
CREATE UNIQUE INDEX IDX_ENM
ON EMPLOYEE (EMP_NAME);

-- 2. ������ ���� ���ο� �����͸� �Է��� ����, ���� ������ �����Ͻÿ�.
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES ('400', '871120-1234567', '���켷');

-- EMP_NAME �÷��� �̹� '���켷' �̸� �����Ͱ� ������
-- UNIQUE INDEX �������� UNIQUE ���������� ����� ����� (�ߺ��� �ԷºҰ�)

SELECT * FROM EMPLOYEE WHERE EMP_NAME = '���켷';

-- �ε��� ����
-- DROP INDEX �ε����̸�;
DROP INDEX IDX_JID;

-- �ε��� ���� Ȯ�� ��ųʸ�
DESC USER_INDEXES;
DESC USER_IND_COLUMNS;

-- �� : EMPLOYEE ���̺� ������ �ε��� ��Ȳ ��ȸ
SELECT INDEX_NAME, COLUMN_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES
JOIN USER_IND_COLUMNS USING (INDEX_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMPLOYEE';

-- �˻� �ӵ� ���� ����
-- EMPLOYEE ���̺��� ������ EMPL01, EMPL02 ���̺� �����
CREATE TABLE EMPL01
AS
SELECT * FROM EMPLOYEE;

CREATE TABLE EMPL02
AS
SELECT * FROM EMPLOYEE;

-- EMPL01�� EMP_ID �÷��� UNIQUE INDEX �����
CREATE UNIQUE INDEX IDX_EID
ON EMPL01 (EMP_ID);

-- �˻� �ӵ� �� ��ȸ�� : ó���ð� Ȯ��
SELECT * FROM EMPL01
WHERE EMP_ID = '141'; -- 0.009

SELECT * FROM EMPL02
WHERE EMP_ID = '141'; -- 0.014

-- ���� �ε���
-- �� ���� �÷����� ������ �ε��� == ���� �ε��� (single index)
-- ���� �ε��� : �� �� �̻��� �÷��� ��� �ε����� ������ ��
CREATE TABLE DEPT01
AS
SELECT * FROM DEPARTMENT;

-- �μ���ȣ�� �μ����� �����ؼ� �ε��� �����ϱ�
CREATE INDEX IDX_DEPT01_COMP
ON DEPT01 (DEPT_ID, DEPT_NAME);

-- ��ųʸ����� Ȯ��
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'DEPT01';

-- �Լ� ��� �ε���
-- SELECT ���̳� WHERE ���� �����̳� �Լ����� ���Ǵ� ��줾
-- ������ �ε����� ������ ���� �ʴ´�.
-- �������� �˻��ϴ� ��찡 ���ٸ�, �����̳� �Լ����� �ε����� ���� �� ����
create table emp01
AS
SELECT * FROM EMPLOYEE;

CREATE INDEX IDX_EMP01_SALCALC
ON EMP01 ((SALARY + (SALARY * NVL(BONUS_PCT, 0))) *12 );

-- ��ųʸ����� Ȯ��
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP01';
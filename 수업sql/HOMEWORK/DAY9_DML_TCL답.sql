-- DAY9_DML_TCL.sql
-- DML ������ TCL ���� ����

-- DML (Data Manipulation Language : ������ ���۾�)
-- ��ɾ� : INSERT, UPDATE, DELETE, TRUNCATE
-- ���̺� �����͸� ��� �����ϰų�(INSERT), ��ϵ� �����͸� �����ϰų�(UPDATE)
-- ���� ��ϵ� ���� ������ ��(DELETE) ����ϴ� ����
-- INSERT �� : �� �߰� (�� ��� ����)
-- UPDATE �� : �÷��� ��ϵ� ���� ���� (�� ���� ���Ծ���)
-- DELETE �� : �� ���� (�� ���� �پ��, ���� ����)
-- TRUNCATE �� : ���̺��� ���� ��� ���� ������ (���� �Ұ���)

-- UPDATE ��
/*
UPDATE ���̺��
SET ���������÷��� = �����Ұ�, �÷��� = DEFAULT, �÷��� = (��������), ....
WHERE �÷��� ������ ã���� | WHERE �÷��� ������ (��������);

���ǻ��� : WHERE ���� �����Ǹ�, ���̺��� �÷����� ���� ������
���� : SET ���� ������ �� ��ġ�� ��������(SELECT ��) ����� �� ����
      WHERE ���� ã�� ���(��) ��ġ�� �������� ����� �� ����
*/

CREATE TABLE DCOPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM DCOPY;

UPDATE DCOPY
SET DEPT_NAME = '�λ���';
-- WHERE ���� �����Ǹ� �÷� ��ü ���� ������

SELECT * FROM DCOPY;

ROLLBACK;  -- ��� ����� DML ���� ���� ���

-- �μ��ڵ� 10�� �μ����� �λ������� �ٲ۴ٸ�
UPDATE DCOPY
SET DEPT_NAME = '�λ���'
WHERE DEPT_ID = '10';

SELECT * FROM DCOPY;

-- UPDATE ���� �������� ����� �� ����
-- SET ���� WHERE ���� �����

-- ���ϱ� ������ �����ڵ�� �޿��� ����
-- ���ر� ������ �����ڵ�� �޿��� ���� ������ �����ؾ� �Ѵٸ�,
SELECT * FROM EMP_COPY;

-- ���� �� Ȯ��
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMP_COPY
WHERE EMP_NAME IN ('���ϱ�', '���ر�');

UPDATE EMP_COPY
--SET JOB_ID = 'J7',
--    SALARY = 1900000
SET JOB_ID = (SELECT JOB_ID FROM EMP_COPY
              WHERE EMP_NAME = '���ر�'),  -- ������ ��������
    SALARY = (SELECT SALARY FROM EMP_COPY
              WHERE EMP_NAME = '���ر�')  -- ������ ��������
WHERE EMP_NAME = '���ϱ�';    

-- ���� �� Ȯ��
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMP_COPY
WHERE EMP_NAME IN ('���ϱ�', '���ر�');

-- ���������� ���� ������ SELECT ���� �׸� �ٸ��ٸ�, ���߿� ���������� �ٲ�
UPDATE EMP_COPY
SET (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY 
                        FROM EMP_COPY
                        WHERE EMP_NAME = '���ر�')
WHERE EMP_NAME = '���ϱ�';

-- ���̺� ������ �÷��� DEFAULT �� ������ �Ǿ� �ִ� ��쿡��
-- ������ �� ��ġ�� DEFAULT Ű���� ����� �� ����
-- ���� : DEFAULT ������ �� �� �÷��� DEFAULT ����, NULL ó����

-- ���� ���̺� �÷����� ���� : DEFAULT �߰�
ALTER TABLE EMP_COPY
MODIFY (MARRIAGE DEFAULT 'N');

-- ���� �� Ȯ�� : ��� 210 ���� ���� Ȯ��
SELECT EMP_NAME, MARRIAGE
FROM EMP_COPY
WHERE EMP_ID = '210';

-- ����
UPDATE EMP_COPY
SET MARRIAGE = DEFAULT
WHERE EMP_ID = '210';

-- ���� �� Ȯ�� : ��� 210 ���� ���� Ȯ��
SELECT EMP_NAME, MARRIAGE
FROM EMP_COPY
WHERE EMP_ID = '210';

ROLLBACK;  -- ����� DML ���

-- UPDATE �� WHERE ������ �������� ����� �� ����
-- �ؿܿ���2�� �������� ���ʽ�����Ʈ�� ��� 0.3���� �����Ͻÿ�.
UPDATE EMP_COPY
SET BONUS_PCT = 0.3
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM DEPARTMENT
                  WHERE DEPT_NAME = '�ؿܿ���2��');

-- Ȯ��
SELECT EMP_NAME, DEPT_ID, DEPT_NAME, BONUS_PCT
FROM EMP_COPY
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME = '�ؿܿ���2��';

-- ���� : ������ �� ����� �ش� �÷��� �������ǿ� ������� �ʴ� ���� ����ؾ� ��
UPDATE EMP_COPY
SET EMP_NAME = NULL  -- EMP_NAME : NOT NULL �������� ����
WHERE DEPT_ID IS NULL;

-- EMP_COPY ���̺� �������� �߰� : FOREIGN KEY
-- DEPT_ID �÷��� �߰� ����
-- �������̺��� DEPARTMENT �� DEPT_ID �θ�Ű�� ����
ALTER TABLE EMP_COPY
ADD FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT (DEPT_ID);

SELECT DEPT_ID FROM DEPARTMENT;  -- �θ�Ű Ȯ��

-- �ܷ�Ű �������� : �θ�Ű�� ���� ���� �ڽķ��ڵ忡�� ����� �� ����
-- �θ�Ű�� ���� �� ����ϸ� ������
UPDATE EMP_COPY
SET DEPT_ID = '65'  -- �θ�Ű�� ���� ���� : ����
WHERE DEPT_ID IS NULL;

-- ��ųʸ��� �������� Ȯ��
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING (CONSTRAINT_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMP_COPY';

-- INSERT �� *******************************
-- ���̺� �� ���� �߰��� �� ����� : ����� �þ
-- ���̺� ������ ��� ������ �� ����ϴ� ������
/*
INSERT INTO ���̺�� (����Ͽ� ����� �÷���, .......)
VALUES (���� ������ �÷��� ���缭 ����� ��, .......);

���ǻ��� : �÷������� ������, �÷��ڷ����� ���ڷ��� �ݵ�� ��ġ���Ѿ� ��
        ���� ������ �߿���
���� : �÷��� ������ �����Ǹ�, ���̺��� ���� ��ü �÷��� ���� ����Ѵٴ� �ǹ���
      ���� ��ϼ����� �߿��� (�÷����� ������ ����� ��)
*/

SELECT COUNT(*) FROM EMP_COPY;  -- 22

INSERT INTO EMP_COPY (EMP_ID, EMP_NAME, EMP_NO, PHONE, EMAIL,
                        SALARY, BONUS_PCT, HIRE_DATE, JOB_ID, DEPT_ID,
                        MARRIAGE, MGR_ID)
VALUES ('900', '������', '891225-1234567', '01012345678', 'oyunha@kkk.com',
        4800000, 0.15, '06/01/05', 'J4', '30', DEFAULT, NULL);   
-- INSERT �ÿ� �� ��ſ� DEFAULT �� NULL Ű���� ����� �� ����        

SELECT COUNT(*) FROM EMP_COPY; -- 23

SELECT * FROM EMP_COPY;

-- ���������� �̿��ؼ� INSERT �� �� ����
-- VALUES Ű���� ������� ����
/*
INSERT INTO ���̺�� (����Ͽ� ����� �÷���, ....) <-- �������� ��� �׸�� ��ġ
(SELECT ��������);
*/
CREATE TABLE EMP (
    EMP_ID  CHAR(3),
    EMP_NAME VARCHAR2(20),
    DEPT_NAME VARCHAR2(20)
);

SELECT COUNT(*) FROM EMP;  -- 0

INSERT INTO EMP
(SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID));

SELECT COUNT(*) FROM EMP; -- 22

SELECT * FROM EMP;

-- DELETE ��
-- ���� �����ϴ� ����
/*
DELETE [FROM] ���̺��
WHERE ������ ���� ��� ������ ���ǽ�;
*/

-- WHERE ���� �����Ǹ� ���̺��� ��� ���� ������
SELECT * FROM DCOPY;

DELETE FROM DCOPY;
SELECT * FROM DCOPY;

ROLLBACK;  -- DELETE �� ������ �� ����

SELECT * FROM DCOPY;

-- TRUNCATE ��
-- ���̺��� ��� ���� ������
-- DELETE ���� ���� �ӵ��� ����. ������ �� ��
-- �θ�Ű(FOREIGN KEY ��������)�� �ִ� ���̺��� ����� �� ����

TRUNCATE TABLE DCOPY;
SELECT * FROM DCOPY;
ROLLBACK;  -- ���� �� ��

TRUNCATE TABLE DEPARTMENT; -- ERROR : �θ�Ű�� ���� (DEPT_ID)

-- DELETE ������ FOREIGN KEY ������������ �����ǰ� �ִ� �θ�Ű�� ���� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90';  -- ERROR

-- �� ���� �پ��
SELECT COUNT(*) FROM EMP_COPY;  -- 23

DELETE FROM EMP_COPY
WHERE EMP_ID = '900';

SELECT COUNT(*) FROM EMP_COPY;  -- 22

-- ************************************************
-- VIEW (��)
/*
: SELECT ���� ������ ����� �����ִ� ȭ��
-- ��� ȭ���� ������ ���̺�ó�� ������ �ΰ� ����� �� ����
-- ��ġ ���ȭ���� ���� �� �����Ѵٴ� ������
-- ��� ���� : 
    1. ���ȿ� ���� : ������ ��� ȭ�鸸 �����ν�, ������ �� ���̰� ��
    2. �����ϰ� �� �������� �並 ���� �����ν� �Ź� �������� �����Ű�� �ʾƵ� ��
*/

/*
VIEW : SELECT �������� �����ϴ� ��ü��

�ۼ����� : 
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸� (��Ī,....)
AS ��������
[WITH CHECK OPTION [CONSTRAINT �̸�]]
[WITH READ ONLY [CONSTRAINT �̸�]];

-- CREATE VIEW | CREATE OR REPLACE VIEW
    �����ϴ� �̸��� �䰡 ������ ���� �����ϰ� (CREATE)
    ���̸��� �����ϸ� ����(REPLACE)
    
-- FORCE | NOFORCE
    * FORCE : ���������� ���� ���̺�(���̽� ���̺�)�� �������� �ʾƵ�
             �� ��ü ������ (�ܼ� ������ ���� �뵵��)
    * NOFORCE : �⺻ ��������. ���̽� ���̺��� �����ϴ� ��쿡�� �� ������
             �������� SELECT ���� ���� �۵��Ǹ� �� ����
 
-- (��Ī, ALIAS, ..)
    - ���̺� �÷� ��Ī ����� ���� �ǹ���
    - �������� SELECT ���� �׸񸶴� ��Ī ó��(�÷��� �ٽ� ����)
    - �������� SELECT ���� �׸� ������ ��Ī(ALIAS) ������ �ݵ�� ��ġ�ؾ� ��
    
-- ��������
    : �信 ������ SELECT ����
    
-- �� ��������
    * WITH CHECK OPTION
      : �並 �̿��ؼ� ���̽� ���̺��� DML �۾� �����
        ���̽� ���̺��� 1���϶��� ������
    * WITH READ ONLY
      : �並 �̿��� ���̽� ���̺� DML �۾� ��� �� ��
   ������������ ���ֵǹǷ� ���� �̸� ������ �� ����
   
** CREATE VIEW �� ���� �ο��� �ʿ���   
-- �����ڰ�������
GRANT CREATE VIEW TO C##STUDENT;
*/

CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE;  -- ���� Ȯ��

-- �� ����� : �������� �����
-- �� ������ �� ����ϴ� ���������� �Ϲ����� SELECT ������ �����
-- ������ ��� ���̺�ó�� ��޵�
-- ��� �����Ͱ� ����

-- 90 �μ��� �Ҽӵ� ���� ����� ��ȸ�ϴ� �������� �ۼ��ϰ�,
-- ��� ������ : V_EMP_DEPT90
-- �̸�, �μ���, ���޸�, �޿� ��ȸ
CREATE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

-- Ȯ��
SELECT * FROM V_EMP_DEPT90;

-- �䰡 ������ �����, ������ ����
CREATE OR REPLACE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

-- �� ���� ������ ��ųʸ� : USER_VIEWS
SELECT * FROM USER_VIEWS;

DESC USER_VIEWS;
-- VIEW_NAME : ���̸�
-- TEXT : ������������

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'V_EMP';

-- �ǽ� : 
-- ���޸��� '���'�� ��� �������� �����, �μ���, ���޸��� ��ȸ�ϴ� ������
-- ��� �����Ͻÿ� : V_EMP_DEPT_JOB

CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '���';

-- Ȯ��
SELECT * FROM V_EMP_DEPT_JOB;

-- �䵵 ���̺�ó�� ��ü�� ��ȸ ������
SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM USER_TAB_COLS  -- ���̺��� �÷� ���� ������ ��ųʸ�
WHERE TABLE_NAME = 'V_EMP_DEPT_JOB';

-- �� ������ �÷� ��Ī ALIAS ��� --------------------
-- ��Ī ���� : �� ���� �κ�, �������� �κ�
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB (ENAME, DNAME, JTITLE)
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '���';

SELECT * FROM V_EMP_DEPT_JOB;

CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS
SELECT EMP_NAME AS ENM, DEPT_NAME AS DNM, JOB_TITLE AS TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '���';

SELECT * FROM V_EMP_DEPT_JOB;

-- �� �ۼ��� ���ǻ��� : 
-- �������� SELECT ���� �Լ��� ������ ������ �ݵ�� ALIAS ������ ��

-- �������� �̸�, ����, �ٹ������ ��ȸ�ϴ� �������� �ۼ��ϰ�
-- ��� �����Ͻÿ�. : V_EMP
CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMP_NAME, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '3', '����', '����') ����,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE;

SELECT * FROM V_EMP;

CREATE OR REPLACE VIEW V_EMP (�̸�, ����, �ټӳ��)
AS
SELECT EMP_NAME, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '3', '����', '����'),
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 
FROM EMPLOYEE;

SELECT * FROM V_EMP;

-- ���� : �� ���� �κ� ��Ī ����ÿ��� ��ü �÷�(�׸�)�� ���� �����ؾ� ��
CREATE OR REPLACE VIEW V_EMP (����, �ټӳ��)
AS
SELECT EMP_NAME, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '3', '����', '����'),
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 
FROM EMPLOYEE;

-- �� ���� ��������
-- ���� ���� ������ �ƴ����� �並 ���� DML �۾� ���� ���θ� �����ϴ� �ɼ�
-- DML �۾� ���� ����� ���̽� ���̺� �����
-- COMMIT | ROLLBACK ó�� �ʿ���
-- �並 ���� DML �۾��� �������� ������ ����

-- WITH READ ONLY : �並 ���� DML �۾� �Ұ�
CREATE OR REPLACE VIEW V_EMP
AS
SELECT * FROM EMPLOYEE
WITH READ ONLY;

-- DML �۾� ������ ���� ���� ������ �ٸ�����
-- DML �۾��� ������� �ʴ´�.
UPDATE V_EMP
SET PHONE = NULL;

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO)
VALUES ('777', '������', '777777-7777777');

DELETE FROM V_EMP;

-- WITH CHECK OPTION : �並 ���� DML �۾� ����
-- ���ǿ� ���� INSERT, UPDATE �۾� ���������� ���ѵǴ� ������ ����
-- DELETE �� ������ ����
CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMP_ID, EMP_NAME, EMP_NO, MARRIAGE
FROM EMPLOYEE
WHERE MARRIAGE = 'N'
WITH CHECK OPTION;

-- ����
INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('777', '������', '777777-7777777', 'Y');

-- ����
UPDATE V_EMP
SET MARRIAGE = 'Y';

-- �並 ������ �� ����� �������� WHERE �� ������ ����Ǵ� �������� ����
INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('777', '������', '777777-7777777', 'N');  -- OK

SELECT * FROM EMPLOYEE;

ROLLBACK;

UPDATE V_EMP
SET EMP_ID = '000'
WHERE EMP_ID = '124';

-- Ȯ��
SELECT *
FROM EMPLOYEE
WHERE EMP_ID = '000';

ROLLBACK;

-- VIEW ��� 1 : 
CREATE OR REPLACE VIEW V_EMP_INFO
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

-- �並 ���̺� ��� ����ؼ� ��ȸ�� �� ����
SELECT EMP_NAME
FROM V_EMP_INFO
WHERE DEPT_NAME = '�ؿܿ���1��' AND JOB_TITLE = '���';

-- �� ��� 2 : 
CREATE OR REPLACE VIEW V_DEPT_SAL ("DID", "DNM", "DAVG")
AS
SELECT NVL(DEPT_ID, 'NO'),
        NVL(DEPT_NAME, 'NONE'),
        ROUND(AVG(SALARY), -3)
FROM DEPARTMENT
RIGHT JOIN EMPLOYEE USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME;

-- ""�� ����� ALIAS �� ���ÿ��� "" ǥ���ؾ� ��
SELECT "DNM", "DAVG"
FROM V_DEPT_SAL
WHERE "DAVG" > 3000000;

-- ""ǥ�� ���ϸ� ���� �߻� : 18C ������ ���� �� ��
SELECT DNM, DAVG
FROM V_DEPT_SAL
WHERE DAVG > 3000000;

-- �� ���� : ���� ���� ����
-- ALTER VIEW ���� ����  => OR REPLACE �̿�

-- �� ���� : DROP VIEW ���̸�;
DROP VIEW V_EMP;

-- FORCE �ɼ� : ������������ ���� ���̺��� �������� �ʾƵ� �� �����ϵ��� ��
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT;  -- ���� �߻��ص� ��� ������

-- NOFORCE �ɼ� : �⺻��, ����
CREATE OR REPLACE NOFORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT;  -- ERROR

-- �� ��ü �ܿ� �ζ��� ���� ������ ����
-- �ζ��� �� : �Ϲ����� SELECT ���� FROM ���� ���� ���������� ��Ī ���� ��

-- �Ҽӵ� �μ��� �μ����޿���պ��� �޿��� ���� �޴� ���� ��ȸ
SELECT EMP_NAME, SALARY
FROM (SELECT NVL(DEPT_ID, 'NO') "DID",
               ROUND(AVG(SALARY), -3) "DAVG"
       FROM EMPLOYEE
       GROUP BY DEPT_ID) INLV  -- �ζ��� ��
JOIN EMPLOYEE ON (NVL(DEPT_ID, 'NO') = INLV."DID")
WHERE SALARY > INLV."DAVG"
ORDER BY 2 DESC;









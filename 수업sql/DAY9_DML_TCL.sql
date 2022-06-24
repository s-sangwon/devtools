-- DAY9_DML_TCL.sql
-- DML ������ TCL ����

-- DATA MANIPULATION LANGUAGE  DML : ������ ���۾�
-- ��ɾ� : INSERT, DELETE, UPDATE, TRUNCATE
-- ���̺� �����͸� ��� �����ϰų�(INSERT), ��ϵ� �����͸� �����ϰų�(UPDATE)
-- ���� ��ϵ� ���� ������ ��(DELETE) ����ϴ� ����
-- INSERT �� : �� �߰� (�� ��� ����)
-- UPDATE �� : �÷��� ��ϵ� ���� ���� (�� ���� ���Ծ���)
-- DELETE �� :  �� ���� (�� ���� �پ��, ���� ����)
-- TRUNCATE �� : ���̺��� ���� ��� ���� ������ (���� �Ұ���)

-- UPDATE ��
/*
UPDATE ���̺��
SET ���������÷��� = ������ ��, �÷��� = DEFAULT, �÷��� = (��������)
WHERE �÷��� ������ ã���� | WHERE �÷��� ������ (��������);

���ǻ��� : WHERE ���� �����Ǹ�, ���̺��� �÷����� ���� ������
���� : SET ���� ������ �� ��ġ�� ��������(SELECT ��) ����� �� ����
        WHERE ���� ã�� ���(��) ��ġ�� �������� ��밡��
*/

CREATE TABLE DCOPY2(DID PRIMARY KEY, DNAME UNIQUE, LOC_ID REFERENCES LOCATION(LOCATION_ID))
AS
SELECT * FROM DEPARTMENT;


SELECT * FROM DCOPY;

DESC DCOPY;




UPDATE DCOPY
SET DEPT_NAME = '�λ���';

ROLLBACK;

-- �μ��ڵ� 10 �� �λ������� �ٲٱ�
UPDATE DCOPY
SET DEPT_NAME = '�λ���'
WHERE DEPT_ID = 10;

SELECT * FROM DCOPY;

--UPDATE ���� �������� ����� �� ����
-- SET ���� WHERE ���� �����

-- ���ϱ� ������ �����ڵ�� �޿��� ����
-- ������ ������ �����ڵ�� �޿��� ���� ������ �����ؾ� �Ѵٸ�,
SELECT * FROM EMP_COPY;
--���� �� Ȯ��
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMP_COPY
WHERE EMP_NAME IN ('���ϱ�', '���ر�');

UPDATE EMP_COPY
SET (SALARY, JOB_ID) = (SELECT SALARY, JOB_ID
                                    from EMP_COPY
                                    WHERE EMP_NAME = '���ر�')
WHERE EMP_NAME ='���ϱ�';                                  

--���� �� Ȯ��
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMP_COPY
WHERE EMP_NAME IN ('���ϱ�', '���ر�');

-- ���������� ���� ������ SELECT ���� �׸� �ٸ��ٸ�, ���߿� ���������� �ٲ�
--UPDATE EMP_COPY
--SET (SALARY, JOB_ID) = (SELECT SALARY, JOB_ID
--                                    from EMP_COPY
--                                    WHERE EMP_NAME = '���ر�')
--WHERE EMP_NAME ='���ϱ�'; 

-- ���̺� ������ �÷��� DEFAULT �� ������ �Ǿ� �ִ� ��쿡��
-- ������ �� ��ġ�� DEFAULT Ű���� ����� �� ����
-- ���� : DEFAULT ������ �� �� �÷��� DEFAULT ����, NULL ó����

-- ���� ���̺� �÷����� ����
ALTER TABLE EMP_COPY
MODIFY (MARRIAGE DEFAULT 'N');
DESC EMP_COPY;

-- ���� �� Ȯ�� : ��� 210 ���� ���� Ȯ��
SELECT EMP_NAME, MARRIAGE
FROM EMP_COPY
WHERE EMP_ID = '210';

--����
UPDATE EMP_COPY
SET MARRIAGE = DEFAULT
WHERE EMP_ID = '210';

-- ���� �� Ȯ�� : ��� 210 ���� ���� Ȯ��
SELECT EMP_NAME, MARRIAGE
FROM EMP_COPY
WHERE EMP_ID = '210';

ROLLBACK; -- ����� DML ���

-- UPDATE �� WHERE ������ �������� ����� �� ����
-- �ؿܿ���2�� �������� ���ʽ�����Ʈ�� ��� 0.3�� �����Ͻÿ�.
UPDATE EMP_COPY
SET BONUS_PCT = 0.3
WHERE DEPT_ID = (SELECT DEPT_ID
                            FROM DEPARTMENT
                            WHERE DEPT_NAME = '�ؿܿ���2��');

--Ȯ��                            
SELECT EMP_NAME, DEPT_ID, DEPT_NAME, BONUS_PCT
FROM EMP_COPY
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME = '�ؿܿ���2��';

-- ���� : ������ �� ����� �ش� �÷��� �������ǿ� ������� �ʴ� ���� ����ؾ� ��
UPDATE EMP_COPY
SET EMP_NAME = NULL
WHERE DEPT_ID IS NULL;

-- EMP_COPY ���̺� �������� �߰� : FOREIGN KEY
-- DEPT_ID �÷��� �߰�
ALTER TABLE EMP_COPY
ADD (FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID));


SELECT DEPT_ID FROM DEPARTMENT; -- �θ�Ű Ȯ��

-- �ܷ�Ű �������� : �θ�Ű�� ���� ���� �ڽķ��ڵ忡�� ����� �� ����

UPDATE EMP_COPY
SET DEPT_ID = '65' -- �θ�Ű�� ���� �� : ����
WHERE DEPT_ID IS NULL;

-- ��ųʸ��� �������� Ȯ��

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'EMP_COPY';

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING(TABLE_NAME, CONSTRAINT_NAME)
WHERE TABLE_NAME = 'EMP_COPY';

-- INSERT �� ***
-- ���̺� �� ���� �߰��� �� ����� : ����� �þ
-- ���̺� ������ ��� ������ �� ����ϴ� ������
/*
INSERT INTO ���̺�� (����Ͽ� ����� �÷���, ...)
VALUES (���� ������ �÷��� ���缭 ����� ��, ...);

���ǻ��� : �÷������� ������, �÷��ڷ����� ���ڷ��� �ݵ�� ��ġ���Ѿ� ��
                ���� ������ �߿���
���� : �÷��� ������ �����Ǹ�, ���̺��� ���� ��ü �÷��� ���� ����Ѵٴ� �ǹ���                
*/

-- TRANSACTION CONTROLL LANGUAGE

SELECT COUNT(*) FROM EMP_COPY; -- 22

INSERT INTO EMP_COPY (EMP_ID, EMP_NAME, EMP_NO, PHONE, EMAIL,
                                    SALARY, BONUS_PCT, HIRE_DATE, JOB_ID, DEPT_ID ,MARRIAGE, MGR_ID)
VALUES ('900', '������', '891225-1234567', '01012345678', 'OYUNHA@KKK.COM', 4810000, 0.15, '06/01/05', 
            'J4', '30', DEFAULT, NULL);
-- INSERT �ÿ� �� ��ſ� DEFAULT �� NULL Ű���� ����� �� ������
            
SELECT COUNT(*) FROM EMP_COPY;

SELECT * FROM EMP_COPY;

-- ���������� �̿��ؼ� INSERT �� �� ����
-- VALUES Ű���� ������� ����
/*
INSERT INTO ���̺�� (����Ͽ� ����� �÷���, ...) <- �������� ��� �׸�� ��ġ
(SELECT ��������);
*/

CREATE TABLE EMP (
    EMP_ID CHAR(3),
    EMP_NAME VARCHAR(20),
    DEPT_NAME VARCHAR(20)
);

INSERT INTO EMP     --(EMP_ID, EMP_NAME, DEPT_NAME)
(SELECT EMP_ID, EMP_NAME, DEPT_NAME
 FROM EMPLOYEE
 LEFT JOIN DEPARTMENT USING (DEPT_ID)
 );

SELECT * FROM EMP;

-- ���� �����ϴ� ����
/*
DELETE [FROM] ���̺��
WHERE ������ ���� ��� ������ ���ǽ�;
*/

-- WHERE ���� �����Ǹ� ���̺��� ��� ���� ������
SELECT * FROM DCOPY;

DELETE FROM DCOPY;
SELECT * FROM DCOPY;

ROLLBACK; -- DELETE �� ������ �� ����

-- TRUNCATE ��
-- ���̺��� ��� ���� ������
-- DELETE ���� ���� �ӵ��� ����, ������ �� ��
-- �θ�Ű(FOREIGN KEY ��������)�� �ִ� ���̺��� ����� �� ����

TRUNCATE TABLE DCOPY;
SELECT * FROM DCOPY;
ROLLBACK; -- ���� �� ��

TRUNCATE TABLE DEPARTMENT; -- ERROR : �����Ǵ� �ܷ�Ű�� �ֱ⶧�� �����Ұ�

-- DELETE ������ FOREIGN KEY ������������ �����ǰ� �ִ� �θ�Ű�� ���� ����

DELETE DEPARTMENT
WHERE DEPT_ID = '90';

-- �� ���� �پ��
SELECT COUNT(*) FROM EMP_COPY; -- 23

DELETE FROM EMP_COPY
WHERE EMP_ID = '900';

SELECT COUNT(*) FROM EMP_COPY; -- 22



-- * ************************ * * * * * * ** * * *** * ** * ** * *  * * *  * ** ** * * ** ** * * *
-- VIEW (��)
/*
: SELECT ���� ������ ����� �����ִ� ȭ��
-- ��� ȭ���� ������ ���̺�ó�� ������ �ΰ� ����� �� ����
-- ��� ���� :
    1. ���ȿ� ���� : ������ ��� ȭ�鸸 �����ν�, ������ �� ���̰� ��
    2. �����ϰ� �� �������� �並 
*/

/*
VIEW : SELECT �������� �����ϴ� ��ü
SELECT OR REPLACE [NOFORCE| NOFORC DEPAUL] VIEW ���̸�(��Ī,000)
AS ��������
[WITH CHECK OPTION [CONSTRAINT �̸�]'
[WITH READ ONLY [CONTRAINT �̸�]];

-- CREATE VIEW | CREATE OR REPLACE VIEW
        �����ϴ� �̸��� �䰡 ������ ���� �����ϰ� (CREATE)
        ���̸��� �����ϸ� ����(REPLACE)

-- FORCE | NOFORCE
    * FORCE : ���������� ���� ���̺�(���̽� ���̺�)�� �������� �ʾƵ�
                         �� ��ü ������(�ܼ� ������ ���� �뵵')
    * NOFORCE : �⺻ ��������, ���̽� ���̺��� �����ϴ� ��쿡�� �� 
                    �������� SELECT ���� ���� �۵��Ǹ� �����
(��Ī, ALIAS,...)
-           -���̺� �÷� ��Ī����� ���� �ǹ���
    --> �����÷� ��Ī�� ���� ��
    -- �������� SELECT ���� �׸� ������ ��Ī ������ �ݵ�� ��ġ�ؾ���.\


-��������
    : �信 ������ SELECT ����;'
    
-- �� ��������
    * WITH CHECK OPTION
            : �並 �̿��ؼ� ���̽� ���̺��� DML �۾� �����
                ���̽� ���̺��� 1���϶��� ������
    * WITH READ ONLY
            : �並 ���� DML �۾� ��� ���� ������������ ���ֵ� ���� �̸� ���� ����
** CREATE VIEW �� ���� �ο� �� �ʿ���
*/
CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE; -- ���� Ȯ��

-- �� ����� : �������� �����
-- �� ������ �� ����ϴ� ���������� �Ϲ����� SELECT ������ �����
-- ������ ��� ���̺�ó�� ��޵�
-- ��� �����Ͱ� ����

CREATE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME �̸�, DEPT_NAME �μ���, JOB_TITLE ���޸�, SALARY �޿�
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE DEPT_ID = '90';

-- Ȯ��
SELECT * FROM V_EMP_DEPT90;

CREATE OR REPLACE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME �̸�, DEPT_NAME �μ���, JOB_TITLE ���޸�, SALARY �޿�
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE DEPT_ID = '90';

-- �� ���� ������ ��ųʸ� : INSER_VIEWS
SELECT * FROM USER_VIEWS;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE  VIEW_NAME = 'V_EMP';

-- �ǽ� :
-- ���޸��� '���'�� ��� �������� �����, �μ���, ���޸��� ��ȸ�ϴ� ������
-- ��� �����Ͻÿ�

CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '���';

SELECT * FROM V_EMP_DEPT_JOB;

-- �䵵 ���̺�ó�� ��ü�� ��ȸ ������
SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM USER_TAB_COLS -- ���̺긣�� �÷� ���� ������ ��ųʸ�
WHERE TABLE_NAME = 'V_EMP_DEPT_JOB';

-- �� ������ �÷� ��Ī ALIAS ��� --------------
-- ��Ī ���� : �� ���� �κ�, �������� �κ�
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB (ENAME, DNAME, JTITLE)
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '���';
-- ���������� ����
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS
SELECT EMP_NAME ENM, DEPT_NAME DNM, JOB_TITLE TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '���';

SELECT * FROM V_EMP_DEPT_JOB;

-- �� �ۼ��� ���ǻ��� :
-- �������� SELECT ���� �Լ��� ������ ������ �ݵ�� ALIAS ������ ��

-- �������� �̸�, ����, ���̸� �ٹ�����ϴ� �������� �ۼ��ϰ�
-- ��� �����Ͻÿ�. : V_EMP
CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMP_NAME �̸�, DECODE( SUBSTR(EMP_NO,8,1), '1', '��', '��') ����,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/ 12) �ٹ����
FROM EMPLOYEE;

-- �� ���� ��������
-- ���� ���� ������ �ƴ����� �並 ���� DML �۾� ���� ���θ� �����ϴ� �ɼ�
-- DML �۾� ���� ����� ���̽� ���̺� �����
-- COMMIT | ROLLBACK
-- �並 ���� DML �۾��� �������� ������ ����

-- WITH READ ONLY : �並 ���� DML�۾� �Ұ� �б�����
CREATE OR REPLACE VIEW V_EMP
AS
SELECT * FROM EMPLOYEE
WITH READ ONLY;

-- DML �۾� ������ ���� ���� ������ �ٸ�����
-- DML �۾��� ������� �ʴ´�.
UPDATE V_EMP
SET PHONE = NULL;

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO)
VALUES ('777', '������', '777777,7777777');

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

--����
INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('777', '������', '777777,7777777', 'Y');

--����
UPDATE V_EMP
SET MARRIAGE = 'Y';

-- �並 ������ �� ����� �������� WHERE �� ������ ����Ǵ� �������� ����

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('777', '������', '777777,7777777', 'N'); -- OK

SELECT * FROM EMPLOYEE;

ROLLBACK;

UPDATE V_EMP
SET EMP_ID = '000'
WHERE EMP_ID = '124';

--Ȯ��
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
SELECT NVL(DEPT_ID, 'NO') �μ���ȣ, 
           NVL( DEPT_NAME, 'NONE') �μ���,
           ROUND(AVG(SALARY), -3) SUMDEPT_SAL
FROM DEPARTMENT
RIGHT JOIN EMPLOYEE USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME;

SELECT * FROM V_DEPT_SAL;

-- ""�� ����� ALIAS �� ���ÿ��� "" Vǥ���ؾ� ��
SELECT *
FROM V_DEPT_SAL
WHERE DAVG > 3000000;

-- "" �̹��������� �����ȳ�
SELECT DNM, DAVG
FROM V_DEPT_SAL
WHERE DAVG > 3000000;

-- �� ���� : ���� ���� ����
-- ALTER VIEW ���� ����

-- �� ���� : DROP VIEW;
DROP VIEW V_EMP;

-- FORCE �ɼ� : ������������ ���� ���̺��� �������� �ʾƵ� �� �����ϵ��� ��
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT;  -- ���� �߻��ص� ��� ������

SELECT * FROM V_EMP;

-- NOFORCE �ɼ� : �⺻��, ����
CREATE OR REPLACE NOFORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT; -- ERROR

-- �� ��ü �ܿ� �ζ��� ���� ������ ����
-- �ζ��� �� : FROM ���� ����ϴ� �������� ����

-- �Ҽӵ� �μ��� �μ����޿���պ��� �޿��� ���� �޴� ���� ��ȸ
SELECT EMP_NAME, SALARY
FROM (SELECT  NVL(DEPT_ID, 'NO') DID,
                        ROUND(AVG(SALARY), -3) DAVG
            FROM EMPLOYEE
            GROUP BY DEPT_ID) INLV
JOIN EMPLOYEE ON (NVL(DEPT_ID, 'NO') = INLV.DID)
WHERE SALARY > INLV.DAVG
ORDER BY 2 DESC;

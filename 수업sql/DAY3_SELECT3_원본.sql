-- DAY3_SELECT3.sql
-- ����Ŭ���� ����ϴ� �Լ�
-- �ٸ� DBMS ������ ����� ����ϰų� ����

-- �Լ� (FUNCTION) *****************************
-- �÷��� ��ϵ� ���� �о �Լ��� ó���� ����� �����ϴ� ������
-- �Լ���(�÷���) ���
-- ������ �Լ� (SINGLE ROW FUNCTION) : 
-- ���� ���� N���̸�, ������� N���� ��ȯ�� (�� �྿ �ٷ�� �Լ�)
-- �׷� �Լ� (GROUP FUNCTION) : 
-- ���� ���� N���̸�, ������� 1�� ��ȯ�� (���� ���� ���� �׷����� ����)

-- �Լ� ���� ������ �ʿ��� ���� :
-- SELECT ������ ������ �Լ��� �׷��Լ��� �Բ� ��� �� �� (������)
-- ������ �����ͺ��̽�(RDBMS)�� 2���� ���̺� ������. (����� �簢���̾�� ��)

SELECT UPPER(EMAIL), -- 22��
        SUM(SALARY)  -- 1��
FROM EMPLOYEE;  -- ���� Ȯ��

-- ����� ���� Ȯ��
SELECT EMAIL, UPPER(EMAIL)
FROM EMPLOYEE;

SELECT SUM(SALARY)
FROM EMPLOYEE;

-- �׷��Լ�
-- SUM(), AVG(), MAX(), MIN(), COUNT()

-- SUM(�÷���) | SUM(DISTINCT �÷���)
-- �հ踦 ���ؼ� ������

-- �ҼӺμ��� '50'�̰ų� �μ��� �������� ���� �������� �޿� �հ踦 ��ȸ
SELECT SUM(SALARY) �޿��հ�, 
        SUM(DISTINCT SALARY) "�ߺ��� ������ �޿��հ�"
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

SELECT DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- WHERE ������ �񱳰��� �׷��Լ� ����� �� ����
-- WHERE ������ �������Լ��� ����� �� ����
-- �� : �� ������ �޿� ��պ��� �޿��� ���� �޴� ���� ��ȸ
-- ���, �̸�, �޿�
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY > AVG(SALARY);  -- ERROR : ORA-00934

-- �ذ� 1 : ��ü �޿� ����� ���� ��ȸ�ϰ�, �� ���� �������� ���
-- SELECT �� ���� �ۼ�
SELECT AVG(SALARY)
FROM EMPLOYEE;  -- 2961818.18181818181818181818181818181818

SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY > 2961818; 

-- �ذ� 2 : �������� ���
-- �� ��� ��ġ�� �� ���� ��ȸ�ϴ� �������� ���� ����ϴ� �����
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                 FROM EMPLOYEE); 

-- AVG(�÷���) | AVG(DISTINCT �÷���)
-- ����� ���ؼ� ��ȯ��

-- �ҼӺμ��� 50 �Ǵ� 90 �Ǵ� NULL �� �������� ���ʽ�����Ʈ ��� ��ȸ
SELECT AVG(BONUS_PCT) �⺻���,  -- /4
        AVG(DISTINCT BONUS_PCT) �ߺ��������, -- /3
        AVG(NVL(BONUS_PCT, 0)) NULL�������  -- /11
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') OR DEPT_ID IS NULL;

SELECT BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') OR DEPT_ID IS NULL;

-- MAX(�÷���) | MAX(DISTINCT �÷���)
-- ���� ū �� ��ȯ (����, ��¥, ���� �� ó����)
-- MIN(�÷���) | MIN(DISTINCT �÷���)
-- ���� ���� �� ��ȯ (����, ��¥, ���� �� ó����)
-- ������(CHAR, VARCHAR2, LONG, CLOB), ������(NUMBER), ��¥��(DATE)

-- �μ��ڵ尡 50 �Ǵ� 90 �� �������� 
-- �����ڵ�(CHAR)�� �ִ밪, �ּҰ�
-- �Ի���(DATE)�� �ִ밪, �ּҰ�
-- �޿�(NUMBER)�� �ִ밪, �ּҰ� ��ȸ
SELECT MAX(JOB_ID), MIN(JOB_ID),
        MAX(HIRE_DATE), MIN(HIRE_DATE),
        MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90');

-- COUNT(*) | COUNT(�÷���) | COUNT(DISTINCT �÷���)
-- * : ��ü �� ���� ��ȯ (NULL ����)
-- �÷��� : NULL ������ ��ϰ��� �� ���� ��ȯ

SELECT DEPT_ID  -- 8��
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

SELECT COUNT(*), -- ��ȸ�� ��ü �� ���� : 8��
        COUNT(DEPT_ID), -- NULL ������ ���� �ִ� �� ���� : 6��
        COUNT(DISTINCT DEPT_ID) -- NULL�� �ߺ��� ������ �� ���� : 1��
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- ������ �Լ� ********************************

-- ���� ó�� �Լ� -------------------------------------------

-- LENGTH('���ڸ��ͷ�') | LENGTH(���ڰ� ��ϵ� �÷���)
-- ���� ���� ����

SELECT LENGTH('ORACLE'), LENGTH('����Ŭ')
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- LENGTHB('���ڸ��ͷ�') | LENGTHB(���ڰ� ��ϵ� �÷���)
-- ��� ������ ����Ʈ ũ�⸦ ����
SELECT LENGTHB('ORACLE'), LENGTHB('����Ŭ')
FROM DUAL;

-- INSTR('���ڿ����ͷ�'| ���ڰ� ��ϵ� �÷���, ã������, ã�� ������ġ, ���°����)
-- ã�� ������ ��ġ ���� (�տ��� ������ ������)

-- �̸��Ͽ��� '@' ���� ��ġ ��ȸ
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- �̸��Ͽ��� '@' ���� �ٷ� �ڿ� �ִ� 'k' ������ ��ġ�� ��ȸ
-- ��, �ڿ��� ���� �˻���
SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3), INSTR(EMAIL, '@') + 1
FROM EMPLOYEE; 

-- �Լ� ��ø ��� ������
-- �̸��Ͽ��� '.' ���� �ٷ� �ڿ� �ִ� 'c' �� ��ġ�� ��ȸ
-- ��, '.' ���� �ٷ� �ձ��ں��� �˻� �����ϵ��� ��
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') - 1)
FROM EMPLOYEE;

-- LPAD('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���, ����� �ʺ���ڼ�, ���¿��� ä�﹮��)
-- ä�﹮�ڰ� �����Ǹ� �⺻���� ' '(���鹮����)
-- LPAD() : ���� ä���, RPAD() : ������ ä���
SELECT EMAIL ����, LENGTH(EMAIL) ��������,
        LPAD(EMAIL, 20, '*') ä�����,
        LENGTH(LPAD(EMAIL, 20, '*')) �������
FROM EMPLOYEE;

SELECT EMAIL ����, LENGTH(EMAIL) ��������,
        RPAD(EMAIL, 20, '*') ä�����,
        LENGTH(RPAD(EMAIL, 20, '*')) �������
FROM EMPLOYEE;

-- LTRIM('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���, '������ ���ڵ�')
-- ���ʿ� �ִ� ���ڵ��� ������ ���ڰ� ����
-- RTRIM() : �����ʿ� �ִ� ���ڵ��� ������ ���� ����
SELECT '    12345abxyORACLExxxyyy567     ',
        LTRIM('    12345abxyORACLExxxyyy567     '),
        LTRIM('    12345abxyORACLExxxyyy567     ', ' '),
        LTRIM('    12345abxyORACLExxxyyy567     ', ' 0123456789'),
        LTRIM('    12345abxyORACLExxxyyy567     ', ' abxy12345')
FROM DUAL;

SELECT '    12345abxyORACLExxxyyy567     ',
        RTRIM('    12345abxyORACLExxxyyy567     '),
        RTRIM('    12345abxyORACLExxxyyy567     ', ' '),
        RTRIM('    12345abxyORACLExxxyyy567     ', ' 0123456789'),
        RTRIM('    12345abxyORACLExxxyyy567     ', ' xy1234567')
FROM DUAL;

-- TRIM(LEADING | TRAILING | BOTH '�����ҹ���' FROM '���ڸ��ͷ�' | �÷���)
SELECT 'aaORACLEaa',
        TRIM('a' FROM 'aaORACLEaa'),
        TRIM(LEADING 'a' FROM 'aaORACLEaa'),
        TRIM(TRAILING 'a' FROM 'aaORACLEaa'),
        TRIM(BOTH 'a' FROM 'aaORACLEaa')
FROM DUAL;

-- SUBSTR('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���, ������ ������ġ, ������ ���ڰ���)
-- ������ ������ġ : ���(�տ��������� ��ġ), ����(�ڿ��������� ��ġ)
-- ������ ���ڰ��� : �����Ǹ� �����ڱ����� �ǹ���
SELECT 'ORACLE 18C',
        SUBSTR('ORACLE 18C', 5), -- LE 18C
        SUBSTR('ORACLE 18C', 8, 2), -- 18
        SUBSTR('ORACLE 18C', -7, 3) -- CLE
FROM DUAL;

-- ���� ���̺��� �ֹι�ȣ���� ����, ����, ������ ���� �и� ��ȸ
SELECT EMP_NO,
        SUBSTR(EMP_NO, 1, 2) ����,
        SUBSTR(EMP_NO, 3, 2) ����,
        SUBSTR(EMP_NO, 5, 2) ����
FROM EMPLOYEE;

-- ��¥ ǥ��ÿ� �ݵ�� ����ó�� '' ��� ǥ���ؾ� ��
-- '22/06/15' ǥ����
-- SUBSTR() �� ��¥�����Ϳ��� ����� �� ����

-- �������� �Ի��Ͽ��� �Ի�⵵, �Ի��, �Ի����� �и� ��ȸ
SELECT HIRE_DATE �Ի���,
        SUBSTR(HIRE_DATE, 1, 2) �Ի�⵵,
        SUBSTR(HIRE_DATE, 4, 2) �Ի��,
        SUBSTR(HIRE_DATE, 7, 2) �ϻ���
FROM EMPLOYEE;

-- SUBSTRB('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���, ������ ����Ʈ��ġ, ������ ����Ʈ)
SELECT SUBSTR('ORACLE', 3, 2), -- AC
        SUBSTRB('ORACLE', 3, 2), -- AC
        SUBSTR('����Ŭ', 2, 2), -- ��Ŭ
        SUBSTRB('����Ŭ', 4, 6)  -- ��Ŭ
FROM DUAL;

-- UPPER('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���)
-- �������� �� �빮�ڷ� �ٲٴ� �Լ�
-- LOWER('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���)
-- �������� �� �ҹ��ڷ� �ٲٴ� �Լ�
-- INITCAP('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���)
-- �������� �� ù���ڸ� �빮�ڷ� �ٲٴ� �Լ�
SELECT UPPER('ORACLE'), UPPER('oracle'),
        LOWER('ORACLE'), LOWER('oracle'),
        INITCAP('ORACLE'), INITCAP('oracle')
FROM DUAL;

-- �Լ� ��ø ��� : �Լ� �ȿ� �� ��ſ� �Լ��� ����� �� ����
-- ���� �Լ��� ��ȯ�� ���� �ٱ� �Լ��� ����Ѵٴ� �ǹ���

-- ���� �������� ���, �̸�, ���̵� ��ȸ
-- ���̵�� �̸��Ͽ��� �и� ������
SELECT EMP_ID ���, EMP_NAME �̸�, EMAIL �̸���, 
        SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) ���̵�
FROM EMPLOYEE;

-- ���� ���̺��� ���, �̸�, �ֹι�ȣ ��ȸ
-- �ֹι�ȣ�� ������ϸ� ���̰��ϰ� ���ڸ��� '*' ó���� : 781225-*******
SELECT EMP_ID ���, EMP_NAME �̸�,
        RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;


-- ���� ó�� �Լ� -----------------------------------------
-- ROUND(), TRUNC(), FLOOR(), ABS(), MOD()

-- ROUND(���� | ���ڰ� ��ϵ� �÷��� | ����, �ݿø��� �ڸ���)
-- �������� �ڸ��� ���� 5�̻��̸� �ڵ� �ݿø���
-- �ݿø��� �ڸ����� ����̸� �Ҽ��� �Ʒ� ǥ���� �ڸ��� �ǹ���
-- �ݿø��� �ڸ����� �����̸� �Ҽ��� ��(������) �ø��� �ڸ��� �ǹ���
SELECT 123.456,
        ROUND(123.456),  -- 123
        ROUND(123.456, 0), -- 123
        ROUND(123.456, 1), -- 123.5
        ROUND(123.456, -1) -- 120
FROM DUAL;

-- ���� �������� ���, �̸�, �޿�, ���ʽ�����Ʈ, ���ʽ�����Ʈ ���� ���� ��ȸ
-- ������ ��Ī ó�� : 1��޿�
-- ������ õ�������� �ݿø�ó����
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, BONUS_PCT ���ʽ�����Ʈ,
        ROUND(((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12), -4) "1��޿�"
FROM EMPLOYEE;

-- TRUNC(���� | ���ڰ� ��ϵ� �÷��� | ����, �ڸ� �ڸ���)
-- ������ �ڸ��Ʒ��� ���� ����, �����Լ�, �ݿø� ����
SELECT 145.678, 
        TRUNC(145.678),  -- 145
        TRUNC(145.678, 0),  -- 145
        TRUNC(145.678, 1),  -- 145.6
        TRUNC(145.678, -1), -- 140
        TRUNC(145.678, -3)  -- 0
FROM DUAL;

-- ���� �������� �޿��� ����� ��ȸ
-- 10�������� ������
SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2)
FROM EMPLOYEE;

-- FLOOR(���� | ���ڰ� ��ϵ� �÷��� | ����)
-- ���� ����� �Լ� (�Ҽ��� �Ʒ��� ����)
SELECT ROUND(123.5), TRUNC(123.5), FLOOR(123.5)
FROM DUAL;

-- ABS(���� | ���ڰ� ��ϵ� �÷��� | ����)
-- ���밪 ���ϴ� �Լ� (����� 0�� �״��, ������ ����� �ٲ�)
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- ���� �������� �Ի��� - ����, ���� - �Ի��� ��ȸ
-- ��Ī : �ٹ��ϼ�
-- ���� ��¥ ��ȯ �Լ� : SYSDATE
-- �ٹ��ϼ��� ���, ������ ó����
SELECT ABS(FLOOR(HIRE_DATE - SYSDATE)) �ٹ��ϼ�,
        ABS(FLOOR(SYSDATE - HIRE_DATE)) �ٹ��ϼ�
FROM EMPLOYEE;

-- MOD(������, ������)
-- �������� �������� ������
-- �����ͺ��̽������� % (MOD) ������ ��� �� ��
SELECT FLOOR(25 / 7) ��, MOD(25, 7) ������
FROM DUAL;

-- ���� �������� ����� Ȧ���� ���� ��ȸ
-- ���, �̸�
SELECT EMP_ID ���, EMP_NAME �̸�
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- ��¥ ó�� �Լ� -------------------------------------

-- SYSDATE �Լ�
-- �ý������� ���� ���� ��¥�� �ð��� ��ȸ�� �� ���
SELECT SYSDATE
FROM DUAL;  -- ��µǴ� ��¥ ����(FORMAT) : '22/06/15'

-- ����Ŭ������ ȯ�漳��, ��ü ���� �������� ��� ���� �����ϰ� ����
-- ������ ��ųʸ�(������ ����) ������ ���̺� ���·� �� �������� ���� �����ϰ� ����
-- ������ ��ųʸ��� DB �ý����� ������, ����ڴ� �մ� �� ����
-- ����� ������ ��ȸ�� �� ���� ����

-- ��, ȯ�漳���� ���õ� �κ��� ���� ������ �Ϻ� ������ �� ����
SELECT *
FROM SYS.nls_session_parameters;

-- ��¥ ���˰� ���õ� ���� ���� ��ȸ�Ѵٸ�
SELECT VALUE
FROM SYS.NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- ��¥ ������ �����Ѵٸ�
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

-- Ȯ��
SELECT SYSDATE
FROM DUAL;

-- ���� �������� ����
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- ADD_MONTHS('��¥' | ��¥�� ��ϵ� �÷���, ���� ������)
-- ���� �������� ���� ��¥�� ���ϵ�

-- ���� ��¥���� 6���� �� ��¥��?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 6)
FROM DUAL;

-- ���� �������� �Ի��Ͽ��� 20��� ��¥ ��ȸ
-- ���, �̸�, �Ի���, 20��� ��¥ (��Ī ó��)
SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���,
        ADD_MONTHS(HIRE_DATE, 240) "20��� ��¥"
FROM EMPLOYEE;

-- ������ �Լ��� WHERE ������ ����� �� ����
-- ������ �� �ٹ������ 20�� �̻�� ���� ���� ��ȸ
-- ���, �̸�, �μ��ڵ�, �����ڵ�, �Ի���, �ٹ���� (��Ī)
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_ID �μ��ڵ�, JOB_ID �����ڵ�,
        HIRE_DATE �Ի���, 
        FLOOR((SYSDATE - HIRE_DATE) / 365) �ٹ����
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE
ORDER BY �ٹ���� DESC;

-- MONTHS_BETWEEN(DATE1, DATE2)
-- '��¥' | ��¥�� ��ϵ� �÷���
-- �� ��¥�� �������� ���̰� ���ϵ�

-- �������� �̸�, �Ի���, ��������� �ٹ��ϼ�, �ٹ�������, �ٹ���� ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        FLOOR(SYSDATE - HIRE_DATE) �ٹ��ϼ�,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) �ٹ�������,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE;

-- NEXT_DAY('��¥' | ��¥�� ��ϵ� �÷���, '�����̸�')
-- ������ ��¥ ���� ��¥���� ���� ����� ���� ������ ��¥�� ������
-- ���� DBMS �� ���� 'KOREAN' �̹Ƿ�, �����̸��� �ѱ۷� ��� ��
-- ���� �����̸� ����ϸ� ������

SELECT SYSDATE, NEXT_DAY(SYSDATE, '�Ͽ���')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL;  -- ����

-- ȯ�漳�� ������ �� ������ ��
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

ALTER SESSION
SET NLS_LANGUAGE = KOREAN;

SELECT NEXT_DAY('22/08/15', '�����')
FROM DUAL;

-- LAST_DAY('��¥' | ��¥�� ��ϵ� �÷���)
-- ������ ��¥�� ���� ���� ������ ��¥�� ������
SELECT SYSDATE, LAST_DAY(SYSDATE),
        '20/02/01', LAST_DAY('20/02/01')
FROM DUAL;

-- ���� �������� �̸�, �Ի���, �Ի��� ��(ù��)�� �ٹ��ϼ� ��ȸ
-- �ָ� ���� �ϼ�
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի�ù�� �ٹ��ϼ�"
FROM EMPLOYEE;

-- ���� ��¥ ��ȸ �Լ�
SELECT SYSDATE, SYSTIMESTAMP, 
        CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(������ ���� FROM ��¥)
-- ��¥ �����Ϳ��� ���ϴ� ������ ������
-- ������ ���� : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

-- ���� ��¥���� �⵵, ��, �� ���� ����
SELECT SYSDATE,
        EXTRACT(YEAR FROM SYSDATE),
        EXTRACT(MONTH FROM SYSDATE),
        EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- �������� �̸�, �Ի���, �ٹ���� ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) /12) �ٹ����
FROM EMPLOYEE;





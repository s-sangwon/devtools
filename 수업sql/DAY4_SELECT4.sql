-- DAY4_SELECT4.sql
-- �Լ� 2

-- Ÿ��(TYPE : �ڷ���) ��ȯ �Լ� --------------------------------

-- �ڵ�����ȯ(�Ͻ�����ȯ)�� ���
-- ��ǻ�� ���� ��Ģ : ���� ������ ��(DATA)������ ����� �� �ִ�.

SELECT 12 || 42  -- NUMBER + CHARACTER --> NUMBER  + NUMBER
FROM DUAL; -- �Ͻ��� ����ȯ�� �Ͼ��.

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 100; -- CHAR = NUMBER --> CHAR = CHAR
-- NUMBER 100 >> CHAR '100' �ڵ� Ÿ���� ��ȯ��

-- �ڵ�����ȯ�� �� �Ǵ� ���
SELECT SYSDATE - '15/03/25' -- DATE - CHARACTER  --> DATE �� ����ȯ �ʿ�
FROM DUAL;

-- ����� ����ȯ : ����ȯ �Լ� �����
SELECT SYSDATE - TO_DATE('15/03/25')
FROM DUAL;

-- TO_CHAR() �Լ� --------------------
-- ����(NUMBER)�� ��¥(DATE)�� ���� ��� ����(FORMAT) ������ ����ϴ� �Լ�
-- TO_CHAR(NUMBER, FORMAT) ->������ ����� ���ڿ�(CHARACTER)�� ����
-- TO_CHAR(DATE, FORMAT) -> ������ ����� ���ڿ�(CHARACTER)�� ����

-- ���ڿ� ���� ����
-- TO_CHAR(���ڸ��ͷ� | ���ڰ� ��ϵ� �÷���, '���˹��ڳ���')
-- �ַ� ��ȭ���� ǥ��, õ����������, �Ҽ��� �ڸ��� ǥ��, ������ ���� ��
SELECT EMP_NAME �̸�,
            TO_CHAR(SALARY, 'L99,999,999') �޿�,
            TO_CHAR(NVL(BONUS_PCT, 0), '90.00') 
FROM EMPLOYEE;

-- ��¥�� ���� ���� 
-- TO_CHAR('��¥ ���ͷ�' | ��¥�� ��ϵ� �÷��� | TO_DATE('����'), '���˹��ڳ���')
-- ����� �ú��� ���� �б� ���� ��� ���� ������ �� ����

-- �⵵ ��� ����
SELECT SYSDATE, -- NLS_DATE_FORMAT : RR/MM/DD
            TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
            TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
            TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- �⵵ ���� + '������ ��¹���'
-- ����ǥ �ȿ��� ����ǥ�� ����� ���� "" �ִٿ�ǥ�̿�
SELECT SYSDATE, -- NLS_DATE_FORMAT : RR/MM/DD
            TO_CHAR(SYSDATE, 'YYYY"��"'), TO_CHAR(SYSDATE, 'RRRR"��"'),
            TO_CHAR(SYSDATE, 'YY"��"'), TO_CHAR(SYSDATE, 'RR"��"'),
            TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ��(MONTH)�� ���� ����
SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'YYYY"��" MM"��"'),
            TO_CHAR(SYSDATE, 'YYYY"��" fmMM"��"'),
            TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'RM'),
            TO_CHAR(SYSDATE, 'MONTH'),  TO_CHAR(SYSDATE, 'MON')
FROM DUAL;

-- ��¥�� ���� ����
SELECT SYSDATE,
            TO_CHAR(SYSDATE, '"1�����" DDD "��°"'),
            TO_CHAR(SYSDATE, '"������" DD "��°"'),
            TO_CHAR(SYSDATE, '"1�ֱ���" D "��°"')
FROM DUAL;

-- �б�, ���� ����

SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'Q "�б�"'),
            TO_CHAR(SYSDATE, 'DAY'),
            TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- ��, ��, ��, ����|���� ����
SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'HH24"��" MI"��" SS"��"'),
            TO_CHAR(SYSDATE, 'AM HH:MI:SS'),
            TO_CHAR(SYSDATE, 'PM HH24:MI:SS')
FROM DUAL;

-- ���� �������� �̸�, �Ի��� ��ȸ
-- �Ի����� ���� ������
-- ���� �� : 2021�� 11�� 12�� (��) �Ի�

SELECT EMP_NAME, HIRE_DATE,
            TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" "("DY")" "�Ի�"')
FROM EMPLOYEE;

-- ��¥ ������ �񱳿���� ���ǻ��� :
SELECT EMP_NAME �̸�,
            TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS')   
FROM EMPLOYEE;

-- �Ѽ��⸸ �ð��� ������ ����, �ٸ� �������� �ð� �����Ͱ� ����

-- ��¥�� �ð��� ���� ��ϵ� ���, �񱳿���� ��¥�� ���� �� ����
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = '90/04/01 13:30:30'; -- '90/01/01 13:30:30' == '30/04/01' : FALSE
-- ����� : 0

-- �ذ��� 1 :
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'RR/MM/DD') = '90/04/01';

-- �ذ��� 2 :
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01';

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = TO_DATE('90/04/01 13:30:30', 'YY/MM/DD HH24:MI:SS'); 


-- TO_DATE() �Լ� --------------------------------------------------
-- TO-DATE('���ڸ��ͷ�' | ���ڰ� ��ϵ� �÷���, '�����ڿ� ��Ī�� ���� ���ڵ�')
-- ������ ���ڼ��� ���˱��ڼ��� �ݵ�� ���ƾ� ��
-- TO_CHAR() ���˰� �ǹ̰� �ٸ�

SELECT TO_DATE('20161225', 'YYYYMMDD'),
            TO_CHAR(TO_DATE('20161225', 'YYYYMMDD'), 'DY')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('20221225 152035', 'YYYYMMDD HH24:MI:SS'), 
                        'YY-MM-DD DY AM HH:MI:SS')
FROM DUAL;


-- RR �� YY �� ����
-- �� �ڸ� �⵵�� ���ڸ� �⵵�� �ٲ� ��
-- ���� �⵵�� (22 : 50���� ����) �� ��
-- �ٲ� �⵵�� 50�̸��̸� ���� ����(2000)�� ����
-- �ٲ� �⵵�� 50�̻��̸� ��������(1900)�� ����
SELECT HIRE_DATE,
            TO_CHAR(HIRE_DATE, 'RRRR'),
            TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE; -- DATE ������ 2�ڸ��� 4�ڸ��� ����� Y, R �ƹ��ų� ���

-- ���� �⵵�� �ٲ� �⵵�� �� �� 50�̸��̸�, Y, R �ƹ��ų� ����ص� ��
SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'YYYY-MM-DD'),
            TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR-MM-DD'),
            TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY-MM-DD'),
            TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'RRRR-MM-DD')
FROM DUAL;

-- ���� �⵵�� 50�̸��̰� �ٲ� �⵵�� 50�̻��϶�,
-- TO_DATE() ���� ���ڸ� �⵵�� �ٲ� �� Y ���� ���� ����(2000) ����
-- R���� �������� ����

SELECT TO_CHAR(TO_DATE('970320', 'YYMMDD'), 'YYYY-MM-DD'),
            TO_CHAR(TO_DATE('970505', 'RRMMDD'), 'YYYY-MM-DD'),
            TO_CHAR(TO_DATE('970505', 'RRMMDD'), 'YYYY-MM-DD'),
            TO_CHAR(TO_DATE('970505', 'YYMMDD'), 'YYYY-MM-DD')
FROM DUAL;

-- ��� : ���ڸ� �⵵��  �ٲ� �� �⵵�� 'R' ����ϸ� ��.


-- ��Ÿ �Լ� -------------------------------------------------------------

-- NVL() �Լ�
-- ������� : NVL(�÷���, �÷��� NULL�϶� �ٲ� ��)
SELECT EMP_NAME , 
            NVL(BONUS_PCT, 0.0), 
            NVL(DEPT_ID, '00'), 
            NVL(JOB_ID, 'J0')
FROM EMPLOYEE;

-- NVL2() �Լ�
-- ������� : NVL2(�÷���, �ٲܰ�1, �ٲܰ�2)
-- �ش� �÷��� ���� ������ �ٲܰ�1�� ����, NULL�̸� �ٲܰ�2�� ����

-- ���� �������� ���ʽ�����Ʈ�� 0.2�̸��̰ų� NULL �� �������� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, BONUS_PCT ���ʽ�����Ʈ,
            NVL2(BONUS_PCT, 0.15, 0.05 ) ���溸�ʽ�����Ʈ
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 OR BONUS_PCT IS NULL;

-- DECODE() �Լ�
/*
������� :
DECODE(���� | �÷���, ������, ���ð��� ������ ���ð�, ......, ������N, ���ð�N)
DECODE(���� | �÷���, ������, ���ð��� ������ ���ð�, ......, ������N, ���ð�N, 
                                        ���õ� ���� ��� �ƴҶ� ������ ��)
���̽� ���α׷��� IF~ELIF~ELIF~... ELSE ������ ������ �Լ���     
�ڹ� ����� SWITCH���� ���� ������ ������ �Լ���
*/

-- 50�� �μ��� �Ҽӵ� �������� �̸��� ���� ��ȸ

SELECT EMP_NAME �̸�,
            DECODE(SUBSTR(EMP_NO, 8,1), '1', '��', '3', '��', '2', '��', '4', '��')����
FROM EMPLOYEE
WHERE DEPT_ID = '50'
ORDER BY ����, �̸�; --  ���� ���� �������� ���� ó��

SELECT EMP_NAME �̸�,
            DECODE(SUBSTR(EMP_NO, 8,1), '1', '��', '3', '��', '��')����
FROM EMPLOYEE
WHERE DEPT_ID = '50'
ORDER BY ����, �̸�; --  ���� ���� �������� ���� ó��


-- ���� �̸��� ������ ��� ��ȸ
SELECT EMP_NAME, MGR_ID
FROM EMPLOYEE;

-- ������ ����� NULL �̸� '000' ���� �ٲٱ�
-- 1. NVL() ���

SELECT EMP_NAME, NVL(MGR_ID, '000')
FROM EMPLOYEE;

-- 2. DECODE() ���
SELECT EMP_NAME, DECODE(MGR_ID, NULL, '����', MGR_ID)
FROM EMPLOYEE;

-- ���޺� �޿� �λ���� �ٸ� ��
-- DECODE() ����� ���
SELECT EMP_NAME, JOB_ID, SALARY,
            TO_CHAR(DECODE(JOB_ID, 'J7', SALARY * 1.1,
                                                    'J6', SALARY * 1.15,
                                                    'J5', SALARY * 1.2,
                                                    SALARY * 1.05), 'L99,999,999') �λ�޿�
FROM EMPLOYEE;

-- 2. CASE ǥ���� ����� ���
-- ���� IF ���� ���� ���� ������ ����

SELECT EMP_NAME, JOB_ID, SALARY,
            TO_CHAR(CASE JOB_ID
                WHEN 'J7' THEN SALARY * 1.1
                WHEN 'J6' THEN SALARY * 1.15
                WHEN 'J5' THEN SALARY * 1.2
                ELSE SALARY * 1.05
            END  , 'L99,999,999') �λ�޿�
FROM EMPLOYEE;

-- �����̤� �޿��� ��� ���� ��ȸ
SELECT EMP_ID,
            EMP_NAME,
            SALARY,
            CASE WHEN SALARY <= 3000000 THEN '�ʱ�'
                    WHEN SALARY <= 4000000 THEN '�߱�'
                    ELSE '���' END AS ����
FROM EMPLOYEE
ORDER BY ����;

--
--�Լ� ��������
--
--1. ������� �ֹι�ȣ�� ��ȸ��
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******
SELECT EMP_NAME, SUBSTR(EMP_NO,1,8) || '******' �ֹι�ȣ,
            RPAD(SUBSTR(EMP_NO,1,8), 14, '*')
FROM EMPLOYEE;



--
--
--2. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
--
SELECT EMP_NAME, JOB_ID, TO_CHAR((SALARY+(NVL(BONUS_PCT, 0) * SALARY)) * 12, 'L999,999,999') "����(��)"
FROM EMPLOYEE;

--3. �μ��ڵ尡 50, 90�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--   �� ��ȸ��.
--	��� ����� �μ��ڵ� �Ի���
SELECT EMP_NO ���, EMP_NAME �����, DEPT_ID �μ��ڵ�, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE DEPT_ID IN('50', '90') AND TO_CHAR(HIRE_DATE, 'YYYY') = '2004';
--
--4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--  ��, �ָ��� ������
SELECT EMP_NAME ������, HIRE_DATE �Ի���, LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;
--
--5. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--     ������ ������ �����Ϸ� ��µǰ� ��.
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
SELECT EMP_NAME ������, DEPT_ID �μ��ڵ�, 
            SUBSTR(EMP_NO, 1, 2) || '�� ' || SUBSTR(EMP_NO, 3,2) || '�� ' || SUBSTR(EMP_NO, 5, 2) || '��' �������,      
            --TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD') "����(��)"
            --TO_CHAR(LAST_DAY(SUBSTR(EMP_NO, 1, 6)), 'DD')
            ROUND((SYSDATE - TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 365.2564), --EXTRACT �� �ٸ��Լ� �Ἥ�ϴ°� �´µ� 365���� ����
            MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12 ,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM'))
FROM EMPLOYEE;
--
--6. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, sum ���
--
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��
--	-------------------------------------------------------------
SELECT COUNT(*) ��ü������, 
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2001', 1, 0)) "2001��",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2002', 1, 0)) "2002��",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2003', 1, 0)) "2003��",
            SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2004', 1, 0)) "2004��"
FROM EMPLOYEE;


--
--7.  �μ��ڵ尡 50�̸� �ѹ���, 60�̸� ��ȹ��, 90�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 50, 60, 90 �� ������ ������ ��ȸ��
--  => case ���
--	�μ��ڵ� ���� �������� ������.
SELECT EMP_NAME, DEPT_ID,
            CASE DEPT_ID
                WHEN '50' THEN '�ѹ���'
                WHEN '60' THEN '��ȹ��'
                WHEN '90' THEN '������'
            END AS �μ��̸�
FROM EMPLOYEE
WHERE DEPT_ID IN (50, 60, 90)
ORDER BY DEPT_ID;

-- �Լ��������� END --

-- ORDER BY �� **************************************
-- ������� : ORDER BY ���ı��� ���Ĺ��, ���ı���2 ���Ĺ�� , ...
-- �����ġ : SELECT ���� ���� �������� �ۼ���
-- ��������� ���� �������� �۵���
-- ���ı��� : SELECT ���� ���� �÷��� | �÷���Ī | �÷����� ���� (1����)
-- ���Ĺ�� : ASC(��������, �⺻�� ��������.), DESC (��������)
-- ������������(ASCENDING) : ���������� ū����
--              1234 , ABCD, �����ٶ�
-- ������������(DESCENDING) : ū������ ������
--              9875, DCBA, ��ٳ��� ZYZ, ������

-- ù��° �������� ���� �Ŀ� ���� ���� ���ؼ��� �ι�° ���ı������� �������� �� ����
-- �ι�° �����Ŀ� ���� ���� ���ؼ� ����° ���ı������� ������ �� �� ����
-- ���� ��� Ƚ������ ������ ����

-- ������ �������� �μ��ڵ尡 50�̰ų� NULL�� ������ȸ

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL
ORDER BY SALARY DESC, 1;

-- 2003�� 1�� 1�� ���� �Ի��� ���� ��ȸ
-- ��, �ش� ��¥�� ������
-- �̸�, �Ի���, �μ��ڵ�, �޿� (��Ī)
-- �μ��ڵ� ���� ������������ , ���� �μ��ڵ��� ���� �Ի��� ���� ��������
-- �Ի��ϵ� ������ �̸� ���� ��������

SELECT EMP_NAME �̸�, HIRE_DATE �Ի���, DEPT_ID �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101', ('RRRRMMDD'))
--ORDER BY DEPT_ID DESC, HIRE_DATE, EMP_NAME;
--ORDER BY �μ��ڵ� DESC, �Ի���, �̸�
--ORDER BY 3 DESC, 2, 1
ORDER BY 3 DESC NULLS LAST, 2, 1;

-- ORDER BY ���� NULL ��ġ ���� ����
-- ORDER BY ���ı��� ���Ĺ�� NULLS LAST : NULL �� �Ʒ��ʿ� ��ġ
-- ORDER BY ���ı��� ���Ĺ�� NULLS FIRST : NULL �� ���ʿ� ��ġ DEFAULT


-- GROUP BY �� **********************
-- ���� ������ ���� �� ��ϵ� �ø��� �������� ���� ������ �׷����� ������
-- GROUP BY �÷��� | �÷��� ���� ����
-- ���� ������ �׷����� ���, �׷��Լ��� �����ϱ� ����
-- SELECT ������ GROUP BY �� ���� �׷캰�� �׷��Լ� ��뱸���� �ۼ���

-- ��ϰ� Ȯ��
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;

-- �μ��� �޿� �հ� ��ȸ
SELECT DISTINCT DEPT_ID,
            SUM(SALARY) �μ����޿��հ�,
            FLOOR(AVG(SALARY)) �μ����޿����,
            COUNT(SALARY) �μ���������,
            MAX(SALARY) �μ����ִٱ޿�,
            MIN(SALARY) �μ��������޿�
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 1 DESC NULLS LAST;

-- GROUP BY ������ �׷����� ���� ������ ����� ���� �ִ�

-- ���� �������� ������ �޿��հ�, �޿����(õ�������� �ݿø���), ������ ��ȸ
-- ������ ��������������

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') ����,
            SUM(SALARY) �޿��հ�,
            ROUND(AVG(SALARY), -4) �޿����,
            COUNT(*) ������
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��')
ORDER BY ����;

-- GROUP BY ���� ����� �÷���� ������ SELECT���� ǥ���� �� ����

-- GROUP BY ���� �Լ� -----
-- ROLLUP() �Լ�
-- �׷캰�� ��� ����� ����� ���� ���� �����踦 ǥ���ϴ� �Լ� (������ �κ���)
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;


SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY), FLOOR(AVG(SALARY)),
            MIN(SALARY), MAX(SALARY), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);

-- �ǽ� : �μ��ڵ�� �����ڵ带 �Բ� �׷��� ����, �޿��� �հ踦 ���ϱ�

SELECT DEPT_ID, JOB_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY DEPT_ID, JOB_ID
ORDER BY 1 DESC;

SELECT DEPT_ID, JOB_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID)
ORDER BY 1 DESC;

SELECT DEPT_ID, JOB_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID), ROLLUP(JOB_ID)
ORDER BY 1 DESC;

SELECT DEPT_ID, JOB_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(JOB_ID), ROLLUP(DEPT_ID)
ORDER BY 1 DESC;


-- CUBE() �Լ�

SELECT DEPT_ID, JOB_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID, JOB_ID)
ORDER BY 1 DESC;
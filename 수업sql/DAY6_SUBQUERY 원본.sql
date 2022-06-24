-- DAY6_SUBQUERY.sql
-- SELECT : ��������

-- ��������(��������)
-- SELECT �� �ȿ� ���Ǵ� SELECT ���� ����
/*
�ٱ��Լ�(��ȯ���� �ִ� �Լ�())
=> ���� �Լ��� ���� ������ �Ǹ鼭 ��ȯ���� �ٱ� �Լ��� �����

�÷��� �񱳿����� �񱳰� <-- �񱳰� �˾Ƴ��� ���� SELECT ����
                        �ٷ� ����� �� ����
�÷��� �񱳿����� (SELECT ������) <-- ��������(��������)��� ��
�ٱ� SELECT ���� �ܺ�(����) ������� ��
*/

-- ���¿��� ���� �μ��� �ٹ��ϴ� ���� ��� ��ȸ
-- 1. ���¿��� �μ��ڵ� ��ȸ
SELECT DEPT_ID
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';  -- '50'

-- 2. ��ȸ�� �μ��ڵ�� ���� ��� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- �������� ���� : 
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '���¿�');

-- �������� ����
-- ������ ��������, ������ ��������, ���߿� ��������, ������ ���߿� ��������,
-- ��[ȣ��]�� ��������, ��Į�� ��������
-- �������� ������ ���� �������� �տ� ���Ǵ� �����ڰ� �ٸ�

-- ������ (SINGLE ROW) ��������
-- ���������� ������� 1���� ���
-- ������ �������� �տ��� �Ϲ� �񱳿����� ����� �� ����
-- >, <, >=, <=, =, != (^=, <>)

-- �� : ���¿��� ������ �����鼭 ���¿����� �޿��� ���� �޴� ���� ��ȸ
-- 1. ���¿��� ���� ��ȸ
SELECT JOB_ID
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';  -- 'J5'

-- 2. ���¿��� �޿� ��ȸ
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�'; -- 2300000

-- 3. ���� ��ȸ
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = 'J5'
AND SALARY > 2300000;

-- �������� ���� : 
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID  -- 'J5' : ������(��1��) ��������
                FROM EMPLOYEE
                WHERE EMP_NAME = '���¿�')
AND SALARY > (SELECT SALARY  -- 2300000 : ������(��1��) ��������
                FROM EMPLOYEE
                WHERE EMP_NAME = '���¿�');

-- ���� �߿��� ���� �޿��� �޴� ���� ��� ��ȸ
-- WHERE ������ �׷��Լ� ��� �� �� => ���������� �ذ�
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY = MIN(SALARY);
WHERE SALARY = (SELECT MIN(SALARY)  -- 1500000 : �� 1 ��(������)
                  FROM EMPLOYEE);

-- HAVING �������� �������� ����� �� ����
-- �� : �μ��� �޿��հ� �� ���� ū���� ���� �μ���� �޿��հ� ��ȸ
-- 1. �μ��� �޿��հ��� ���� ū �� ��ȸ
SELECT MAX(SUM(SALARY))  -- 18100000
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 2. ��ȸ���� ����
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_NAME
--HAVING SUM(SALARY) = 18100000;
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))  -- 18100000 (������)
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);

-- ���������� SELECT ���� ��� ���� ����� �� ����
-- �ַ� SELECT, FROM, WHERE, HAVING �� �����

-- ���߿� (MULTI COLUMNS) [������] ��������
-- ���������� ���� ��� ���� 1���ε�, �÷�(��)�� ���� ���� ���
-- �Ϲ� �񱳿����ڸ� ���������� �տ� ����� �� ���� (������)

-- ���¿��� ���ް� �޿��� ���� ���� ��ȸ
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
-- ���߿� �������� ����� ���ϴ� �÷��� ��(�÷�) ������ �׸��� ����� ��
-- (���� �÷�, ���� �÷�) �񱳿����� (���߿� ��������)
WHERE (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '���¿�');

-- ������ (MULTI ROWS) [���Ͽ�] ��������
-- ���������� ���� �����(�����)�� ���� ���� ���
-- ������ �������� �տ��� �Ϲ� �񱳿�����(��1���� ��) ��� �� �� : ������ 
-- ���� ���� ���� ���� �� �ִ� �����ڸ� ����ؾ� �� : IN, ANY, ALL

-- �� : �� �μ����� �޿��� ���� ���� ���� ���� ��ȸ
SELECT MIN(SALARY)  -- 7��
FROM EMPLOYEE  
GROUP BY DEPT_ID; 

SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)  -- 7�� (������ ��������)
                FROM EMPLOYEE  
                GROUP BY DEPT_ID);  -- ERROR
-- ������ �������� �տ� �Ϲ� �񱳿�����(�� 1�� ����) ��� �� ��

SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)  -- 7�� (������ ��������)
                    FROM EMPLOYEE  
                    GROUP BY DEPT_ID); 

-- �÷��� IN (���� ���� ���� | ������ ��������)
-- �÷��� = �񱳰�1 OR �÷��� = �񱳰�2 OR �÷��� = �񱳰�3 ......
-- �÷����� ���� ���� �񱳰��� ��ġ�ϴ� ���� ������ ����

-- �÷��� NOT IN (���� ���� ���� | ������ ��������)
-- NOT �÷��� IN (���� ���� ���� | ������ ��������) �� ����
-- NOT (�÷��� = �񱳰�1 OR �÷��� = �񱳰�2 OR �÷��� = �񱳰�3 ......)
-- �÷����� ���� ���� �񱳰��� ��ġ���� �ʴ� ���� ������ ����

-- �� : �������� ������ �����ڰ� �ƴ� ���� ������ ������ ��ȸ�ؼ� ���Ķ�.
-- 1. �������� ���� ��ȸ
SELECT DISTINCT MGR_ID  -- 6��
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 2. ���� �������� �����ڸ� ��ȸ
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MGR_ID  -- 6��
                  FROM EMPLOYEE
                  WHERE MGR_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MGR_ID  -- 6��
                      FROM EMPLOYEE
                      WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;                  

-- SELECT �������� �������� ����� �� ����
-- �ַ� �Լ����� �ȿ��� ����

-- ���� ������ �����Ѵٸ�
SELECT EMP_ID, EMP_NAME,
        CASE WHEN EMP_ID IN (SELECT DISTINCT MGR_ID  -- 6��
                              FROM EMPLOYEE
                              WHERE MGR_ID IS NOT NULL)
             THEN '������'
             ELSE '����'
        END ����
FROM EMPLOYEE
ORDER BY 3, 1;

-- �÷��� > ANY (������ ��������) : ���� ���� ������ ū
-- �÷��� < ANY (������ ��������) : ���� ū ������ ����

-- �� : �븮 ������ ���� �߿��� ���� ������ �޿��� �ּҰ����� ���� �޴� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '����');

-- �÷��� > ALL (������ ��������) : ���� ū ������ ū
-- �÷��� < ALL (������ ��������) : ���� ���� ������ ����
-- �� : ��� ������� �޿����� �� ���� �޿��� �޴� �븮 ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '����');

-- �������� ��� ��ġ : 
-- SELECT ���� : SELECT ��, FROM ��, WHERE ��, HAVING ��, GROUP BY��
--              ORDER BY �� (��� ������ ����� �� ����)
-- DML ���� : INSERT ��, UPDATE ��
-- DDL ���� : CREATE TABLE ��, CREATE VIEW ��

-- ���߿� ������ ��������
-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ
-- 1. ���޺� ��� �޿� ��ȸ
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;
-- ���� ��ϵ� �޿����� ��հ��� �ڸ��� ���߱Ⱑ �ʿ���

-- 2. ����
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- FROM �������� �������� ����� �� ���� : ���̺��� �����
-- FROM (��������) ��Ī : ��Ī�� ���̺���� �����
-- ���������� ���� �������(RESULT SET)�� ���̺�� ����� : �ζ��� ���� ��

-- ���� : ����Ŭ ���뱸���� FROM ���� ������ ���̺���� ������ ��
--      ���̺� ��Ī ������ �� ����
-- ANSI ǥ�ر����� USING �� ���̺� ��Ī ����� �� ����
-- ANSI ǥ�ر������� ���̺��� ��Ī ����Ϸ���, ON �� ����ϸ� ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ
-- �ζ��� ��� �ۼ��Ѵٸ� : 
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
        FROM EMPLOYEE
        GROUP BY JOB_ID) V -- �ζ��� ��
JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND V.JOB_ID = E.JOB_ID)
JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- ��[ȣ��]�� �������� (CORRELATED SUBQUERY)
-- ��κ� ���������� ���������� ���� ������� ���������� ����ϴ� ������
-- ���������� ���� �������� Ȯ���� �� ����
-- ��ȣ���� ���������� ���������� ���������� ���� ������ ����� ����
-- �׷��� ���������� ���� �ٲ�� ���������� ����� �޶����� ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ : ��ȣ���� ���������� �ۼ��Ѵٸ�
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
-- WHERE SALARY = (�� ������ ������ ��ձ޿� ���)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                  FROM EMPLOYEE
                  WHERE NVL(JOB_ID, ' ') = NVL(E.JOB_ID, ' '));

SELECT EMP_NAME, JOB_ID
FROM EMPLOYEE
ORDER BY 2;

-- EXISTS / NOT EXISTS ������
-- ��ȣ���� �������� �տ��� �����
-- ���������� ���� ����� �����ϴ��� ��� ���� EXISTS �����
-- �� ������ ����� ���� �������� SELECT ���� �÷��� ����ϸ� �ȵ�
-- �������� WHERE ���� ������ ����� TRUE �� ���̳�? �� �ǹ���
-- SELECT ���� NULL �����

-- �� : �������� �������� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
-- ���������� ������ �����ϴ� ��鸸 ���

-- NOT EXISTS : ���������� ������ �����ϴ� ���� �������� �ʴ���
-- �� : �����ڰ� �ƴ� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
-- ���������� �������� ��ġ���� �ʴ� ��鸸 ���

-- ��Į�� ��������
-- ������ + ��ȣ������������
-- �� : �̸�, �μ��ڵ�, �޿�, �ش� ������ �Ҽӵ� �μ��� ��ձ޿� ��ȸ
SELECT EMP_NAME, DEPT_ID, SALARY,
        (SELECT TRUNC(AVG(SALARY), -5)
         FROM EMPLOYEE
         WHERE E.DEPT_ID = DEPT_ID) "�ҼӺμ��� �޿����"
FROM EMPLOYEE E;

-- ORDER BY ������ ��Į�� �������� ����� �� ����
-- ������ �Ҽӵ� �μ��� �μ����� ū ������ �����ؼ� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME
            FROM DEPARTMENT
            WHERE DEPT_ID = E.DEPT_ID) DESC NULLS LAST;

-- CASE ǥ������ ����� ��������
-- �μ��� �ٹ������� 'OT'�̸� '������', �ƴϸ� '������' ���� ������
-- ������ �ٹ������� ���� �Ҽ��� ��ȸ ó��
SELECT EMP_ID, EMP_NAME,
        CASE WHEN DEPT_ID = (SELECT DEPT_ID
                               FROM DEPARTMENT
                               WHERE LOC_ID = 'OT')
             THEN '������'
             ELSE '������'
        END �Ҽ�
FROM EMPLOYEE
ORDER BY �Ҽ� DESC;

-- TOP-N �м� --------------------------
-- ���� �� ��, ���� �� ���� ��ȸ�ϴ� ��
-- ��� 1, �ζ��� ��� RANK() �Լ��� �̿��� TOP-N �м� ���
-- ��� 2. ROWNUM �� �̿��� TOP-N �м� ���

-- 1. �ζ��� ��� RANK() �Լ��� �̿�
-- ���� �������� �޿��� ���� ���� �޴� ���� 5�� ��ȸ
-- �̸�, �޿�, ����

SELECT *
FROM (SELECT EMP_NAME, SALARY, 
               RANK() OVER (ORDER BY SALARY DESC) ����
       FROM EMPLOYEE)
WHERE ���� <= 5;       

-- 2. ROWNUM �̿�
-- ORDER BY �� ����� ROWNUM �� �ο��� => �ζ��� ��� �ذ�
-- ROWNUM : ���ȣ�� �ǹ���, WHERE ó�� �Ŀ� �ڵ����� ������

-- Ȯ��
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE  -- �� �࿡ ROWNUM ������
ORDER BY SALARY DESC;

-- �޿� ���� �޴� ���� 5�� ��ȸ
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5  -- WHERE �� ������ ROWNUM �ο���
ORDER BY SALARY DESC;  -- Ʋ�� �����

-- �ذ� : �����ϰ� ���� ROWNUM �ο��ǰԲ� �ۼ�
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
       FROM EMPLOYEE
       ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;







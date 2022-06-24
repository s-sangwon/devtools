-- DAY6_SELECT6.sql
-- SELECT :  ����(SET) �����ڿ� �������� (SUBQUERY)

-- ���� ������ (SET OPERATOR)
-- UNION, INTERSECT, MINUS, UNION ALL
-- �� ���� SELECT ���� ������� �ϳ��� ǥ���ϱ� ���� ����ϴ� ������
-- ù��° ��������� ����, �ι�° ��� ������ �Ʒ��� ��ġ�ϸ鼭 ����� (���η� ��ħ)
-- ������ : UNION, UNION ALL - �� ���� SELECT ����� �ϳ��� ��ħ
--              UNION - �� ���� ����� �ߺ��Ǵ� ���� 1���� ����
--              UNION ALL - �� ���� ����� �ߺ����� �������� �ʰ� ��� ����
-- ������ : INTERSECT - �� ���� ����� �ߺ��ุ ����
-- ������ : MINUS - ù��° ���� ������� �ߺ��Ǵ� �ι�° ���� ����� ��

/*��� ���� :
            SELECT ��
            ���տ�����
            SELECT ��
            ORDER BY ���� ���Ĺ��;

���� ���� : (RELATIONAL DB�� 2���� ���̺� �����̴�.)
            1. SELECT ���� �÷������� ���ƾ� ��
                �÷� ������ �ٸ��� DUMMY COLUMN(NULL �÷�) �� �߰��ؼ� ���� ����
            2. SELECT ���� �÷��� �ڷ����� ���ƾ� ��
        

*/

-- ������ ����� �������� ��ȸ
-- EMPLOYEE_ROLE �� ROLE_HISTORY ���� ���� ��ȸ�ؼ� �ϳ��� ��ħ
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
UNION   -- 25�� : �ߺ��� 1�� ���ܵ�
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
UNION ALL  -- 25�� : �ߺ��� 1�� ��� ���Ե�
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
INTERSECT    -- 1�� : �ߺ��� 1�� ���õ�
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
MINUS   -- 21�� : �ߺ��� 1�� ���ܵ�
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4��

-- SET ������ ���� ���ǻ���
-- 1. �� ������ �÷������� ���ƾ� ��
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL
FROM DEPARTMENT
WHERE DEPT_ID = '20';


-- Ȱ�� : ROLLUP() �Լ��� �߰����� ��ġ�� ���ϴ� ����ó�� �� ��
-- ��� �ذ������ ���տ����� Ȱ���� �� ����
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '20'  -- 3��
UNION
SELECT DEPT_NAME, '�޿��հ�', SUM(SALARY)
FROM DEPARTMENT
JOIN EMPLOYEE USING(DEPT_ID)
WHERE DEPT_ID = '20'
GROUP BY DEPT_NAME;


-- �ݺ��Ǵ� �������� �ʹ� ����� => ��ȣ���� ���������� �̿��ϰų�, ���ν��� ���
-- ���ν��� : SQL������ ���α׷����� �����ϴ� ��ü��

-- 50�� �μ��� �Ҽӵ� ���� �� �����ڿ� �Ϲ������� ���� ��ȸ�ؼ� �ϳ��� ���Ķ�.
-- 50�� �μ� ���� ����

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '������' AS ����
FROM EMPLOYEE
WHERE EMP_ID = '141' AND DEPT_ID = '50'
UNION
SELECT EMP_ID, EMP_NAME, '����' AS ����
FROM EMPLOYEE
WHERE EMP_ID != '141' AND DEPT_ID = '50'
ORDER BY 3, 1;

SELECT 'SQL�� �����ϰ� �ֽ��ϴ�.' ����, 3 ���� FROM DUAL
UNION
SELECT '�츮�� ���� ', 1 FROM DUAL
UNION
SELECT '���� ����ְ�', 2 FROM DUAL
ORDER BY 2;

-- SET �����ڿ� JOIN �� ����
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- �� �������� SELECT ���� ������ �÷����� ������ ��쿡�� �������� �ٲ� �� ����
-- USING( EMP_ID, ROLE_NAME) ����� �� ����
-- (104 SE) = (104 SE) : ����, ���ο� ����(EQUAL JOIN�̹Ƿ�)
-- (104 SE-ANLY) != (140 SE) : �ٸ���, ��������

-- ���� ������ �������� �ٲٸ�
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING( EMP_ID, ROLE_NAME);

-- SET �����ڿ� IN �������� ����
-- UNION �� IN�� ���� ����� ���� �� ����
-- ���տ����ڿ� ���� �������� SELECT ���� �÷����� ����, �����ϴ� ���̺��� ����
-- WHERE �������� �񱳰��� �ٸ� ��쿡 IN ���� �ٲ� �� ����

-- ������ �븮 �Ǵ� ����� ������ �̸�, ���޸� ��ȸ
-- ���޼� �������� ����, ���� ������ �̸��� ������������ ó����

SELECT EMP_NAME, JOB_TITLE
FROM JOB
JOIN EMPLOYEE USING (JOB_ID)
WHERE JOB_TITLE IN ('�븮', '���')
ORDER BY 2, 1;

-- UNION ��� �������� �ٲ۴ٸ�
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '���'
ORDER BY 2, 1




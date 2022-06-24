-- SELECT ����
/*
���̺� ��� ����� �����͸� �˻�(��ȸ : ã�Ƴ��� ����)�ϱ� ���� ����ϴ� SQL ����.
DQL(Data Query Language : ������ ��ȸ��) �̶�� ��

SELECT ���� �⺻ �ۼ��� : 
SELECT * | �÷���, �÷���, �Լ�ǥ����, ����
FROM ���̺��;

* : ���̺��� ���� ��� �÷� �����͸� ��ȸ�Ѵٴ� �ǹ���
*/

-- ����(EMPLOYEE) ���̺� ����� ��ü �����͸� ��ȸ�Ѵٸ�
SELECT * 
FROM EMPLOYEE;

-- �μ�(DEPARTMENT) ���̺� ��ü ��ȸ
SELECT *
FROM DEPARTMENT;

-- ����(JOB) ���̺� ��ü ��ȸ
SELECT *
FROM JOB;

-- ��ȸ ��� ���� 1 : 
-- ���� ���̺��� ���, �̸�, �ֹι�ȣ ��ȸ�Ѵٸ�
SELECT EMP_ID, EMP_NAME, EMP_NO
FROM EMPLOYEE;

-- ���� ���̺��� ���, �̸�, �޿�, ���ʽ�����Ʈ ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT
FROM EMPLOYEE;

-- SELECT ���� ���� ��� ����
-- ���� ���̺��� ���, �̸�, �޿�, ����(�޿� * 12) ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- SELECT ���� �Լ�ǥ���� ��� ����
-- ���� ���̺��� ���, �̸�, �ֹι�ȣ �� 6�ڸ� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO, 1, 6)
FROM EMPLOYEE;

-- ��ȸ ��� ���� 2 : 
-- Ư�� ����� ��ȸ�ϴ� ���
-- ������ �����ؼ�, ���ǿ� �ش��ϴ� ����� ���
-- ������(WHERE ��)�� �����
-- ��: ���� �������� ��ȥ(��ȥ��)�� �����鸸 ��󳻴� ���
SELECT *
FROM EMPLOYEE
WHERE MARRIAGE = 'Y';  
--WHERE MARRIAGE = 'y';  -- ��ϵ� ���� ��ҹ��� ������

SELECT *
FROM EMPLOYEE
WHERE MARRIAGE = 'N'; -- ��ȥ�� ���� ���� ��ȸ


-- ��ȸ ��� ���� 3 :
-- ������ �����ϴ� ����� ��� ����, ���ϴ� �÷����� ���� ��ȸ
-- ���� �������� �����ڵ尡 'J4'�� �������� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

-- ��ȸ ��� ���� 4 : 
-- SELECT ������ �⺻ �� ���� ���̺� ���� ������ ��ȸ��.
-- �ʿ��� ��� ���� ���� ���̺��� ���ļ�(����) ���ϴ� �÷��� ��ȸ�� �� ����
-- ���� ���̺�� �μ� ���̺��� ���, �̸�. �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

-- ���� �������� ���, �̸�, �޿�, ���ʽ�����Ʈ�� ����� ���� ��� ��ȸ
SELECT EMP_ID AS ���, EMP_NAME AS �����̸�, SALARY AS �޿�,
        (SALARY + (SALARY * BONUS_PCT)) * 12 AS ���ʽ����뿬��
FROM EMPLOYEE;

SELECT EMP_ID ���, EMP_NAME �����̸�, SALARY �޿�,
        (SALARY + (SALARY * BONUS_PCT)) * 12 ���ʽ����뿬��
FROM EMPLOYEE;

-- SELECT ���� �÷��� �տ� DISTINCT Ű���� ����� �� ����
-- �ߺ� ���Ÿ� �ǹ��� : �÷��� ���(���)�� ������ ���� ������ �Ѱ��� ������ �ǹ�
SELECT DEPT_ID
FROM EMPLOYEE;

-- ���� �������� ���� �μ��ڵ� ��ȸ
SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;

-- ���� �������� ���� �����ڵ� ��ȸ
SELECT DISTINCT JOB_ID
FROM EMPLOYEE
ORDER BY JOB_ID ASC;



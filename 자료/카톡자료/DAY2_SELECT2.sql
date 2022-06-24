-- DAY2_SELECT2.sql
-- DAY2 : SELECT �⺻ 2

-- �⺻ �ѱ� 1���ڴ� 2����Ʈ��.
-- ����Ŭ 18c xe �ѱ� ����Ʈ ũ�� Ȯ��
-- �ѱ� 1���� 3����Ʈ��
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;  -- DUMMY TABLE ���

-- ������ Ÿ���� ������ �� �⺻ ������ BYTE ��
-- ���ڼ�(CHAR)�ε� ������ �� ����
CREATE TABLE TEST (
    NAME VARCHAR2(20),  -- �ִ� 20����Ʈ ���
    CONTENT VARCHAR2(10CHAR) -- �ִ� 10���� ���
);

-- �⺻ ��¥ ǥ�� ����(FORMAT)
SELECT SYSDATE
FROM DUAL;

-- ��¥�� ������ ������
SELECT SYSDATE + 15
FROM DUAL;  -- ���ú��� 15�� �� ��¥�� �ǹ���

SELECT SYSDATE - 100
FROM DUAL;  -- ���ú��� 100�� �� ��¥�� �ǹ���

SELECT TRUNC(SYSDATE - HIRE_DATE) AS �ٹ��ϼ�
FROM EMPLOYEE;

SELECT SYSDATE + 48/24
FROM DUAL;  -- ����/24 �� �ð��� �ǹ���

-- ******************************************
-- CHAP3. 13P ~

/*
SELECT ���� �ۼ� ���� : 
�������
5 :  SELECT * | �÷��� [AS] ��Ī, �÷���, ����, ���� [AS] ��Ī
1 :  FROM ��ȸ�� ����� ���̺��
2 :  WHERE �÷��� �񱳿����� �񱳰� (������� ���)
3 :  GROUP BY �÷��� | ����
4 :  HAVING �׷��Լ� �񱳿����� �񱳰� (������ �����ϴ� �׷��� ���)
6 :  ORDER BY �÷��� ���ı���, SELECT���� �׸���� ���ı���, ��Ī ���ı���
*/

-- SELECT �ۼ� �� 1 :
-- ���� ���̺��� ����� �̸� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�
FROM EMPLOYEE;

-- ���� ���̺��� ��� �÷� ���� ��ȸ (��ü ��ȸ)
SELECT EMP_ID ���, EMP_NAME �̸�, EMP_NO �ֹι�ȣ,
        EMAIL �̸���, PHONE ��ȭ��ȣ, HIRE_DATE �Ի���,
        JOB_ID �����ڵ�, SALARY �޿�, BONUS_PCT ���ʽ�����Ʈ,
        MARRIAGE  ��ȥ����, MGR_ID �����ڻ��, DEPT_ID �μ��ڵ�
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

-- SELECT ���� �÷��� ��ϵ� ���� ���� ���ĵ� ����� �� ����
-- ���, �̸�, �޿�, ����(�޿�*12), ���ʽ�����Ʈ, ���ʽ�����Ʈ�� ����� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS ����,
        BONUS_PCT ���ʽ�����Ʈ, 
        (SALARY + (SALARY * BONUS_PCT)) * 12
FROM EMPLOYEE;

-- �����ͺ��̽������� ��갪�� NULL�� ������, ����� NULL��
-- ���Ŀ� �����ͺ��̽��� �����ϴ� �Լ��� ����� �� ����
-- �Լ� �߿� �÷����� NULL�̸� �ٸ� ������ �ٲٴ� �Լ��� �̿��ϸ� ��
-- NVL(�� ���� �÷���, ���� NULL�϶� �ٲܰ�)
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "1��޿�",
        BONUS_PCT ���ʽ�����Ʈ, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "�Ѽҵ�(��)"
FROM EMPLOYEE;

-- SELECT ���� �÷��� | ���� �ڿ� ��Ī(ALIAS)�� ����� �� ����
-- �÷��� AS ��Ī, ���� AS ��Ī
-- AS �� ������ �� ���� ==> �÷��� ��Ī, ���� ��Ī
-- ���ǻ��� : ��Ī�� ����, ����, ��ȣ�� ���� ���� �ݵ�� "��Ī" (""�� ����� ��)
--          ���ڼ� ���� ����, ���Ī�� �⺻ �빮�ڷ� ǥ�õ�
--          �ҹ��ڷ� ǥ�õǰ� �Ϸ��� "" �����ָ� ��

SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "1��޿�",
        BONUS_PCT "bonuspoint", 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 ���ʽ�����Ʈ���뿬����
FROM EMPLOYEE;

-- SELECT ���� ���ͷ�(LITERAL : ��) ����� �� ����
-- RESULTSET �� ������ �÷��� �߰��Ǹ鼭, ���ͷ�(��)�� ä���� 
-- ������ �����͸� �ǹ���. �ڿ� ��Ī �߰� ����
--SELECT EMP_ID ���, EMP_NAME �̸�, '����'
SELECT EMP_ID ���, EMP_NAME �̸�, '����' �ٹ�����
FROM EMPLOYEE;

-- SELECT ���� �÷��� �տ� DISTINCT �� ����� �� ����
-- DISTINCT �÷���
-- SELECT ���� �ѹ��� ����� �� ����.
-- �ߺ� ��ϵ� ���� �� ���� �����϶�� �ǹ̷� �۵���
SELECT DISTINCT MARRIAGE  -- �÷��� ��ϵ� ���� ���� �ľ��� �� �ַ� �̿�
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID, DISTINCT JOB_ID  -- ERROR
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID, JOB_ID -- �� �÷����� ��� �ϳ��� ������ ���� �ߺ� �Ǵ���
FROM EMPLOYEE;  -- 'J1 90' �� 'J2 90' �� �ٸ� ����

-- ���� �߿��� �������� �������� ����� ��ȸ
SELECT DISTINCT MGR_ID
FROM EMPLOYEE;  -- 22�� �� 6���� ���������� Ȯ����.

SELECT DISTINCT MGR_ID
FROM EMPLOYEE
ORDER BY 1;   -- �⺻�� ��������������. ASC�� �����ص� ��

SELECT DISTINCT MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL  -- �����ڻ���� NULL �� �ƴ� ������ ���
ORDER BY 1; 

-- WHERE �� ************************************
/*
�۵� ���� : FROM ���� �۵��ǰ� ���� WHERE ���� �۵���
WHERE �÷��� �񱳿����� �񱳰�
�������̶�� �� : ���̺��� ������ �����ϴ�(������ ����� ����) ����� ���
��(����) ������ : > (ũ��, �ʰ�), < (������, �̸�), >= (ũ�ų� ������, �̻�),
            <= (�۰ų� ������, ����), = (������), != (���� �ʴ���, ^=, <>),
            IN, NOT IN, LIKE, NOT LIKE, BETWEEN AND, NOT BETWEEN AND
�� ������ : AND, OR, NOT
*/

-- ���� ���̺��� �μ��ڵ尡 '90'�� �������� ��ȸ
-- (90�� �μ��� �ٹ��ϴ� ���� ��ȸ)
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90';  -- ���ǰ� ��ġ�ϴ� ���� ��ϵ� ��(ROW)���� ���

-- �����ڵ尡 'J7'�� �������� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE JOB_ID = 'J7'; -- ��ϰ��� ��ҹ��� ������. ������� �״�� ���ؾ� ��
WHERE JOB_ID = 'j7';

-- ���� �� �޿��� 4�鸸���� ���� �޴� ���� ��� ��ȸ
-- ���, �̸�, �޿� (��Ī ó��)
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 90�� �μ��� �ٹ��ϴ� ���� �� �޿��� 2�鸸�� �ʰ��ϴ� ���� ���� ��ȸ
-- ���, �̸�, �޿�, �μ��ڵ� (��Ī ó��)
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND SALARY > 2000000;

-- 90 �Ǵ� 20�� �μ��� �ٹ��ϴ� ���� ��ȸ
-- ���, �̸�, �ֹι�ȣ, ��ȭ��ȣ, �μ��ڵ� (��Ī ó��)
SELECT EMP_ID ���, EMP_NAME �̸�, EMP_NO �ֹι�ȣ, 
        PHONE ��ȭ��ȣ, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_ID = '90' OR DEPT_ID = '20';

-- ���� 1 : 
-- �޿��� 2�鸸�̻� 4�鸸������ ���� ��ȸ
-- ���, �̸�, �޿�, �����ڵ�, �μ��ڵ� (��Ī ó��)
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, 
        JOB_ID �����ڵ�, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 4000000;

-- ���� 2 : 
-- �Ի����� 1995�� 1�� 1�Ϻ��� 2000�� 12�� 31�� ���̿� �Ի��� ���� ��ȸ
-- ���, �̸�, �Ի���, �μ��ڵ� (��Ī ó��)
-- ��¥�����ʹ� ��ϵ� ��¥ ����(����)�� ��ġ�ǰ� �ۼ���
-- ��¥�����ʹ� ���� ����ǥ�� ��� ǥ���� : '1995/01/01' �Ǵ� '95/04/01'
SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';

-- ���� ������ : ||
-- ���̼������� 'HELLO' + 'WORLD' => 'HELLOWORLD' 
-- SELECT ������ ��ȸ�� �÷������� ���� ó���� �ϳ��� ������ ���� �� ���
-- WHERE ������ �񱳰� ���� ���� �� ���� ������ ���� �� ����ϱ⵵ ��
SELECT EMP_NAME || ' ������ �޿��� ' || SALARY || ' ���Դϴ�.' AS �޿�����
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- ���� 3 : 
-- 2000�� 1�� 1�� ���Ŀ� �Ի��� ��ȥ�� ���� ��ȸ
-- �̸�, �Ի���, �����ڵ�, �μ��ڵ�, �޿�, ��ȥ���� (��Ī ó��)
-- �Ի糯¥ �ڿ� ' �Ի�' ���� ���� �����
-- �޿��� �ڿ��� '(��)' ���� ���� �����
-- ��ȥ���δ� ���ͷ� ����� : '��ȥ' ���� ä��
SELECT EMP_NAME �̸�, HIRE_DATE || ' �Ի�' �Ի���, 
        JOB_ID �����ڵ�, DEPT_ID �μ��ڵ�, 
        SALARY || '(��)' �޿�, '��ȥ' ��ȥ����
FROM EMPLOYEE
WHERE HIRE_DATE >= '00/01/01' AND MARRIAGE = 'Y';

-- �񱳿����� *******************************
-- BETWEEN AND ������
-- WHERE �÷��� BETWEEN ������ AND ū��
-- �÷��� ���� �������̻��̸鼭 ū�������� �� �ǹ̸� ����
-- WHERE �÷��� >= ������ AND �÷��� <= ū��  �� ����

-- �����߿��� 2�鸸�̻� 4�鸸���� ������ �޿��� �޴� ���� ��ȸ
-- ���, �̸�, �޿�, �����ڵ�, �μ��ڵ� (��Ī ó��)
SELECT EMP_ID ���, EMP_NAME �̸�, SALARY �޿�, 
        JOB_ID �����ڵ�, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
--WHERE SALARY >= 2000000 AND SALARY <= 4000000;
WHERE SALARY BETWEEN 2000000 AND 4000000;

-- ��¥ �����Ϳ��� ����� �� ����
SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
--WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';
WHERE HIRE_DATE BETWEEN '95/01/01' AND '00/12/31';






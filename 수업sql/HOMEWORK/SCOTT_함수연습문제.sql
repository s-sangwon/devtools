-- SCOTT �Լ� �������� 


-- COMM �� ���� NULL�� �ƴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

-- Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NULL;

-- �����ڰ� ���� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE MGR IS NULL;



-- �޿��� ���� �޴� ���� ������ ��ȸ
SELECT *
FROM EMP
ORDER BY SAL DESC;


-- �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
SELECT *
FROM EMP
ORDER BY SAL DESC, COMM DESC;


-- EMP ���̺��� �����ȣ, �����,����, �Ի��� ��ȸ
-- �� �Ի����� �������� ���� ó����.
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE;

      

-- EMP ���̺�� ���� �����ȣ, ����� ��ȸ
-- �����ȣ ���� �������� ����
SELECT EMPNO, ENAME
FROM EMP
ORDER BY 1 DESC;

-- ���, �Ի���, �����, �޿� ��ȸ
-- �μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��ϼ����� ó��
SELECT EMPNO, HIREDATE, ENAME, SAL
FROM EMP
ORDER BY DEPTNO , HIREDATE;


/***** �Լ� *****/

-- �ý������� ���� ���� ��¥�� ���� ������ ����� �� ��
SELECT SYSDATE
FROM DUAL;
   

-- EMP ���̺�� ���� ���, �����, �޿� ��ȸ
-- ��, �޿��� 100���� ������ ���� ��� ó����.
-- �޿� ���� �������� ������.
SELECT EMPNO, ENAME, TRUNC(SAL,-2)
FROM EMP
ORDER BY SAL DESC;


-- EMP ���̺�� ���� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) = 1;


/* ���� ó�� �Լ�*/  

-- EMP ���̺�� ���� �����, �Ի��� ��ȸ
-- ��, �Ի����� �⵵�� ���� �и� �����ؼ� ���
--SELECT ENAME, EXTRACT(YEAR FROM HIREDATE) �⵵, EXTRACT(MONTH FROM HIREDATE) ��
--FROM EMP;

SELECT ENAME, SUBSTR(HIREDATE, 1,2) �⵵, SUBSTR(HIREDATE, 4,2) ��
FROM EMP;


-- EMP ���̺�� ���� 9���� �Ի��� ������ ���� ��ȸ
--SELECT *
--FROM EMP
--WHERE EXTRACT(MONTH FROM HIREDATE) = 9;

SELECT *
FROM EMP
WHERE SUBSTR(HIREDATE, 4, 2) = '09';

-- EMP ���̺�� ���� '81'�⵵�� �Ի��� ���� ��ȸ
--SELECT *
--FROM EMP
--WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;

SELECT *
FROM EMP
WHERE SUBSTR(HIREDATE, 1, 2) = '81';

-- EMP ���̺�� ���� �̸��� 'E'�� ������ ���� ��ȸ
--SELECT *
--FROM EMP
--WHERE ENAME LIKE '%E';

SELECT *
FROM EMP
WHERE SUBSTR(ENAME, -1, 1) = 'E';


-- emp ���̺�� ���� �̸��� ����° ���ڰ� 'R'�� ������ ���� ��ȸ
-- LIKE �����ڸ� ���
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

-- SUBSTR() �Լ� ���
SELECT *
FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'R';




/************ ��¥ ó�� �Լ� **************/

-- �Ի��Ϸ� ���� 40�� �Ǵ� ��¥ ��ȸ
SELECT HIREDATE �Ի���, ADD_MONTHS(HIREDATE, 40*12) "�Ի��� 40�� �� ��¥"
FROM EMP;


-- �Ի��Ϸ� ���� 33�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE SYSDATE > ADD_MONTHS(HIREDATE, 33*12);

-- ���� ��¥���� �⵵�� ����
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;





   




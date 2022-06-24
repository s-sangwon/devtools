-- DAY5_SELECT5.sql
-- SELECT �߰� �ɼ� : HAVING �� ~

-- HAVING �� ---------------------------------------------------------
-- �����ġ : GROUP BY �� ������ �ۼ���
-- ������� : HAVING �׷��Լ�(��꿡 ����� �÷���) �񱳿����� �񱳰�
-- �׷캰�� �׷��Լ� ������� ������ ������ �����ϴ� ������ �񤩶�

SELECT MAX( SUM(SALARY) ) -- �μ��� �޿��հ��� ���� ū ��, 1���� ���
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, MAX( SUM(SALARY) ) -- �μ��� �޿��հ��� ���� ū ��, 1���� ���
FROM EMPLOYEE
GROUP BY DEPT_ID; -- ����

SELECT DEPT_ID-- 7��
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- �μ��� �޿��հ� �� ���� ū ���� ���� �μ��ڵ�� �޿��հ踦 ��ȸ
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
gROUP BY DEPT_ID
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                                        FROM EMPLOYEE
                                        GROUP BY DEPT_ID);
                                        
-- �м��Լ� (������ �Լ���� ��) ---
-- �Ϲ��Լ��� ��������� �ٸ�

-- RANK() �Լ�
-- ����(���) ��ȯ

-- 1. �÷����� ������ �ű� �� ���
-- RANK() OVER (ORDER BY ���� �ű� �÷��� ���Ĺ��)

-- �޿��� ���� �޴� ������ ������ �ű�ٸ�
SELECT EMP_NAME, SALARY,
            RANK() OVER (ORDER BY SALARY DESC)����
FROM EMPLOYEE;
--ORDER BY ����;

-- 2. ���� ���Ǽ����� �˰��� �� ��
-- RANK(������ �˰����ϴ� ��) WITHIN GROUP (ORDER BY �����ű��÷� ���Ĺ��)

-- �޿� 230���� ��ü �޿��� �� ����? (�޿� �������������� ���)
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC)
FROM EMPLOYEE;

-- ROWID
-- ���̺� ������ ��Ͻ�(�� �߰���, INSERT��) �ڵ����� �ٿ���
-- DBMS �� �ڵ����� ����. ���� �� ��, ��ȸ�� �� �� ����

-- ������ ���Ͽ� ����� �� ���� �������� ��ġ�� ��Ÿ���� ������ ���� �÷�
SELECT EMP_ID, ROWID
FROM EMPLOYEE;


-- ROWNUM
-- ROWID �� �ٸ�
-- ROWNUM�� SELECT �� ����(�۵�)�� ����࿡ �ο��Ǵ� ���ȣ��.(1���� ����)

SELECT *
FROM (SELECT ROWNUM, EMP_ID, EMP_NAME, JOB_ID
            FROM EMPLOYEE
            WHERE JOB_ID = 'J5');
--TOP���м�? �� ����


-- ***************************************************************
-- ���� (JOIN)
-- ���� ���� ���̺��� �ϳ��� ���ļ� ū ���̺��� ���� �÷��� ��ȸ��
-- ����Ŭ ���뱸���� ANSI ǥ�ر������� �ۼ��� �� ����
-- ������ �⺻�� EQUAL JOIN ��
-- �� ���̺긣�� FOREIGN KEY(�ܷ�Ű | �ܺ�Ű)�� ����� �÷������� ��ġ�ϴ�
-- ����� �����

-- ����Ŭ ���뱸�� : ����Ŭ������ �����
-- FROM ���� ��ĥ ���̺���� ������
-- FROM ���̺�� ��Ī, ��ĥ���̺�� ��Ī, ...
-- ��ĥ ������ WHERE ���� �ۼ���



SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;
20 ��, DEPT_ID�� NULL �� ���� 2���� ���ܵ�
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID);

-- ���� �̸�, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ANSI ǥ�ر��� 
-- ��� DBMS�� �������� ����ϴ� ǥ�ر�����
-- ���� ó���� ���� ������ FROM ���� �߰� �ۼ���

SELECT *
FROM EMPLOYEE
--INNER JOIN DEPARTMENT USING(DEPT_ID); -- INNER �� ������ �� ����
JOIN DEPARTMENT USING(DEPT_ID); -- ������ �⺻�� INNEER EQUAL JOIN��

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);
-- ��ģ ������̺� DEPT_ID �� �ϳ� ������ (�� �տ� ǥ�õ�)

-- ������ �⺻ EQUAL INNER JOIN ��.
-- �� ���̺��� �����ϴ� �÷��� ���� EQUAL�� ����� �����Ŵ
-- INNER JOIN �� EQUAL �� �ƴ� ���� ���ܵ�
-- INNER JOIN �� �����̺��� �����ϴ� �÷����� ���� ���� USING �����

SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEE
-- INNER JOIN DEPARTMENT USING (DEPT_ID)
JOIN DEPARTMENT USING(DEPT_ID)
WHERE JOB_ID = 'J6'
ORDER BY DEPT_NAME;

-- �� ���̺��� ������ �÷����� �ٸ� ���� ON �����
-- ��, �÷��� �ٸ� (��ϵ� ���� ����)
SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- ����Ŭ ���뱸��
SELECT *
FROM DEPARTMENT D, LOCATION L
WHERE D.LOC_ID = L.LOCATION_ID;

-- ���, �̸�, ���޸� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID; -- 21��

SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID);

-- OUTER JOING
-- EQUAL �� �ƴ� �൵ ���ο� ���Խ�Ű���� �� �� ����ϴ� ���α���
-- EQUAL JOIN �� : ���� ���� �߰��ؼ� ��ġ�ǰ� ���� ������

-- EMPLOYEE ���̺��� �� ������ ������ ���� ����� ���Խ�Ű���� �Ѵٸ�
-- ����Ŭ ���뱸�� : ���� ���� ���̺� ���� �߰��ϴ� �����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);  -- LEFT JOIN

SELECT *
FROM EMPLOYEE 
-- LEFT OUTHE JOIN DEPARTMENT USING(DEPT_ID);
LEFT JOIN DEPARTMENT USING(DEPT_ID);

-- DEPARTMENT ���̺��� ���� ��� ���� ���ο� ���Խ�Ű����...
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;  -- RIGHT OUTER JOIN

SELECT *
FROM EMPLOYEE 
-- LEFT OUTHE JOIN DEPARTMENT USING(DEPT_ID);
RIGHT JOIN DEPARTMENT USING(DEPT_ID);

-- �� ���̺��� ��ġ���� �ʴ� ��� ���� ���ο� �����Ϸ���...
-- FULL OUTER JOIN �̶�� ��

-- ����Ŭ ���뱸���� FULL OUTER JOIN �� �ۼ��� �� ����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);

SELECT *
FROM EMPLOYEE
FULL JOIN DEPARTMENT USING (DEPT_ID);

-- CROSS JOIN
-- �� ���̺��� ������ �÷��� ���� �� �����
-- N �� * M ���� ����� ����

--ANSI
SELECT *
FROM LOCATION
CROSS JOIN COUNTRY;

-- ����Ŭ ���뱸��
SELECT *
FROM LOCATION, COUNTRY;

-- NATURAL JOIN
-- ���̺��� ���� PRIMARY KEY �÷��� �̿��ؼ� ������ ��

SELECT *
FROM EMPLOYEE
-- JOIN DEPARTMETN USING(DEPT_ID);
NATURAL JOIN DEPARTMENT; -- PRIMARY KEY : DEPT_ID ���ο� ����

-- NON EQUI JOIN
-- �����ϴ� �÷��� ���� ��ġ�ϴ� ��찡 �ƴ�
-- ���� ������ �ش��ϴ� ����� �����ϴ� ����� ������

SELECT EMP_NAME, SALARY, SLEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN
-- ���� ���̺��� �� �� �����ϴ� �����
-- ���� ���̺� �ȿ� �ٸ� �÷��� �ܷ�Ű(FOREIGN KEY)�� ����ϴ� ��쿡 �̿�
-- EMP_ID : ������ ���, MGR_ID : �������� ������ ���(EMP_ID�� ������)
-- MGR_ID : ���� �߿� �������� ������ �ǹ���

-- �����ڰ� ������ ������ ��ܰ� �������� ���� ��� ��ȸ
-- ANSI ǥ�ر��� : ���̺� ��Ī ����ؾ� ��. ON �����

SELECT EMP_NAME
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);;

-- ����Ŭ ���뱸��
SELECT *
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MGR_ID = M.EMP_ID;

SELECT E.EMP_NAME �������, M.EMP_NAME �����ڸ��
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);


-- N���� ���̺� ����
-- ���� ������ �߿���
-- ù��°�� �ι�°�� ������ �ǰ� ����, �� ����� ����°�� ���ε�

SELECT EMP_NAME, JOB_TITLE, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID);

SELECT *
FROM EMPLOYEE
JOIN LOCATION ON (LOC_ID = LOCATION_ID);    
JOIN DEPARTMENT USING(DEPT_ID) -- ���� ������ ������ �߿���


SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID);    -- ERD���� �ϸ� ����

-- ���� �̸�, ���޸�, �μ���, ������, ������ ��ȸ
-- ���� ��ü ��ȸ
-- ANSI ǥ��
SELECT EMP_NAME ������, JOB_TITLE ���޸�, DEPT_NAME �μ���,
            LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING(COUNTRY_ID);

SELECT EMP_NAME ������, JOB_TITLE ���޸�, DEPT_NAME �μ���,
            LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.JOB_ID = J.JOB_ID(+) AND 
E.DEPT_ID = D.DEPT_ID(+) AND 
D.LOC_ID = L.LOCATION_ID(+) AND 
L.COUNTRY_ID = C.COUNTRY_ID(+);




----------------------------------------------------------------------------
--PRACTICE

--JOIN ��������
--
--1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'DY')
FROM DUAL;
--
--2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, ���� �达�� �������� 
--�����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE E
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE SUBSTR(EMP_NO,1,2) LIKE '6%'
AND SUBSTR(EMP_NO,8,1) IN(2,4)
AND EMP_NAME LIKE '��%';

-- ORACLE
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND SUBSTR(EMP_NO,1,2) LIKE '6%'
AND SUBSTR(EMP_NO,8,1) IN(2,4)
AND EMP_NAME LIKE '��%';
--SELECT *
--FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,1,2) LIKE '6%'
--AND SUBSTR(EMP_NO,8,1) IN(2,4)
--AND EMP_NAME LIKE '��%';



--
--3. ���� ���̰� ���� ������ ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_ID ���, EMP_NAME �����, 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) ����,
            DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE SUBSTR(EMP_NO, 1, 2) = (SELECT MAX(SUBSTR(EMP_NO, 1, 2))
                                                FROM EMPLOYEE);
--WHERE 
SELECT MAX(SUBSTR(EMP_NO, 1, 2))
FROM EMPLOYEE;

--�ȵǳ� ��?
-- ORACLE
SELECT EMP_ID ���, EMP_NAME �����, 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) ����,
            DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND SUBSTR(EMP_NO, 1, 2) = (SELECT MAX(SUBSTR(EMP_NO, 1, 2))
                                                FROM EMPLOYEE);

--MIN() �׷��Լ��� SELECT�������
--����ϴ� ��ҵ��� GROUP BY�� �ٹ�� HAVING ������ ��
--
--4. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID ���, EMP_NAME �����, DEPT_NAME �μ���
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE EMP_NAME LIKE '%��%';

--ORACLE
SELECT EMP_ID ���, EMP_NAME �����, DEPT_NAME �μ���
FROM EMPLOYEE E , DEPARTMENT D
--LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE E.DEPT_ID = D.DEPT_ID
AND EMP_NAME LIKE '%��%';

--
--
--5. �ؿܿ������� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME �����, JOB_TITLE ���޸�, DEPT_ID �μ��ڵ�, DEPT_NAME �μ���
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE DEPT_NAME LIKE '�ؿܿ���%��'
ORDER BY 3;
--
--
--6. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ�������
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL;
--
--
--7. �μ��ڵ尡 20�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME �����, JOB_TITLE ���޸�, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ�������
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID)
JOIN JOB USING(JOB_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE DEPT_ID = '20';
--
--
--8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
--�����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
--������ ���ʽ�����Ʈ�� �����Ͻÿ�.
SELECT DISTINCT E.EMP_NAME �����, J.JOB_TITLE ���޸�, SALARY �޿� , (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 ����
FROM EMPLOYEE E, (SELECT JOB_ID, MIN(SALARY) "MIN_SAL"
                            FROM EMPLOYEE
                            JOIN JOB USING(JOB_ID)
                            GROUP BY JOB_ID) JLIST, JOB J
WHERE E.JOB_ID = J.JOB_ID
AND E.JOB_ID = JLIST.JOB_ID AND E.SALARY > JLIST.MIN_SAL
ORDER BY 2;
--WHERE ���޸� = ���޸��̰� �޿� > �ּұ޿� �͵鸸 ��ȸ

--SELECT DISTINCT EMP_NAME, JOB_TITLE ���޸�, SALARY �޿� , (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 ����
--FROM EMPLOYEE, ( SELECT E.JOB_ID, MIN(SALARY) AS "MIN_SAL"
--                            FROM EMPLOYEE E, JOB J
--                            WHERE E.JOB_ID = J.JOB_ID
--                            GROUP BY E.JOB_ID ) "ABC"
--LEFT JOIN JOB USING(JOB_ID)
--WHERE SALARY > ABC.MIN_SAL;

SELECT JOB_ID, MIN(SALARY) "MIN_SAL"
--,MIN((SALARY + SALARY * NVL(BONUS_PCT, 0)) *12) �ּҿ���
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
GROUP BY JOB_ID;


SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿� , (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 ����
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 > MIN_SAL;

--HAVING SALARY > MIN(SALARY);
--
--
--9. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
--�����(emp_name), �μ���(dept_name), ������(loc_describe), ������(country_name)�� ��ȸ�Ͻÿ�.
SELECT emp_name �����, DEPT_NAME �μ���, LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON(LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING(COUNTRY_ID)
WHERE COUNTRY_NAME IN ('�ѱ�', '�Ϻ�');
--
--10. ���� �μ��� �ٹ��ϴ� �������� �����, �μ��ڵ�, �����̸��� ��ȸ�Ͻÿ�.
--self join ���
SELECT DISTINCT e1.emp_name �����, E1.DEPT_ID �μ��ڵ� , E2.EMP_NAME �����̸�
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.DEPT_ID = E2.DEPT_ID
AND E1.EMP_ID <> E2.EMP_ID 
--AND E1.DEPT_ID = E2.DEPT_ID 
ORDER BY 2;

SELECT e1.emp_name �����, E1.DEPT_ID �μ��ڵ� , E2.EMP_NAME �����̸�
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.EMP_NAME <> E2.EMP_NAME
AND E1.DEPT_ID = E2.DEPT_ID;

--ORACLE
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, C.EMP_NAME �����̸�
FROM EMPLOYEE E
JOIN EMPLOYEE C ON (E.DEPT_ID = C.DEPT_ID)
WHERE E.EMP_NAME <> C.EMP_NAME
ORDER BY 1;
--
--
--11. ���ʽ�����Ʈ�� ���� ������ �߿��� �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
--��, join�� IN ����� ��
SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿�
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
WHERE BONUS_PCT IS NULL
AND JOB_ID IN ('J4', 'J7');
--
--12. ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
--SELECT SUM(DECODE(MARRIAGE, 'Y', 1))"��ȥ�� ���� ��", SUM(DECODE(MARRIAGE, 'N', 1)) "��ȥ�� ���� ��"
SELECT *
FROM (SELECT COUNT(*) "��ȥ�� ������ ��"
            FROM EMPLOYEE
            GROUP BY MARRIAGE
            HAVING MARRIAGE = 'Y') ,
            (SELECT COUNT(*) "��ȥ�� ������ ��"
            FROM EMPLOYEE 
            GROUP BY MARRIAGE
            HAVING MARRIAGE = 'N');
            
            
SELECT DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ') ��ȥ����,
        COUNT(*) ������
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ')
ORDER BY 1;
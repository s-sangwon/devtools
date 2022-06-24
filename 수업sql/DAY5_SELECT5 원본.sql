-- DAY5_SELECT5.sql
-- SELECT �߰� �ɼ� : HAVING �� ~

-- HAVING �� ---------------------------------------
-- �����ġ : GROUP BY �� ������ �ۼ���
-- ������� : HAVING �׷��Լ�(��꿡 ����� �÷���) �񱳿����� �񱳰�
-- �׷캰�� �׷��Լ� ������� ������ ������ �����ϴ� ������ ���

SELECT MAX(SUM(SALARY))  -- �μ��� �޿��հ��� ���� ū��, 1���� ���
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, MAX(SUM(SALARY))  -- �μ��� �޿��հ��� ���� ū��, 1���� ���
FROM EMPLOYEE
GROUP BY DEPT_ID;  -- ���� : SELECT �� ����� ���� �ٸ�

SELECT DEPT_ID  -- 7��
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- �μ��� �޿��հ� �� ���� ū ���� ���� �μ��ڵ�� �޿��հ踦 ��ȸ
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
--HAVING SUM(SALARY) = 18100000;
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);

-- �м��Լ� (������ �Լ���� ��) ---------------------
-- �Ϲ��Լ��� ��������� �ٸ�

-- RANK() �Լ�
-- ����(���) ��ȯ

-- 1. �÷����� ������ �ű� �� ���
-- RANK() OVER (ORDER BY �����ű� �÷��� ���Ĺ��)

-- �޿��� ���� �޴� ������ ������ �ű�ٸ�
SELECT EMP_NAME, SALARY,
        RANK() OVER (ORDER BY SALARY DESC) ����
FROM EMPLOYEE
ORDER BY ����;

-- 2. ���� ���� ������ �˰��� �� ��
-- RANK(������ �˰����ϴ� ��) WITHIN GROUP (ORDER BY �����ű��÷� ���Ĺ��)

-- �޿� 230���� ��ü �޿��� �� ����? (�޿� �������������� ���)
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC)
FROM EMPLOYEE;

-- ROWID
-- ���̺� ������ ��Ͻ�(�� �߰���, INSERT��) �ڵ����� �ٿ���
-- DBMS �� �ڵ����� ����. ���� �� ��, ��ȸ�� �� �� ����
SELECT EMP_ID, ROWID
FROM EMPLOYEE;

-- ROWNUM
-- ROWID �� �ٸ�
-- ROWNUM�� SELECT �� ����(�۵�)�� ����࿡ �ο��Ǵ� ���ȣ��.(1���� ����)
SELECT *
FROM (SELECT ROWNUM, EMP_ID, EMP_NAME, JOB_ID
        FROM EMPLOYEE
        WHERE JOB_ID = 'J5');

-- *********************************************
-- ���� (JOIN)
-- ���� ���� ���̺��� �ϳ��� ���ļ� ū ���̺��� ���� �÷��� ��ȸ��
-- ����Ŭ ���뱸���� ANSI ǥ�ر������� �ۼ��� �� ����
-- ������ �⺻�� EQUAL JOIN ��
-- �� ���̺��� FOREIGN KEY(�ܷ�Ű | �ܺ�Ű)�� ����� �÷������� ��ġ�ϴ� 
-- ����� �����

-- ����Ŭ ���뱸�� : ����Ŭ������ �����
-- FROM ���� ��ĥ ���̺���� ������
-- FROM ���̺�� ��Ī, ��ĥ���̺�� ��Ī, ��ĥ���̺�� ��Ī, .....
-- ��ĥ ������ WHERE ���� �ۼ���

SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;
-- 20��, DEPT_ID�� NULL �� ���� 2���� ���ܵ� (EQUAL JOIN)

-- ���νÿ� ���̺���� ��Ī(ALIAS) ó���� �� ����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ���� �̸�, �μ��ڵ�, �μ��� ��ȸ
SELECT E.EMP_NAME, E.DEPT_ID, D.DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

SELECT EMP_NAME, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ANSI ǥ�ر���
-- ��� DBMS�� �������� ����ϴ� ǥ�ر�����
-- ���� ó���� ���� ������ FROM ���� �߰� �ۼ���
SELECT *
FROM EMPLOYEE
--INNER JOIN DEPARTMENT USING (DEPT_ID);  -- INNER �� ������ �� ����
JOIN DEPARTMENT USING (DEPT_ID);  -- ������ �⺻�� INNER EQUAL JOIN��

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);
-- ��ģ ������̺� DEPT_ID �� �ϳ� ������ (�� �տ� ǥ�õ�)

-- ������ �⺻ EQUAL INNER JOIN ��.
-- �� ���̺��� �����ϴ� �÷��� ���� EQUAL�� ����� �����Ŵ
-- INNER JOIN �� EQUAL�� �ƴ� ���� ���ܵ�
-- INNER JOIN �� �� ���̺��� �����ϴ� �÷����� ���� ���� USING �����

SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEE
-- INNER JOIN DEPARTMENT USING (DEPT_ID)
JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_ID = 'J6'
ORDER BY DEPT_NAME DESC;

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
-- ����Ŭ ���뱸��
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_TITLE ���޸�
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;  -- 21��, 

-- ANSI ǥ�ر���
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_TITLE ���޸�
FROM EMPLOYEE
JOIN JOB USING (JOB_ID);

-- OUTER JOIN
-- EQUAL �� �ƴ� �൵ ���ο� ���Խ�Ű���� �� �� ����ϴ� ���α���
-- EQUAL JOIN �� : ���� ���� �߰��ؼ� ��ġ�ǰ� ���� ������

-- EMPLOYEE ���̺��� �� ������ ������ ���� ����� ���Խ�Ű���� �Ѵٸ�
-- ����Ŭ ���뱸�� : ���� ���� ���̺� ���� �߰��ϴ� �����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE 
--LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID);
LEFT JOIN DEPARTMENT USING (DEPT_ID);

-- DEPARTMENT ���̺��� ���� ��� ���� ���ο� ���Խ�Ű����...
-- ����Ŭ ���뱸�� : ���� ���� ���̺� ���� �߰��ϴ� �����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE 
--RIGHT OUTER JOIN DEPARTMENT USING (DEPT_ID);
RIGHT JOIN DEPARTMENT USING (DEPT_ID);

-- �� ���̺��� ��ġ���� �ʴ� ��� ���� ���ο� �����Ϸ���...
-- FULL OUTER JOIN �̶�� ��

-- ����Ŭ ���뱸���� FULL OUTER JOIN �� �ۼ��� �� ����
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE 
--FULL OUTER JOIN DEPARTMENT USING (DEPT_ID);
FULL JOIN DEPARTMENT USING (DEPT_ID);  -- 23��

-- CROSS JOIN
-- �� ���̺��� ������ �÷��� ���� �� �����
-- N �� * M ���� ����� ����

-- ANSI
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
-- JOIN DEPARTMENT USING (DEPT_ID);
NATURAL JOIN DEPARTMENT;  -- PRIMARY KEY : DEPT_ID ���ο� ����

-- NON EQUI JOIN 
-- �����ϴ� �÷��� ���� ��ġ�ϴ� ��찡 �ƴ�
-- ���� ������ �ش��ϴ� ����� �����ϴ� ����� ������
-- JOIN ON �����
SELECT *
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN
-- ���� ���̺��� �� �� �����ϴ� �����
-- ���� ���̺� �ȿ� �ٸ� �÷��� �ܷ�Ű(FOREIGN KEY)�� ����ϴ� ��쿡 �̿�
-- EMP_ID : ������ ���, MGR_ID : �������� ������ ���(EMP_ID�� ������)
-- MGR_ID : ���� �߿� �������� ������ �ǹ���

-- �����ڰ� ������ ������ ��ܰ� �������� ���� ��� ��ȸ
-- ANSI ǥ�ر��� : ���̺� ��Ī ����ؾ� ��. ON �����
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

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
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

SELECT *
FROM EMPLOYEE
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
JOIN DEPARTMENT USING (DEPT_ID);  -- ERROR : ���� ���� Ʋ��

SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID);

-- ���� �̸�, ���޸�, �μ���, ������, ������ ��ȸ
-- ���� ��ü ��ȸ
-- ANSI ǥ��
SELECT EMP_NAME ������, JOB_TITLE ���޸�, DEPT_NAME �μ���, 
        LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING (COUNTRY_ID);

-- ����Ŭ ����
SELECT EMP_NAME ������, JOB_TITLE ���޸�, DEPT_NAME �μ���, 
        LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND L.COUNTRY_ID = C.COUNTRY_ID(+);


-- ************************************************
-- JOIN ��������

-- 1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'YYYYMMDD DAY') 
FROM DUAL;


-- 2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, 
-- ���� �达�� �������� 
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.

-- ANSI
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '��%';

-- ORACLE
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '��%';

-- 3. ���� ���̰� ���� ������ 
-- ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.

--������ �ּҰ� ��ȸ
SELECT MIN(TRUNC((MONTHS_BETWEEN(SYSDATE,
          TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))) ���� 
FROM EMPLOYEE;       

-- ��ȸ�� ������ �ּҰ��� �̿��� ������ ���� ��ȸ��
-- outer join �ʿ���.
SELECT EMP_ID, EMP_NAME, 
       MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 
       'RRMM')) / 12))) ���� ,
       DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, 
        TO_DATE(SUBSTR(EMP_NO, 1, 4), 
       'RRMM')) / 12))) = 32;

-- ���������� ����� ��� *****************************
-- ANSI
SELECT EMP_ID, EMP_NAME, 
       MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(
       SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))) ���� ,
       DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(
        SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))) = (SELECT MIN(TRUNC((MONTHS_BETWEEN
                                                  (SYSDATE, 
                                                  TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))) ���� 
                                                  FROM EMPLOYEE);

-- ORACLE
SELECT EMP_ID, EMP_NAME, 
       MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(
       SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))) ���� ,
       DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(
        SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))) = (SELECT MIN(TRUNC((MONTHS_BETWEEN
                                                  (SYSDATE, 
                                                  TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12))) ���� 
                                                  FROM EMPLOYEE);



-- 4. �̸��� '��'�ڰ� ���� �������� 
-- ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%��%';


-- 5. �ؿܿ������� �ٹ��ϴ� 
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_TITLE, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;


-- 6. ���ʽ�����Ʈ�� �޴� �������� 
-- �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
WHERE BONUS_PCT IS NOT NULL
AND BONUS_PCT <> 0.0;


-- 7. �μ��ڵ尡 20�� �������� 
-- �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
WHERE DEPT_ID = '20';


-- 8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�.
SELECT EMP_NAME, JOB_TITLE, SALARY, 
       (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 ����
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)       
WHERE (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 
      > MIN_SAL;


-- 9 . �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
-- �����(emp_name), �μ���(dept_name), ������(loc_describe),
--  ������(country_name)�� ��ȸ�Ͻÿ�.
SELECT EMP_NAME �����, DEPT_NAME �μ���,
       LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
JOIN COUNTRY USING (COUNTRY_ID)       
WHERE COUNTRY_ID IN ('KO', 'JP');

-- 10. ���� �μ��� �ٹ��ϴ� �������� 
-- �����, �μ��ڵ�, �����̸�, �μ��ڵ带 ��ȸ�Ͻÿ�.
-- self join ���
-- ORACLE
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, 
       C.EMP_NAME �����̸�, C.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E, EMPLOYEE C
WHERE E.EMP_NAME <> C.EMP_NAME
AND E.DEPT_ID = C.DEPT_ID
ORDER BY E.EMP_NAME;

-- ANSI
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, 
       C.EMP_NAME �����̸�, C.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E
JOIN EMPLOYEE C ON (E.DEPT_ID = C.DEPT_ID)
WHERE E.EMP_NAME <> C.EMP_NAME
ORDER BY E.EMP_NAME;



-- 11. ���ʽ�����Ʈ�� ���� ������ �߿��� 
-- �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.

-- ��, join�� IN ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7') AND BONUS_PCT IS NULL;

-- ��, join�� set operator ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID = 'J4' AND BONUS_PCT IS NULL
UNION
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID = 'J7' AND BONUS_PCT IS NULL;



-- 12. �ҼӺμ��� 50 �Ǵ� 90�� ������ 
-- ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ') ��ȥ����, 
       COUNT(*) ������
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ')
ORDER BY 1;








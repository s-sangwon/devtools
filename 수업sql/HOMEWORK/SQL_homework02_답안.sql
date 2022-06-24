--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
--������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
--ǥ�õǵ��� �Ѵ�.)
SELECT STUDENT_NO AS �й�,
       STUDENT_NAME AS �̸�,
	   TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD') AS ���г⵵
FROM   TB_STUDENT
WHERE  DEPARTMENT_NO='002'
ORDER BY ENTRANCE_DATE;

--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �Ѹ� �ִٰ� �Ѵ�. �� ������
--�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL
--������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME , 
       PROFESSOR_SSN
FROM   TB_PROFESSOR
--WHERE  PROFESSOR_NAME NOT LIKE '___';
WHERE LENGTH(PROFESSOR_NAME) != 3;

--3. �� ������б��� ���� �������� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. �� �̶�
--���̰� ���� ������� ���� ��� ����(���̰� ���ٸ� �̸��� ������ ����)�� ȭ�鿡
--��µǵ��� ����ÿ�. (��, ���� �� 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�"
--���� �Ѵ�. ���̴� ���������� ����Ѵ�.)
SELECT PROFESSOR_NAME AS �����̸�,
       TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 
       TO_NUMBER('19' || SUBSTR(PROFESSOR_SSN, 1, 2)) AS ����
FROM   TB_PROFESSOR
WHERE  SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2, 1;

--4.
SELECT SUBSTR(PROFESSOR_NAME, 2) AS �̸�
FROM   TB_PROFESSOR;

--5.
SELECT  STUDENT_NO,
        STUDENT_NAME
FROM    TB_STUDENT
WHERE   TO_NUMBER(TO_CHAR(ENTRANCE_DATE, 'YYYY'))  - 
            TO_NUMBER(TO_CHAR(TO_DATE(
                SUBSTR(STUDENT_SSN, 1, 2), 'RR'), 'YYYY')) > 19
ORDER BY 1;



--6.
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'YYYYMMDD DAY') FROM DUAL;

--7.

SELECT TO_DATE('99/10/11', 'YY/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11', 'YY/MM/DD') FROM DUAL;
SELECT TO_DATE('99/10/11', 'RR/MM/DD') FROM DUAL;
SELECT TO_DATE('49/10/11', 'RR/MM/DD') FROM DUAL;
/*
TO_DATE('99/10/11', 'YY/MM/DD') : 2099�� 10�� 11��
TO_DATE('49/10/11', 'YY/MM/DD') : 2049�� 10�� 11��
TO_DATE('99/10/11', 'RR/MM/DD') : 1999�� 10�� 11��
TO_DATE('49/10/11', 'RR/MM/DD') : 2049�� 10�� 11��
*/

--8.
SELECT STUDENT_NO,
       STUDENT_NAME
FROM   TB_STUDENT
WHERE  SUBSTR(STUDENT_NO, 1, 1) <> 'A'
ORDER BY 1
;

--9. 
SELECT ROUND(AVG(POINT), 1) AS ���� 
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A517178';

--10.
SELECT DEPARTMENT_NO AS �а���ȣ,
       COUNT(*) AS "�л���(��)"
FROM   TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
--�ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM   TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
--�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
--�Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.

SELECT SUBSTR(TERM_NO, 1 ,4) AS �⵵,
       ROUND(AVG(POINT), 1) AS "�⵵ �� ����" 
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

--13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�.

SELECT DEPARTMENT_NO AS �а��ڵ��,
       SUM(CASE WHEN ABSENCE_YN ='Y' THEN 1 
			     ELSE 0 END) AS "���л� ��"
FROM   TB_STUDENT
GROUP BY DEPARTMENT_NO
--ORDER BY 1
;

--14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. � SQL
--������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME AS �����̸�,
       COUNT(*)     AS "������ ��"
FROM   TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

--15.
SELECT SUBSTR(TERM_NO, 1, 4) AS �⵵,
       SUBSTR(TERM_NO, 5, 2) AS �б�,
	   ROUND(AVG(POINT), 1) AS ����
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2));



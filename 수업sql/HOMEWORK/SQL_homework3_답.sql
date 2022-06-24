--1. 2001 �⿡ ���� �� ���а� �л��� �� ������ �л����� ��ȸ�Ͻÿ�. 
--���а� �ڵ�� TB_DEPARTMENT ���� �˻��Ѵ�. (Join �� ������� �ʴ´�.)

SELECT 	DEPARTMENT_NO 
FROM 	TB_DEPARTMENT
WHERE 	DEPARTMENT_NAME = '���а�';

SELECT 	COUNT(*) �л��� 
FROM 	TB_STUDENT
WHERE 	DEPARTMENT_NO = '003' 
AND ENTRANCE_DATE LIKE '01%';

--2. �迭�� �����С��� �а� �� ���������� 20 �� �̻�, 30 �� ������ �а��� 
--   �迭, �а��̸�, ������ ��ȸ�Ͻÿ�.
--�� �а��̸��� �������� �������� �����Ͻÿ�.��

SELECT 	CATEGORY �迭, DEPARTMENT_NAME �а��̸�, CAPACITY ����
FROM 	TB_DEPARTMENT
WHERE 	CAPACITY BETWEEN 20 AND 30 
AND CATEGORY = '����';

--3. ���С��ڰ� �� �迭�� �Ҽ� �а��� �� �� �ִ��� �迭, �а����� ����Ͻÿ�. 
--�� �а����� ���� ������ �����Ͻÿ�.
SELECT	CATEGORY �迭, COUNT(*) AS �а���
FROM 	TB_DEPARTMENT 
WHERE 	CATEGORY LIKE '%��%'
GROUP BY CATEGORY
ORDER BY 2 DESC;

--4. ��������а��� �����̸�, ����⵵, �ּҸ� ��ȸ�ϰ� ���̰� ���� ������ �����Ͻÿ�. 
--������а� �ڵ�� TB_DEPARTMENT ���� �˻��Ѵ�. (Join �� ������� �ʴ´�.)
SELECT 	DEPARTMENT_NO 
FROM 	TB_DEPARTMENT
WHERE 	DEPARTMENT_NAME = '������а�';

SELECT PROFESSOR_NAME �����̸�, 
          SUBSTR(PROFESSOR_SSN, 1, 2) ����⵵, 
          PROFESSOR_ADDRESS �ּ� 
FROM	TB_PROFESSOR 
WHERE	DEPARTMENT_NO = '002'
ORDER BY 2;

--5. ������а� �л� �� ���￡ �����ϴ� �л��� 
--�а���ȣ, �л��̸�, ���п��θ� ��ȸ�ϰ� �л��̸����� �������� �����Ͻÿ�. 
--�� ���п��δ� ���� ��Y���̸� �����С����� ��N���̸� ���������� ����Ѵ�. 
--������а� �ڵ�� TB_DEPARTMENT ���� ã�´�. (Join �� ������� �ʴ´�)
SELECT 	DEPARTMENT_NO 
FROM 	TB_DEPARTMENT
WHERE 	DEPARTMENT_NAME = '������а�';

SELECT DEPARTMENT_NO �а���ȣ, STUDENT_NAME �л��̸�, 
          DECODE(ABSENCE_YN, 'Y', '����', 'N', '����') ���п���
FROM 	TB_STUDENT
WHERE	DEPARTMENT_NO = '001'
AND STUDENT_ADDRESS LIKE '%����%'
ORDER BY 2;


--6. 80 ����� ���л� �� ���� ���衯���� �л��� �ֹι�ȣ, �л��̸��� ��ȸ�Ͻÿ�. 
--�� �л��̸����� �������� �����Ͻÿ�.
SELECT '[' || SUBSTR(STUDENT_SSN, 1, 8) || '******]' AS "[�ֹι�ȣ]",
          STUDENT_NAME �̸�
FROM TB_STUDENT
WHERE STUDENT_SSN LIKE '80%'
AND SUBSTR(STUDENT_SSN, 8, 1) = '2'
AND STUDENT_NAME LIKE '��%'
ORDER BY 2;


--7. �迭�� ����ü�ɡ��� �а��� ������ �������� 
--40 �� �̻��̸� ���밭�ǽǡ�, 30 �� �̻��̸� ���߰��ǽǡ�, 30 ��̸��̸� ���Ұ��ǽǡ��� ����Ѵ�. 
--��, ������ ���� ������ ���� �Ѵ�.
SELECT	DEPARTMENT_NAME �а��̸�, CAPACITY ��������, 
            CASE WHEN CAPACITY >= 40 THEN '�밭�ǽ�'
                    WHEN CAPACITY >=30 THEN '�߰��ǽ�'
                    ELSE '�Ұ��ǽ�' 
            END AS ���ǽ�ũ��
FROM 	TB_DEPARTMENT
WHERE	CATEGORY = '��ü��'
ORDER BY 2 DESC, 1;

--8. �ּ����� ����⡯ �Ǵ� ����õ���� �л� �� 1900��뿡 ���� �� �л����� ��ȸ �ϰ��� �Ѵ�. 
--���ó�¥�� �������� ���� �� �Ⱓ�� ����Ͽ� ���� �� �Ⱓ�� ������ ������ ���� �Ѵ�. 
--(�� ���� �� �Ⱓ�� ������ ��(Ҵ)���� �ϰ�, �Ҽ��� ���� �ڸ��� ������. 
--���� ���� �� �Ⱓ�� ���� ��� �̸����� �������� �����Ѵ�.)
SELECT STUDENT_NAME �л��̸�,
          TO_CHAR(ENTRANCE_DATE, 'YY"��" MM"��" DD"��"') ��������,
          TRUNC((MONTHS_BETWEEN(SYSDATE, ENTRANCE_DATE) / 12), 0) || '��' AS "�����ıⰣ(��)"
FROM 	TB_STUDENT
WHERE 	(STUDENT_ADDRESS LIKE '%���%' OR STUDENT_ADDRESS LIKE '%��õ%') 
AND ENTRANCE_DATE LIKE '9%'
ORDER BY 3 DESC, 1;

--9. �а��� ���￡ �����ϴ� ���� �� ���̰� ���� ���� ������ ���̸� ��ȸ�Ѵ�. 
--��, ���̰� ���� ������ �����Ѵ�
SELECT 	DEPARTMENT_NO �а���ȣ, 
        MIN(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - 
                (TO_NUMBER(SUBSTR(PROFESSOR_SSN,1,2)) + 1900)) ����
FROM 	TB_PROFESSOR
WHERE 	PROFESSOR_ADDRESS LIKE '%����%'
GROUP BY DEPARTMENT_NO 
ORDER BY 2;

--10. 2005��1��1�Ϻ��� 2006��12��31�ϱ����� �Ⱓ�� ������ �л� �� 
--�ּҰ� ��ϵ��� ���� ���л��� �а���ȣ, �л��̸�, ����������ȣ, ���г⵵�� ��ȸ�Ͻÿ�. 
--���г⵵�� �������� �������� �����Ѵ�.
SELECT 	DEPARTMENT_NO �а���ȣ, STUDENT_NAME �л��̸�, 
            COACH_PROFESSOR_NO ����������ȣ, 
            TO_CHAR(ENTRANCE_DATE, 'YYYY') || '��' AS ���г⵵
FROM 	TB_STUDENT
WHERE 	STUDENT_ADDRESS IS NULL 
AND TO_CHAR(ENTRANCE_DATE, 'YYYY') BETWEEN 2005 AND 2007 
AND SUBSTR(STUDENT_SSN, 8, 1) = 1
ORDER BY 4,2;

--11. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�.
-- * ���������� �л��� ���� ������ ������ �л����� �⵵ �� ������ ǥ���ϴ� ������ �ۼ��Ѵ�.
-- * ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ�� �Ѱ� �⵵�� �ֱ� ������ ���� �Ѵ�.
SELECT SUBSTR(TERM_NO, 1, 4) �⵵, ROUND(AVG(POINT),1) ����
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE COACH_PROFESSOR_NO = (SELECT COACH_PROFESSOR_NO 
                                                  FROM TB_STUDENT 
                                                  WHERE STUDENT_NAME='������')
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

--12. �Ʒ� ���ǿ� �´� ������ �˻� �Ͻÿ�.
--  ��ü ���л� �� ������ �л��� ���� ���ڸ� ��ȸ�Ѵ�.
--  �������ڰ� 2001 �� 1 �� 1 ��(����)���� �������(����)�� �л��� ǥ���ϴ� ������ �ۼ��Ѵ�.
--  ���� ���ڰ� �ֱ� ������ �����Ѵ�.

--Ȳ���� ���� �̹ο�   �� 52��
SELECT   DEPARTMENT_NAME �а���,
         STUDENT_NAME �л���,
				 ENTRANCE_DATE ��������
FROM     TB_STUDENT
JOIN     TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE    SUBSTR(STUDENT_SSN, 8, 1) IN ('1', '3')
AND      ABSENCE_YN = 'Y'
AND      ENTRANCE_DATE 
              BETWEEN TO_DATE('20010101', 'YYYYMMDD') AND SYSDATE
ORDER BY 3 DESC;

--13. �Ʒ� ���ǿ� �´� ������ �˻� �Ͻÿ�
-- ������ �ϳ��� ���� ���� ���� ������ ���������� �л����� ǥ���ϴ� ������ �ۼ��Ѵ�
SELECT    PROFESSOR_NAME ��������,
          COUNT(STUDENT_NO) �л���
FROM      TB_PROFESSOR
LEFT JOIN TB_CLASS_PROFESSOR USING (PROFESSOR_NO)
JOIN      TB_STUDENT ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE     CLASS_NO IS NULL
GROUP BY  PROFESSOR_NAME;

--14. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�.
-- �����С��迭�� �л��� �� 2009 �⵵ ���� �� 4.0 �̻��� �л��� ǥ���ϴ� ������ �ۼ��Ѵ�.
-- ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ�� �Ѵ�.
-- ������ ���� ������ ���� �ϰ� ������ �л��̸���(�����ټ�)���� ���� �Ѵ�.

SELECT STUDENT_NAME �л���, SUBSTR(TERM_NO,1,6) �б�, 
          ROUND(AVG(POINT),1) ����
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE SUBSTR(TERM_NO,1,4) IN ('2009')
AND category='����'
GROUP BY STUDENT_NAME , DEPARTMENT_NAME , SUBSTR(TERM_NO,1,6) 
HAVING ROUND(AVG(POINT),1) >= 4.0 
ORDER BY 3 DESC, 1 ASC;

--15. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�
-- ����� �л��� �ִ� ���� 2007 ��, 2008 �� �б� �� ������
--�⵵ �� ���� ����, �� ������ ǥ���ϴ� ������ �ۼ��Ѵ�. 
--(������ �Ҽ��� 1 �ڸ������� �ݿø�)

SELECT SUBSTR(TERM_NO, 1,4) �⵵ , 
          SUBSTR(TERM_NO, 5,2) �б� ,ROUND(AVG(POINT),1) ����
FROM TB_GRADE
JOIN TB_STUDENT S USING (STUDENT_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE D.DEPARTMENT_NO = (SELECT DEPARTMENT_NO 
                                            FROM TB_STUDENT 
                                            WHERE STUDENT_NAME='����')
            AND SUBSTR(TERM_NO, 1,4) < 2009 
            AND  SUBSTR(TERM_NO, 1,4) > 2006 
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1,4)),
                ROLLUP(SUBSTR(TERM_NO, 5,2))
ORDER BY 1,2;

--16. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�
-- �����а������С� ������ �����ϴ� ���� 2004 �⵵ �б� �� ������
--�� ������ ǥ���ϴ� ������ �ۼ��Ѵ�.
-- ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ�� �Ѵ�
SELECT SUBSTR(TERM_NO, 1,4) �⵵,
          NVL(SUBSTR(TERM_NO, 5, 2), '-') �б�,
          ROUND(AVG(POINT), 1)����
FROM   TB_GRADE 
JOIN   TB_STUDENT USING (STUDENT_NO)
WHERE  TERM_NO LIKE '2004%'
            AND DEPARTMENT_NO = ( SELECT DEPARTMENT_NO 
                                                  FROM   TB_CLASS
                                                  WHERE  CLASS_NAME = '���а�������' )
            AND    SUBSTR(TERM_NO, 5, 2) IS NOT NULL                 
GROUP BY ROLLUP  (SUBSTR(TERM_NO, 5, 2)), SUBSTR(TERM_NO, 1,4)
ORDER BY 1;

--17. �л���ȣ�� �� 7 �ڸ��̰� 'A'�� �����ϸ� 4 ��° �ڸ� �����Ͱ� '3'�� �л� �� 
--���������� ���� '��'���� �л��� 
--�л��̸� ��(�����ټ�)���� ǥ���ϴ� ������ �ۼ� �Ͻÿ�
SELECT STUDENT_NAME �л��̸�, PROFESSOR_NAME ��������
FROM TB_STUDENT
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE LENGTH(STUDENT_NO) = 7
AND STUDENT_NO LIKE 'A__3%'
AND PROFESSOR_NAME LIKE '��%'
ORDER BY 1;

--18. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�
-- ����ü�ɡ��� �����С� �迭�� ��� �а��� �а��̸��� �л����� ǥ���ϴ� ������ �ۼ� �Ͻÿ�.
-- �迭�̸� ��(�����ټ�)���� ���� �ϰ� ������ �л����� ���� ������ ���� �Ѵ�.
SELECT   CATEGORY , DEPARTMENT_NAME �а��� ,
            COUNT(STUDENT_NO) AS �л���
FROM TB_DEPARTMENT 
LEFT JOIN TB_STUDENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '��ü��' OR CATEGORY = '����'
GROUP BY  CATEGORY,  DEPARTMENT_NAME
ORDER BY 1,3 DESC ;

--19. �������а����� ��� ������ ���� ����� �Բ� 
--�����̸���(�����ټ�)���� ǥ���ϴ� ������ �ۼ� �Ͻÿ�.
--(���������� ���� ��� ��µ��� �ʴ´�.) 
SELECT TC2.CLASS_NAME ���� , TC1.CLASS_NAME ��������
FROM TB_CLASS TC1
JOIN (SELECT C2.CLASS_NAME, C2.CLASS_NO, C2.PREATTENDING_CLASS_NO
        FROM TB_CLASS C1 
        JOIN TB_CLASS C2 ON C2.PREATTENDING_CLASS_NO = C1.CLASS_NO
        )  TC2 ON TC1.CLASS_NO = TC2.PREATTENDING_CLASS_NO
WHERE DEPARTMENT_NO IN (SELECT DEPARTMENT_NO 
                                          FROM TB_DEPARTMENT 
                                          WHERE DEPARTMENT_NAME = '�����а�')
ORDER BY 1;



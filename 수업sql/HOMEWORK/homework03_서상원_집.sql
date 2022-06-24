--1. 2001 �⿡ ���� �� ���а� �л��� �� ������ �л����� ��ȸ�Ͻÿ�. ���а� �ڵ�� TB_DEPARTMENT ����
--�˻��Ѵ�. (Join �� ������� �ʴ´�.)
--SELECT  DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE DEPARTMENT_NAME = '���а�';

SELECT COUNT(*) �л���
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) = 2001
AND DEPARTMENT_NO = (SELECT  DEPARTMENT_NO
                                        FROM TB_DEPARTMENT
                                        WHERE DEPARTMENT_NAME = '���а�') ;

--2. �迭�� �����С��� �а� �� ���������� 20 �� �̻�, 30 �� ������ �а��� �迭, �а��̸�, ������ ��ȸ�Ͻÿ�. 
--�� �а��̸��� �������� �������� �����Ͻÿ�.��
SELECT CATEGORY �迭, DEPARTMENT_NAME �а��̸�, CAPACITY ����
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '%����%' 
AND CAPACITY BETWEEN 20 AND 30
ORDER BY �а��̸� ASC;
--
--3. ���С��ڰ� �� �迭�� �Ҽ� �а��� �� �� �ִ��� �迭, �а����� ����Ͻÿ�. �� �а����� ���� ������
--�����Ͻÿ�.
SELECT CATEGORY �迭, COUNT(*) �а���
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '%��%' 
GROUP BY CATEGORY
ORDER BY �а��� DESC;

--4. ��������а��� �����̸�, ����⵵, �ּҸ� ��ȸ�ϰ� ���̰� ���� ������ �����Ͻÿ�. ������а� �ڵ��
--TB_DEPARTMENT ���� �˻��Ѵ�. (Join �� ������� �ʴ´�.)
SELECT PROFESSOR_NAME �����̸�, SUBSTR(PROFESSOR_SSN, 1, 2) ����⵵, professor_address �ּ�
FROM tb_professor
WHERE department_no = (SELECT DEPARTMENT_NO
                                     FROM TB_DEPARTMENT
                                     WHERE DEPARTMENT_NAME = '������а�')
ORDER BY 2;

--SELECT DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE DEPARTMENT_NAME = '������а�';

--5. ������а� �л� �� ���￡ �����ϴ� �л��� �а���ȣ, �л��̸�, ���п��θ� ��ȸ�ϰ� �л��̸�����
--�������� �����Ͻÿ�. �� ���п��δ� ���� ��Y���̸� �����С����� ��N���̸� ���������� ����Ѵ�. ������а�
--�ڵ�� TB_DEPARTMENT ���� ã�´�. (Join �� ������� �ʴ´�)
--SELECT DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE DEPARTMENT_NAME = '������а�'; --SUB QUERY

SELECT department_no �а���ȣ, student_name �л��̸�, DECODE(absence_yn, 'Y', '����', '����') ���п���
FROM TB_STUDENT
WHERE department_no = (SELECT DEPARTMENT_NO
                                        FROM TB_DEPARTMENT
                                        WHERE DEPARTMENT_NAME = '������а�')
AND SUBSTR(STUDENT_ADDRESS, 1, 2) = '����'                                         
ORDER BY 2;
--6. 80 ����� ���л� �� ���� ���衯���� �л��� �ֹι�ȣ, �л��̸��� ��ȸ�Ͻÿ�. �� �л��̸����� ��������
--�����Ͻÿ�.
SELECT '[' || RPAD(SUBSTR(STUDENT_SSN,1,8), 14, '*') || ']' "[�ֹι�ȣ]", STUDENT_NAME �л��̸�
FROM tb_student
WHERE STUDENT_SSN LIKE '80%'
AND SUBSTR(STUDENT_SSN, 8, 1) = 2
AND STUDENT_NAME LIKE '��%'
ORDER BY �л��̸�;


--7. �迭�� ����ü�ɡ��� �а��� ������ �������� 40 �� �̻��̸� ���밭�ǽǡ�, 30 �� �̻��̸� ���߰��ǽǡ�, 30 ��
--�̸��̸� ���Ұ��ǽǡ��� ����Ѵ�. ��, ������ ���� ������ ���� �Ѵ�.
SELECT department_name �а��̸�, capacity ����, CASE 
                                                                            WHEN CAPACITY >= 40 THEN '�밭�ǽ�'
                                                                            WHEN CAPACITY >= 30 THEN '�߰��ǽ�'
                                                                            ELSE '�Ұ��ǽ�'
                                                                            END ���ǽ�ũ��
FROM  TB_DEPARTMENT
WHERE CATEGORY = '��ü��'
ORDER BY ���� DESC;

--SELECT *
--FROM TB_DEPARTMENT
--WHERE CATEGORY = '��ü��';
--8. �ּ����� ����⡯ �Ǵ� ����õ���� �л� �� 1900��뿡 ���� �� �л����� ��ȸ �ϰ��� �Ѵ�. ���ó�¥�� ����
--���� ���� �� �Ⱓ�� ����Ͽ� ���� �� �Ⱓ�� ������ ������ ���� �Ѵ�. (�� ���� �� �Ⱓ�� ������ ��(Ҵ)��
--�� �ϰ�, �Ҽ��� ���� �ڸ��� ������. ���� ���� �� �Ⱓ�� ���� ��� �̸����� �������� �����Ѵ�.)
SELECT STUDENT_NAME �а��̸�, TO_CHAR(ENTRANCE_DATE, 'YY "��" MM "��" DD "��"') ��������, 
            FLOOR(MONTHS_BETWEEN(SYSDATE, ENTRANCE_DATE) / 12) "�����ıⰣ(��)"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '���%' OR STUDENT_ADDRESS LIKE '��õ%')
AND EXTRACT(YEAR FROM ENTRANCE_DATE) >= 1900 
AND EXTRACT(YEAR FROM ENTRANCE_DATE) < 2000
ORDER BY FLOOR(MONTHS_BETWEEN(SYSDATE, ENTRANCE_DATE) / 12) DESC, STUDENT_NAME;


--9. �а��� ���￡ �����ϴ� ���� �� ���̰� ���� ���� ������ ���̸� ��ȸ�Ѵ�. ��, ���̰� ���� ������ ����
--�Ѵ�.
SELECT department_no �а���ȣ, EXTRACT(YEAR FROM SYSDATE) - (Max(SUBSTR(PROFESSOR_SSN,1,2)) + 1900) ����
--EXTRACT(YEAR FROM TO_DATE(MAX(SUBSTR(PROFESSOR_SSN,1,6)), 'RRMMDD' )
FROM tb_professor
WHERE professor_address LIKE '����%'
GROUP BY department_no
ORDER BY 2;

--SELECT department_no, MAX(SUBSTR(PROFESSOR_SSN,1,2))
--FROM tb_professor
--WHERE professor_address LIKE '����%'
--GROUP BY department_no
--ORDER BY 2 DESC;

--10. 2005��1��1�Ϻ��� 2006��12��31�ϱ����� �Ⱓ�� ������ �л� �� �ּҰ� ��ϵ��� ���� ���л��� �а���
--ȣ, �л��̸�, ����������ȣ, ���г⵵�� ��ȸ�Ͻÿ�. ���г⵵�� �������� �������� �����Ѵ�
SELECT department_no �а���ȣ, STUDENT_NAME �̸�, coach_professor_no ����������ȣ, TO_CHAR(entrance_date, 'YYYY "��"') ���г⵵
FROM TB_STUDENT
WHERE entrance_date >= '05/01/01' AND entrance_date <= '06/12/31'
AND student_address IS NULL
AND SUBSTR(STUDENT_SSN, 8, 1) = '1'
ORDER BY entrance_date;
--11. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�.
--? ���������� �л��� ���� ������ ������ �л����� �⵵ �� ������ ǥ���ϴ� ������ �ۼ��Ѵ�.
--? ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ�� �Ѱ� �⵵�� �ֱ� ������ ���� �Ѵ�.
SELECT SUBSTR(TERM_NO,1,4) �⵵, ROUND(AVG(POINT),1) ����
FROM tb_student 
LEFT JOIN tb_professor ON COACH_PROFESSOR_NO = PROFESSOR_NO
LEFT JOIN tb_GRADE USING(STUDENT_NO)
WHERE COACH_PROFESSOR_NO = 'P095'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY �⵵ DESC;

--SELECT COACH_PROFESSOR_NO
--FROM tb_student 
--LEFT JOIN tb_professor ON COACH_PROFESSOR_NO = PROFESSOR_NO
--WHERE STUDENT_NAME = '������';  -- ������ �л��� �������� ������ P095   sub

--12. �Ʒ� ���ǿ� �´� ������ �˻� �Ͻÿ�. 
--? ��ü ���л� �� ������ �л��� ���� ���ڸ� ��ȸ�Ѵ�.
--? �������ڰ� 2001 �� 1 �� 1 ��(����)���� �������(����)�� �л��� ǥ���ϴ� ������ �ۼ��Ѵ�.
--? ���� ���ڰ� �ֱ� ������ �����Ѵ�
SELECT DEPARTMENT_NAME �а���, STUDENT_NAME �л��� ,ENTRANCE_DATE ��������
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE SUBSTR(STUDENT_SSN, 8, 1) IN(1,3) AND ABSENCE_YN = 'Y'
AND ENTRANCE_DATE >= '2001/01/01'
AND ENTRANCE_DATE <= SYSDATE
ORDER BY 3 DESC;


--13. �Ʒ� ���ǿ� �´� ������ �˻� �Ͻÿ�
--? ������ �ϳ��� ���� ���� ���� ������ ���������� �л����� ǥ���ϴ� ������ �ۼ��Ѵ�.
SELECT PROFESSOR_NAME ��������, COUNT(*) �л���
FROM TB_PROFESSOR
LEFT JOIN TB_CLASS_PROFESSOR USING(PROFESSOR_NO)
LEFT JOIN TB_STUDENT ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE CLASS_NO IS NULL -- ������ �ϳ��� �������� ���� ������
GROUP BY PROFESSOR_NAME;

--14. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�.
--? �����С��迭�� �л��� �� 2009 �⵵ ���� �� 4.0 �̻��� �л��� ǥ���ϴ� ������ �ۼ��Ѵ�.
--? ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ�� �Ѵ�.
--? ������ ���� ������ ���� �ϰ� ������ �л��̸���(�����ټ�)���� ���� �Ѵ�

--
--SELECT STUDENT_NAME, TERM_NO, ROUND( AVG(POINT), 1) ����
--FROM TB_STUDENT
--LEFT JOIN TB_GRADE USING(STUDENT_NO)
--LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
--WHERE CATEGORY = '����' AND SUBSTR(TERM_NO,1,4) = 2009 --AND POINT>= 4.0
--GROUP BY STUDENT_NAME, TERM_NO
--HAVING ROUND( AVG(POINT), 1) >= 4.0; -- 2009�⵵ ������ 4.0 �̻��� �л���


SELECT STUDENT_NAME �л��̸�, TERM_NO �б�, ROUND( AVG(POINT), 1) ����
FROM TB_STUDENT
LEFT JOIN TB_GRADE USING(STUDENT_NO)
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE STUDENT_NAME IN (SELECT STUDENT_NAME
                                        FROM TB_STUDENT
                                        LEFT JOIN TB_GRADE USING(STUDENT_NO)
                                        LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                                        WHERE CATEGORY = '����' AND SUBSTR(TERM_NO,1,4) = 2009 --AND POINT>= 4.0
                                        GROUP BY STUDENT_NAME, TERM_NO
                                        HAVING ROUND( AVG(POINT), 1) >= 4.0)
GROUP BY STUDENT_NAME, TERM_NO
ORDER BY ���� DESC, �л��̸�;


--.15. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�
--? ����� �л��� �ִ� ���� 2007 ��, 2008 �� �б� �� ������
--�⵵ �� ���� ����, �� ������ ǥ���ϴ� ������ �ۼ��Ѵ�. (������ �Ҽ��� 1 �ڸ������� �ݿø�)
SELECT SUBSTR(TERM_NO, 1, 4) �⵵, SUBSTR(TERM_NO, 5, 2) �б�, ROUND( AVG(POINT), 1) ����
FROM TB_STUDENT
LEFT JOIN TB_GRADE USING(STUDENT_NO)
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO = '034' 
AND SUBSTR(TERM_NO, 1, 4) IN('2007', '2008')
GROUP BY CUBE(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY 1;

SELECT DEPARTMENT_NO
FROM TB_STUDENT
WHERE STUDENT_NAME = '����'; -- ���� �л��� �ִ� �� '034'


--16. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�
--? �����а������С� ������ �����ϴ� ���� 2004 �⵵ �б� �� ������
--�� ������ ǥ���ϴ� ������ �ۼ��Ѵ�.
--? ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ�� �Ѵ�.
--SELECT department_no
--FROM TB_CLASS
--WHERE CLASS_NAME ='���а�������'; -- ���а� ������ ������ �����ϴ� �� '002'
--
--SELECT *
--FROM TB_GRADE
--LEFT JOIN TB_STUDENT USING(STUDENT_NO)
--WHERE DEPARTMENT_NO = '002' AND SUBSTR(TERM_NO, 1, 4) = '2004';  


SELECT SUBSTR(TERM_NO, 1, 4) �⵵, SUBSTR(TERM_NO, 5, 2) �б�, ROUND( AVG(POINT), 1) ����
FROM TB_STUDENT
FULL JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT department_no
                                            FROM TB_CLASS
                                            WHERE CLASS_NAME ='���а�������') -- = '002'
AND SUBSTR(TERM_NO, 1, 4) = '2004'                                             
GROUP BY SUBSTR(TERM_NO, 1, 4), ROLLUP(SUBSTR(TERM_NO, 5, 2));

    
--17. �л���ȣ�� �� 7 �ڸ��̰� 'A'�� �����ϸ� 4 ��° �ڸ� �����Ͱ� '3'�� �л� �� ���������� ���� '��'����
--�л��� �л��̸� ��(�����ټ�)���� ǥ���ϴ� ������ �ۼ� �Ͻÿ�.
--SELECT STUDENT_NO
--FROM TB_STUDENT
--WHERE STUDENT_NO LIKE 'A__3___';    -- �л���ȣ�� �� 7 �ڸ��̰� 'A'�� �����ϸ� 4 ��° �ڸ� �����Ͱ� '3'�� �л���

SELECT STUDENT_NAME �л��̸�, PROFESSOR_NAME ��������
FROM TB_STUDENT
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO LIKE 'A__3___'
AND PROFESSOR_NAME LIKE '��%'
ORDER BY �л��̸�;

--18. �������ǿ� �´� �����͸� ��ȸ �Ͻÿ�
--? ����ü�ɡ��� �����С� �迭�� ��� �а��� �а��̸��� �л����� ǥ���ϴ� ������ �ۼ� �Ͻÿ�.
--? �迭�̸� ��(�����ټ�)���� ���� �ϰ� ������ �л����� ���� ������ ���� �Ѵ�.
SELECT CATEGORY �迭, DEPARTMENT_NAME �а��̸�, CAPACITY �л���
FROM TB_DEPARTMENT
WHERE category IN ('��ü��', '����')
ORDER BY �迭, �л��� DESC;

SELECT CATEGORY �迭, DEPARTMENT_NAME �а��̸�, COUNT(*) �л���
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
WHERE category IN ('��ü��', '����')
GROUP BY DEPARTMENT_NAME, CATEGORY
ORDER BY �迭, �л��� DESC;
--19. �������а����� ��� ������ ���� ����� �Բ� �����̸���(�����ټ�)���� ǥ���ϴ� ������ �ۼ� �Ͻÿ�. 
--(���������� ���� ��µ��� �ʴ´�.)
--SELECT *
--FROM TB_CLASS
--WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
--                                          FROM TB_DEPARTMENT
--                                          WHERE DEPARTMENT_NAME = '�����а�' );

SELECT C.CLASS_NAME ����, P.CLASS_NAME ��������
FROM TB_CLASS C, TB_CLASS P
WHERE C.PREATTENDING_CLASS_NO = P.CLASS_NO
AND C.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = '�����а�' );
                                          
SELECT C.CLASS_NAME ����, P.CLASS_NAME ��������
FROM TB_CLASS C
JOIN TB_CLASS P ON c.preattending_class_no =P.CLASS_NO
AND C.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = '�����а�' );
--���ϴ� ��� ����               ��������
--                ��å��ʿ���    ��å������
--                ����������       �ѱ�������
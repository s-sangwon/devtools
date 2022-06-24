--homework04_�����.sql

--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--������ �̸����� �������� ǥ���ϵ��� ����.
SELECT STUDENT_NAME "�л� �̸�", STUDENT_ADDRESS �ּ���
FROM TB_STUDENT
ORDER BY 1;

--2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD') DESC;

--3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�, 
--�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
--"������ �ּ�" �� ��µǵ��� ����.
SELECT STUDENT_NAME �л��̸�, STUDENT_NO �й�, STUDENT_ADDRESS "������ �ּ�"
FROM TB_STUDENT
WHERE STUDENT_ADDRESS LIKE '������%' OR STUDENT_ADDRESS LIKE '��⵵%'
AND STUDENT_NO LIKE '9%'
ORDER BY 1;

--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
--�ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
--������ ����)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                            FROM TB_DEPARTMENT
                                            WHERE DEPARTMENT_NAME = '���а�')
ORDER BY TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6), 'RRMMDD');

--5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
--���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
--�ۼ��غ��ÿ�.
SELECT STUDENT_NO, LPAD(TO_CHAR(POINT, '9.99'),LENGTH(TO_CHAR(POINT, '9.99'))+2 ,' ') POINT
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100' AND TERM_NO ='200402'
ORDER BY POINT DESC, 1;                                     

--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �̸� ������ ������ �����Ͽ� ����ϴ� SQL ����
--�ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY 2;

--7. �� ������б��� ���� �̸��� ������ �а� �̸��� �а� �̸� ������ ������ ����ϴ�
--SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_DEPARTMENT
LEFT JOIN TB_CLASS USING(DEPARTMENT_NO)
ORDER BY 2;

--8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
--�ۼ��Ͻÿ�.

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_PROFESSOR
JOIN TB_CLASS_PROFESSOR USING(PROFESSOR_NO)
JOIN TB_CLASS USING(CLASS_NO);



--9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿�
--�ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_PROFESSOR P
JOIN TB_CLASS_PROFESSOR CP ON(P.PROFESSOR_NO = CP.PROFESSOR_NO)
JOIN TB_CLASS C ON(CP.CLASS_NO = C.CLASS_NO)
WHERE P.DEPARTMENT_NO IN (SELECT DEPARTMENT_NO
                                            FROM TB_DEPARTMENT
                                            WHERE CATEGORY = '�ι���ȸ');
                                      

--10. �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�", 
--"��ü ����"�� ������ ���� ����(������ �����ϸ� �й� ����)�� ����ϴ� SQL ������
--�ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ������.)
SELECT STUDENT_NO �й�, STUDENT_NAME "�л� �̸�", ROUND(AVG(POINT), 1) "��ü ����"
FROM tb_student
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                            FROM TB_DEPARTMENT
                                            WHERE DEPARTMENT_NAME = '�����а�')
GROUP BY STUDENT_NO, STUDENT_NAME                                      
ORDER BY 3 DESC, 1;

--11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
--���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
--�ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
--��µǵ��� ����.
SELECT DEPARTMENT_NAME �а��̸�, STUDENT_NAME �л��̸�, PROFESSOR_NAME ���������̸�
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

--12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸦ �̸�
--������ ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE CLASS_NAME = '�ΰ������' 
AND TERM_NO LIKE '2007%'
--SUBSTR(TERM_NO,1,4) = 2007;
ORDER BY 1;

--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
                                                                                                                                                                                        
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_PROFESSOR P
LEFT JOIN TB_CLASS_PROFESSOR CP ON(P.PROFESSOR_NO = CP.PROFESSOR_NO)
RIGHT JOIN TB_CLASS C ON (CP.CLASS_NO = C.CLASS_NO)
JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE C.DEPARTMENT_NO IN  (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE CATEGORY = '��ü��')                           
AND P.PROFESSOR_NO IS NULL;

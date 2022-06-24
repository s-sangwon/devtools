--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
--������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
--ǥ�õǵ��� ����.)

SELECT STUDENT_NO �й�, STUDENT_NAME �̸�, 
            TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD') ���г⵵
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;
--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
--�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
--������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
--WHERE LENGTH(PROFESSOR_NAME) != 3; 
WHERE PROFESSOR_NAME NOT LIKE '___'; --�Ѵٰ���
-- ���� �α���

--3. �� ������б��� ���� �������� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. �� �̶�
--���̰� ���� ������� ���� ��� ����(���̰� ���ٸ� �̸��� ������ ����)�� ȭ�鿡
--��µǵ��� ����ÿ�. (��, ���� �� 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�"
--���� ����. ���̴� ���������� �������.)
SELECT PROFESSOR_NAME �����̸�,  (EXTRACT(YEAR FROM SYSDATE)-(SUBSTR(professor_ssn,1,2) +1900))
FROM TB_PROFESSOR
WHERE SUBSTR(professor_ssn,8,1) IN(1,3)
ORDER BY (EXTRACT(YEAR FROM SYSDATE)-(SUBSTR(professor_ssn,1,2) +1900)), �����̸�;

--4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
--?�̸� �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME,2) �̸�
FROM TB_PROFESSOR;

--5. �� ������б��� ����� ������ �й��� �̸��� ǥ���Ͻÿ�.(�̶�, 19 �쿡 �����ϸ�
--����� ���� ���� ������ �A��)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM entrance_date) - TO_CHAR(TO_DATE(SUBSTR(student_ssn,1,6), 'RRMMDD'), 'YYYY')> 19
ORDER BY 1;
-- ���г⵵ - �����

--6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE('2020/12/25', 'YYYY/MM/DD' ), 'DY')
FROM DUAL;
-- �ݿ���

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
--�� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'), 
--TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����?
-- 2099�� 10�� 11��        2049�� 10�� 11��
-- 1999�� 10�� 11��        2049�� 10�� 11��
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'), 'YYYYMMDD'),
            TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'), 'YYYYMMDD'),
            TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'), 'YYYYMMDD'),
            TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'), 'YYYYMMDD')
FROM DUAL;

--8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
--�̠� �й��� ���� �л����� �й��� �̸��� �й� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT STUDENT_NO LIKE 'A%'
ORDER BY 1;

--9. �й��� A517178 �� ���Ƹ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
--�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
--�ڸ������� ǥ������.
SELECT  ROUND(AVG(POINT),1) ����
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
--��µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO �а���ȣ, COUNT(*) "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
--�ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
--�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
--�Ҽ��� ���� �� �ڸ������� ǥ������.
SELECT SUBSTR(TERM_NO,1,4) �⵵, ROUND(AVG(POINT), 1) "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

--13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO �а��ڵ��, 
                    SUM(CASE ABSENCE_YN
                                WHEN 'Y' THEN 1
                                WHEN 'N' THEN 0
                            END) "���л� �� "
                        , COUNT(DECODE(ABSENCE_YN, 'Y', 'EXIST'))
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL 
--������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME �����̸�, COUNT(STUDENT_NAME) "������ ��"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) <> 1;
                    
--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
--������ �⵵ ������ ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
--�ݿø��Ͽ� ǥ������.)
SELECT SUBSTR(TERM_NO,1,4) �⵵, SUBSTR(TERM_NO,5,2) �б�, ROUND(AVG(POINT), 1) ����
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2));
                    

-- homework06_�����.sql

-- DML
--4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, 
--�ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� ����)      
SELECT DEPARTMENT_NAME, CAPACITY
FROM TB_DEPARTMENT;

UPDATE TB_DEPARTMENT
SET capacity = ROUND(CAPACITY*1.1);

SELECT DEPARTMENT_NAME, CAPACITY
FROM TB_DEPARTMENT;

ROLLBACK;

--5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ�
--����. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT WHERE STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21 '
WHERE STUDENT_NO = 'A413042';

SELECT * FROM TB_STUDENT WHERE STUDENT_NO = 'A413042';
ROLLBACK;

--6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ��
--�����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_SSN FROM TB_STUDENT;

UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

SELECT STUDENT_SSN FROM TB_STUDENT;
ROLLBACK;

--7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������
--�߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش�
--������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.
--������
SELECT TERM_NO, POINT
FROM TB_GRADE 
WHERE STUDENT_NO =
    (SELECT STUDENT_NO
     FROM TB_STUDENT
     LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     JOIN TB_CLASS USING (DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '���а�' AND STUDENT_NAME = '�����' AND CLASS_NAME = '�Ǻλ�����')
     AND TERM_NO = '200501' ;  
--����
UPDATE TB_GRADE
SET POINT = 3.5
WHERE STUDENT_NO =      
            (SELECT STUDENT_NO
            FROM TB_STUDENT
            LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
            JOIN TB_CLASS USING (DEPARTMENT_NO)
            WHERE DEPARTMENT_NAME = '���а�' AND STUDENT_NAME = '�����' AND CLASS_NAME = '�Ǻλ�����')
            AND TERM_NO = '200501';                                       
--������
SELECT TERM_NO, POINT
FROM TB_GRADE 
WHERE STUDENT_NO =      
    (SELECT STUDENT_NO
     FROM TB_STUDENT
     LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     JOIN TB_CLASS USING (DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '���а�' AND STUDENT_NAME = '�����' AND CLASS_NAME = '�Ǻλ�����')
    AND TERM_NO = '200501' ;                                       

ROLLBACK;

--8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�
SELECT * FROM TB_GRADE; -- 5036

DELETE TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO
                                    FROM TB_STUDENT
                                    WHERE ABSENCE_YN = 'Y'); --483�� ����
                                    
SELECT * FROM TB_GRADE;      -- 4553        

ROLLBACK;

--DDL 10~15��
-- DDL 15���� 2006~ 2009����

--10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� ����. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS
SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, STUDENT_ADDRESS
FROM TB_STUDENT;

SELECT * FROM "VW_�л��Ϲ�����";

--11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� ��������. 
--�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
--�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT 
--���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
CREATE OR REPLACE VIEW VW_�������
AS
SELECT STUDENT_NAME �л��̸�, DEPARTMENT_NAME �а��̸�, PROFESSOR_NAME ���������̸�
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
ORDER BY DEPARTMENT_NAME;

SELECT * FROM "VW_�������";

--12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
CREATE OR REPLACE VIEW VW_�а����л���
AS
SELECT DEPARTMENT_NAME, COUNT(*) STUDENT_COUNT
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_�а����л���;

--13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
--�̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.

UPDATE VW_�л��Ϲ�����
SET �л��̸� = '�����'
WHERE �й� = 'A213046';

SELECT * FROM VW_�л��Ϲ����� WHERE �й� = 'A213046';

--14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW ��
--��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS
SELECT STUDENT_NO �й�, STUDENT_NAME �л��̸�, STUDENT_ADDRESS
FROM TB_STUDENT
WITH READ ONLY;

SELECT * FROM "VW_�л��Ϲ�����";

UPDATE VW_�л��Ϲ�����
SET �л��̸� = '�����'
WHERE �й� = 'A213046';

--15. �� ������б��� �ų� ������û ��A�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
--������ �ǰ� �ִ�. �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������
--�ۼ��غ��ÿ�. 2006~2009����
CREATE OR REPLACE VIEW V_CMOST(����, �����ȣ, �����̸�, "������������(��)")
AS
SELECT ROWNUM, �����ȣ, �����̸�, "������������(��)"
FROM
    (SELECT CLASS_NO �����ȣ, CLASS_NAME �����̸�, COUNT(*) "������������(��)"
    FROM TB_STUDENT
    JOIN TB_GRADE USING (STUDENT_NO)
    JOIN TB_CLASS USING (CLASS_NO)
    WHERE SUBSTR(TERM_NO, 1, 4) <= 2009 AND SUBSTR(TERM_NO, 1, 4) >= 2006
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY 3 DESC) CCOUNT;
--WHERE ROWNUM <= 3;

SELECT �����ȣ, �����̸�, "������������(��)"
FROM V_CMOST
WHERE ROWNUM <= 3;

-- DDL �� ����

--14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸���
--�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
--ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
--ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����.
SELECT STUDENT_NAME �л��̸�, NVL(PROFESSOR_NAME, '�������� ������') ��������
FROM TB_STUDENT
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE TB_STUDENT.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                        FROM TB_DEPARTMENT
                                        WHERE DEPARTMENT_NAME = '���ݾƾ��а�')
ORDER BY STUDENT_NO;                                        

--15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
--�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO �й�, STUDENT_NAME �̸�, DEPARTMENT_NAME "�а� �̸�", AVG(POINT) ����
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0
ORDER BY 1;

--16. �Q�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_GRADE
JOIN TB_CLASS USING (CLASS_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = 'ȯ�������а�')
AND CLASS_TYPE LIKE '%����%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

--17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ�
--SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                        FROM TB_STUDENT
                                        WHERE STUDENT_NAME = '�ְ���');

--18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ����
--�ۼ��Ͻÿ�.

SELECT STUDENT_NO, STUDENT_NAME --, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = '������а�')
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) >= ALL (SELECT  AVG(POINT)
                                                FROM TB_STUDENT
                                                JOIN TB_GRADE USING(STUDENT_NO)
                                                WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                                                                          FROM TB_DEPARTMENT
                                                                                          WHERE DEPARTMENT_NAME = '������а�')
                                                GROUP BY STUDENT_NO, STUDENT_NAME);

--19. �� ������б��� "�Q�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������
--�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
--"��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ���
--����.
SELECT DEPARTMENT_NAME "�迭 �а���", ROUND(AVG(POINT),1) ��������
FROM TB_GRADE
LEFT JOIN TB_CLASS USING(CLASS_NO)
LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY =(SELECT CATEGORY
                                FROM TB_DEPARTMENT
                                WHERE DEPARTMENT_NAME = 'ȯ�������а�')
AND CLASS_TYPE LIKE '%����%'                                
GROUP BY DEPARTMENT_NAME                               
ORDER BY 1;

--
--WHERE DEPARTMENT_NO IN (SELECT DEPARTMENT_NO
--                                        FROM TB_DEPARTMENT
--                                        WHERE CATEGORY =(SELECT CATEGORY
--                                                                        FROM TB_DEPARTMENT
--                                                                        WHERE DEPARTMENT_NAME = 'ȯ�������а�'))
--GROUP BY                                                                        
--
--
--SELECT DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE CATEGORY =(SELECT CATEGORY
--                                FROM TB_DEPARTMENT
--                                WHERE DEPARTMENT_NAME = 'ȯ�������а�'); -- ȯ�������а� �� ���� �迭�� �а���ȣ��

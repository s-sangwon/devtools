-- homework06_서상원.sql

-- DML
--4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용핛 SQL 문을 작성하시오. (단, 
--반올림을 사용하여 소수점 자릿수는 생기지 않도록 핚다)      
SELECT DEPARTMENT_NAME, CAPACITY
FROM TB_DEPARTMENT;

UPDATE TB_DEPARTMENT
SET capacity = ROUND(CAPACITY*1.1);

SELECT DEPARTMENT_NAME, CAPACITY
FROM TB_DEPARTMENT;

ROLLBACK;

--5. 학번 A413042 인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경되었다고
--핚다. 주소지를 정정하기 위해 사용핛 SQL 문을 작성하시오.
SELECT * FROM TB_STUDENT WHERE STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21 '
WHERE STUDENT_NO = 'A413042';

SELECT * FROM TB_STUDENT WHERE STUDENT_NO = 'A413042';
ROLLBACK;

--6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로
--결정하였다. 이 내용을 반영핛 적젃핚 SQL 문장을 작성하시오.
SELECT STUDENT_SSN FROM TB_STUDENT;

UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

SELECT STUDENT_SSN FROM TB_STUDENT;
ROLLBACK;

--7. 의학과 김명훈 학생은 2005 년 1 학기에 자신이 수강핚 '피부생리학' 점수가
--잘못되었다는 것을 발견하고는 정정을 요청하였다. 담당 교수의 확인 받은 결과 해당
--과목의 학점을 3.5 로 변경키로 결정되었다. 적젃핚 SQL 문을 작성하시오.
--수정전
SELECT TERM_NO, POINT
FROM TB_GRADE 
WHERE STUDENT_NO =
    (SELECT STUDENT_NO
     FROM TB_STUDENT
     LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     JOIN TB_CLASS USING (DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '의학과' AND STUDENT_NAME = '김명훈' AND CLASS_NAME = '피부생리학')
     AND TERM_NO = '200501' ;  
--수정
UPDATE TB_GRADE
SET POINT = 3.5
WHERE STUDENT_NO =      
            (SELECT STUDENT_NO
            FROM TB_STUDENT
            LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
            JOIN TB_CLASS USING (DEPARTMENT_NO)
            WHERE DEPARTMENT_NAME = '의학과' AND STUDENT_NAME = '김명훈' AND CLASS_NAME = '피부생리학')
            AND TERM_NO = '200501';                                       
--수정후
SELECT TERM_NO, POINT
FROM TB_GRADE 
WHERE STUDENT_NO =      
    (SELECT STUDENT_NO
     FROM TB_STUDENT
     LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     JOIN TB_CLASS USING (DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '의학과' AND STUDENT_NAME = '김명훈' AND CLASS_NAME = '피부생리학')
    AND TERM_NO = '200501' ;                                       

ROLLBACK;

--8. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오
SELECT * FROM TB_GRADE; -- 5036

DELETE TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO
                                    FROM TB_STUDENT
                                    WHERE ABSENCE_YN = 'Y'); --483행 삭제
                                    
SELECT * FROM TB_GRADE;      -- 4553        

ROLLBACK;

--DDL 10~15번
-- DDL 15번은 2006~ 2009까지

--10. 춘 기술대학교 학생들의 정보맊이 포함되어 있는 학생일반정보 VIEW 를 맊들고자 핚다. 
--아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오.
CREATE OR REPLACE VIEW VW_학생일반정보
AS
SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS
FROM TB_STUDENT;

SELECT * FROM "VW_학생일반정보";

--11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행핚다. 
--이를 위해 사용핛 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 맊드시오.
--이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT 
--맊을 핛 경우 학과별로 정렬되어 화면에 보여지게 맊드시오.)
CREATE OR REPLACE VIEW VW_지도면담
AS
SELECT STUDENT_NAME 학생이름, DEPARTMENT_NAME 학과이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
ORDER BY DEPARTMENT_NAME;

SELECT * FROM "VW_지도면담";

--12. 모든 학과의 학과별 학생 수를 확인핛 수 있도록 적젃핚 VIEW 를 작성해 보자.
CREATE OR REPLACE VIEW VW_학과별학생수
AS
SELECT DEPARTMENT_NAME, COUNT(*) STUDENT_COUNT
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_학과별학생수;

--13. 위에서 생성핚 학생일반정보 View 를 통해서 학번이 A213046 인 학생의 이름을 본인
--이름으로 변경하는 SQL 문을 작성하시오.

UPDATE VW_학생일반정보
SET 학생이름 = '서상원'
WHERE 학번 = 'A213046';

SELECT * FROM VW_학생일반정보 WHERE 학번 = 'A213046';

--14. 13 번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW 를
--어떻게 생성해야 하는지 작성하시오.
CREATE OR REPLACE VIEW VW_학생일반정보
AS
SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS
FROM TB_STUDENT
WITH READ ONLY;

SELECT * FROM "VW_학생일반정보";

UPDATE VW_학생일반정보
SET 학생이름 = '서상원'
WHERE 학번 = 'A213046';

--15. 춘 기술대학교는 매년 수강신청 기갂맊 되면 특정 인기 과목들에 수강 신청이 몰려
--문제가 되고 있다. 최근 3 년을 기준으로 수강인원이 가장 맋았던 3 과목을 찾는 구문을
--작성해보시오. 2006~2009까지
CREATE OR REPLACE VIEW V_CMOST(순위, 과목번호, 과목이름, "누적수강생수(명)")
AS
SELECT ROWNUM, 과목번호, 과목이름, "누적수강생수(명)"
FROM
    (SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
    FROM TB_STUDENT
    JOIN TB_GRADE USING (STUDENT_NO)
    JOIN TB_CLASS USING (CLASS_NO)
    WHERE SUBSTR(TERM_NO, 1, 4) <= 2009 AND SUBSTR(TERM_NO, 1, 4) >= 2006
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY 3 DESC) CCOUNT;
--WHERE ROWNUM <= 3;

SELECT 과목번호, 과목이름, "누적수강생수(명)"
FROM V_CMOST
WHERE ROWNUM <= 3;

-- DDL 앞 문제

--14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 핚다. 학생이름과
--지도교수 이름을 찾고 맊일 지도 교수가 없는 학생일 경우 "지도교수 미지정?으로
--표시하도록 하는 SQL 문을 작성하시오. 단, 출력헤더는 ?학생이름?, ?지도교수?로
--표시하며 고학번 학생이 먼저 표시되도록 핚다.
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE TB_STUDENT.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                        FROM TB_DEPARTMENT
                                        WHERE DEPARTMENT_NAME = '서반아어학과')
ORDER BY STUDENT_NO;                                        

--15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과
--이름, 평점을 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", AVG(POINT) 평점
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0
ORDER BY 1;

--16. 홖경조경학과 젂공과목들의 과목 별 평점을 파악핛 수 있는 SQL 문을 작성하시오.
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_GRADE
JOIN TB_CLASS USING (CLASS_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = '환경조경학과')
AND CLASS_TYPE LIKE '%전공%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

--17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는
--SQL 문을 작성하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                        FROM TB_STUDENT
                                        WHERE STUDENT_NAME = '최경희');

--18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을
--작성하시오.

SELECT STUDENT_NO, STUDENT_NAME --, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = '국어국문학과')
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) >= ALL (SELECT  AVG(POINT)
                                                FROM TB_STUDENT
                                                JOIN TB_GRADE USING(STUDENT_NO)
                                                WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                                                                          FROM TB_DEPARTMENT
                                                                                          WHERE DEPARTMENT_NAME = '국어국문학과')
                                                GROUP BY STUDENT_NO, STUDENT_NAME);

--19. 춘 기술대학교의 "홖경조경학과"가 속핚 같은 계열 학과들의 학과 별 젂공과목 평점을
--파악하기 위핚 적젃핚 SQL 문을 찾아내시오. 단, 출력헤더는 "계열 학과명", 
--"젂공평점"으로 표시되도록 하고, 평점은 소수점 핚 자리까지맊 반올림하여 표시되도록
--핚다.
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT),1) 전공평점
FROM TB_GRADE
LEFT JOIN TB_CLASS USING(CLASS_NO)
LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY =(SELECT CATEGORY
                                FROM TB_DEPARTMENT
                                WHERE DEPARTMENT_NAME = '환경조경학과')
AND CLASS_TYPE LIKE '%전공%'                                
GROUP BY DEPARTMENT_NAME                               
ORDER BY 1;

--
--WHERE DEPARTMENT_NO IN (SELECT DEPARTMENT_NO
--                                        FROM TB_DEPARTMENT
--                                        WHERE CATEGORY =(SELECT CATEGORY
--                                                                        FROM TB_DEPARTMENT
--                                                                        WHERE DEPARTMENT_NAME = '환경조경학과'))
--GROUP BY                                                                        
--
--
--SELECT DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE CATEGORY =(SELECT CATEGORY
--                                FROM TB_DEPARTMENT
--                                WHERE DEPARTMENT_NAME = '환경조경학과'); -- 환경조경학과 가 속한 계열의 학과번호들

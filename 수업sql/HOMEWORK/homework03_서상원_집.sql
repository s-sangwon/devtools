--1. 2001 년에 입학 한 사학과 학생이 몇 명인지 학생수를 조회하시오. 사학과 코드는 TB_DEPARTMENT 에서
--검색한다. (Join 을 사용하지 않는다.)
--SELECT  DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE DEPARTMENT_NAME = '사학과';

SELECT COUNT(*) 학생수
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) = 2001
AND DEPARTMENT_NO = (SELECT  DEPARTMENT_NO
                                        FROM TB_DEPARTMENT
                                        WHERE DEPARTMENT_NAME = '사학과') ;

--2. 계열이 ‘공학’인 학과 중 입학정원이 20 명 이상, 30 명 이하인 학과의 계열, 학과이름, 정원을 조회하시오. 
--단 학과이름을 기준으로 오름차순 정렬하시오.”
SELECT CATEGORY 계열, DEPARTMENT_NAME 학과이름, CAPACITY 정원
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '%공학%' 
AND CAPACITY BETWEEN 20 AND 30
ORDER BY 학과이름 ASC;
--
--3. ‘학’자가 들어간 계열의 소속 학과가 몇 개 있는지 계열, 학과수를 출력하시오. 단 학과수가 많은 순으로
--정렬하시오.
SELECT CATEGORY 계열, COUNT(*) 학과수
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '%학%' 
GROUP BY CATEGORY
ORDER BY 학과수 DESC;

--4. ‘영어영문학과’ 교수이름, 출생년도, 주소를 조회하고 나이가 많은 순으로 정렬하시오. 영어영문학과 코드는
--TB_DEPARTMENT 에서 검색한다. (Join 을 사용하지 않는다.)
SELECT PROFESSOR_NAME 교수이름, SUBSTR(PROFESSOR_SSN, 1, 2) 출생년도, professor_address 주소
FROM tb_professor
WHERE department_no = (SELECT DEPARTMENT_NO
                                     FROM TB_DEPARTMENT
                                     WHERE DEPARTMENT_NAME = '영어영문학과')
ORDER BY 2;

--SELECT DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE DEPARTMENT_NAME = '영어영문학과';

--5. 국어국문학과 학생 중 서울에 거주하는 학생의 학과번호, 학생이름, 휴학여부를 조회하고 학생이름으로
--오름차순 정렬하시오. 단 휴학여부는 값이 ‘Y’이면 ‘휴학’으로 ‘N’이면 ‘정상’으로 출력한다. 국어국문학과
--코드는 TB_DEPARTMENT 에서 찾는다. (Join 을 사용하지 않는다)
--SELECT DEPARTMENT_NO
--FROM TB_DEPARTMENT
--WHERE DEPARTMENT_NAME = '국어국문학과'; --SUB QUERY

SELECT department_no 학과번호, student_name 학생이름, DECODE(absence_yn, 'Y', '휴학', '정상') 휴학여부
FROM TB_STUDENT
WHERE department_no = (SELECT DEPARTMENT_NO
                                        FROM TB_DEPARTMENT
                                        WHERE DEPARTMENT_NAME = '국어국문학과')
AND SUBSTR(STUDENT_ADDRESS, 1, 2) = '서울'                                         
ORDER BY 2;
--6. 80 년생인 여학생 중 성이 ‘김’씨인 학생의 주민번호, 학생이름을 조회하시오. 단 학생이름으로 오름차순
--정렬하시오.
SELECT '[' || RPAD(SUBSTR(STUDENT_SSN,1,8), 14, '*') || ']' "[주민번호]", STUDENT_NAME 학생이름
FROM tb_student
WHERE STUDENT_SSN LIKE '80%'
AND SUBSTR(STUDENT_SSN, 8, 1) = 2
AND STUDENT_NAME LIKE '김%'
ORDER BY 학생이름;


--7. 계열이 ‘예체능’인 학과의 정원을 기준으로 40 명 이상이면 ‘대강의실’, 30 명 이상이면 ‘중강의실’, 30 명
--미만이면 ‘소강의실’로 출력한다. 단, 정원이 많은 순으로 정렬 한다.
SELECT department_name 학과이름, capacity 정원, CASE 
                                                                            WHEN CAPACITY >= 40 THEN '대강의실'
                                                                            WHEN CAPACITY >= 30 THEN '중강의실'
                                                                            ELSE '소강의실'
                                                                            END 강의실크기
FROM  TB_DEPARTMENT
WHERE CATEGORY = '예체능'
ORDER BY 정원 DESC;

--SELECT *
--FROM TB_DEPARTMENT
--WHERE CATEGORY = '예체능';
--8. 주소지가 ‘경기’ 또는 ‘인천’인 학생 중 1900년대에 입학 한 학생들을 조회 하고자 한다. 오늘날짜를 기준
--으로 입학 후 기간을 계산하여 입학 후 기간이 오래된 순으로 정렬 한다. (단 입학 후 기간의 단위는 년(年)으
--로 하고, 소수점 이하 자리는 버린다. 또한 입학 후 기간이 같을 경우 이름으로 오름차순 정렬한다.)
SELECT STUDENT_NAME 학과이름, TO_CHAR(ENTRANCE_DATE, 'YY "년" MM "월" DD "일"') 입학일자, 
            FLOOR(MONTHS_BETWEEN(SYSDATE, ENTRANCE_DATE) / 12) "입학후기간(년)"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '경기%' OR STUDENT_ADDRESS LIKE '인천%')
AND EXTRACT(YEAR FROM ENTRANCE_DATE) >= 1900 
AND EXTRACT(YEAR FROM ENTRANCE_DATE) < 2000
ORDER BY FLOOR(MONTHS_BETWEEN(SYSDATE, ENTRANCE_DATE) / 12) DESC, STUDENT_NAME;


--9. 학과별 서울에 거주하는 교수 중 나이가 가장 적은 교수의 나이를 조회한다. 단, 나이가 적은 순으로 정렬
--한다.
SELECT department_no 학과번호, EXTRACT(YEAR FROM SYSDATE) - (Max(SUBSTR(PROFESSOR_SSN,1,2)) + 1900) 나이
--EXTRACT(YEAR FROM TO_DATE(MAX(SUBSTR(PROFESSOR_SSN,1,6)), 'RRMMDD' )
FROM tb_professor
WHERE professor_address LIKE '서울%'
GROUP BY department_no
ORDER BY 2;

--SELECT department_no, MAX(SUBSTR(PROFESSOR_SSN,1,2))
--FROM tb_professor
--WHERE professor_address LIKE '서울%'
--GROUP BY department_no
--ORDER BY 2 DESC;

--10. 2005년1월1일부터 2006년12월31일까지의 기간에 입학한 학생 중 주소가 등록되지 않은 남학생의 학과번
--호, 학생이름, 지도교수번호, 입학년도를 조회하시오. 입학년도를 기준으로 오름차순 정렬한다
SELECT department_no 학과번호, STUDENT_NAME 이름, coach_professor_no 지도교수번호, TO_CHAR(entrance_date, 'YYYY "년"') 입학년도
FROM TB_STUDENT
WHERE entrance_date >= '05/01/01' AND entrance_date <= '06/12/31'
AND student_address IS NULL
AND SUBSTR(STUDENT_SSN, 8, 1) = '1'
ORDER BY entrance_date;
--11. 다음조건에 맞는 데이터를 조회 하시오.
--? “서가람” 학생의 지도 교수가 지도한 학생들의 년도 별 평점을 표시하는 구문을 작성한다.
--? 평점은 소수점 1 자리까지만 반올림하여 표시 한고 년도를 최근 순으로 정렬 한다.
SELECT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT),1) 평점
FROM tb_student 
LEFT JOIN tb_professor ON COACH_PROFESSOR_NO = PROFESSOR_NO
LEFT JOIN tb_GRADE USING(STUDENT_NO)
WHERE COACH_PROFESSOR_NO = 'P095'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 년도 DESC;

--SELECT COACH_PROFESSOR_NO
--FROM tb_student 
--LEFT JOIN tb_professor ON COACH_PROFESSOR_NO = PROFESSOR_NO
--WHERE STUDENT_NAME = '서가람';  -- 서가람 학생의 지도교수 노현주 P095   sub

--12. 아래 조건에 맞는 내용을 검색 하시오. 
--? 전체 남학생 중 휴학한 학생의 입학 일자를 조회한다.
--? 입학일자가 2001 년 1 월 1 일(포함)부터 현재까지(포함)인 학생만 표시하는 구문을 작성한다.
--? 입학 일자가 최근 순으로 정렬한다
SELECT DEPARTMENT_NAME 학과명, STUDENT_NAME 학생명 ,ENTRANCE_DATE 입학일자
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE SUBSTR(STUDENT_SSN, 8, 1) IN(1,3) AND ABSENCE_YN = 'Y'
AND ENTRANCE_DATE >= '2001/01/01'
AND ENTRANCE_DATE <= SYSDATE
ORDER BY 3 DESC;


--13. 아래 조건에 맞는 내용을 검색 하시오
--? 과목을 하나도 배정 받지 못한 교수가 지도교수인 학생수를 표시하는 구문을 작성한다.
SELECT PROFESSOR_NAME 지도교수, COUNT(*) 학생수
FROM TB_PROFESSOR
LEFT JOIN TB_CLASS_PROFESSOR USING(PROFESSOR_NO)
LEFT JOIN TB_STUDENT ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE CLASS_NO IS NULL -- 과목을 하나도 배정받지 못한 교수들
GROUP BY PROFESSOR_NAME;

--14. 다음조건에 맞는 데이터를 조회 하시오.
--? “공학”계열의 학생들 중 2009 년도 평점 이 4.0 이상인 학생을 표시하는 구문을 작성한다.
--? 평점은 소수점 1 자리까지만 반올림하여 표시 한다.
--? 점수가 높은 순으로 정렬 하고 같으면 학생이름순(가나다순)으로 정렬 한다

--
--SELECT STUDENT_NAME, TERM_NO, ROUND( AVG(POINT), 1) 평점
--FROM TB_STUDENT
--LEFT JOIN TB_GRADE USING(STUDENT_NO)
--LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
--WHERE CATEGORY = '공학' AND SUBSTR(TERM_NO,1,4) = 2009 --AND POINT>= 4.0
--GROUP BY STUDENT_NAME, TERM_NO
--HAVING ROUND( AVG(POINT), 1) >= 4.0; -- 2009년도 평점이 4.0 이상인 학생들


SELECT STUDENT_NAME 학생이름, TERM_NO 학기, ROUND( AVG(POINT), 1) 학점
FROM TB_STUDENT
LEFT JOIN TB_GRADE USING(STUDENT_NO)
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE STUDENT_NAME IN (SELECT STUDENT_NAME
                                        FROM TB_STUDENT
                                        LEFT JOIN TB_GRADE USING(STUDENT_NO)
                                        LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                                        WHERE CATEGORY = '공학' AND SUBSTR(TERM_NO,1,4) = 2009 --AND POINT>= 4.0
                                        GROUP BY STUDENT_NAME, TERM_NO
                                        HAVING ROUND( AVG(POINT), 1) >= 4.0)
GROUP BY STUDENT_NAME, TERM_NO
ORDER BY 학점 DESC, 학생이름;


--.15. 다음조건에 맞는 데이터를 조회 하시오
--? “김고운” 학생이 있는 과의 2007 년, 2008 년 학기 별 평점과
--년도 별 누적 평점, 총 평점을 표시하는 구문을 작성한다. (평점은 소수점 1 자리까지만 반올림)
SELECT SUBSTR(TERM_NO, 1, 4) 년도, SUBSTR(TERM_NO, 5, 2) 학기, ROUND( AVG(POINT), 1) 평점
FROM TB_STUDENT
LEFT JOIN TB_GRADE USING(STUDENT_NO)
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO = '034' 
AND SUBSTR(TERM_NO, 1, 4) IN('2007', '2008')
GROUP BY CUBE(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY 1;

SELECT DEPARTMENT_NO
FROM TB_STUDENT
WHERE STUDENT_NAME = '김고운'; -- 김고운 학생이 있는 과 '034'


--16. 다음조건에 맞는 데이터를 조회 하시오
--? “문학과생태학” 과목을 진행하는 과의 2004 년도 학기 별 평점과
--총 평점을 표시하는 구문을 작성한다.
--? 평점은 소수점 1 자리까지만 반올림하여 표시 한다.
--SELECT department_no
--FROM TB_CLASS
--WHERE CLASS_NAME ='문학과생태학'; -- 문학과 생태학 과목을 진행하는 과 '002'
--
--SELECT *
--FROM TB_GRADE
--LEFT JOIN TB_STUDENT USING(STUDENT_NO)
--WHERE DEPARTMENT_NO = '002' AND SUBSTR(TERM_NO, 1, 4) = '2004';  


SELECT SUBSTR(TERM_NO, 1, 4) 년도, SUBSTR(TERM_NO, 5, 2) 학기, ROUND( AVG(POINT), 1) 평점
FROM TB_STUDENT
FULL JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT department_no
                                            FROM TB_CLASS
                                            WHERE CLASS_NAME ='문학과생태학') -- = '002'
AND SUBSTR(TERM_NO, 1, 4) = '2004'                                             
GROUP BY SUBSTR(TERM_NO, 1, 4), ROLLUP(SUBSTR(TERM_NO, 5, 2));

    
--17. 학생번호가 총 7 자리이고 'A'로 시작하며 4 번째 자리 데이터가 '3'인 학생 중 지도교수의 성이 '이'씨인
--학생을 학생이름 순(가나다순)으로 표시하는 구문을 작성 하시오.
--SELECT STUDENT_NO
--FROM TB_STUDENT
--WHERE STUDENT_NO LIKE 'A__3___';    -- 학생번호가 총 7 자리이고 'A'로 시작하며 4 번째 자리 데이터가 '3'인 학생들

SELECT STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수
FROM TB_STUDENT
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO LIKE 'A__3___'
AND PROFESSOR_NAME LIKE '이%'
ORDER BY 학생이름;

--18. 다음조건에 맞는 데이터를 조회 하시오
--? “예체능”과 “의학” 계열의 모든 학과를 학과이름과 학생수로 표시하는 구문을 작성 하시오.
--? 계열이름 순(가나다순)으로 정렬 하고 같으면 학생수가 많은 순으로 정렬 한다.
SELECT CATEGORY 계열, DEPARTMENT_NAME 학과이름, CAPACITY 학생수
FROM TB_DEPARTMENT
WHERE category IN ('예체능', '의학')
ORDER BY 계열, 학생수 DESC;

SELECT CATEGORY 계열, DEPARTMENT_NAME 학과이름, COUNT(*) 학생수
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
WHERE category IN ('예체능', '의학')
GROUP BY DEPARTMENT_NAME, CATEGORY
ORDER BY 계열, 학생수 DESC;
--19. ‘행정학과’의 모든 과목을 선수 과목과 함께 과목이름순(가나다순)으로 표시하는 구문을 작성 하시오. 
--(선수과목이 없을 출력되지 않는다.)
--SELECT *
--FROM TB_CLASS
--WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
--                                          FROM TB_DEPARTMENT
--                                          WHERE DEPARTMENT_NAME = '행정학과' );

SELECT C.CLASS_NAME 과목, P.CLASS_NAME 선수과목
FROM TB_CLASS C, TB_CLASS P
WHERE C.PREATTENDING_CLASS_NO = P.CLASS_NO
AND C.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = '행정학과' );
                                          
SELECT C.CLASS_NAME 과목, P.CLASS_NAME 선수과목
FROM TB_CLASS C
JOIN TB_CLASS P ON c.preattending_class_no =P.CLASS_NO
AND C.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                          FROM TB_DEPARTMENT
                                          WHERE DEPARTMENT_NAME = '행정학과' );
--원하는 결과 과목               선수과목
--                정책사례연구    정책결정론
--                지방행정론       한국행정론
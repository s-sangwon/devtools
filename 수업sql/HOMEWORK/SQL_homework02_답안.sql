--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
--순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가
--표시되도록 한다.)
SELECT STUDENT_NO AS 학번,
       STUDENT_NAME AS 이름,
	   TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD') AS 입학년도
FROM   TB_STUDENT
WHERE  DEPARTMENT_NO='002'
ORDER BY ENTRANCE_DATE;

--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한명 있다고 한다. 그 교수의
--이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성핚 SQL
--문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
SELECT PROFESSOR_NAME , 
       PROFESSOR_SSN
FROM   TB_PROFESSOR
--WHERE  PROFESSOR_NAME NOT LIKE '___';
WHERE LENGTH(PROFESSOR_NAME) != 3;

--3. 춘 기술대학교의 남자 교수들의 이름을 출력하는 SQL 문장을 작성하시오. 단 이때
--나이가 적은 사람에서 많은 사람 순서(나이가 같다면 이름의 가나다 순서)로 화면에
--출력되도록 만드시오. (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름"
--으로 한다. 나이는 ‘만’으로 계산한다.)
SELECT PROFESSOR_NAME AS 교수이름,
       TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 
       TO_NUMBER('19' || SUBSTR(PROFESSOR_SSN, 1, 2)) AS 나이
FROM   TB_PROFESSOR
WHERE  SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2, 1;

--4.
SELECT SUBSTR(PROFESSOR_NAME, 2) AS 이름
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
TO_DATE('99/10/11', 'YY/MM/DD') : 2099년 10월 11일
TO_DATE('49/10/11', 'YY/MM/DD') : 2049년 10월 11일
TO_DATE('99/10/11', 'RR/MM/DD') : 1999년 10월 11일
TO_DATE('49/10/11', 'RR/MM/DD') : 2049년 10월 11일
*/

--8.
SELECT STUDENT_NO,
       STUDENT_NAME
FROM   TB_STUDENT
WHERE  SUBSTR(STUDENT_NO, 1, 1) <> 'A'
ORDER BY 1
;

--9. 
SELECT ROUND(AVG(POINT), 1) AS 평점 
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A517178';

--10.
SELECT DEPARTMENT_NO AS 학과번호,
       COUNT(*) AS "학생수(명)"
FROM   TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을
--작성하시오.
SELECT COUNT(*)
FROM   TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단,
--이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
--소수점 이하 한 자리까지만 표시한다.

SELECT SUBSTR(TERM_NO, 1 ,4) AS 년도,
       ROUND(AVG(POINT), 1) AS "년도 별 평점" 
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

--13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
--작성하시오.

SELECT DEPARTMENT_NO AS 학과코드명,
       SUM(CASE WHEN ABSENCE_YN ='Y' THEN 1 
			     ELSE 0 END) AS "휴학생 수"
FROM   TB_STUDENT
GROUP BY DEPARTMENT_NO
--ORDER BY 1
;

--14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 SQL
--문장을 사용하면 가능하겠는가?
SELECT STUDENT_NAME AS 동일이름,
       COUNT(*)     AS "동명인 수"
FROM   TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

--15.
SELECT SUBSTR(TERM_NO, 1, 4) AS 년도,
       SUBSTR(TERM_NO, 5, 2) AS 학기,
	   ROUND(AVG(POINT), 1) AS 평점
FROM   TB_GRADE
WHERE  STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2));



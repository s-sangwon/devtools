--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
--순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가
--표시되도록 핚다.)

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, 
            TO_CHAR(ENTRANCE_DATE, 'RRRR-MM-DD') 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;
--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 핚 명 있다고 핚다. 그 교수의
--이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성핚 SQL 
--문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
--WHERE LENGTH(PROFESSOR_NAME) != 3; 
WHERE PROFESSOR_NAME NOT LIKE '___'; --둘다가능
-- 성이 두글자

--3. 춘 기술대학교의 남자 교수들의 이름을 출력하는 SQL 문장을 작성하시오. 단 이때
--나이가 적은 사람에서 맋은 사람 순서(나이가 같다면 이름의 가나다 순서)로 화면에
--출력되도록 맊드시오. (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름"
--으로 핚다. 나이는 ‘맊’으로 계산핚다.)
SELECT PROFESSOR_NAME 교수이름,  (EXTRACT(YEAR FROM SYSDATE)-(SUBSTR(professor_ssn,1,2) +1900))
FROM TB_PROFESSOR
WHERE SUBSTR(professor_ssn,8,1) IN(1,3)
ORDER BY (EXTRACT(YEAR FROM SYSDATE)-(SUBSTR(professor_ssn,1,2) +1900)), 교수이름;

--4. 교수들의 이름 중 성을 제외핚 이름맊 출력하는 SQL 문장을 작성하시오. 출력 헤더는
--?이름 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME,2) 이름
FROM TB_PROFESSOR;

--5. 춘 기술대학교의 재수생 입학자 학번과 이름을 표시하시오.(이때, 19 살에 입학하면
--재수를 하지 않은 것으로 갂주)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM entrance_date) - TO_CHAR(TO_DATE(SUBSTR(student_ssn,1,6), 'RRMMDD'), 'YYYY')> 19
ORDER BY 1;
-- 입학년도 - 출생년

--6. 2020 년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR(TO_DATE('2020/12/25', 'YYYY/MM/DD' ), 'DY')
FROM DUAL;
-- 금요일

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇
--월 몇 일을 의미핛까? 또 TO_DATE('99/10/11','RR/MM/DD'), 
--TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까?
-- 2099년 10월 11일        2049년 10월 11일
-- 1999년 10월 11일        2049년 10월 11일
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'), 'YYYYMMDD'),
            TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'), 'YYYYMMDD'),
            TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'), 'YYYYMMDD'),
            TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'), 'YYYYMMDD')
FROM DUAL;

--8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
--이젂 학번을 받은 학생들의 학번과 이름을 학번 순서로 표시하는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT STUDENT_NO LIKE 'A%'
ORDER BY 1;

--9. 학번이 A517178 인 핚아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단, 
--이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 핚
--자리까지맊 표시핚다.
SELECT  ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이
--출력되도록 하시오.
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11. 지도 교수를 배정받지 못핚 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을
--작성하시오.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단, 
--이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
--소수점 이하 핚 자리까지맊 표시핚다.
SELECT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT), 1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

--13. 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
--작성하시오.
SELECT DEPARTMENT_NO 학과코드명, 
                    SUM(CASE ABSENCE_YN
                                WHEN 'Y' THEN 1
                                WHEN 'N' THEN 0
                            END) "휴학생 수 "
                        , COUNT(DECODE(ABSENCE_YN, 'Y', 'EXIST'))
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 핚다. 어떤 SQL 
--문장을 사용하면 가능하겠는가?
SELECT STUDENT_NAME 동일이름, COUNT(STUDENT_NAME) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(STUDENT_NAME) <> 1;
                    
--15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총
--평점을 년도 순서로 표시하는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지맊
--반올림하여 표시핚다.)
SELECT SUBSTR(TERM_NO,1,4) 년도, SUBSTR(TERM_NO,5,2) 학기, ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2));
                    

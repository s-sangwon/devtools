-- DAY4_SELECT4.sql
-- 함수 2

-- 타입(TYPE : 자료형) 변환 함수 ------------------------

-- 자동형변환(암시적변환)의 경우
-- 컴퓨터 연산 원칙 : 같은 종류의 값(DATA)끼리만 계산할 수 있다.
SELECT 25 + '10'  -- NUMBER + CHARACTER --> NUMBER + NUMBER
FROM DUAL;  -- 자동으로 CHARACTER >> NUMBER 로 변환함

SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 100;  -- CHAR = NUMBER --> CHAR = CHAR
-- NUMBER 100 >> CHAR '100' 자동 타입이 변환됨

-- 자동형변환이 안 되는 경우 >> 형변환을 명시해야 함
SELECT SYSDATE - '15/03/25' -- DATE - CHARACTER >> DATE 로 형변환 필요
FROM DUAL;

-- 명시적 형변환 : 형변환 함수 사용함
SELECT SYSDATE - TO_DATE('15/03/25')
FROM DUAL;

-- TO_CHAR() 함수 -----------------
-- 숫자(NUMBER)나 날짜(DATE)에 대해 출력 포맷(FORMAT) 설정시 사용하는 함수
-- TO_CHAR(NUMBER, FORMAT) -> 포맷이 적용된 문자열(CHARACTER)이 리턴
-- TO_CHAR(DATE, FORMAT) -> 포맷이 적용된 문자열(CHARACTER)이 리턴

-- 숫자에 포맷 적용
-- TO_CHAR(숫자리터럴 | 숫자가 기록된 컬럼명, '포맷문자나열')
-- 주로 통화단위 표시, 천단위구분자 표시, 소숫점 자릿수 표수, 지수형 표시 등

SELECT EMP_NAME 이름,
        TO_CHAR(SALARY, 'L99,999,999') 급여,
        TO_CHAR(NVL(BONUS_PCT, 0), '90.00') 보너스포인트
FROM EMPLOYEE;

-- 날짜에 포맷 적용
-- TO_CHAR('날짜리터럴' | 날짜가 기록된 컬럼명 | TO_DATE('문자'), '포맷문자들')
-- 년월일 시분초 요일 분기 등을 출력 형식 지정할 수 있음

-- 년도 출력 포맷
SELECT SYSDATE, -- NLS_DATE_FORMAT : RR/MM/DD
        TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
        TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 년도 포맷 + '임의의 출력문자'
-- 따옴표 안에서 따옴표를 사용할 때 주의 사항 : '..'..'..' 사용 못 함
-- 작은 따옴표와 큰 따옴표를 교대로 사용해야 함 : '..".."..'
SELECT SYSDATE, -- NLS_DATE_FORMAT : RR/MM/DD
        TO_CHAR(SYSDATE, 'YYYY"년"'), TO_CHAR(SYSDATE, 'RRRR"년"'),
        TO_CHAR(SYSDATE, 'YY"년"'), TO_CHAR(SYSDATE, 'RR"년"'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월(MONTH)에 대한 포맷
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY"년" MM"월"'),
        TO_CHAR(SYSDATE, 'YYYY"년" fmMM"월"'),
        TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'RM'),
        TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON')
FROM DUAL;

-- 날짜에 대한 포맷
SELECT SYSDATE,
        TO_CHAR(SYSDATE, '"1년기준" DDD "일째"'),
        TO_CHAR(SYSDATE, '"월기준" DD "일째"'),
        TO_CHAR(SYSDATE, '"1주기준" D "일째"')
FROM DUAL;

-- 분기, 요일 포맷
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'Q "분기"'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- 시, 분, 초, 오전|오후 포맷
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'HH24"시" MI"분" SS"초"'),
        TO_CHAR(SYSDATE, 'AM HH:MI:SS'),
        TO_CHAR(SYSDATE, 'PM HH24:MI:SS')
FROM DUAL;

-- 직원 정보에서 이름, 입사일 조회
-- 입사일은 포맷 적용함
-- 포맷 예 : 2021년 11월 12일 (금) 입사
SELECT EMP_NAME 이름,
        TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" "("DY") 입사"') 입사일,
        TO_CHAR(HIRE_DATE, 'YYYY"년" fmMM"월" DD"일" "("DY") 입사"') 입사일,
        TO_CHAR(HIRE_DATE, 'YYYY"년" MON DD"일" "("DY") 입사"') 입사일
FROM EMPLOYEE;

-- 날짜데이터 비교연산시 주의사항 : 
SELECT EMP_NAME 이름, 
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH:MI:SS') 입사일,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS') 입사일
FROM EMPLOYEE;
-- 한선기만 시간데이터 가지고 있음. 다른 직원들은 시간데이터가 없음

-- 날짜와 시간이 같이 기록된 경우, 비교연산시 날짜만 비교할 수 없음
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = '90/04/01'; -- '90/04/01 13:30:30' = '90/04/01'
-- 결과가 나오지 않음 : 0행

-- 해결방법 1
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'RR/MM/DD') = '90/04/01';

-- 해결방법 2
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01';

-- 해결방법 3
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
-- WHERE HIRE_DATE = '90/04/01 13:30:30';  -- ERROR
-- 이유 : DATE = CHARACTER --> DATE 로 변경 필요
WHERE HIRE_DATE = TO_DATE('90/04/01 13:30:30', 'YY/MM/DD HH24:MI:SS'); 

-- TO_DATE() 함수 -----------------------------
-- TO_DATE('문자리터럴' | 문자가 기록된 컬럼명, '각문자와매칭할포맷문자들')
-- 문자의 글자수와 포맷글자수는 반드시 같아야 함
-- TO_CHAR() 포맷과 의미가 다름

SELECT TO_DATE('20161225', 'YYYYMMDD'),
        TO_CHAR(TO_DATE('20161225', 'YYYYMMDD'), 'DY')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('20221225 152035', 'YYYYMMDD HH24:MI:SS'), 
                'YY-MM-DD DY AM HH:MI:SS')
FROM DUAL;

-- RR 와 YY 의 차이
-- 두 자리 년도를 네자리 년도로 바꿀 때
-- 현재 년도가 (22 : 50보다 작음) 일 때
-- 바꿀 년도가 50미만이면 현재 세기(2000)가 적용
-- 바꿀 년도가 50이상이면 이전세기(1900)가 적용

SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'RRRR'),
        TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE;  -- DATE 형에서 2자리를 4자리로 변경시 Y, R 아무거나 사용.

-- 현재 년도와 바꿀 년도가 둘 다 50미만이면, Y, R 아무거나 사용해도 됨
SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'RRRR-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR-MM-DD')
FROM DUAL;

-- 현재 년도가 50미만이고 바꿀 년도가 50이상일때,
-- TO_DATE() 에서 문자를 년도로 바꿀 때 Y 사용시 현재 세기(2000) 적용
-- R 사용시 이전 세기(1900) 적용됨
SELECT TO_CHAR(TO_DATE('970320', 'YYMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('970320', 'RRMMDD'), 'RRRR-MM-DD'),
        TO_CHAR(TO_DATE('970320', 'RRMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('970320', 'YYMMDD'), 'RRRR-MM-DD')
FROM DUAL;

-- 결론 : 문자를 년도로 바꿀 때 년도에 'R' 사용하면 됨

-- 기타 함수 ------------------------------

-- NVL() 함수
-- 사용형식 : NVL(컬럼명, 컬럼이 NULL일때 바꿀 값)
SELECT EMP_NAME, BONUS_PCT, DEPT_ID, JOB_ID
FROM EMPLOYEE;

SELECT EMP_NAME,
        NVL(BONUS_PCT, 0.0),
        NVL(DEPT_ID, '00'),
        NVL(JOB_ID, 'J0')
FROM EMPLOYEE;

-- NVL2() 함수
-- 사용형식 : NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼에 값이 있으면 바꿀값1로 변경하고, NULL이면 바꿀값2로 변경함

-- 직원 정보에서 보너스포인트가 0.2미만이거나 NULL 인 직원들을 조회
-- 사번, 이름, 보너스포인트, 변경보너스포인트 (별칭처리)
-- 변경보너스포인트는 값이 있으면 0.15로 바꾸고, NULL 이면 0.05로 바꿈
SELECT EMP_ID 사번, EMP_NAME 이름, BONUS_PCT 보너스포인트,
        NVL2(BONUS_PCT, 0.15, 0.05) 변경보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 OR BONUS_PCT IS NULL;

-- DECODE() 함수
/*
사용형식 : 
DECODE(계산식 | 컬럼명, 값제시, 제시값이 맞을때 선택값, ....., 값제시N, 선택값N)
DECODE(계산식 | 컬럼명, 값제시, 제시값이 맞을때 선택값, ....., 값제시N, 선택값N, 
                    제시된 값이 모두 아닐때 선택값)
파이선 프로그램의 IF~ELIF~ELIF~ELSE 구조를 가지는 함수임
자바 등에서는 SWITCH문의 동작 구조를 가지는 함수임
*/

-- 50번 부서에 소속된 직원들의 이름과 성별 조회
-- 성별 기준 : 주민번호 8번째 값이 1, 3 이면 남자, 2, 4이면 여자로 처리
SELECT EMP_NAME 이름,
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '2', '여자', '3', '남자', '4', '여자') 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50'
ORDER BY 성별, 이름; -- 성별 기준 오름차순정렬 처리

SELECT EMP_NAME 이름,
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '3', '남자', '여자') 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50'
ORDER BY 성별, 이름;

-- 직원 이름과 관리자 사번 조회
SELECT EMP_NAME, MGR_ID
FROM EMPLOYEE;

-- 관리자사번이 NULL이면 '000' 으로 바꿈
-- 1. NVL() 사용
SELECT EMP_NAME, NVL(MGR_ID, '없음')
FROM EMPLOYEE;

-- 2. DECODE() 사용
SELECT EMP_NAME, DECODE(MGR_ID, NULL, '없음', MGR_ID)
FROM EMPLOYEE;

-- 직급별 급여 인상분이 다를 때
-- DECODE() 사용한 경우
SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(DECODE(JOB_ID, 'J7', SALARY * 1.1, 
                                'J6', SALARY * 1.15,
                                'J5', SALARY * 1.2,
                                SALARY * 1.05), 'L99,999,999') 인상급여
FROM EMPLOYEE;

-- 2. CASE 표현식은 다중 IF문과 같은 동작 구조를 가짐
SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(CASE JOB_ID
                    WHEN 'J7' THEN SALARY * 1.1
                    WHEN 'J6' THEN SALARY * 1.15
                    WHEN 'J5' THEN SALARY * 1.2
                    ELSE SALARY * 1.05
                END, 'L99,999,999') 인상급여
FROM EMPLOYEE;

-- CASE 표현식 사용 2 : 
-- 직원의 급여를 등급 구분 조회
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY <= 3000000 THEN '초급'
              WHEN SALARY <= 4000000 THEN '중급'
              ELSE '고급'
        END 구분
FROM EMPLOYEE
ORDER BY 구분;  -- 정렬방식 생략되면 기본이 오름차순정렬임


--함수 연습문제 ******************************************
--
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT EMP_NAME 직원명, 
        RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 주민번호
FROM EMPLOYEE;


--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME 직원명, NVL(DEPT_ID, '없음') 직급코드, 
        TO_CHAR((SALARY + (SALARY * NVL(BONUS_PCT, 0)) * 12), 'L999,999,999') "연봉(원)"
FROM EMPLOYEE;
--
--3. 부서코드가 50, 90인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--	사번 사원명 부서코드 입사일

SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_ID 부서코드, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') AND HIRE_DATE LIKE '04/%';
--
--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--  단, 주말도 포함함
SELECT EMP_NAME 직원명, HIRE_DATE 입사일, 
        LAST_DAY(HIRE_DATE) - HIRE_DATE "입사한 달의 근무일수"
FROM EMPLOYEE;

--
--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--     ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--
SELECT EMP_NAME 직원명, DEPT_ID 부서코드,
		SUBSTR(EMP_NO, 1, 2) || '년' || 
        SUBSTR(EMP_NO, 3, 2) || '월' || 
        SUBSTR(EMP_NO, 5, 2) || '일' 생년월일,
		EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM 
                        TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) 나이
FROM EMPLOYEE;

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용
--
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------
SELECT COUNT(*) 전체직원수,
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2001, 1, 0)) "2001년",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2002, 1, 0)) "2002년",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2003, 1, 0)) "2003년",
        SUM(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 2004, 1, 0)) "2004년"
FROM EMPLOYEE;

--7.  부서코드가 50이면 총무부, 60이면 기획부, 90이면 영업부로 처리하시오.
--   단, 부서코드가 50, 60, 90 인 직원의 정보만 조회함
--  => case 사용
--	부서코드 기준 오름차순 정렬함.

SELECT DEPT_ID 부서코드, 
        CASE DEPT_ID 
            WHEN '50' THEN '총무부'
            WHEN '60' THEN '기획부'
            WHEN '90' THEN '영업부' 
        END AS "부서명"
FROM EMPLOYEE
WHERE DEPT_ID IN('50', '60', '90') 
ORDER BY DEPT_ID ASC;

-- 함수연습문제 END -------------------------------------------

-- ORDER BY 절 ****************************
-- 사용형식 : ORDER BY 정렬기준 정렬방식, 정렬기준2 정렬방식, .....
-- 사용위치 : SELECT 구문 가장 마지막에 작성함
-- 실행순서도 가장 마지막에 작동됨
-- 정렬기준 : SELECT 절에 사용된 컬럼명 | 컬럼별칭 | 컬럼나열 순번(1부터 시작함)
-- 정렬방식 : ASC(오름차순, 기본값으로 생략할 수 있음), DESC (내림차순)
-- 오름차순정렬(ASCending) : 작은값에서 큰값순으로 정렬하는 것
--      1234순, abcd순, 가나다라순
-- 내림차순정렬(DESCending) : 큰값에서 작은순으로 정렬하는 것
--      987순, zyx순, ㅎㅍㅌ순

-- 첫번째 기준으로 정렬 후에 같은 값에 대해서는 두번째 정렬기준으로 재정렬할 수 있음
-- 두번째 정렬후에 같은 값에 대해서 세번째 정렬기준으로 재정렬할 수 있음
-- 정렬 사용 횟수에는 제한이 없음

-- 직원 정보에서 부서코드가 50이거나 NULL인 직원들 조회
-- 이름, 급여
-- 급여기준 내림차순정렬하고, 같은 급여에 대해서는 이름기준 오름차순정렬함
SELECT EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL
--ORDER BY SALARY DESC, EMP_NAME ASC;
--ORDER BY 급여 DESC, 이름;
ORDER BY 2 DESC, 1;

-- 2003년 1월 1일 이후 입사한 직원 조회
-- 단, 해당 날짜는 제외함
-- 이름, 입사일, 부서코드, 급여 (별칭)
-- 부서코드 기준 내림차순정렬하고, 같은 부서코드일 때는 입사일 기준 오름차순정렬하고
-- 입사일도 같으면 이름 기준 오름차순정렬함
SELECT EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101', 'RRRRMMDD')
--ORDER BY DEPT_ID DESC, HIRE_DATE, EMP_NAME;
--ORDER BY 부서코드 DESC, 입사일, 이름;
--ORDER BY 3 DESC, 2, 1;
ORDER BY DEPT_ID DESC NULLS LAST, HIRE_DATE, EMP_NAME;

-- ORDER BY 절의 NULL 위치 조정 구문
-- ORDER BY 정렬기준 정렬방식 NULLS LAST : NULL 을 아래쪽에 배치
-- ORDER BY 정렬기준 정렬방식 NULLS FIRST : NULL 을 위에 배치

-- GROUP BY 절 *******************
-- 같은 값들이 여러 개 기록된 컬럼을 기준으로 같은 값들을 그룹으루 묶어줌
-- GROUP BY 컬럼명 | 컬럼이 사용된 계산식
-- 같은 값들을 그룹으로 묶어서, 그룹함수를 적용하기 위함
-- SELECT 절에서 GROUP BY 로 묶은 그룹별로 그룹함수 사용구문을 작성함

-- 기록값 확인
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;

-- 부서별 급여 합계 조회
SELECT DEPT_ID,
        SUM(SALARY) 부서별급여합계,
        FLOOR(AVG(SALARY)) 부서별급여평균,
        COUNT(SALARY) 부서별직원수,
        MAX(SALARY) 부서별급여큰값,
        MIN(SALARY) 부서별최저급여
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY DEPT_ID DESC NULLS LAST;

-- GROUP BY 절에는 그룹핑을 위한 계산식을 사용할 수도 있음

-- 직원 정보에서 성별별 급여합계, 급여평균(천단위에서 반올림함), 직원수 조회
-- 성별로 오름차순정렬함

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '3', '남', '여') 성별,
        SUM(SALARY) 급여합계, ROUND(AVG(SALARY), -4) 급여평균,
        COUNT(*) 직원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '3', '남', '여')
ORDER BY 성별;

-- GROUP BY 절에 사용한 컬럼명과 계산식은 SELECT 절에 표기할 수 있음

-- GROUP BY 관련 함수 --------------------

-- ROLLUP() 함수
-- GROUP BY 절에 사용함
-- 그룹별로 묶어서 계산한 결과에 대한 집계와 총집계를 표현함 (엑셀의 부분합)
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);

SELECT DEPT_ID, SUM(SALARY), FLOOR(AVG(SALARY)),
        MIN(SALARY), MAX(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);

-- 실습 : 부서코드와 직급코드를 함께 그룹을 묶고, 급여의 합계를 구함
-- NULL 제외함, ROLLUP 사용함
SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY DEPT_ID, JOB_ID
ORDER BY 1 DESC;

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID)
ORDER BY 1 DESC;

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID), ROLLUP(JOB_ID)
ORDER BY 1 DESC;

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(JOB_ID), ROLLUP(DEPT_ID)
ORDER BY 1 DESC;

-- CUBE() 함수
SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID, JOB_ID)
ORDER BY 1 DESC;



-- DAY5_SELECT5.sql
-- SELECT 추가 옵션 : HAVING 절 ~

-- HAVING 절 ---------------------------------------------------------
-- 사용위치 : GROUP BY 절 다음에 작성함
-- 사용형식 : HAVING 그룹함수(계산에 사용할 컬럼명) 비교연산자 비교값
-- 그룹별로 그룹함수 계산결과를 가지고 조건을 만족하는 값들을 골ㄹ라냄

SELECT MAX( SUM(SALARY) ) -- 부서별 급여합게중 가장 큰 값, 1개행 출력
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, MAX( SUM(SALARY) ) -- 부서별 급여합게중 가장 큰 값, 1개행 출력
FROM EMPLOYEE
GROUP BY DEPT_ID; -- 에러

SELECT DEPT_ID-- 7행
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 부서별 급여합계 중 가장 큰 값에 대한 부서코드와 급여합계를 조회
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
gROUP BY DEPT_ID
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                                        FROM EMPLOYEE
                                        GROUP BY DEPT_ID);
                                        
-- 분석함수 (윈도우 함수라고도 함) ---
-- 일반함수와 사용형식이 다름

-- RANK() 함수
-- 순위(등수) 반환

-- 1. 컬럼값에 순위를 매길 때 사용
-- RANK() OVER (ORDER BY 순위 매길 컬럼명 정렬방식)

-- 급여를 많이 받는 순으로 순위를 매긴다면
SELECT EMP_NAME, SALARY,
            RANK() OVER (ORDER BY SALARY DESC)순위
FROM EMPLOYEE;
--ORDER BY 순위;

-- 2. 지정 값의순위를 알고자 할 떄
-- RANK(순위를 알고자하는 값) WITHIN GROUP (ORDER BY 순위매길컬럼 정렬방식)

-- 급여 230만이 전체 급여중 몇 순위? (급여 내립차순정렬의 경우)
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC)
FROM EMPLOYEE;

-- ROWID
-- 테이블에 데이터 기록시(행 추가시, INSERT문) 자동으로 붙여짐
-- DBMS 가 자동으로 붙임. 수정 못 함, 조회만 할 수 있음

-- 데이터 파일에 저장된 각 행의 물리적인 위치를 나타내는 논리적인 가상 컬럼
SELECT EMP_ID, ROWID
FROM EMPLOYEE;


-- ROWNUM
-- ROWID 와 다름
-- ROWNUM은 SELECT 문 실행(작동)시 결과행에 부여되는 행번호임.(1부터 시작)

SELECT *
FROM (SELECT ROWNUM, EMP_ID, EMP_NAME, JOB_ID
            FROM EMPLOYEE
            WHERE JOB_ID = 'J5');
--TOP엔분석? 에 사용됨


-- ***************************************************************
-- 조인 (JOIN)
-- 여러 개의 테이블을 하나로 합쳐서 큰 테이블을 만들어서 컬럼을 조회함
-- 오라클 전용구문과 ANSI 표준구문으로 작성할 수 있음
-- 조인은 기본이 EQUAL JOIN 임
-- 두 테이브르이 FOREIGN KEY(외래키 | 외부키)로 연결된 컬럼값들이 일치하는
-- 행들이 연결됨

-- 오라클 전용구문 : 오라클에서만 사용함
-- FROM 절에 합칠 테이블명을 나열함
-- FROM 테이블명 별칭, 합칠테이블명 별칭, ...
-- 합칠 조건을 WHERE 절에 작성함



SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;
20 행, DEPT_ID가 NULL 인 직원 2명이 제외됨
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID);

-- 직원 이름, 부서코드, 부서명 조회
SELECT EMP_ID, E.EMP_NAME, D.DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ANSI 표준구문 
-- 모든 DBMS가 공통으로 사용하는 표준구문임
-- 조인 처리를 위한 구문을 FROM 절에 추가 작성함

SELECT *
FROM EMPLOYEE
--INNER JOIN DEPARTMENT USING(DEPT_ID); -- INNER 는 생략할 수 있음
JOIN DEPARTMENT USING(DEPT_ID); -- 조인의 기본은 INNEER EQUAL JOIN임

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);
-- 합친 결과테이블에 DEPT_ID 가 하나 존재함 (맨 앞에 표시됨)

-- 조인은 기본 EQUAL INNER JOIN 임.
-- 두 테이블의 지정하는 컬럼의 값이 EQUAL인 행들을 연결시킴
-- INNER JOIN 은 EQUAL 이 아닌 행은 제외됨
-- INNER JOIN 시 두테이블의 조인하는 컬럼며이 같을 때는 USING 사용함

SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEE
-- INNER JOIN DEPARTMENT USING (DEPT_ID)
JOIN DEPARTMENT USING(DEPT_ID)
WHERE JOB_ID = 'J6'
ORDER BY DEPT_NAME;

-- 두 테이블을 연결할 컬럼명이 다른 때는 ON 사용함
-- 단, 컬럼명만 다름 (기록된 값은 같음)
SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- 오라클 전용구문
SELECT *
FROM DEPARTMENT D, LOCATION L
WHERE D.LOC_ID = L.LOCATION_ID;

-- 사번, 이름, 직급명 조회
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID; -- 21행

SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID);

-- OUTER JOING
-- EQUAL 이 아닌 행도 조인에 포함시키고자 할 때 사용하는 조인구문
-- EQUAL JOIN 임 : 없는 행을 추가해서 일치되게 만들어서 조인함

-- EMPLOYEE 테이블의 전 직원의 정보를 조인 결과에 포함시키고자 한다면
-- 오라클 전용구문 : 값이 없는 테이블에 행을 추가하는 방식임
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);  -- LEFT JOIN

SELECT *
FROM EMPLOYEE 
-- LEFT OUTHE JOIN DEPARTMENT USING(DEPT_ID);
LEFT JOIN DEPARTMENT USING(DEPT_ID);

-- DEPARTMENT 테이블이 가진 모든 행을 조인에 포함시키려면...
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;  -- RIGHT OUTER JOIN

SELECT *
FROM EMPLOYEE 
-- LEFT OUTHE JOIN DEPARTMENT USING(DEPT_ID);
RIGHT JOIN DEPARTMENT USING(DEPT_ID);

-- 두 테이블의 일치하지 않는 모든 행을 조인에 포함하려면...
-- FULL OUTER JOIN 이라고 함

-- 오라클 전용구문은 FULL OUTER JOIN 을 작성할 수 없음
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);

SELECT *
FROM EMPLOYEE
FULL JOIN DEPARTMENT USING (DEPT_ID);

-- CROSS JOIN
-- 두 테이블을 연결할 컬럼이 없을 때 사용함
-- N 행 * M 행의 결과를 만듦

--ANSI
SELECT *
FROM LOCATION
CROSS JOIN COUNTRY;

-- 오라클 전용구문
SELECT *
FROM LOCATION, COUNTRY;

-- NATURAL JOIN
-- 테이블이 가진 PRIMARY KEY 컬럼을 이용해서 조인이 됨

SELECT *
FROM EMPLOYEE
-- JOIN DEPARTMETN USING(DEPT_ID);
NATURAL JOIN DEPARTMENT; -- PRIMARY KEY : DEPT_ID 조인에 사용됨

-- NON EQUI JOIN
-- 지정하는 컬럼의 값이 일치하는 경우가 아닌
-- 값의 범위에 해당하는 행들을 연결하는 방식의 조인임

SELECT EMP_NAME, SALARY, SLEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN
-- 같은 테이블을 두 번 조인하는 경우임
-- 같은 테이블 안에 다른 컬럼을 외래키(FOREIGN KEY)로 사용하는 경우에 이용
-- EMP_ID : 직원의 사번, MGR_ID : 관리자인 직원의 사번(EMP_ID를 참조함)
-- MGR_ID : 직원 중에 관리자인 직원을 의미함

-- 관리자가 배정된 직원의 명단과 관리자인 직원 명단 조회
-- ANSI 표준구문 : 테이블 별칭 사용해야 함. ON 사용함

SELECT EMP_NAME
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);;

-- 오라클 전용구문
SELECT *
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MGR_ID = M.EMP_ID;

SELECT E.EMP_NAME 직원명단, M.EMP_NAME 관리자명단
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);


-- N개의 테이블 조인
-- 조인 순서가 중요함
-- 첫번째와 두번째가 조인이 되고 나서, 그 결과에 세번째가 조인됨

SELECT EMP_NAME, JOB_TITLE, DEPT_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID);

SELECT *
FROM EMPLOYEE
JOIN LOCATION ON (LOC_ID = LOCATION_ID);    
JOIN DEPARTMENT USING(DEPT_ID) -- 에러 조인의 순서가 중요함


SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID);    -- ERD보고 하면 쉬움

-- 직원 이름, 직급명, 부서명, 지역명, 국가명 조회
-- 직원 전체 조회
-- ANSI 표준
SELECT EMP_NAME 직원명, JOB_TITLE 직급명, DEPT_NAME 부서명,
            LOC_DESCRIBE 지역명, COUNTRY_NAME 국가명
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING(COUNTRY_ID);

SELECT EMP_NAME 직원명, JOB_TITLE 직급명, DEPT_NAME 부서명,
            LOC_DESCRIBE 지역명, COUNTRY_NAME 국가명
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.JOB_ID = J.JOB_ID(+) AND 
E.DEPT_ID = D.DEPT_ID(+) AND 
D.LOC_ID = L.LOCATION_ID(+) AND 
L.COUNTRY_ID = C.COUNTRY_ID(+);




----------------------------------------------------------------------------
--PRACTICE

--JOIN 연습문제
--
--1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'DY')
FROM DUAL;
--
--2. 주민번호가 60년대 생이면서 성별이 여자이고, 성이 김씨인 직원들의 
--사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE E
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE SUBSTR(EMP_NO,1,2) LIKE '6%'
AND SUBSTR(EMP_NO,8,1) IN(2,4)
AND EMP_NAME LIKE '김%';

-- ORACLE
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND SUBSTR(EMP_NO,1,2) LIKE '6%'
AND SUBSTR(EMP_NO,8,1) IN(2,4)
AND EMP_NAME LIKE '김%';
--SELECT *
--FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,1,2) LIKE '6%'
--AND SUBSTR(EMP_NO,8,1) IN(2,4)
--AND EMP_NAME LIKE '김%';



--
--3. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.
SELECT EMP_ID 사번, EMP_NAME 사원명, 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) 나이,
            DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE SUBSTR(EMP_NO, 1, 2) = (SELECT MAX(SUBSTR(EMP_NO, 1, 2))
                                                FROM EMPLOYEE);
--WHERE 
SELECT MAX(SUBSTR(EMP_NO, 1, 2))
FROM EMPLOYEE;

--안되네 모가?
-- ORACLE
SELECT EMP_ID 사번, EMP_NAME 사원명, 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) 나이,
            DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND SUBSTR(EMP_NO, 1, 2) = (SELECT MAX(SUBSTR(EMP_NO, 1, 2))
                                                FROM EMPLOYEE);

--MIN() 그룹함수를 SELECT문에사용
--사용하는 요소들을 GROUP BY로 다묶어서 HAVING 절에서 비교
--
--4. 이름에 '성'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_NAME 부서명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE EMP_NAME LIKE '%성%';

--ORACLE
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_NAME 부서명
FROM EMPLOYEE E , DEPARTMENT D
--LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE E.DEPT_ID = D.DEPT_ID
AND EMP_NAME LIKE '%성%';

--
--
--5. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_ID 부서코드, DEPT_NAME 부서명
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
WHERE DEPT_NAME LIKE '해외영업%팀'
ORDER BY 3;
--
--
--6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME 사원명, BONUS_PCT 보너스포인트, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL;
--
--
--7. 부서코드가 20인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID)
JOIN JOB USING(JOB_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE DEPT_ID = '20';
--
--
--8. 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
--사원명, 직급명, 급여, 연봉을 조회하시오.
--연봉에 보너스포인트를 적용하시오.
SELECT DISTINCT E.EMP_NAME 사원명, J.JOB_TITLE 직급명, SALARY 급여 , (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 연봉
FROM EMPLOYEE E, (SELECT JOB_ID, MIN(SALARY) "MIN_SAL"
                            FROM EMPLOYEE
                            JOIN JOB USING(JOB_ID)
                            GROUP BY JOB_ID) JLIST, JOB J
WHERE E.JOB_ID = J.JOB_ID
AND E.JOB_ID = JLIST.JOB_ID AND E.SALARY > JLIST.MIN_SAL
ORDER BY 2;
--WHERE 직급명 = 직급명이고 급여 > 최소급여 것들만 조회

--SELECT DISTINCT EMP_NAME, JOB_TITLE 직급명, SALARY 급여 , (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 연봉
--FROM EMPLOYEE, ( SELECT E.JOB_ID, MIN(SALARY) AS "MIN_SAL"
--                            FROM EMPLOYEE E, JOB J
--                            WHERE E.JOB_ID = J.JOB_ID
--                            GROUP BY E.JOB_ID ) "ABC"
--LEFT JOIN JOB USING(JOB_ID)
--WHERE SALARY > ABC.MIN_SAL;

SELECT JOB_ID, MIN(SALARY) "MIN_SAL"
--,MIN((SALARY + SALARY * NVL(BONUS_PCT, 0)) *12) 최소연봉
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
GROUP BY JOB_ID;


SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여 , (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 연봉
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE (SALARY + SALARY * NVL(BONUS_PCT, 0)) *12 > MIN_SAL;

--HAVING SALARY > MIN(SALARY);
--
--
--9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--사원명(emp_name), 부서명(dept_name), 지역명(loc_describe), 국가명(country_name)을 조회하시오.
SELECT emp_name 사원명, DEPT_NAME 부서명, LOC_DESCRIBE 지역명, COUNTRY_NAME 국가명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON(LOC_ID = LOCATION_ID)
LEFT JOIN COUNTRY USING(COUNTRY_ID)
WHERE COUNTRY_NAME IN ('한국', '일본');
--
--10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
--self join 사용
SELECT DISTINCT e1.emp_name 사원명, E1.DEPT_ID 부서코드 , E2.EMP_NAME 동료이름
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.DEPT_ID = E2.DEPT_ID
AND E1.EMP_ID <> E2.EMP_ID 
--AND E1.DEPT_ID = E2.DEPT_ID 
ORDER BY 2;

SELECT e1.emp_name 사원명, E1.DEPT_ID 부서코드 , E2.EMP_NAME 동료이름
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.EMP_NAME <> E2.EMP_NAME
AND E1.DEPT_ID = E2.DEPT_ID;

--ORACLE
SELECT E.EMP_NAME 사원명, E.DEPT_ID 부서코드, C.EMP_NAME 동료이름
FROM EMPLOYEE E
JOIN EMPLOYEE C ON (E.DEPT_ID = C.DEPT_ID)
WHERE E.EMP_NAME <> C.EMP_NAME
ORDER BY 1;
--
--
--11. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
--단, join과 IN 사용할 것
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_ID)
WHERE BONUS_PCT IS NULL
AND JOB_ID IN ('J4', 'J7');
--
--12. 기혼인 직원과 미혼인 직원의 수를 조회하시오.
--SELECT SUM(DECODE(MARRIAGE, 'Y', 1))"기혼인 직원 수", SUM(DECODE(MARRIAGE, 'N', 1)) "미혼인 직원 수"
SELECT *
FROM (SELECT COUNT(*) "기혼인 직원의 수"
            FROM EMPLOYEE
            GROUP BY MARRIAGE
            HAVING MARRIAGE = 'Y') ,
            (SELECT COUNT(*) "미혼인 직원의 수"
            FROM EMPLOYEE 
            GROUP BY MARRIAGE
            HAVING MARRIAGE = 'N');
            
            
SELECT DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼') 결혼유무,
        COUNT(*) 직원수
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼')
ORDER BY 1;
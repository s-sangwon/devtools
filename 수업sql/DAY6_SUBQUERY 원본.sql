-- DAY6_SUBQUERY.sql
-- SELECT : 서브쿼리

-- 서브쿼리(내부쿼리)
-- SELECT 문 안에 사용되는 SELECT 문을 말함
/*
바깥함수(반환값이 있는 함수())
=> 안쪽 함수가 먼저 실행이 되면서 반환값을 바깥 함수가 사용함

컬럼명 비교연산자 비교값 <-- 비교값 알아내기 위한 SELECT 문을
                        바로 사용할 수 있음
컬럼명 비교연산자 (SELECT 쿼리문) <-- 내부쿼리(서브쿼리)라고 함
바깥 SELECT 문을 외부(메인) 쿼리라고 함
*/

-- 나승원과 같은 부서에 근무하는 직원 명단 조회
-- 1. 나승원의 부서코드 조회
SELECT DEPT_ID
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';  -- '50'

-- 2. 조회된 부서코드로 직원 명단 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- 서브쿼리 구문 : 
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '나승원');

-- 서브쿼리 유형
-- 단일행 서브쿼리, 다중행 서브쿼리, 다중열 서브쿼리, 다중행 다중열 서브쿼리,
-- 상[호연]관 서브쿼리, 스칼라 서브쿼리
-- 서브쿼리 유형에 따라 서브쿼리 앞에 사용되는 연산자가 다름

-- 단일행 (SINGLE ROW) 서브쿼리
-- 서브쿼리의 결과값이 1개인 경우
-- 단일행 서브쿼리 앞에는 일반 비교연산자 사용할 수 있음
-- >, <, >=, <=, =, != (^=, <>)

-- 예 : 나승원과 직급이 같으면서 나승원보다 급여를 많이 받는 직원 조회
-- 1. 나승원의 직급 조회
SELECT JOB_ID
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';  -- 'J5'

-- 2. 나승원의 급여 조회
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '나승원'; -- 2300000

-- 3. 직원 조회
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = 'J5'
AND SALARY > 2300000;

-- 서브쿼리 구문 : 
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID  -- 'J5' : 단일행(값1개) 서브쿼리
                FROM EMPLOYEE
                WHERE EMP_NAME = '나승원')
AND SALARY > (SELECT SALARY  -- 2300000 : 단일행(값1개) 서브쿼리
                FROM EMPLOYEE
                WHERE EMP_NAME = '나승원');

-- 직원 중에서 최저 급여를 받는 직원 명단 조회
-- WHERE 절에는 그룹함수 사용 못 함 => 서브쿼리로 해결
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY = MIN(SALARY);
WHERE SALARY = (SELECT MIN(SALARY)  -- 1500000 : 값 1 개(단일행)
                  FROM EMPLOYEE);

-- HAVING 절에서도 서브쿼리 사용할 수 있음
-- 예 : 부서별 급여합계 중 가장 큰값에 대한 부서명과 급여합계 조회
-- 1. 부서별 급여합계중 가장 큰 값 조회
SELECT MAX(SUM(SALARY))  -- 18100000
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 2. 조회구문 적용
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_NAME
--HAVING SUM(SALARY) = 18100000;
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))  -- 18100000 (단일행)
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);

-- 서브쿼리는 SELECT 구문 모든 절에 사용할 수 있음
-- 주로 SELECT, FROM, WHERE, HAVING 에 사용함

-- 다중열 (MULTI COLUMNS) [단일행] 서브쿼리
-- 서브쿼리가 만든 결과 행은 1개인데, 컬럼(열)이 여러 개인 경우
-- 일반 비교연산자를 서브쿼리문 앞에 사용할 수 있음 (단일행)

-- 나승원과 직급과 급여가 같은 직원 조회
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
-- 다중열 서브쿼리 결과와 비교하는 컬럼도 열(컬럼) 갯수와 항목을 맞춰야 함
-- (비교할 컬럼, 비교할 컬럼) 비교연산자 (다중열 서브쿼리)
WHERE (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '나승원');

-- 다중행 (MULTI ROWS) [단일열] 서브쿼리
-- 서브쿼리가 만든 결과행(결과값)이 여러 개인 경우
-- 다중행 서브쿼리 앞에는 일반 비교연산자(값1개와 비교) 사용 못 함 : 에러남 
-- 여러 개의 값을 비교할 수 있는 연산자를 사용해야 함 : IN, ANY, ALL

-- 예 : 각 부서별로 급여가 제일 작은 직원 정보 조회
SELECT MIN(SALARY)  -- 7행
FROM EMPLOYEE  
GROUP BY DEPT_ID; 

SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)  -- 7행 (다중행 서브쿼리)
                FROM EMPLOYEE  
                GROUP BY DEPT_ID);  -- ERROR
-- 다중행 서브쿼리 앞에 일반 비교연산자(값 1개 비교함) 사용 못 함

SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)  -- 7행 (다중행 서브쿼리)
                    FROM EMPLOYEE  
                    GROUP BY DEPT_ID); 

-- 컬럼명 IN (여러 개의 값들 | 다중행 서브쿼리)
-- 컬럼명 = 비교값1 OR 컬럼명 = 비교값2 OR 컬럼명 = 비교값3 ......
-- 컬럼값에 여러 개의 비교값과 일치하는 값이 있으면 선택

-- 컬럼명 NOT IN (여러 개의 값들 | 다중행 서브쿼리)
-- NOT 컬럼명 IN (여러 개의 값들 | 다중행 서브쿼리) 과 같음
-- NOT (컬럼명 = 비교값1 OR 컬럼명 = 비교값2 OR 컬럼명 = 비교값3 ......)
-- 컬럼값에 여러 개의 비교값과 일치하지 않는 값이 있으면 선택

-- 예 : 관리자인 직원과 관리자가 아닌 직원 정보를 별도로 조회해서 합쳐라.
-- 1. 관리자인 직원 조회
SELECT DISTINCT MGR_ID  -- 6행
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 2. 직원 정보에서 관리자만 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MGR_ID  -- 6행
                  FROM EMPLOYEE
                  WHERE MGR_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MGR_ID  -- 6행
                      FROM EMPLOYEE
                      WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;                  

-- SELECT 절에서도 서브쿼리 사용할 수 있음
-- 주로 함수계산식 안에서 사용됨

-- 위의 구문을 변경한다면
SELECT EMP_ID, EMP_NAME,
        CASE WHEN EMP_ID IN (SELECT DISTINCT MGR_ID  -- 6행
                              FROM EMPLOYEE
                              WHERE MGR_ID IS NOT NULL)
             THEN '관리자'
             ELSE '직원'
        END 구분
FROM EMPLOYEE
ORDER BY 3, 1;

-- 컬럼명 > ANY (다중행 서브쿼리) : 가장 작은 값보다 큰
-- 컬럼명 < ANY (다중행 서브쿼리) : 가장 큰 값보다 작은

-- 예 : 대리 직급의 직원 중에서 과장 직급의 급여의 최소값보다 많이 받는 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '과장');

-- 컬럼명 > ALL (다중행 서브쿼리) : 가장 큰 값보다 큰
-- 컬럼명 < ALL (다중행 서브쿼리) : 가장 작은 값보다 작은
-- 예 : 모든 과장들의 급여보다 더 많은 급여를 받는 대리 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ALL (SELECT SALARY
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '과장');

-- 서브쿼리 사용 위치 : 
-- SELECT 구문 : SELECT 절, FROM 절, WHERE 절, HAVING 절, GROUP BY절
--              ORDER BY 절 (모든 절에서 사용할 수 있음)
-- DML 구문 : INSERT 문, UPDATE 문
-- DDL 구문 : CREATE TABLE 문, CREATE VIEW 문

-- 다중열 다중행 서브쿼리
-- 자기 직급의 평균 급여를 받는 직원 조회
-- 1. 직급별 평균 급여 조회
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;
-- 실제 기록된 급여값과 평균값의 자릿수 맞추기가 필요함

-- 2. 적용
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- FROM 절에서도 서브쿼리 사용할 수 있음 : 테이블을 대신함
-- FROM (서브쿼리) 별칭 : 별칭이 테이블명을 대신함
-- 서브쿼리가 만든 결과집합(RESULT SET)을 테이블로 사용함 : 인라인 뷰라고 함

-- 참고 : 오라클 전용구문은 FROM 절에 조인할 테이블명을 나열할 때
--      테이블 별칭 지정할 수 있음
-- ANSI 표준구문의 USING 은 테이블 별칭 사용할 수 없음
-- ANSI 표준구문에서 테이블의 별칭 사용하려면, ON 을 사용하면 됨

-- 자기 직급의 평균 급여를 받는 직원 조회
-- 인라인 뷰로 작성한다면 : 
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
        FROM EMPLOYEE
        GROUP BY JOB_ID) V -- 인라인 뷰
JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND V.JOB_ID = E.JOB_ID)
JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- 상[호연]관 서브쿼리 (CORRELATED SUBQUERY)
-- 대부분 서브쿼리는 서브쿼리가 만든 결과값을 메인쿼리가 사용하는 구조임
-- 서브쿼리만 따로 실행결과를 확인할 수 있음
-- 상호연관 서브쿼리는 서브쿼리가 메인쿼리의 값을 가져다 결과를 만듦
-- 그래서 메인쿼리의 값이 바뀌면 서브쿼리의 결과도 달라지게 됨

-- 자기 직급의 평균 급여를 받는 직원 조회 : 상호연관 서브쿼리로 작성한다면
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
-- WHERE SALARY = (각 직원의 직급의 평균급여 계산)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                  FROM EMPLOYEE
                  WHERE NVL(JOB_ID, ' ') = NVL(E.JOB_ID, ' '));

SELECT EMP_NAME, JOB_ID
FROM EMPLOYEE
ORDER BY 2;

-- EXISTS / NOT EXISTS 연산자
-- 상호연관 서브쿼리 앞에만 사용함
-- 서브쿼리가 만든 결과가 존재하는지 물어볼 때는 EXISTS 사용함
-- 이 연산자 사용할 때는 서브쿼리 SELECT 절에 컬럼명 사용하면 안됨
-- 서브쿼리 WHERE 절의 조건의 결과가 TRUE 인 값이냐? 의 의미임
-- SELECT 절에 NULL 사용함

-- 예 : 관리자인 직원들의 정보 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
-- 서브쿼리의 조건을 만족하는 행들만 골라냄

-- NOT EXISTS : 서브쿼리의 조건을 만족하는 행이 존재하지 않느냐
-- 예 : 관리자가 아닌 직원 정보 조회
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
-- 서브쿼리의 조건절과 일치하지 않는 행들만 골라냄

-- 스칼라 서브쿼리
-- 단일행 + 상호연관서브쿼리
-- 예 : 이름, 부서코드, 급여, 해당 직원이 소속된 부서의 평균급여 조회
SELECT EMP_NAME, DEPT_ID, SALARY,
        (SELECT TRUNC(AVG(SALARY), -5)
         FROM EMPLOYEE
         WHERE E.DEPT_ID = DEPT_ID) "소속부서의 급여평균"
FROM EMPLOYEE E;

-- ORDER BY 절에서 스칼라 서브쿼리 사용할 수 있음
-- 직원이 소속된 부서의 부서명이 큰 값부터 정렬해서 직원 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME
            FROM DEPARTMENT
            WHERE DEPT_ID = E.DEPT_ID) DESC NULLS LAST;

-- CASE 표현식을 사용한 서브쿼리
-- 부서의 근무지역이 'OT'이면 '지역팀', 아니면 '본사팀' 으로 지정함
-- 직원의 근무지역에 대한 소속을 조회 처리
SELECT EMP_ID, EMP_NAME,
        CASE WHEN DEPT_ID = (SELECT DEPT_ID
                               FROM DEPARTMENT
                               WHERE LOC_ID = 'OT')
             THEN '지역팀'
             ELSE '본사팀'
        END 소속
FROM EMPLOYEE
ORDER BY 소속 DESC;

-- TOP-N 분석 --------------------------
-- 상위 몇 개, 하위 몇 개를 조회하는 것
-- 방법 1, 인라인 뷰와 RANK() 함수를 이용한 TOP-N 분석 방법
-- 방법 2. ROWNUM 을 이용한 TOP-N 분석 방법

-- 1. 인라인 뷰와 RANK() 함수를 이용
-- 직원 정보에서 급여를 가장 많이 받는 직원 5명 조회
-- 이름, 급여, 순위

SELECT *
FROM (SELECT EMP_NAME, SALARY, 
               RANK() OVER (ORDER BY SALARY DESC) 순위
       FROM EMPLOYEE)
WHERE 순위 <= 5;       

-- 2. ROWNUM 이용
-- ORDER BY 한 결과에 ROWNUM 을 부여함 => 인라인 뷰로 해결
-- ROWNUM : 행번호를 의미함, WHERE 처리 후에 자동으로 지정됨

-- 확인
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE  -- 각 행에 ROWNUM 지정됨
ORDER BY SALARY DESC;

-- 급여 많이 받는 직원 5명 조회
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5  -- WHERE 절 다음에 ROWNUM 부여됨
ORDER BY SALARY DESC;  -- 틀린 결과임

-- 해결 : 정렬하고 나서 ROWNUM 부여되게끔 작성
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
       FROM EMPLOYEE
       ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;







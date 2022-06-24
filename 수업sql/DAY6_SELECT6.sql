-- DAY6_SELECT6.sql
-- SELECT :  집합(SET) 연산자와 서브쿼리 (SUBQUERY)

-- 집합 연산자 (SET OPERATOR)
-- UNION, INTERSECT, MINUS, UNION ALL
-- 두 개의 SELECT 문의 결과들을 하나로 표현하기 위해 사용하는 연산자
-- 첫번째 결과집합이 위에, 두번째 결과 집합이 아래에 위치하면서 연결됨 (세로로 합침)
-- 합집합 : UNION, UNION ALL - 두 개의 SELECT 결과를 하나로 합침
--              UNION - 두 쿼리 결과의 중복되는 행은 1개만 선택
--              UNION ALL - 두 쿼리 결과의 중복행을 제외하지 않고 모두 포함
-- 교집합 : INTERSECT - 두 쿼리 결과의 중복행만 선택
-- 차집합 : MINUS - 첫번째 쿼리 결과에서 중복되는 두번째 쿼리 결과를 뺌

/*사용 형식 :
            SELECT 문
            집합연산자
            SELECT 문
            ORDER BY 순번 정렬방식;

주의 사항 : (RELATIONAL DB는 2차원 테이블 구조이다.)
            1. SELECT 절의 컬럼갯수가 같아야 함
                컬럼 갯수가 다르면 DUMMY COLUMN(NULL 컬럼) 을 추가해서 갯수 맞춤
            2. SELECT 절의 컬럼별 자료형이 같아야 함
        

*/

-- 직원의 사번과 직무명을 조회
-- EMPLOYEE_ROLE 과 ROLE_HISTORY 에서 각각 조회해서 하나로 합침
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
UNION   -- 25행 : 중복행 1개 제외됨
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
UNION ALL  -- 25행 : 중복행 1개 모두 포함됨
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
INTERSECT    -- 1행 : 중복행 1개 선택됨
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
MINUS   -- 21행 : 중복행 1개 제외됨
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행

-- SET 연산자 사용시 주의사항
-- 1. 두 쿼리의 컬럼갯수가 같아야 함
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL
FROM DEPARTMENT
WHERE DEPT_ID = '20';


-- 활용 : ROLLUP() 함수의 중간집계 위치에 원하는 문자처리 못 함
-- 대신 해결법으로 집합연산자 활용할 수 있음
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '20'  -- 3행
UNION
SELECT DEPT_NAME, '급여합계', SUM(SALARY)
FROM DEPARTMENT
JOIN EMPLOYEE USING(DEPT_ID)
WHERE DEPT_ID = '20'
GROUP BY DEPT_NAME;


-- 반복되는 쿼리문이 너무 길어짐 => 상호연관 서브쿼리를 이용하거나, 프로시저 사용
-- 프로시저 : SQL구문에 프로그래밍을 적용하는 객체임

-- 50번 부서에 소속된 직원 중 관리자와 일반직원을 따로 조회해서 하나로 합쳐라.
-- 50번 부서 직원 정보

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '관리자' AS 구분
FROM EMPLOYEE
WHERE EMP_ID = '141' AND DEPT_ID = '50'
UNION
SELECT EMP_ID, EMP_NAME, '직원' AS 구분
FROM EMPLOYEE
WHERE EMP_ID != '141' AND DEPT_ID = '50'
ORDER BY 3, 1;

SELECT 'SQL을 공부하고 있습니다.' 문장, 3 순서 FROM DUAL
UNION
SELECT '우리는 지금 ', 1 FROM DUAL
UNION
SELECT '아주 재미있게', 2 FROM DUAL
ORDER BY 2;

-- SET 연산자와 JOIN 의 관계
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- 각 쿼리문의 SELECT 절에 선택한 컬럼명이 동일한 경우에는 조인으로 바꿀 수 있음
-- USING( EMP_ID, ROLE_NAME) 사용할 수 있음
-- (104 SE) = (104 SE) : 같다, 조인에 포함(EQUAL JOIN이므로)
-- (104 SE-ANLY) != (140 SE) : 다르다, 조인제외

-- 위의 구문을 조인으로 바꾸면
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING( EMP_ID, ROLE_NAME);

-- SET 연산자와 IN 연산자의 관계
-- UNION 과 IN은 같은 결과를 만들 수 있음
-- 집합연산자에 대한 쿼리문의 SELECT 절의 컬럼들이 같고, 참조하는 테이블이 같고
-- WHERE 조건절의 비교값만 다른 경우에 IN 으로 바꿀 수 있음

-- 직급이 대리 또는 사원인 직원의 이름, 직급명 조회
-- 직급순 오름차순 정렬, 같은 직급은 이름순 오름차순정렬 처리함

SELECT EMP_NAME, JOB_TITLE
FROM JOB
JOIN EMPLOYEE USING (JOB_ID)
WHERE JOB_TITLE IN ('대리', '사원')
ORDER BY 2, 1;

-- UNION 사용 구문으로 바꾼다면
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원'
ORDER BY 2, 1




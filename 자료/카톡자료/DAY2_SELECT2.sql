-- DAY2_SELECT2.sql
-- DAY2 : SELECT 기본 2

-- 기본 한글 1글자는 2바이트임.
-- 오라클 18c xe 한글 바이트 크기 확인
-- 한글 1글자 3바이트임
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;  -- DUMMY TABLE 사용

-- 문자형 타입을 지정할 때 기본 단위는 BYTE 임
-- 글자수(CHAR)로도 지정할 수 있음
CREATE TABLE TEST (
    NAME VARCHAR2(20),  -- 최대 20바이트 기록
    CONTENT VARCHAR2(10CHAR) -- 최대 10글자 기록
);

-- 기본 날짜 표시 형식(FORMAT)
SELECT SYSDATE
FROM DUAL;

-- 날짜는 연산이 가능함
SELECT SYSDATE + 15
FROM DUAL;  -- 오늘부터 15일 뒤 날짜를 의미함

SELECT SYSDATE - 100
FROM DUAL;  -- 오늘부터 100일 전 날짜를 의미함

SELECT TRUNC(SYSDATE - HIRE_DATE) AS 근무일수
FROM EMPLOYEE;

SELECT SYSDATE + 48/24
FROM DUAL;  -- 숫자/24 는 시간을 의미함

-- ******************************************
-- CHAP3. 13P ~

/*
SELECT 구문 작성 형식 : 
실행순서
5 :  SELECT * | 컬럼명 [AS] 별칭, 컬럼명, 계산식, 계산식 [AS] 별칭
1 :  FROM 조회에 사용할 테이블명
2 :  WHERE 컬럼명 비교연산자 비교값 (행단위로 골라냄)
3 :  GROUP BY 컬럼명 | 계산식
4 :  HAVING 그룹함수 비교연산자 비교값 (조건을 만족하는 그룹을 골라냄)
6 :  ORDER BY 컬럼명 정렬기준, SELECT절의 항목순번 정렬기준, 별칭 정렬기준
*/

-- SELECT 작성 예 1 :
-- 직원 테이블에서 사번과 이름 조회
SELECT EMP_ID 사번, EMP_NAME 이름
FROM EMPLOYEE;

-- 직원 테이블의 모든 컬럼 정보 조회 (전체 조회)
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호,
        EMAIL 이메일, PHONE 전화번호, HIRE_DATE 입사일,
        JOB_ID 직급코드, SALARY 급여, BONUS_PCT 보너스포인트,
        MARRIAGE  결혼여부, MGR_ID 관리자사번, DEPT_ID 부서코드
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

-- SELECT 절에 컬럼에 기록된 값에 대한 계산식도 사용할 수 있음
-- 사번, 이름, 급여, 연봉(급여*12), 보너스포인트, 보너스포인트가 적용된 연봉 조회
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS 연봉,
        BONUS_PCT 보너스포인트, 
        (SALARY + (SALARY * BONUS_PCT)) * 12
FROM EMPLOYEE;

-- 데이터베이스에서는 계산값에 NULL이 있으면, 결과가 NULL임
-- 계산식에 데이터베이스가 제공하는 함수를 사용할 수 있음
-- 함수 중에 컬럼값이 NULL이면 다른 값으로 바꾸는 함수를 이용하면 됨
-- NVL(값 읽을 컬럼명, 값이 NULL일때 바꿀값)
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "1년급여",
        BONUS_PCT 보너스포인트, 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "총소득(원)"
FROM EMPLOYEE;

-- SELECT 절에 컬럼명 | 계산식 뒤에 별칭(ALIAS)를 사용할 수 있음
-- 컬럼명 AS 별칭, 계산식 AS 별칭
-- AS 는 생략할 수 있음 ==> 컬럼명 별칭, 계산식 별칭
-- 주의사항 : 별칭에 숫자, 공백, 기호가 사용될 때는 반드시 "별칭" (""로 묶어야 함)
--          글자수 제한 없음, 영어별칭은 기본 대문자로 표시됨
--          소문자로 표시되게 하려면 "" 묶어주면 됨

SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "1년급여",
        BONUS_PCT "bonuspoint", 
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 보너스포인트적용연봉액
FROM EMPLOYEE;

-- SELECT 절에 리터럴(LITERAL : 값) 사용할 수 있음
-- RESULTSET 에 가상의 컬럼이 추가되면서, 리터럴(값)로 채워짐 
-- 보여질 데이터를 의미함. 뒤에 별칭 추가 가능
--SELECT EMP_ID 사번, EMP_NAME 이름, '재직'
SELECT EMP_ID 사번, EMP_NAME 이름, '재직' 근무상태
FROM EMPLOYEE;

-- SELECT 절에 컬럼명 앞에 DISTINCT 를 사용할 수 있음
-- DISTINCT 컬럼명
-- SELECT 절에 한번만 사용할 수 있음.
-- 중복 기록된 값을 한 개만 선택하라는 의미로 작동됨
SELECT DISTINCT MARRIAGE  -- 컬럼에 기록된 값의 종류 파악할 때 주로 이용
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID, DISTINCT JOB_ID  -- ERROR
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID, JOB_ID -- 두 컬럼값을 묶어서 하나의 값으로 보고 중복 판단함
FROM EMPLOYEE;  -- 'J1 90' 과 'J2 90' 은 다른 값임

-- 직원 중에서 관리자인 직원들의 사번만 조회
SELECT DISTINCT MGR_ID
FROM EMPLOYEE;  -- 22명 중 6명이 관리자임을 확인함.

SELECT DISTINCT MGR_ID
FROM EMPLOYEE
ORDER BY 1;   -- 기본이 오름차순정렬임. ASC는 생략해도 됨

SELECT DISTINCT MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL  -- 관리자사번이 NULL 이 아닌 직원만 골라냄
ORDER BY 1; 

-- WHERE 절 ************************************
/*
작동 순서 : FROM 절이 작동되고 나서 WHERE 절이 작동됨
WHERE 컬럼명 비교연산자 비교값
조건절이라고 함 : 테이블에서 조건을 만족하는(조건의 결과가 참인) 행들을 골라냄
비교(관계) 연산자 : > (크냐, 초과), < (작으냐, 미만), >= (크거나 같으냐, 이상),
            <= (작거나 같으냐, 이하), = (같으냐), != (같지 않느냐, ^=, <>),
            IN, NOT IN, LIKE, NOT LIKE, BETWEEN AND, NOT BETWEEN AND
논리 연산자 : AND, OR, NOT
*/

-- 직원 테이블에서 부서코드가 '90'인 직원들을 조회
-- (90번 부서에 근무하는 직원 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90';  -- 조건과 일치하는 값이 기록된 행(ROW)들을 골라냄

-- 직급코드가 'J7'인 직원들을 조회
SELECT *
FROM EMPLOYEE
--WHERE JOB_ID = 'J7'; -- 기록값은 대소문자 구분함. 기록형태 그대로 비교해야 함
WHERE JOB_ID = 'j7';

-- 직원 중 급여를 4백만보다 많이 받는 직원 명단 조회
-- 사번, 이름, 급여 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 90번 부서에 근무하는 직원 중 급여가 2백만을 초과하는 직원 정보 조회
-- 사번, 이름, 급여, 부서코드 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND SALARY > 2000000;

-- 90 또는 20번 부서에 근무하는 직원 조회
-- 사번, 이름, 주민번호, 전화번호, 부서코드 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, 
        PHONE 전화번호, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE DEPT_ID = '90' OR DEPT_ID = '20';

-- 연습 1 : 
-- 급여가 2백만이상 4백만이하인 직원 조회
-- 사번, 이름, 급여, 직급코드, 부서코드 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, 
        JOB_ID 직급코드, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE SALARY >= 2000000 AND SALARY <= 4000000;

-- 연습 2 : 
-- 입사일이 1995년 1월 1일부터 2000년 12월 31일 사이에 입사한 직원 조회
-- 사번, 이름, 입사일, 부서코드 (별칭 처리)
-- 날짜데이터는 기록된 날짜 포멧(형식)과 일치되게 작성함
-- 날짜데이터는 작은 따옴표로 묶어서 표기함 : '1995/01/01' 또는 '95/04/01'
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';

-- 연결 연산자 : ||
-- 파이선에서의 'HELLO' + 'WORLD' => 'HELLOWORLD' 
-- SELECT 절에서 조회한 컬럼값들의 연결 처리로 하나의 문장을 만들 때 사용
-- WHERE 절에서 비교값 여러 개를 한 개의 값으로 만들 때 사용하기도 함
SELECT EMP_NAME || ' 직원의 급여는 ' || SALARY || ' 원입니다.' AS 급여정보
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- 연습 3 : 
-- 2000년 1월 1일 이후에 입사한 기혼인 직원 조회
-- 이름, 입사일, 직급코드, 부서코드, 급여, 결혼여부 (별칭 처리)
-- 입사날짜 뒤에 ' 입사' 문자 연결 출력함
-- 급여값 뒤에는 '(원)' 문자 연결 출력함
-- 결혼여부는 리터럴 사용함 : '기혼' 으로 채움
SELECT EMP_NAME 이름, HIRE_DATE || ' 입사' 입사일, 
        JOB_ID 직급코드, DEPT_ID 부서코드, 
        SALARY || '(원)' 급여, '기혼' 결혼여부
FROM EMPLOYEE
WHERE HIRE_DATE >= '00/01/01' AND MARRIAGE = 'Y';

-- 비교연산자 *******************************
-- BETWEEN AND 연산자
-- WHERE 컬럼명 BETWEEN 작은값 AND 큰값
-- 컬럼의 값이 작은값이상이면서 큰값이하인 의 의미를 가짐
-- WHERE 컬럼명 >= 작은값 AND 컬럼명 <= 큰값  과 같음

-- 직원중에서 2백만이상 4백만이하 범위의 급여를 받는 직원 조회
-- 사번, 이름, 급여, 직급코드, 부서코드 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, 
        JOB_ID 직급코드, DEPT_ID 부서코드
FROM EMPLOYEE
--WHERE SALARY >= 2000000 AND SALARY <= 4000000;
WHERE SALARY BETWEEN 2000000 AND 4000000;

-- 날짜 데이터에도 사용할 수 있음
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드
FROM EMPLOYEE
--WHERE HIRE_DATE >= '95/01/01' AND HIRE_DATE <= '00/12/31';
WHERE HIRE_DATE BETWEEN '95/01/01' AND '00/12/31';






-- DAY2_SELECT2.sql
-- DAY2 : SELECT 기본2

-- 기본 한글 1글자는 2바이트임.
-- 오라클 18c xe 한글 바이트 크기 확인
-- 한글 1글자 3byte임 실무용 dbms는 2바이트 라고함
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- DUMMY TABLE 사용

-- 문자형 타입을 지정할 때 기본 단위는 BYTE 임
-- 글자수(CHAR)로도 지정할 수 있음
CREATE TABLE TEST (
    NAME VARCHAR2(20), -- 최대 20바이트 기록
    CONTENT VARCHAR2(10CHAR) -- 최대 10글자 기록
);

-- 기본 날짜 표시 형식(FORMAT)
SELECT SYSDATE
FROM DUAL;

-- 날짜는 연산이 가능함
SELECT SYSDATE+15
FROM DUAL; -- 오늘부터 15일 뒤 날짜를 의미

SELECT SYSDATE - 100
FROM DUAL; -- 오늘부터 100전 날짜를 의미

SELECT HIRE_DATE, TRUNC(SYSDATE - HIRE_DATE) AS 근무일수
FROM EMPLOYEE;

SELECT SYSDATE + 48/24
FROM DUAL; -- 숫자/24 는 시간을 의미함

-- *********************************************************************
-- CHAP3. 13P ~

/*

SELECT 구문 작성 형식 :
실행 순서
5 :    SELECT   * | 컬럼명 [AS] 별칠, 컬럼명, 계산식, 계산식 AS 별칭
1 :    FROM    조회에 사용할 테이블명
2 :    WHERE  컬럼명 비교연산자 비교값 (행단위로 골라냄)
3 :    GROUP BY 컬럼명 | 계산식
4 :    HAVING 그룹함수 비교연산자 비교값 ( 조건을 만족하는 그룹을 골라냄)
6 :    ORDER BY (ASC DESC) 컬럼명 정렬기준, SELECT절의 항목순번 정렬기준, 별칭 정렬기준
실행순서!
*/

-- SELECT 작성 예 1 :
-- 직원 테이블에서 사번과 이름 조회
SELECT EMP_ID 사번, EMP_NAME 이름
FROM EMPLOYEE;

-- 직원 테이블의 모든 컬럼 정보 조회 (전체 조회)
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호,
            EMAIL 이메일, PHONE 전화번호, HIRE_DATE 입사일, 
            JOB_ID 직급코드, SALARY 급여, BONUS_PCT 보너스포인트,
            MARRIAGE 결혼여부, MGR_ID 관리자사번, DEPT_ID 부서코드
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

-- SELECT 절에 컬럼에 기록된 값에 대한 계산식도 사용할 수 있음
-- 사번, 이름, 급여, 연봉(급여*12), 보너스포인트, 보너스포인트가 적용된 연봉 조회
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 연봉, 
            BONUS_PCT 보너스포인트,
            (SALARY + (SALARY * BONUS_PCT)) * 12 보너스적용연봉
FROM EMPLOYEE;

-- 데이터베이스에서는 계산값에 NULL이 있으면, 결과가 NULL임
-- 계산식에 데이터베이스가 제공하는 함수를 사용할 수 있음
-- 함수 중에 컬럼값이 NULL 이면 다른 값으로 바꾸는 함수를 이용하면 됨
-- NVL(값 읽을 컬럼명, 값이 NULL일때 바꿀값

SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 "1년급여", 
            BONUS_PCT 보너스포인트,
            (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "총소득(원)"
FROM EMPLOYEE;

-- SELECT 절에 컬럼명 | 계산식 뒤에 별칭(ALIAS)를 사용할 수 있음
-- 컬럼명 AS 별칭, 계산식 AS 별칭
-- AS 는 생략할 수 있다 == 컬럼명 별칭, 계산식 별칭
-- 주의사항 : 별칭에 숫자, 공백, 기호가 사용될 때는 반드시 "별칭" (""로 묶어야 함)
--                별칭의 글자수는 30바이트 이하로 작성할 수 있음X 128바이트 초과시 안댐 (1024비트

SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 "1년급여", 
            BONUS_PCT "bonuspoint",
            (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "보너스포인트적용연봉보너스포인트적용연봉보너스포인트적용연봉보너스포인트적용연봉12345678"
FROM EMPLOYEE;

-- SELECT 절에 리터럴(LITERAL : 값) 사용할 수 있음
-- RESULT SET에 가상의 컬럼이 추가되면서, 리터럴(값)로 채워짐
SELECT EMP_ID 사번, EMP_NAME 이름, '재직' 근무상태
FROM EMPLOYEE;

-- SELECT 절에 컬럼명 앞에 DINSTICT 를 사용할 수 있음
-- DISTINCT 컬럼명
-- SELECT 절에 한번만 사용할 수 있음.
-- 중복 기록된 값을 한 개만 선택하라는 의미로 사용됨
SELECT DISTINCT MARRIAGE -- 컬럼에 기록된 값의 종류 파악할 때 주로 이용
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID, DISTINCT JOB_ID - ERROR
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID, JOB_ID -- 두 컬럼값을 묶어서 하나의 값으로 보고 중복 판단함
FROM EMPLOYEE; -- 'J1 90' 과 'J2 90' 은 다른 값임

-- 직원 중에서 관리자인 직원들의 사번만 조회

SELECT DISTINCT MGR_ID
FROM EMPLOYEE -- 22명 중 6명이 관리자임을 확인함.
WHERE MGR_ID != 'null';

SELECT DISTINCT MGR_ID
FROM EMPLOYEE
ORDER BY 1; -- DEAFULT 오름차순 정렬임. ASC생략가능 DESC생략불가

SELECT DISTINCT MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL -- 관리자사번이 NULL 이 아닌 직원만 골라냄
ORDER BY 1;

-- WHRER 절 ****************************************************
/*
작동 순서 : FROM 절이 작동되고 나서 WHERE 절이 작동됨
WHERE 컬럼명 비교연산자 비교값
조건절이라고 함 : 테이블에서 조건을 만족하는(조건의 결과가 참인) 행들을 골라냄
비교(관계) 연산자 : >(크냐, 초과), < (작으냐, 미만), >=(크거나 같으냐, 이상),
                    <= (작거냐 같으냐, 이하), = (같으냐), !=(같지 않으냐, ^=, <>),
                    IN, NOT IN, LIKE, NOT LIKE, BETWEEN AND, NOT BETWEEN
논리 연산자 : AND, OR, NOT 
*/

-- 직원 테이블에서 부서코드가 '90'인 직원들을 조회
-- (90번 부서에 근무하는 직원 조회)

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90'; -- 조건과 일치하는 값이 기록된 행(ROW)들을 골라냄

-- 직급코드가 'J7'인 직원들을 조회
SELECT *
FROM EMPLOYEE
--WHERE JOB_ID = 'J7'; -- 기록값은 대소문자 구분함. 기록형태 그대로 비교해야 함.
WHERE JOB_ID = 'j7';

-- 직원 중 급여를 4백만보다 많이 받는 직원 명단
-- 사번, 이름, 급여 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 90번 부서에 근무하는 직원 중 급여가 2백만원을 초과하는 직원 정보 조회
-- 사번, 이름, 급여, 부서코드 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE DEPT_ID = 90 AND SALARY > 2000000;

-- 90 또는 20번 부서에 근무하는 직원 조회
-- 사번, 이름, 주민번호, 전화번호, 부서코드 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE DEPT_ID = '90' OR DEPT_ID = '20';

-- 연습 1 :
-- 급여가 2백만이상 4백만 이하인 직원 조회
-- 사번, 이름, 급여, 직급코드, 부서코드 (별칭 처리)

SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, JOB_ID 직급코드, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE SALARY > 2000000 AND SALARY <4000000;

-- 연습 2 :
-- 입사일이 1995년 1월 1일부터 2000년 12월 31일 사이에 입사한 직원 조회
-- 사번, 이름, 입사일, 부서코드 (별칭 처리)
-- 날짜데이터는 기록된 날짜 포멧(형식)과 일치되게 작성함
-- 날짜데이터는 작은 따옴표로 묶어서 표기함 : '1995/01/01' 또는 '95/04/01'
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE HIRE_DATE >= '55/01/01' AND HIRE_DATE <= '95/12/31'; -- 2090년 짜리는 뒤에두자리만 보고 어캐 아는거? 아마 DEFAULT가 있는듯 아마 5~9는 19 1~4는20

-- 연결 연산자 : ||
-- 파이썬에서의 'HELLO' + 'WORLD' => 'HELLOWORLD'
-- SELECT 절에서 조회한 컬럼값들의 연결 처리로 하나의 문자을 만들 때 사용
-- WHERE 절에서 비교값 여러 개를 한 개의 값으로 만들 때 사용하기도 함

SELECT EMP_NAME || ' 직원의 급여는 ' || SALARY || ' 원입니다.' AS 급여정보
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- 연습 3:
-- 2000년 1월 1일 이후에 입사한 기혼인 직원 조회
-- 이름, 입사일, 직급코드, 부서코드, 급여, 결혼여부 조회 (별칭 처리)
-- 입사날짜 뒤에 ' 입사' 문자 연결
-- 급여값 뒤에는 '(원)' 문자 연결 출력
-- 결혼여부는 리터럴 사용함 : '기혼' 으로 채움
SELECT EMP_NAME 이름, HIRE_DATE || '입사' 입사일, JOB_ID 직급코드, DEPT_ID 부서코드, SALARY || '(원)' 급여, '기혼' 결혼여부
FROM EMPLOYEE
WHERE HIRE_DATE >= '00/01/01' AND MARRIAGE = 'Y';


-- 비교연산자 **************************************************
-- BETWEEN AND 연산자
-- WHERER 컬럼명 BETWEEN 작은값 AND 큰값
-- 컬럼의 값이 작은값이상이면서 큰값이하인 의 의미를 가짐
-- WHERE 컬럼명 >= 작은값 AND 컬럼명 <= 큰값 과 같음

-- 직원중에서 2백만 이상 4백만 이하 범위의 급여를 받는 직원 조회

SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, JOB_ID 직급코드, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 4000000;
-- WHERE SALARY >= 2000000 AND SALARY <= 4000000;

-- 날짜 데이터에도 사용할 수 있음
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '95/01/01' AND  '00/12/31';

-- LIKE 연산자
-- 와일드카드 문자(%,_) 를 이용해서 문자패턴을 설정함
-- 컬럼에 기록된 값이 제시된 패턴과 일치하는 값들을 골라낼 때 사용함
-- WHERE 컬럼명 LIKE '문자패턴'
-- '%' : 0개 이상의 글자들, '_' : 글자 한자리

-- 성이 '김'씨인 직원 조회
-- 사번, 이름, 전화번호, 이메일 (별칭)

SELECT EMP_ID 사번, EMP_NAME 이름, PHONE 전화번호, EMAIL 메일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '김%';

-- 성이 '김'씨가 아닌 직원 조회
SELECT EMP_ID 사번, EMP_NAME 이름, PHONE 전화번호, EMAIL 메일
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';

-- 직원들의 이름에 '해'자가 들어있는 직원 조회
SELECT EMP_ID 사번, EMP_NAME 이름, PHONE 전화번호, EMAIL 메일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%해%';

-- 전화번호의 국번이 4자리이면서 9로 시작하는 번호를 가진 직원 조회
-- 이름, 전화번호
SELECT EMP_NAME 이름, PHONE 전화번호
FROM EMPLOYEE
--WHERE PHONE LIKE '___9_______'; -- 결과행 : 2
WHERE PHONE LIKE '___9%'; -- 결과행 : 3

-- 성별이 여자인 직원 조회
-- 사번, 이름, 주민번호, 전화번호 (별칭)
-- 주민번호 8번째 글자가 1이면 남자, 2이면 여자임
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호
FROM EMPLOYEE
WHERE EMP_NO LIKE '%-2%';

--- 성별이 남자인 직원 조회
SELECT EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호, PHONE 전화번호
FROM EMPLOYEE
WHERE EMP_NO LIKE '%-1%';

-- LIKE 연산 사용시에 기록된 '_', '%' 문자와 패턴을 지정하는 와일드카드가
-- 구분이 필요한 경우가 발생할 수도 있음
-- 예 : 이메일에서 아이디 값에서 기록된 '_' 문자 앞 글자가 3글자로 된 직원 조회

-- ESCAPE OPTION : 와일드카드와 기록문자와의 구분이 필요할 때 사용함
-- 기록문자 앞에 기호문자 표시함.
-- '문자패턴와일드카드기호문자기록문자' ESCAPE '기호문자;
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___/_%' ESCAPE '/';

-- IS NULL | IS NOT NULL
-- WHERE 컬럼명 IS NULL : 컬럼값이 NULL(비어있는) 인 행을 고름
-- WHERE 컬럼명 IS NOT NULL : 컬럼값이 NULL이 아닌(비어있지 않은) 행 고름
-- 주의 : 컬럼명 = NULL : 에러                                 근대 'NULL'은 되더라 ㅋ

-- 부서도 직급도 배정받지 못한 직원 조회
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_ID 직급코드, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE JOB_ID IS NULL AND DEPT_ID IS NULL;

-- 보너스포인트가 없는 직원 조회
-- 사번, 이름, 부서코드, 보너스포인트

SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT IS NULL or BONUS_PCT = 0.0;

-- 보너스포인트 받는 직원 조회
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드, BONUS_PCT 보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT IS NOT NULL;

-- 부서는 배정받지 않았는데, 관리자가 있는 직원 조회
-- 사번, 이름, 관리자사번, 부서코드

SELECT EMP_ID 사번, EMP_NAME 이름, MGR_ID 관리자사번, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL AND DEPT_ID IS NULL; -- 0 행

-- 부서도 없고, 관리자도 없는 직원 조회
SELECT EMP_ID 사번, EMP_NAME 이름, MGR_ID 관리자사번, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE MGR_ID IS NULL AND DEPT_ID IS  NULL; -- 2행

-- 부서는 없는데, 보너스포인트는 받는 직원 조회

SELECT EMP_ID 사번, EMP_NAME 이름, BONUS_PCT 보너스포인트, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE BONUS_PCT IS NOT NULL AND DEPT_ID IS NULL; 

-- IN 연산자
-- WHERE 컬럼명 IN (비교값1, 비교값2, ...)
-- WHERE 컬럼명 = 비교값1 OR 컬럼명 = 비교값2 OR ... ...

-- 20 또는 90번 부서에 근무하는 직원 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '20' OR DEPT_ID = '90';

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IN (20,90);

-- 연산자 우선 순위에 따라 조건 계산이 처리됨
-- 60,90번 부서에 소속된 직원들 중에서 급여를 3백만보다 많이 받는 직원 조회
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '60' OR DEPT_ID = '90' AND SALARY > 3000000; -- 연산자 우선순위 AND먼저 계산됨
-- AND 가 OR 보다 우선순위가 높음

-- 해결 : 먼저 계산할 내용을 ()로 묶음
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE (DEPT_ID = '60' OR DEPT_ID = '90') AND SALARY > 3000000; -- 연산자 우선순위 AND먼저 계산됨

-- 해결 : IN 연산자 사용
SELECT EMP_ID, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID IN ('60', '90') AND SALARY > 3000000; -- 연산자 우선순위 AND먼저 계산됨
-- IN 연산자가 AND 보다 우선순위가 높음

-- NOT 연산자 : 논리 부정 연산자
-- 비교 또는 논리연산의 결과(참, 거짓)를 반대로 바꿀 때 사용함
-- WHERE NOT 컬럼명 비교연산자 비교값
-- WHERE 컬럼명 NOT 비교연산자 비교값

-- 급여가 2백만보다 작거나, 4백만보다 많이 받는 직원 조회
SELECT EMP_ID, EMP_NAME, SALARY, JOB_ID, DEPT_ID
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 2000000 AND 4000000; 
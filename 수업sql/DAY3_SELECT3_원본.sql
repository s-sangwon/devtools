-- DAY3_SELECT3.sql
-- 오라클에서 사용하는 함수
-- 다른 DBMS 에서도 사용이 비슷하거나 같음

-- 함수 (FUNCTION) *****************************
-- 컬럼에 기록된 값을 읽어서 함수가 처리한 결과를 리턴하는 형태임
-- 함수명(컬럼명) 사용
-- 단일행 함수 (SINGLE ROW FUNCTION) : 
-- 읽은 값이 N개이면, 결과값도 N개가 반환됨 (한 행씩 다루는 함수)
-- 그룹 함수 (GROUP FUNCTION) : 
-- 읽은 값이 N개이면, 결과값은 1개 반환됨 (여러 개의 값을 그룹으로 묶음)

-- 함수 종류 구분이 필요한 이유 :
-- SELECT 절에서 단일행 함수와 그룹함수는 함께 사용 못 함 (에러남)
-- 관계형 데이터베이스(RDBMS)는 2차원 테이블 구조임. (결과가 사각형이어야 됨)

SELECT UPPER(EMAIL), -- 22행
        SUM(SALARY)  -- 1행
FROM EMPLOYEE;  -- 에러 확인

-- 결과행 갯수 확인
SELECT EMAIL, UPPER(EMAIL)
FROM EMPLOYEE;

SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 그룹함수
-- SUM(), AVG(), MAX(), MIN(), COUNT()

-- SUM(컬럼명) | SUM(DISTINCT 컬럼명)
-- 합계를 구해서 리턴함

-- 소속부서가 '50'이거나 부서가 배정되지 않은 직원들의 급여 합계를 조회
SELECT SUM(SALARY) 급여합계, 
        SUM(DISTINCT SALARY) "중복값 제외한 급여합계"
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

SELECT DEPT_ID, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- WHERE 절에서 비교값에 그룹함수 사용할 수 없음
-- WHERE 절에는 단일행함수만 사용할 수 있음
-- 예 : 전 직원의 급여 평균보다 급여를 많이 받는 직원 조회
-- 사번, 이름, 급여
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE SALARY > AVG(SALARY);  -- ERROR : ORA-00934

-- 해결 1 : 전체 급여 평균을 먼저 조회하고, 그 값을 조건절에 사용
-- SELECT 문 따로 작성
SELECT AVG(SALARY)
FROM EMPLOYEE;  -- 2961818.18181818181818181818181818181818

SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE SALARY > 2961818; 

-- 해결 2 : 서브쿼리 사용
-- 값 사용 위치에 그 값을 조회하는 쿼리문을 직접 사용하는 방식임
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                 FROM EMPLOYEE); 

-- AVG(컬럼명) | AVG(DISTINCT 컬럼명)
-- 평균을 구해서 반환함

-- 소속부서가 50 또는 90 또는 NULL 인 직원들의 보너스포인트 평균 조회
SELECT AVG(BONUS_PCT) 기본평균,  -- /4
        AVG(DISTINCT BONUS_PCT) 중복제외평균, -- /3
        AVG(NVL(BONUS_PCT, 0)) NULL포함평균  -- /11
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') OR DEPT_ID IS NULL;

SELECT BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90') OR DEPT_ID IS NULL;

-- MAX(컬럼명) | MAX(DISTINCT 컬럼명)
-- 가장 큰 값 반환 (숫자, 날짜, 문자 다 처리함)
-- MIN(컬럼명) | MIN(DISTINCT 컬럼명)
-- 가장 작은 값 반환 (숫자, 날짜, 문자 다 처리함)
-- 문자형(CHAR, VARCHAR2, LONG, CLOB), 숫자형(NUMBER), 날짜형(DATE)

-- 부서코드가 50 또는 90 인 직원들의 
-- 직급코드(CHAR)의 최대값, 최소값
-- 입사일(DATE)의 최대값, 최소값
-- 급여(NUMBER)의 최대값, 최소값 조회
SELECT MAX(JOB_ID), MIN(JOB_ID),
        MAX(HIRE_DATE), MIN(HIRE_DATE),
        MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90');

-- COUNT(*) | COUNT(컬럼명) | COUNT(DISTINCT 컬럼명)
-- * : 전체 행 갯수 반환 (NULL 포함)
-- 컬럼명 : NULL 제외한 기록값의 행 갯수 반환

SELECT DEPT_ID  -- 8행
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

SELECT COUNT(*), -- 조회된 전체 행 갯수 : 8행
        COUNT(DEPT_ID), -- NULL 제외한 값이 있는 행 갯수 : 6행
        COUNT(DISTINCT DEPT_ID) -- NULL과 중복값 제외한 값 갯수 : 1행
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL;

-- 단일행 함수 ********************************

-- 문자 처리 함수 -------------------------------------------

-- LENGTH('문자리터럴') | LENGTH(문자가 기록된 컬럼명)
-- 글자 갯수 리턴

SELECT LENGTH('ORACLE'), LENGTH('오라클')
FROM DUAL;

SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- LENGTHB('문자리터럴') | LENGTHB(문자가 기록된 컬럼명)
-- 기록 글자의 바이트 크기를 리턴
SELECT LENGTHB('ORACLE'), LENGTHB('오라클')
FROM DUAL;

-- INSTR('문자열리터럴'| 문자가 기록된 컬럼명, 찾을문자, 찾을 시작위치, 몇번째문자)
-- 찾을 문자의 위치 리턴 (앞에서 부터의 순번임)

-- 이메일에서 '@' 문자 위치 조회
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- 이메일에서 '@' 문자 바로 뒤에 있는 'k' 문자의 위치를 조회
-- 단, 뒤에서 부터 검색함
SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3), INSTR(EMAIL, '@') + 1
FROM EMPLOYEE; 

-- 함수 중첩 사용 가능함
-- 이메일에서 '.' 문자 바로 뒤에 있는 'c' 의 위치를 조회
-- 단, '.' 문자 바로 앞글자부터 검색 시작하도록 함
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') - 1)
FROM EMPLOYEE;

-- LPAD('문자리터럴' | 문자가 기록된 컬럼명, 출력할 너비글자수, 남는영역 채울문자)
-- 채울문자가 생략되면 기본값은 ' '(공백문자임)
-- LPAD() : 왼쪽 채우기, RPAD() : 오른쪽 채우기
SELECT EMAIL 원본, LENGTH(EMAIL) 원본길이,
        LPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(LPAD(EMAIL, 20, '*')) 결과길이
FROM EMPLOYEE;

SELECT EMAIL 원본, LENGTH(EMAIL) 원본길이,
        RPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(RPAD(EMAIL, 20, '*')) 결과길이
FROM EMPLOYEE;

-- LTRIM('문자리터럴' | 문자가 기록된 컬럼명, '제거할 문자들')
-- 왼쪽에 있는 문자들을 제거한 문자가 리턴
-- RTRIM() : 오른쪽에 있는 문자들을 제거한 문자 리턴
SELECT '    12345abxyORACLExxxyyy567     ',
        LTRIM('    12345abxyORACLExxxyyy567     '),
        LTRIM('    12345abxyORACLExxxyyy567     ', ' '),
        LTRIM('    12345abxyORACLExxxyyy567     ', ' 0123456789'),
        LTRIM('    12345abxyORACLExxxyyy567     ', ' abxy12345')
FROM DUAL;

SELECT '    12345abxyORACLExxxyyy567     ',
        RTRIM('    12345abxyORACLExxxyyy567     '),
        RTRIM('    12345abxyORACLExxxyyy567     ', ' '),
        RTRIM('    12345abxyORACLExxxyyy567     ', ' 0123456789'),
        RTRIM('    12345abxyORACLExxxyyy567     ', ' xy1234567')
FROM DUAL;

-- TRIM(LEADING | TRAILING | BOTH '제거할문자' FROM '문자리터럴' | 컬럼명)
SELECT 'aaORACLEaa',
        TRIM('a' FROM 'aaORACLEaa'),
        TRIM(LEADING 'a' FROM 'aaORACLEaa'),
        TRIM(TRAILING 'a' FROM 'aaORACLEaa'),
        TRIM(BOTH 'a' FROM 'aaORACLEaa')
FROM DUAL;

-- SUBSTR('문자리터럴' | 문자가 기록된 컬럼명, 추출할 시작위치, 추출할 글자갯수)
-- 추출할 시작위치 : 양수(앞에서부터의 위치), 음수(뒤에서부터의 위치)
-- 추출할 글자갯수 : 생략되면 끝글자까지를 의미함
SELECT 'ORACLE 18C',
        SUBSTR('ORACLE 18C', 5), -- LE 18C
        SUBSTR('ORACLE 18C', 8, 2), -- 18
        SUBSTR('ORACLE 18C', -7, 3) -- CLE
FROM DUAL;

-- 직원 테이블의 주민번호에서 생년, 생월, 생일을 각각 분리 조회
SELECT EMP_NO,
        SUBSTR(EMP_NO, 1, 2) 생년,
        SUBSTR(EMP_NO, 3, 2) 생월,
        SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;

-- 날짜 표기시에 반드시 문자처럼 '' 묶어서 표기해야 함
-- '22/06/15' 표기함
-- SUBSTR() 은 날짜데이터에도 사용할 수 있음

-- 직원들의 입사일에서 입사년도, 입사월, 입사일을 분리 조회
SELECT HIRE_DATE 입사일,
        SUBSTR(HIRE_DATE, 1, 2) 입사년도,
        SUBSTR(HIRE_DATE, 4, 2) 입사월,
        SUBSTR(HIRE_DATE, 7, 2) 일사일
FROM EMPLOYEE;

-- SUBSTRB('문자리터럴' | 문자가 기록된 컬럼명, 추출할 바이트위치, 추출할 바이트)
SELECT SUBSTR('ORACLE', 3, 2), -- AC
        SUBSTRB('ORACLE', 3, 2), -- AC
        SUBSTR('오라클', 2, 2), -- 라클
        SUBSTRB('오라클', 4, 6)  -- 라클
FROM DUAL;

-- UPPER('문자리터럴' | 문자가 기록된 컬럼명)
-- 영문자일 때 대문자로 바꾸는 함수
-- LOWER('문자리터럴' | 문자가 기록된 컬럼명)
-- 영문자일 때 소문자로 바꾸는 함수
-- INITCAP('문자리터럴' | 문자가 기록된 컬럼명)
-- 영문자일 때 첫글자만 대문자로 바꾸는 함수
SELECT UPPER('ORACLE'), UPPER('oracle'),
        LOWER('ORACLE'), LOWER('oracle'),
        INITCAP('ORACLE'), INITCAP('oracle')
FROM DUAL;

-- 함수 중첩 사용 : 함수 안에 값 대신에 함수를 사용할 수 있음
-- 안쪽 함수가 반환한 값을 바깥 함수가 사용한다는 의미임

-- 직원 정보에서 사번, 이름, 아이디 조회
-- 아이디는 이메일에서 분리 추출함
SELECT EMP_ID 사번, EMP_NAME 이름, EMAIL 이메일, 
        SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) 아이디
FROM EMPLOYEE;

-- 직원 테이블에서 사번, 이름, 주민번호 조회
-- 주민번호는 생년월일만 보이게하고 뒷자리는 '*' 처리함 : 781225-*******
SELECT EMP_ID 사번, EMP_NAME 이름,
        RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') 주민번호
FROM EMPLOYEE;


-- 숫자 처리 함수 -----------------------------------------
-- ROUND(), TRUNC(), FLOOR(), ABS(), MOD()

-- ROUND(숫자 | 숫자가 기록된 컬럼명 | 계산식, 반올림할 자릿수)
-- 버려지는 자리의 값이 5이상이면 자동 반올림함
-- 반올림할 자릿수가 양수이면 소숫점 아래 표시할 자리를 의미함
-- 반올림할 자릿수가 음수이면 소숫점 앞(정수부) 올림할 자리를 의미함
SELECT 123.456,
        ROUND(123.456),  -- 123
        ROUND(123.456, 0), -- 123
        ROUND(123.456, 1), -- 123.5
        ROUND(123.456, -1) -- 120
FROM DUAL;

-- 직원 정보에서 사번, 이름, 급여, 보너스포인트, 보너스포인트 적용 연봉 조회
-- 연봉은 별칭 처리 : 1년급여
-- 연봉은 천단위에서 반올림처리함
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여, BONUS_PCT 보너스포인트,
        ROUND(((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12), -4) "1년급여"
FROM EMPLOYEE;

-- TRUNC(숫자 | 숫자가 기록된 컬럼명 | 계산식, 자를 자릿수)
-- 지정한 자리아래의 값을 버림, 절삭함수, 반올림 없음
SELECT 145.678, 
        TRUNC(145.678),  -- 145
        TRUNC(145.678, 0),  -- 145
        TRUNC(145.678, 1),  -- 145.6
        TRUNC(145.678, -1), -- 140
        TRUNC(145.678, -3)  -- 0
FROM DUAL;

-- 직원 정보에서 급여의 평균을 조회
-- 10단위에서 절삭함
SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2)
FROM EMPLOYEE;

-- FLOOR(숫자 | 숫자가 기록된 컬럼명 | 계산식)
-- 정수 만들기 함수 (소수점 아래값 버림)
SELECT ROUND(123.5), TRUNC(123.5), FLOOR(123.5)
FROM DUAL;

-- ABS(숫자 | 숫자가 기록된 컬럼명 | 계산식)
-- 절대값 구하는 함수 (양수와 0은 그대로, 음수는 양수로 바꿈)
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- 직원 정보에서 입사일 - 오늘, 오늘 - 입사일 조회
-- 별칭 : 근무일수
-- 오늘 날짜 반환 함수 : SYSDATE
-- 근무일수는 양수, 정수로 처리함
SELECT ABS(FLOOR(HIRE_DATE - SYSDATE)) 근무일수,
        ABS(FLOOR(SYSDATE - HIRE_DATE)) 근무일수
FROM EMPLOYEE;

-- MOD(나눌값, 나눌수)
-- 나누기한 나머지를 리턴함
-- 데이터베이스에서는 % (MOD) 연산자 사용 못 함
SELECT FLOOR(25 / 7) 몫, MOD(25, 7) 나머지
FROM DUAL;

-- 직원 정보에서 사번이 홀수인 직원 조회
-- 사번, 이름
SELECT EMP_ID 사번, EMP_NAME 이름
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- 날짜 처리 함수 -------------------------------------

-- SYSDATE 함수
-- 시스템으로 부터 현재 날짜와 시간을 조회할 때 사용
SELECT SYSDATE
FROM DUAL;  -- 출력되는 날짜 형식(FORMAT) : '22/06/15'

-- 오라클에서는 환경설정, 객체 관련 정보들을 모두 저장 관리하고 있음
-- 데이터 딕셔너리(데이터 사전) 영역에 테이블 형태로 각 정보들을 저장 관리하고 있음
-- 데이터 딕셔너리는 DB 시스템이 관리함, 사용자는 손댈 수 없음
-- 저장된 정보는 조회해 볼 수는 있음

-- 단, 환경설정과 관련된 부분은 셋팅 정보를 일부 변경할 수 있음
SELECT *
FROM SYS.nls_session_parameters;

-- 날짜 포맷과 관련된 변수 값만 조회한다면
SELECT VALUE
FROM SYS.NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- 날짜 포맷을 수정한다면
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

-- 확인
SELECT SYSDATE
FROM DUAL;

-- 원래 포맷으로 변경
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- ADD_MONTHS('날짜' | 날짜가 기록된 컬럼명, 더할 개월수)
-- 더한 개월수에 대한 날짜가 리턴됨

-- 오늘 날짜에서 6개월 뒤 날짜는?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 6)
FROM DUAL;

-- 직원 정보에서 입사일에서 20년된 날짜 조회
-- 사번, 이름, 입사일, 20년된 날짜 (별칭 처리)
SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일,
        ADD_MONTHS(HIRE_DATE, 240) "20년된 날짜"
FROM EMPLOYEE;

-- 단일행 함수는 WHERE 절에서 사용할 수 있음
-- 직원들 중 근무년수가 20년 이상된 직원 정보 조회
-- 사번, 이름, 부서코드, 직급코드, 입사일, 근무년수 (별칭)
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드, JOB_ID 직급코드,
        HIRE_DATE 입사일, 
        FLOOR((SYSDATE - HIRE_DATE) / 365) 근무년수
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE
ORDER BY 근무년수 DESC;

-- MONTHS_BETWEEN(DATE1, DATE2)
-- '날짜' | 날짜가 기록된 컬럼명
-- 두 날짜의 개월수의 차이가 리턴됨

-- 직원들의 이름, 입사일, 현재까지의 근무일수, 근무개월수, 근무년수 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        FLOOR(SYSDATE - HIRE_DATE) 근무일수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) 근무개월수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 근무년수
FROM EMPLOYEE;

-- NEXT_DAY('날짜' | 날짜가 기록된 컬럼명, '요일이름')
-- 지정한 날짜 뒤쪽 날짜에서 가장 가까운 지정 요일의 날짜를 리턴함
-- 현재 DBMS 의 사용언어가 'KOREAN' 이므로, 요일이름은 한글로 써야 함
-- 영어 요일이름 사용하면 에러남

SELECT SYSDATE, NEXT_DAY(SYSDATE, '일요일')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL;  -- 에러

-- 환경설정 변수의 언어를 변경해 봄
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

ALTER SESSION
SET NLS_LANGUAGE = KOREAN;

SELECT NEXT_DAY('22/08/15', '토요일')
FROM DUAL;

-- LAST_DAY('날짜' | 날짜가 기록된 컬럼명)
-- 지정한 날짜의 월에 대한 마지막 날짜를 리턴함
SELECT SYSDATE, LAST_DAY(SYSDATE),
        '20/02/01', LAST_DAY('20/02/01')
FROM DUAL;

-- 직원 정보에서 이름, 입사일, 입사한 월(첫달)의 근무일수 조회
-- 주말 포함 일수
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        LAST_DAY(HIRE_DATE) - HIRE_DATE "입사첫달 근무일수"
FROM EMPLOYEE;

-- 오늘 날짜 조회 함수
SELECT SYSDATE, SYSTIMESTAMP, 
        CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(추출할 정보 FROM 날짜)
-- 날짜 데이터에서 원하는 정보만 추출함
-- 추출할 정보 : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

-- 오늘 날짜에서 년도, 월, 일 따로 추출
SELECT SYSDATE,
        EXTRACT(YEAR FROM SYSDATE),
        EXTRACT(MONTH FROM SYSDATE),
        EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- 직원들의 이름, 입사일, 근무년수 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) /12) 근무년수
FROM EMPLOYEE;





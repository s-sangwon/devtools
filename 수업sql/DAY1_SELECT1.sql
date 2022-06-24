-- SELECT 구문
/*
테이블 기록 저장된 데이터를 검색(조회 : 찾아내기 위한)하기 위해 사용하는 SQL 구문.
DQL(Data Query Lenguage : 데이터 조회어) 이라고도 함

SELECT 구문 기본 작성법 :
SELECT * | 컬럼명, 컬럼명, 함수표현식, 계산식
FROM 테이블 명;

* : 테이블이 가진 모든 컬럼 데이터를 조회한다는 의미
*/

-- 직원(EMPLOYEE) 테이블에 저장된 전체 데이터를 조회한다면
SELECT * FROM EMPLOYEE;

-- 부서(DEPARTMENT) 테이블 전체 조회
SELECT *
FROM DEPARTMENT;

-- 직급(JOB) 테이블 전체 조회
SELECT *
FROM JOB;

-- 조회 결과 형태 1 :
-- 직원 테이블에서 사번, 이름, 주민번호 조회한다면
SELECT EMP_ID, EMP_NAME, EMP_NO
FROM EMPLOYEE;

-- 직원 테이블에서 사번, 이름, 급여, 보너스포인트 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT
FROM EMPLOYEE;

-- SELECT 절에 계산식 사용  가능
-- 직원 테이블에서 사번, 이름, 급여, 연봉(급여 *12) 조회
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- SELECT 절에 함수표현식 사용 가능
-- 직원 테이블에서 사번, 이름, 주민번호 앞 6자리 값만 조회
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO, 1, 6)
FROM EMPLOYEE;

-- 조회 결과 형태 2 :
-- 특정 행들을 조회하는 경우
-- 조건을 제시해서, 조건에 해당하는 행들을 골라냄
-- 조건절(WHERE 절)을 사용함
-- 예: 직원 정보에서 기혼(결혼한)인 직원들만 골라내는 경우

SELECT *
FROM EMPLOYEE
WHERE EMPLOYEE.marriage = 'Y'; -- 기록된 값은 대소문자 구분함

SELECT *
FROM EMPLOYEE
WHERE EMPLOYEE.marriage != 'Y'; -- 미혼인 직원 = 'N'도가능


-- 조회 결과 형태 3 :
-- 조건을 만족하는 행들을 골라낸 다음, 원하는 컬럼값만 선택 조회
-- 직원 정보에서 직급코드가 'J4'인 직원들의 사번, 이름, 직급코드, 급여 저회

SELECT emp_id, emp_name, job_id, salary
FROM EMPLOYEE
where job_id = 'J4';

-- 조회 결과 형태 4 : 
-- SELECT 구문은 기본 한 개의 테이블에 대한 데이터 조회임
-- 필요할 경우 여러 개의 테이블을 합쳐서(조인) 원하는 컬럼을 조회할 수 있음
-- 직원 테이블과 부서 테이블에서 사번, 이름, 부서코드, 부서명 조회

SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';
-- 아래처럼 표현가능

SELECT EMP_ID, EMP_NAME, employee.DEPT_ID, DEPT_NAME
FROM EMPLOYEE, DEPARTMENT
WHERE employee.dept_id = department.dept_id and employee.dept_id = '90';

-- 직원 정보에서 사번, 이름, 급여, 보너스포인트가 적용된 연본 계산 조회
SELECT EMP_ID as 사번, EMP_NAME as 직원이름, SALARY as 급여, 
            (SALARY+(SALARY * bonus_pct)) * 12 as 보너스적용연봉
FROM EMPLOYEE;

SELECT EMP_ID 사번, EMP_NAME 직원이름, SALARY 급여, 
             (SALARY+(SALARY * bonus_pct)) * 12 보너스적용연봉
FROM EMPLOYEE;

-- SELECT 절의 컬럼명 앞에 DISTINCT 키워드 사용할 수 있음
-- 중복 제거를 의미함 : 컬럼의 사용(기록)된 값들중 같은 값들은 한개만 선택을 의미
SELECT DEPT_ID
FROM EMPLOYEE;

-- 직원 정보에서 사용된 부서코드 조회
SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;

-- 직원 정보에서 사용된 직급코드 조회
SELECT DISTINCT JOB_ID
FROM EMPLOYEE
ORDER BY JOB_ID ASC;
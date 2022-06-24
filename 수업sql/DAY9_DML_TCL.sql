-- DAY9_DML_TCL.sql
-- DML 구문과 TCL 구문

-- DATA MANIPULATION LANGUAGE  DML : 데이터 조작어
-- 명령어 : INSERT, DELETE, UPDATE, TRUNCATE
-- 테이블에 데이터를 기록 저장하거나(INSERT), 기록된 데이터를 수정하거나(UPDATE)
-- 값이 기록된 행을 삭제할 때(DELETE) 사용하는 구문
-- INSERT 문 : 행 추가 (값 기록 저장)
-- UPDATE 문 : 컬럼에 기록된 값을 수정 (행 갯수 변함없음)
-- DELETE 문 :  행 삭제 (행 갯수 줄어듦, 복구 가능)
-- TRUNCATE 문 : 테이블이 가진 모든 행을 삭제함 (복구 불가능)

-- UPDATE 문
/*
UPDATE 테이블명
SET 값수정할컬럼명 = 수정할 값, 컬럼명 = DEFAULT, 컬럼명 = (서브쿼리)
WHERE 컬럼명 연산자 찾을값 | WHERE 컬럼명 연사자 (서브쿼리);

주의사항 : WHERE 절이 생략되면, 테이블의 컬럼값이 전부 수정됨
참고 : SET 절의 수정할 값 위치에 서브쿼리(SELECT 문) 사용할 수 있음
        WHERE 절에 찾을 대상(값) 위치에 서브쿼리 사용가능
*/

CREATE TABLE DCOPY2(DID PRIMARY KEY, DNAME UNIQUE, LOC_ID REFERENCES LOCATION(LOCATION_ID))
AS
SELECT * FROM DEPARTMENT;


SELECT * FROM DCOPY;

DESC DCOPY;




UPDATE DCOPY
SET DEPT_NAME = '인사팀';

ROLLBACK;

-- 부서코드 10 을 인사팀으로 바꾸기
UPDATE DCOPY
SET DEPT_NAME = '인사팀'
WHERE DEPT_ID = 10;

SELECT * FROM DCOPY;

--UPDATE 문에 서브쿼리 사용할 수 있음
-- SET 절과 WHERE 절에 사용함

-- 심하균 직원의 직급코드와 급여를 수정
-- 성혜교 직원의 직급코드와 급여와 같은 값으로 수정해야 한다면,
SELECT * FROM EMP_COPY;
--수정 전 확인
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMP_COPY
WHERE EMP_NAME IN ('심하균', '성해교');

UPDATE EMP_COPY
SET (SALARY, JOB_ID) = (SELECT SALARY, JOB_ID
                                    from EMP_COPY
                                    WHERE EMP_NAME = '성해교')
WHERE EMP_NAME ='심하균';                                  

--수정 후 확인
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMP_COPY
WHERE EMP_NAME IN ('심하균', '성해교');

-- 서브쿼리가 같은 조건의 SELECT 절의 항목만 다르다면, 다중열 서브쿼리로 바꿈
--UPDATE EMP_COPY
--SET (SALARY, JOB_ID) = (SELECT SALARY, JOB_ID
--                                    from EMP_COPY
--                                    WHERE EMP_NAME = '성해교')
--WHERE EMP_NAME ='심하균'; 

-- 테이블 생성시 컬럼에 DEFAULT 값 설정이 되어 있는 경우에는
-- 수정할 값 위치에 DEFAULT 키워드 사용할 수 있음
-- 참고 : DEFAULT 지정이 안 된 컬럼에 DEFAULT 사용시, NULL 처리됨

-- 복사 테이블에 컬럼정보 변경
ALTER TABLE EMP_COPY
MODIFY (MARRIAGE DEFAULT 'N');
DESC EMP_COPY;

-- 수정 전 확인 : 사번 210 직원 정보 확인
SELECT EMP_NAME, MARRIAGE
FROM EMP_COPY
WHERE EMP_ID = '210';

--수정
UPDATE EMP_COPY
SET MARRIAGE = DEFAULT
WHERE EMP_ID = '210';

-- 수정 후 확인 : 사번 210 직원 정보 확인
SELECT EMP_NAME, MARRIAGE
FROM EMP_COPY
WHERE EMP_ID = '210';

ROLLBACK; -- 실행된 DML 취소

-- UPDATE 문 WHERE 절에도 서브쿼리 사용할 수 있음
-- 해외영업2팀 직원들의 보너스포인트를 모두 0.3을 변경하시오.
UPDATE EMP_COPY
SET BONUS_PCT = 0.3
WHERE DEPT_ID = (SELECT DEPT_ID
                            FROM DEPARTMENT
                            WHERE DEPT_NAME = '해외영업2팀');

--확인                            
SELECT EMP_NAME, DEPT_ID, DEPT_NAME, BONUS_PCT
FROM EMP_COPY
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME = '해외영업2팀';

-- 주의 : 수정할 값 적용시 해당 컬럼의 제약조건에 위배되지 않는 값을 사용해야 함
UPDATE EMP_COPY
SET EMP_NAME = NULL
WHERE DEPT_ID IS NULL;

-- EMP_COPY 테이블에 제약조건 추가 : FOREIGN KEY
-- DEPT_ID 컬럼에 추가
ALTER TABLE EMP_COPY
ADD (FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID));


SELECT DEPT_ID FROM DEPARTMENT; -- 부모키 확인

-- 외래키 제약조건 : 부모키가 가진 값만 자식레코드에서 사용할 수 있음

UPDATE EMP_COPY
SET DEPT_ID = '65' -- 부모키에 없는 값 : 에러
WHERE DEPT_ID IS NULL;

-- 딕셔너리로 제약조건 확인

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'EMP_COPY';

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, COLUMN_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
JOIN USER_CONS_COLUMNS USING(TABLE_NAME, CONSTRAINT_NAME)
WHERE TABLE_NAME = 'EMP_COPY';

-- INSERT 문 ***
-- 테이블에 한 행을 추가할 때 사용함 : 행수가 늘어남
-- 테이블에 데이터 기록 저장할 때 사용하는 구문임
/*
INSERT INTO 테이블명 (값기록에 사용할 컬럼명, ...)
VALUES (위에 나열된 컬럼에 맞춰서 기록할 값, ...);

주의사항 : 컬럼개수와 값갯수, 컬럼자료형과 값자료형 반드시 일치시켜야 함
                값의 순서도 중요함
참고 : 컬럼명 나열이 생략되면, 테이블이 가진 전체 컬럼에 값을 기록한다는 의미임                
*/

-- TRANSACTION CONTROLL LANGUAGE

SELECT COUNT(*) FROM EMP_COPY; -- 22

INSERT INTO EMP_COPY (EMP_ID, EMP_NAME, EMP_NO, PHONE, EMAIL,
                                    SALARY, BONUS_PCT, HIRE_DATE, JOB_ID, DEPT_ID ,MARRIAGE, MGR_ID)
VALUES ('900', '오운햐', '891225-1234567', '01012345678', 'OYUNHA@KKK.COM', 4810000, 0.15, '06/01/05', 
            'J4', '30', DEFAULT, NULL);
-- INSERT 시에 값 대신에 DEFAULT 와 NULL 키워드 사용할 ㅅ ㅜ있음
            
SELECT COUNT(*) FROM EMP_COPY;

SELECT * FROM EMP_COPY;

-- 서브쿼리를 이용해서 INSERT 할 수 있음
-- VALUES 키워드 사용하지 않음
/*
INSERT INTO 테이블명 (값기록에 사용할 컬럼명, ...) <- 서브쿼리 결과 항목과 일치
(SELECT 서브쿼리);
*/

CREATE TABLE EMP (
    EMP_ID CHAR(3),
    EMP_NAME VARCHAR(20),
    DEPT_NAME VARCHAR(20)
);

INSERT INTO EMP     --(EMP_ID, EMP_NAME, DEPT_NAME)
(SELECT EMP_ID, EMP_NAME, DEPT_NAME
 FROM EMPLOYEE
 LEFT JOIN DEPARTMENT USING (DEPT_ID)
 );

SELECT * FROM EMP;

-- 행을 삭제하는 구문
/*
DELETE [FROM] 테이블명
WHERE 삭제를 위한 대상 지정용 조건식;
*/

-- WHERE 절이 생략되면 테이블의 모든 행이 삭제됨
SELECT * FROM DCOPY;

DELETE FROM DCOPY;
SELECT * FROM DCOPY;

ROLLBACK; -- DELETE 는 복구할 수 있음

-- TRUNCATE 문
-- 테이블의 모든 행을 삭제함
-- DELETE 보다 실행 속도가 빠름, 복구가 안 됨
-- 부모키(FOREIGN KEY 제약조건)가 있는 테이블에는 사용할 수 없음

TRUNCATE TABLE DCOPY;
SELECT * FROM DCOPY;
ROLLBACK; -- 복구 안 됨

TRUNCATE TABLE DEPARTMENT; -- ERROR : 참조되는 외래키가 있기때문 삭제불가

-- DELETE 구문도 FOREIGN KEY 제약조건으로 참조되고 있는 부모키는 삭제 못함

DELETE DEPARTMENT
WHERE DEPT_ID = '90';

-- 행 갯수 줄어듦
SELECT COUNT(*) FROM EMP_COPY; -- 23

DELETE FROM EMP_COPY
WHERE EMP_ID = '900';

SELECT COUNT(*) FROM EMP_COPY; -- 22



-- * ************************ * * * * * * ** * * *** * ** * ** * *  * * *  * ** ** * * ** ** * * *
-- VIEW (뷰)
/*
: SELECT 쿼리 실행의 결과를 보여주는 화면
-- 결과 화면을 가상의 테이블처럼 저장해 두고 사용할 수 있음
-- 사용 목적 :
    1. 보안에 유리 : 보관된 결과 화면만 봄으로써, 쿼리문 안 보이게 함
    2. 복잡하고 긴 쿼리문을 뷰를 
*/

/*
VIEW : SELECT 쿼리문장 저장하는 객체
SELECT OR REPLACE [NOFORCE| NOFORC DEPAUL] VIEW 뷰이름(별칭,000)
AS 서브쿼리
[WITH CHECK OPTION [CONSTRAINT 이름]'
[WITH READ ONLY [CONTRAINT 이름]];

-- CREATE VIEW | CREATE OR REPLACE VIEW
        지정하는 이름의 뷰가 없으면 새로 생성하고 (CREATE)
        뷰이름이 존재하면 수정(REPLACE)

-- FORCE | NOFORCE
    * FORCE : 서브쿼리에 사용된 테이블(베이스 테이블)이 존재하지 않아도
                         뷰 객체 생성함(단순 쿼리문 저장 용도')
    * NOFORCE : 기본 설정값임, 베이스 테이블이 존재하는 경우에만 뷰 
                    서브쿼리 SELECT 문에 정상 작동되면 뷰생성
(별칭, ALIAS,...)
-           -테이블 컬럼 별칭적용과 같은 의미임
    --> 서브컬럼 별칭과 같은 의
    -- 서브쿼리 SELECT 절의 항목 갯수와 별칭 갯수가 반드시 일치해야함.\


-서브쿼리
    : 뷰에 지정할 SELECT 구문;'
    
-- 뷰 제약조건
    * WITH CHECK OPTION
            : 뷰를 이용해서 베이스 테이블의 DML 작업 허용함
                베이스 테이블이 1개일때만 가능함
    * WITH READ ONLY
            : 뷰를 통해 DML 작업 허용 안함 제약조건으로 간주됨 별도 이름 지정 가능
** CREATE VIEW 는 권한 부여 가 필요함
*/
CREATE VIEW V_EMP
AS SELECT * FROM EMPLOYEE; -- 권한 확인

-- 뷰 만들기 : 서브쿼리 사용함
-- 뷰 생성할 때 사용하는 서브쿼리는 일반적인 SELECT 구문을 사용함
-- 생성된 뷰는 테이블처럼 취급됨
-- 뷰는 데이터가 없음

CREATE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME 이름, DEPT_NAME 부서명, JOB_TITLE 직급명, SALARY 급여
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE DEPT_ID = '90';

-- 확인
SELECT * FROM V_EMP_DEPT90;

CREATE OR REPLACE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME 이름, DEPT_NAME 부서명, JOB_TITLE 직급명, SALARY 급여
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE DEPT_ID = '90';

-- 뷰 관련 데이터 딕셔너리 : INSER_VIEWS
SELECT * FROM USER_VIEWS;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE  VIEW_NAME = 'V_EMP';

-- 실습 :
-- 직급명이 '사원'인 모든 직원들의 사원명, 부서명, 직급명을 조회하는 구문을
-- 뷰로 저장하시오

CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '사원';

SELECT * FROM V_EMP_DEPT_JOB;

-- 뷰도 테이블처럼 객체로 조회 가능함
SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM USER_TAB_COLS -- 테이브르이 컬럼 정보 관리용 딕셔너리
WHERE TABLE_NAME = 'V_EMP_DEPT_JOB';

-- 뷰 생성시 컬럼 별칭 ALIAS 사용 --------------
-- 별칭 지정 : 뷰 정의 부분, 서브쿼리 부분
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB (ENAME, DNAME, JTITLE)
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '사원';
-- 서브쿼리도 가능
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS
SELECT EMP_NAME ENM, DEPT_NAME DNM, JOB_TITLE TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE JOB_TITLE = '사원';

SELECT * FROM V_EMP_DEPT_JOB;

-- 뷰 작성시 주의사항 :
-- 서브쿼리 SELECT 절의 함수나 계산식이 있으면 반드시 ALIAS 지정할 것

-- 직원들의 이름, 성별, 나이를 근무년수하는 쿼리문을 작성하고
-- 뷰로 저장하시오. : V_EMP
CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMP_NAME 이름, DECODE( SUBSTR(EMP_NO,8,1), '1', '남', '여') 성별,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/ 12) 근무년수
FROM EMPLOYEE;

-- 뷰 생성 제약조건
-- 뷰의 원래 목적은 아니지만 뷰를 통한 DML 작업 가능 여부를 지정하는 옵션
-- DML 작업 적용 결과는 베이스 테이블에 적용됨
-- COMMIT | ROLLBACK
-- 뷰를 통한 DML 작업은 여러가지 제한이 있음

-- WITH READ ONLY : 뷰를 통한 DML작업 불가 읽기전용
CREATE OR REPLACE VIEW V_EMP
AS
SELECT * FROM EMPLOYEE
WITH READ ONLY;

-- DML 작업 유형에 따라 에러 유형은 다르지만
-- DML 작업을 허용하지 않는다.
UPDATE V_EMP
SET PHONE = NULL;

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO)
VALUES ('777', '오헌정', '777777,7777777');

DELETE FROM V_EMP;

-- WITH CHECK OPTION : 뷰를 통한 DML 작업 가능
-- 조건에 따라 INSERT, UPDATE 작업 가능하지만 제한되는 내용이 있음
-- DELETE 는 제한이 없음
CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMP_ID, EMP_NAME, EMP_NO, MARRIAGE
FROM EMPLOYEE
WHERE MARRIAGE = 'N'
WITH CHECK OPTION;

--에러
INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('777', '오헌정', '777777,7777777', 'Y');

--에러
UPDATE V_EMP
SET MARRIAGE = 'Y';

-- 뷰를 생성할 때 사용한 서브쿼리 WHERE 절 조걸이 적용되는 범위에서 허용됨

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('777', '오헌정', '777777,7777777', 'N'); -- OK

SELECT * FROM EMPLOYEE;

ROLLBACK;

UPDATE V_EMP
SET EMP_ID = '000'
WHERE EMP_ID = '124';

--확인
SELECT *
FROM EMPLOYEE
WHERE EMP_ID = '000';

ROLLBACK;

-- VIEW 사용 1 :
CREATE OR REPLACE VIEW V_EMP_INFO
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

-- 뷰를 테이블 대신 사용해서 조회할 수 있음

SELECT EMP_NAME
FROM V_EMP_INFO
WHERE DEPT_NAME = '해외영업1팀' AND JOB_TITLE = '사원';

-- 뷰 사용 2 :
CREATE OR REPLACE VIEW V_DEPT_SAL ("DID", "DNM", "DAVG")
AS
SELECT NVL(DEPT_ID, 'NO') 부서번호, 
           NVL( DEPT_NAME, 'NONE') 부서명,
           ROUND(AVG(SALARY), -3) SUMDEPT_SAL
FROM DEPARTMENT
RIGHT JOIN EMPLOYEE USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME;

SELECT * FROM V_DEPT_SAL;

-- ""를 사용한 ALIAS 는 사용시에도 "" V표기해야 함
SELECT *
FROM V_DEPT_SAL
WHERE DAVG > 3000000;

-- "" 이버전에서는 에러안남
SELECT DNM, DAVG
FROM V_DEPT_SAL
WHERE DAVG > 3000000;

-- 뷰 수정 : 별도 구문 없음
-- ALTER VIEW 구문 없음

-- 뷰 삭제 : DROP VIEW;
DROP VIEW V_EMP;

-- FORCE 옵션 : 서브쿼리에서 사용된 테이블이 존재하지 않아도 뷰 생성하도록 함
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT;  -- 에러 발생해도 뷰는 생성됨

SELECT * FROM V_EMP;

-- NOFORCE 옵션 : 기본값, 생략
CREATE OR REPLACE NOFORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT; -- ERROR

-- 뷰 객체 외에 인라인 뷰라는 개념이 있음
-- 인라인 뷰 : FROM 절에 사용하는 서브쿼리 개념

-- 소속된 부서의 부서별급여평균보다 급여를 많이 받는 직원 조회
SELECT EMP_NAME, SALARY
FROM (SELECT  NVL(DEPT_ID, 'NO') DID,
                        ROUND(AVG(SALARY), -3) DAVG
            FROM EMPLOYEE
            GROUP BY DEPT_ID) INLV
JOIN EMPLOYEE ON (NVL(DEPT_ID, 'NO') = INLV.DID)
WHERE SALARY > INLV.DAVG
ORDER BY 2 DESC;

-- DAY10_DDL_TCL.sql
-- SEQUENCE, INDEX, TCL, LOCK

-- 시퀀스 (SEQUENCE) **
-- 자동 숫자 발생기
-- 순차적으로 정수 값 자동으로 발생하는 객체 주로 INSERT할때 사용

/*
구문작성 형식 :
CREATE SEQUENCE 시퀀스이름
START WITH N
INCREMENT BY N
CHASH N         NOCHASH
CYCLE, NOCYCLE
MAXVALUE N      MINVALUE N, 
NOMAXVALUE  NOMINVALUE

* INCREMENT BY N
    : 시퀀스 번호 증가 | 감소 간격 (N은 정수 , 기본값 1

* START WITH N
    : 시퀀스 시작값 (N은 정수, 기본값 1)
    
* MAXVALUE N | NOMAXVALUE
* MINVALUE N | NOMINVALUE
    - MAXVALUE N : 시퀀스의 최대값 지정 (N은 정수)
    - NOMAXVALUE : 지정된 최대값 사용을 의미함
                (오름차순 : 10의 27승, 내림차순 : -1)
    - MINVALUE N : 시퀀스의 최소값 지정 (N은 정수)
    - NOMINVALUE : 지정된 최소값 사용을 의미함
                (오름차순 : 1, 내림차순 : -10의 26승)
    - CYCLE | NOCYCLE
        : 최대 최소값에 도달시  반복여부 결정
        반복시 시작값은 무조건 1부터 시작됨
    - CACHE | NOCAHE
    : 지정된 n개 수량을 메모리에 미리 생성할지 여부 결정
    (최소 2부터 지정할 수 있음 기본값 20)
*/
CREATE SEQUENCE SEQ_EMPID
START WITH 300  -- 시작값 : 300부터 시작
INCREMENT BY 5     -- 증가값 : 5씩증가
MAXVALUE 310    -- 310 까지 생성 
NOCYCLE         -- 310까지 생성 후 더이상 생성 안함
NOCACHE;

-- 데이터 딕셔너리 저장됨
DESC USER_SEQUENCES;
SELECT *FROM user_sequences;

-- 데이터 딕셔너리에서 시퀀스 정보 확인
SELECT SEQUENCE_NAME, CACHE_SIZE, LAST_NUMBER
FROM USER_SEQUENCES;
-- LAST_NUMBER 값은
-- NOCACHE 일때는 새로 반환될(발생될) 시퀀스 값
-- CACHE 사용 : CACHE에 저장된 시퀀스값들 중 마지막 값

-- 시퀀스 값 발생 : 시퀀스.NEXTVAL 속성 사용함
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- MAXVALUE 값에 도달했고 NOCYCLE 이기 때문에
-- 4회 사용시 에러 발생'


-- 시퀀스 만들기 2
CREATE SEQUENCE SEQ_EMPID2
START WITH 5
INCREMENT BY 5
MAXVALUE 15
CYCLE   -- MAXVALUE 15가 발생되면 다음 값은 1부터 
        -- 시작하면서 반복
NOCACHE;

-- 발생 값 확인
SELECT SEQ_EMPID2.NEXTVAL FROM DUAL;
-- 4회 사용부터 1, 6, 11이 반복적으로 생성됨

-- 시퀀스 사용 속성
/*
    NEXTVAL 
    : 새로운 숫자를 발생시키는 속성
        시퀀스이름.NEXTVAL 형태로 사용함
    CURRVAL
        : CURRENT VALUE 를 의미함
        현재 시퀀스 값을 반환하는 속성
        시퀀스이름.CURRVAL 형태로 사용함
        주의사항 : 시퀀스 객체 생성후에 NEXTVAL 이 한번 사용되거 나서 사용해야함
*/

CREATE SEQUENCE SEQ_EMPID03
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE NOCACHE;

SELECT SEQ_EMPID03.CURRVAL FROM DUAL;
-- 시퀀스 객체 생성후 NEXTVAL 이 사용이 안 된 상태에서는
-- CURRVAL 사용 못 함 (발생값이 없음)


SELECT SEQ_EMPID03.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID03.CURRVAL FROM DUAL; -- 300

-- 시퀀스 사용 : INSERT 구문에서 값 기록시 사용
CREATE SEQUENCE SEQID
START WITH 300
INCREMENT BY 1
MAXVALUE 300
NOCYCLE NOCACHE;

ALTER SEQUENCE SEQID
MAXVALUE 310;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '951225-2345678', '홍길순');

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL), '931225-2345678', '황지니');

SELECT *
FROM EMPLOYEE WHERE EMP_ID = 301;

/*
ALTER SEQUENCE SEQID
INCREMENT BY N
CHASH N         NOCHASH
CYCLE, NOCYCLE
MAXVALUE N      MINVALUE N, 
NOMAXVALUE  NOMINVALUE

    START WITH 수정불가
    시작값을 변경하려면 시퀀스 삭제하고 다시 만들기함
    한번도 사용하지 않은 시퀀스는 수정 불가
    변경된 값은 수정 이후에 시퀀스 사용시 적용
*/
CREATE SEQUENCE SEQID2
INCREMENT BY 1
START WITH 300
MAXVALUE 310
NOCYCLE NOCACHE;

ALTER SEQUENCE SEQID2
INCREMENT BY 5;

SELECT *
FROM SYS.user_sequences;


SELECT SEQID2.NEXTVAL FROM DUAL; -- 발생값 오류 : 에러

-- 시퀀스 삭제
-- DROP SEQUENCE 시퀀스이름;
DROP SEQUENCE SEQID2;

-- SEQID2 다시 마늗ㄹ기하고 나서 값 발생 하ㅗㄱ인
SELECT SEQID2.NEXTVAL FROM DUAL;
SELECT SEQID2.CURRVAL FROM DUAL;
-- SEQID2 수정하고 나서 값 발생 확인

-- 세션1
SELECT EMP_NAME,
        MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID = '143';

UPDATE EMPLOYEE
SET MARRIAGE='N'
WHERE EMP_ID = '143';

COMMIT;

-- TCL (Transaction Coltroll Language : 트랜잭션 제어어)
-- COMMIT, ROLLBACK , SAVEPOINT

-- 트랜잭션 시작 : DML 구문이 처음 사용될때(이전 트랜잭션 종료후)

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT FK_MGRID; -- 제약조건 비활성화 : DDL 
-- DDL 사용시, 이전 트랜잭션 자동 커밋함 (AUTO COMMIT) -- 트랜잭션 종료

SAVEPOINT S0;

INSERT INTO DEPARTMENT
VALUES ('45', '기획전략팀', 'A1'); -- 새 트랜잭션이 시작됨

SELECT * FROM DEPARTMENT;

SAVEPOINT S1;

UPDATE EMPLOYEE
SET DEPT_ID = '45'
WHERE DEPT_ID IS NULL;

SELECT * FROM EMPLOYEE
WHERE DEPT_ID = '45';

SAVEPOINT S2;

DELETE FROM EMPLOYEE;

SELECT COUNT(*) FROM EMPLOYEE;

--ROLLBACK; -- 트랜잭션 시작 위치까지 모든 작업이 취소됨
ROLLBACK TO S2; -- S2 위치까지만 취소됨
ROLLBACK TO S1; -- S1 위치까지만 취소됨
ROLLBACK TO S0; -- S0 위치까지만 취소됨
SET AUTOCOMMIT ON;

-- *******************************
-- 인덱스 (INDEX)

/*
SQL 명령문의 처리속도를 향상시키기 위해서 컬럼에 대해서 생성하는 객체임
-- 인덱스의 내부 구조 B* 트리 (이진트리 : BINARY TREE) 형식으로 구성됨
-- 컬럼에 인덱스를 설정하면 이를 위한 B* 트리도 생성해야 하기 때문에
    인덱스를 생성하기 위한 시간도 필요하고, 인덱스를 위한 추가 저장공간이 필요함
        (반드시 좋은 것은 아님)
-- 인덱스 생성 후에 DML 작업을 수행하면, 인덱스가 사용된 컬럼값이 변경되므로
    B* 트리 내부 구조 역시 함께 수정되므로, DML 작업이 훨씬 무거워지게 됨

* 장점
    검색속도가 빨라짐
    시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킴
* 단점
    인덱스를 위한 추가적인 공간이 필요함
    인덱스를 생성하는데 시간이 걸림
    데이터의 변경 작업 (INSERT, DELETE, UPDATE)이 자주 발생하는 경우에는
    오히려 성능이 저하됨
    
-- 키워드(컬럼값)와 해당 내용이(행) 기록된 디스크 위치(물리적인 위치)가 저장됨
-- 키워드(컬럼값)을 이용해서 검색할 때(SELECT) 자동 사용됨

-- 인덱스 구조 :
    정렬된 특정 컬럼값(KEY)과 해당 컬럼값이 기록된 행위치(ROWID)로 구성됨
    
-- 인덱스가 자동 생성되는 경우 :
    테이블 컬럼에 PRIMARY KEY 제약조건 또는 UNIQUE 제약조건 설정시
    자동으로 UNIQUE INDEX 가 생성됨 (이름은 제약조건 이름과 같음)
    * 제약조건 제거시 해당 인덱스 객체도 같이 제거됨
    
-- 인덱스 생성 구문 :
CREATE [UNIQUE] INDEX 인덱스이름
ON 테이블명 (적용할 컬럼명, 함수식);

-- 인덱스 종류
1. 고유 인덱스   unique index
2. 비고유 인덱스 nonunique index
3. 단일 인덱스 ingle index
4. 결합 인덱스 composite index
5. 함수기반 인덱스 function based index


-- UNIQUE INDEX, NONUNIQUE 로 구분됨
- NONUNIQUE INDEX : 같은 값이 여러 번 기록된 컬럼에 사용하는 인덱스
    주로 성능향상을 위한 목적으로 생성
    
- UNIQUE INDEX :
    UNIQUE INDEX 가 생성된 컬럼에는 같은 값 두번 기록 못함
    UNIQUE 제약조건 설정과 같은 동작이 수행됨
    PRIMARY KEY 가 설정된 컬럼에는 UNIQUE 인덱스가 자동 생성됨
    => PK가 지정된 컬럼값을 이용하면 검색 속도가 향상되는 효과가 있음

*/

-- UNIQUE INDEX 만들기
CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);

-- NONUNIQUE INDEX 만들기
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);

-- 인덱스 생성 실습
-- 1. EMPLOYEE 테이블의 EMP_NAME 컬럼에 'IDX_ENM' 이름의
--  UNIQUE INDEX 생성하시오.
CREATE UNIQUE INDEX IDX_ENM
ON EMPLOYEE (EMP_NAME);

-- 2. 다음과 같이 새로운 데이터를 입력해 보고, 오류 원인을 설명하시오.
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES ('400', '871120-1234567', '감우섭');

-- EMP_NAME 컬럼에 이미 '감우섭' 이름 데이터가 존재함
-- UNIQUE INDEX 지정으로 UNIQUE 제약조건의 기능이 수행됨 (중복값 입력불가)

SELECT * FROM EMPLOYEE WHERE EMP_NAME = '감우섭';

-- 인덱스 삭제
-- DROP INDEX 인덱스이릅;
DROP INDEX IDX_JID;

-- 인덱스 정보 확인 딕셔너리
DESC USER_INDEXES;
DESC USER_IND_COLUMNS;

-- 예 : EMPLOYEE 테이블에 생성된 인덱스 현황 조회
SELECT INDEX_NAME, COLUMN_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES
JOIN USER_IND_COLUMNS USING (INDEX_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMPLOYEE';

-- 검색 속도 비교해 보기
-- EMPLOYEE 테이블을 복사한 EMPL01, EMPL02 테이블 만들기
CREATE TABLE EMPL01
AS
SELECT * FROM EMPLOYEE;

CREATE TABLE EMPL02
AS
SELECT * FROM EMPLOYEE;

-- EMPL01에 EMP_ID 컬럼에 UNIQUE INDEX 만들기
CREATE UNIQUE INDEX IDX_EID
ON EMPL01 (EMP_ID);

-- 검색 속도 비교 조회함 : 처리시간 확인
SELECT * FROM EMPL01
WHERE EMP_ID = '141'; -- 0.009

SELECT * FROM EMPL02
WHERE EMP_ID = '141'; -- 0.014

-- 결합 인덱스
-- 한 개의 컬럼으로 구성한 인덱스 == 단일 인덱스 (single index)
-- 결합 인덱스 : 두 개 이상의 컬럼을 묶어서 인덱스를 구성한 것
CREATE TABLE DEPT01
AS
SELECT * FROM DEPARTMENT;

-- 부서번호와 부서명을 결합해서 인덱스 생성하기
CREATE INDEX IDX_DEPT01_COMP
ON DEPT01 (DEPT_ID, DEPT_NAME);

-- 딕셔너리에서 확인
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'DEPT01';

-- 함수 기반 인덱스
-- SELECT 절이나 WHERE 절에 계산식이나 함수식이 사용되는 경우ㅎ
-- 계산식은 인덱스의 적용을 받지 않는다.
-- 계산기으로 검색하는 경우가 많다면, 수식이나 함수식을 인덱스로 만들 수 있음
create table emp01
AS
SELECT * FROM EMPLOYEE;

CREATE INDEX IDX_EMP01_SALCALC
ON EMP01 ((SALARY + (SALARY * NVL(BONUS_PCT, 0))) *12 );

-- 딕셔너리에서 확인
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP01';
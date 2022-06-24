-- DAY7_DDL_DML1.sql
-- DDL 구문과 DML 구문

/*
DDL (DATA DEFINITION LANGUAGE : 데이터 정의어)
    데이터베이스 객체를 만들 때 사용하는 sql 구문
    현재 데이터베이스들은 ORDB (object realtional DataBase)이다.
    데이터베이스 객체 : TABLE, VIEW, SEQUENCE, INDEX, USER 등
    명령어 : CREATE(생성), ALTER(변경), DROP(제거)
    
    테이블 만들기 : CREATE TABLE
    작성형식 :
CREATE TABLE 테이블명 (
    컬럼명 자료형(바이트크기), [DEFAULT 기본값],
    컬럼명 자료형(크기) [제약조건]
);
*/

DROP TABLE TSET;

CREATE TABLE TEST (
    USERID      VARCHAR2(20),
    USERNAME    VARCHAR2(30),
    PASSWORD    VARCHAR2(20),
    AGE             NUMBER,
    ENROLL_DATE DATE
);

CREATE TABLE TEST2 (
    MEMBER_ID   VARCHAR2(15CHAR),
    MEMBER_PWD VARCHAR2(15),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE    DEFAULT SYSDATE,
    GENDER  CHAR(1)         DEFAULT 'M'
    
);

CREATE TABLE TEST3 (
    MEM_ID VARCHAR2(15) PRIMARY KEY,
    MEM_PWD VARCHAR2(15) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_DATE DATE   DEFAULT SYSDATE,
    GENDER  CHAR(1) DEFAULT 'M' CHECK (GENDER IN ('F', 'M'))

);

-- 컬럼에 설명 달기 : COMMENT ON CLOUMN 구문 사용함
-- COMMENT ON COLUMN 사용자계정.테이블명.컬럼명
COMMENT ON COLUMN TEST3.MEM_ID IS '회원아이디';
COMMENT ON COLUMN TEST3.MEM_PWD IS '회원암호';
COMMENT ON COLUMN TEST3.mem_name IS '회원이름';
COMMENT ON COLUMN TEST3.mem_date IS '회원가입날짜';
COMMENT ON COLUMN TEST3.gender IS '회원성별';


CREATE TABLE ORDERS (
    ORDERNO CHAR(4),
    CUSTNO  CHAR(4),
    ORDERDATE   DATE DEFAULT SYSDATE,
    SHIPDATE    DATE,
    SHIPADDRESS VARCHAR2(40),
    QUANTITY    NUMBER
);

COMMENT ON COLUMN orders.orderno IS '주문번호';
COMMENT ON COLUMN orders.custno IS '고객번호';
COMMENT ON COLUMN orders.orderdate IS '주문일자';
COMMENT ON COLUMN orders.shipdate IS '배송일자';
COMMENT ON COLUMN orders.shipaddress IS '배송주소';
COMMENT ON COLUMN orders.quantity IS '주문수량';


-- ********************************************************
/*
무결성 제약조건들 (CONSTRAINTS
    테이블에 데이터가 기록 또는 수정될 때 올바른 값이 기록되도록 검사하는 기능
    테이블의 저장된 데이터의 신뢰성 높이기 위한 기술임 : 데이터 무결성
    
제약조건 설정 방법 :
1. 테이블 만들 때 컬럼에 설정함
2. 테이블 만든 후에 테이블 수정시 제약조건 추가함

CREATE TABLE 테이블명 (
    컬럼명 자료형(크기) [DEFAULT 기본값] 제약조건,
    컬럼명 자료형(크기) CONSTRAINT 제약조건이름 제약조건,
    ...             컬럼 옆에 설정 : 컬럼레벨 ...         ,
    컬럼명 자료형,
    컬럼명 자료형,
    -- 컬럼 구성 완료 후에 제약조건들을 따로 모아서 설정할 수도 있음
    -- 테이블 레벨
    제약조건 (적용할컬럼명),
    CONSTRAINT 제약조건이름 제약조건 (적용할컬럼명)
);

    테이블이 생성되면, 제약조건들도 같이 생성됨
    이름 지정없이 설정된 제약조건들은 자동으로 이름이 붙여짐 : SYS_C000000 형식
    제약조건 작동은, 테이블에 데이터가 기록될 때 검사기능이 작동됨
    제약조건이 위배된 값이 기록되면 에러 발생 : 값 기록 안됨
*/


-- DML (Data Manipulation Language : 데이터 조작어)
/*
명령어 : INSERT (새로운 행 추가), UPDATE (기록된 값 수정), DELETE(행 삭제)

    INSERT 문 작성형식 :
INSERT INTO 테이블명 [(컬럼명, 컬럼명, 컬럼명, ...)]
VALUES (기록할 값, ... ...);

    테이블이 가진 모든 컬럼에 값을 기록할 때는 컬럼명 나열을 생략할 수 있음
INSERT INTO 테이블명
VALUES (기록할 값, 값, ...);
    주의사항 : 컬럼 생성 순서에 맞춰서 값을 기술해야 함
*/

-- TEST 테이블에 데이터 기록 저장 
INSERT INTO TEST
VALUES ('ABCD', 'AAAA', '1234', '3', DEFAULT);

INSERT INTO TEST (USERID, USERNAME, PASSWORD, AGE, ENROLL_DATE)
VALUES ('user001', '김유신', 'pass001', 35, TO_DATE('20211030', 'RRRRMMDD'));

SELECT * FROM TEST;

-- 제약조건 : NOT NULL -----------------------
-- 반드시 값이 기록되어야 하는 컬러멩 사용함
-- 필수입력항목의 값을 기록하는 컬럼에 적용할 수 있음
-- 컬럼에 NULL(빈칸)을 사용 못 한다는 의미임
-- 컬럼레벨에서만 설정할 수 있음. (테이블레벨에서 설정 못 함)

CREATE TABLE TESTNN (
    NID NUMBER(5) NOT NULL, -- 컬럼레벨, 제약조건 이름없으면 SYS_C.. 이름
    N_NAME VARCHAR2(20)
);

INSERT INTO TESTNN
VALUES (12, '오라클');

INSERT INTO TESTNN
VALUES (NULL,'클라오'); -- NOT NULL ERROR

INSERT INTO TESTNN (N_NAME)
VALUES ('PYTHON'); -- 제외된 컬럼은 NULL 처리됨, NOT NULL ERROR

INSERT INTO TESTNN
VALUES (2, NULL); 

-- 테이블레벨 설정 확인
CREATE TABLE TESTNN2 (
    NID NUMBER(5),
    N_NAME VARCHAR2(20),
    -- 테이블레벨
    UNIQUE (NID)
); -- ERROR
ROLLBACK;

SELECT * FROM TESTNN;


-- 제약조건 : UNIQUE ---
-- 컬럼의 중복값(같은 값 두번 기록) 기록을 검사하는 제약조건임
-- 중복 기록을 막는 검사기능임
-- 컬럼레벨, 테이블레벨 둘 다 설정 가능
-- NULL 사용 가능
DROP TABLE TESTUN;
CREATE TABLE TESTUN (
    U_ID CHAR(3) UNIQUE,
    U_NAME VARCHAR2(10) NOT NULL
);

INSERT INTO TESTUN VALUES('AAA', 'ORACLE');
INSERT INTO TESTUN VALUES('AAA', 'ORACLE'); -- 중복 에러

SELECT * FROM TESTUN;

-- 고정길이 문자열 (CHAR)과 가변길이 문자열 (VARCHAR2) 차이 확인
CREATE TABLE TESTCHAR(
    TCH CHAR(10),
    TVCH    VARCHAR2(10)
);

INSERT INTO TESTCHAR VALUES ('ORACLE', 'ORACLE');

SELECT LENGTH(tch), LENGTH(tvch) FROM TESTCHAR;
-- CHAR 타입 : 기록값이 정해진 바이트 크기보다 작으면 공백으로 나머지를 채움
-- 무조건 정해진 바이트 크기를 만듦 => 고정길이 문자열

-- CHAR 타입과 VARCHAR2 타입 값의 비교연산시

SELECT *
FROM TESTCHAR
WHERE RTRIM(TCH) = TVCH;

-- 제약조건에 이름 부여 : 컬럼 레벨
CREATE TABLE TESTUN2 (
    UN_ID CHAR(3)   CONSTRAINT UN_TUN2_ID   UNIQUE,
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TUN2_NAME NOT NULL
);


-- 제약조건에 이름 부여 : 테이블 레벨
CREATE TABLE TESTUN3 (
    UN_ID CHAR(3),
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TUN3_NAME NOT NULL,
    -- 테이블 레벨
    CONSTRAINT UN_TUN3_ID UNIQUE (UN_ID)
);

-- UNIQUE 제약조건은 테이블레벨에서 복합키로 설정할 수도 있음
-- 여러 개의 컬럼을 묶어서 하나의 제약조건을 설정하는 것 : 복합키
CREATE TABLE TESTUN4 (
    UN_ID CHAR(3),
    UN_NAME VARCHAR2(10) CONSTRAINT NN_TUN4_NAME NOT NULL,
    UN_CODE CHAR(2),
    -- 테이블 레벨
    CONSTRAINT UN_TUN4_COMP UNIQUE (UN_ID, UN_NAME) -- 복합키
    
    
);

-- 여러 개의 컬럼을 묶어서 하나의 제약조건을 설정한 경우
-- 묶여진 컬럼값들을 하나의 값으로보고 중복을 판단함
INSERT INTO TESTUN4 VALUES('100', '오라클', '01');
INSERT INTO TESTUN4 VALUES('200', '오라클', '01');

INSERT INTO TESTUN4 VALUES('200', '오라클', '02'); --에러

--UNIQUE 복합키에 대한 NULL 사용
INSERT INTO TESTUN4 VALUES(NULL, '오라클', '02');
INSERT INTO TESTUN4 VALUES('300', NULL, '02'); -- NOT NULL 에러~

SELECT * FROM TESTUN4;

-- 제약조건 : PRIMARY KEY ----
-- 기본키라고 함. (데이터베이스 정규화 과정에서 IDENTIFIER(식별키)를 말함)
-- 테이블에서 한 행의 정보를 찾아내기 위해 사용할 수 있는 컬럼을 정할 때 사용함
-- NOT NULL + UNIQUE
-- 한 테이블에 한 번만 설정할 수 있음

CREATE TABLE TESTPK (
    PID NUMBER PRIMARY KEY,
    PNAME VARCHAR2(15) NOT NULL,
    PDATE DATE
);

INSERT INTO TESTPK VALUES(100, '홍길동', '99/12/25');
INSERT INTO TESTPK VALUES(2, '김철수', TO_DATE('21/07/20'));
INSERT INTO TESTPK VALUES(NULL, '이순신', SYSDATE); -- NOT NULL ERROR
INSERT INTO TESTPK VALUES(2, '홍길동', '99/12/25'); --UNIQUE ERROR

SELECT * FROM TESTPK;

CREATE TABLE TESTPK2 (
    PID NUMBER CONSTRAINT PK_TPK2_PID PRIMARY KEY,
    PNAME VARCHAR2(15) PRIMARY KEY
);  -- PRIMARY KEY 는 한 테이블에 한번만 설정할 수 있음

-- PRIMARY KEY 제약조건은 컬럼레벨, 테이블레벨 둘 다 설정할 수 있음
CREATE TABLE TESTPK2 (
    PID NUMBER CONSTRAINT PK_TPK2_PID PRIMARY KEY,
    PNAME VARCHAR2(15)
);


CREATE TABLE TESTPK3 (
    PID NUMBER,
    PNAME VARCHAR2(15),
    -- 테이블레벨
    CONSTRAINT PK_TPK3_PID PRIMARY KEY (PID)
);


CREATE TABLE TESTPK4 (
    PID NUMBER,
    PNAME VARCHAR2(15),
    PDATE DATE,
    -- 테이블레벨
    CONSTRAINT PK_TPK4_COMP PRIMARY KEY (PID, PNAME)
);

INSERT INTO TESTPK4 VALUES(100, 'ORACLE', SYSDATE);
INSERT INTO TESTPK4 VALUES(200, 'ORACLE', '22/06/01');
INSERT INTO TESTPK4 VALUES(100, 'ORACLE', '21/03/25'); --에ㅓㄹ
INSERT INTO TESTPK4 VALUES(null, 'java', SYSDATE); -- 에러

SELECT * FROM TESTPK4;


-- 제약조건 : check --
-- 컬럼에 기록되는 값에 조건을 설정할 때 사용함
-- 컬럼레벨, 테이블레벨 둘 다 설정 가능함
-- constraint 이름 CHECK (컬럼명 연산자 제한값)
-- 제한값은 반드시 리터럴(값)만 사용할 수 있음
-- 제한값에 함수 사용 불가 (INSERT, UPDATE 할 때마다 바뀌는 값은 사용 못 함)
DROP TABLE TESTCHK;
CREATE TABLE TESTCHK (
    C_NAME VARCHAR2(15) CONSTRAINT NN_TCT_NAME NOT NULL,
    C_PRICE NUMBER(5)   CHECK (C_PRICE BETWEEN 1 AND 99999),
    C_LEVEL CHAR(1) CHECK (C_LEVEL IN ('A','B','C'))
);

-- 기록시 확인
INSERT INTO TESTCHK VALUES('객럭시', 65000,'A');
INSERT INTO TESTCHK VALUES('객럭시', 12365000,'A'); --
INSERT INTO TESTCHK VALUES('객럭시', 65000,'a');

SELECT * FROM TESTCHK;

CREATE TABLE TESTCHK2 (
    C_NAME VARCHAR2(15 CHAR) PRIMARY KEY,
    C_PRICE NUMBER(5) CHECK (C_PRICE > 0 AND C_PRICE < 1000000),
    C_LEVEL CHAR(1) CHECK (C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
--    C_DATE DATE CHECK (C_DATE >
--    C_DATE DATE CHECK (C_DATE > '16/01/01')
    C_DATE DATE CHECK (C_DATE > TO_DATE('16/01/01', 'YYYY/MM/DD')) --BUG 인대 됨
);
DROP TABLE TESTCHK2;

-- 제약조걱 : FOREIGN KEY (외래키 | 외부키) --
-- 다른(참조) 테이블이 제공하는 값만 사용할 수 있는 커럼 지정시 이용함
-- FOREIGN KEY 제약조건 설정으로 테이블 사이에 관계(RELATIONAL)가 맺어짐
-- 컬럼레벨, 테이블레벨 둘 다 설정 가능함
-- 컬럼레벨 :
-- 컬럼명 자료형 [CONSTRAINT 이름] REFERENCES 값제공테이블명 (값제공컬럼명)
-- 테이블레벨 :
-- [CONSTRAINT 이름] FOREIGN KEY (적용할컬럼명) REFERENCES 테이블명 (컬럼명)
-- (값제공컬럼명) 생략되면 참조테이블의 기본키(PRIMARY KEY) 컬럼을 사용한다는 의미
-- 값제공컬럼(참조컬럼)은 PRIMARY KEY 이거나 UNIQUE 제약조건이설정되어 있어야 사용가능
-- 제공되는 값만 기록에 사용할 수 있게 됨 => 제공되지 않는 값 기록하면 에러남
-- NULL 은 사용할 수 있음

CREATE TABLE TESTFK (
    EMP_ID CHAR(3)  REFERENCES EMPLOYEE,
    DEPT_ID CHAR(2) CONSTRAINT FK_TFK_DID REFERENCES DEPARTMENT (DEPT_ID),
    JOB_ID CHAR(2),
    -- TABLE 레벨
    CONSTRAINT FK_TFK_JID FOREIGN KEY (JOB_ID) REFERENCES JOB (JOB_ID)
);

-- 기록 확인 : 제공되는 값만 기록에 사용할 수 있음
INSERT INTO TESTFK VALUES ('100', '90', 'J4');
INSERT INTO TESTFK VALUES ('300', '90', 'J4'); -- ERROR EMP_ID
INSERT INTO TESTFK VALUES ('200', '65', 'J7'); -- ERROR DEPT_ID
INSERT INTO TESTFK VALUES ('100', '90', 'J9'); -- ERROR JOB_ID
INSERT INTO TESTFK VALUES (nulL, '90', 'J4'); -- NULL 은 가능


SELECT * FROM TESTFK;

-- 참조테이블의 참조컬럼은 반드시 PK 이거나 UNIQUE 설정이 되어 있어야 함
CREATE TABLE TEST_NOPK (
    ID CHAR(3),
    NAME VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID CHAR(3) REFERENCES TEST_NOPK (ID),
    FNAME VARCHAR2(15)
); -- 참조컬럼에 PK | UN 설정이 없음 에러

CREATE TABLE TEST_YESPK (
    ID CHAR(3) PRIMARY KEY,
    NAME VARCHAR2(15)
);

CREATE TABLE TESTFK2 (
    FID CHAR(3) REFERENCES TEST_YESPK  ,
    FNAME VARCHAR2(15)
);

CREATE TABLE TEST_YESPK2 (
    ID CHAR(3) PRIMARY KEY,
    NAME VARCHAR2(15) UNIQUE
);

CREATE TABLE TEST_YESPK3 (
    ID CHAR(3),
    NAME VARCHAR2(15),
    PRIMARY KEY (ID, NAME)
);

CREATE TABLE TESTFK9 (
    FID CHAR(3) ,
    FNAME VARCHAR2(15),
    FOREIGN KEY (FID, FNAME) REFERENCES TEST_YESPK3
);

-- 부모키(값 제공자)가 자식레크도(값 사용자)에서 사용이 되고 있으면,
-- 부모키 삭제할 수 없음

-- DML 문 : DELETE 문
-- 테이블이ㅡ 저장 데이터 삭제하는 구문 (행 삭제)
-- 작성형식 :
-- DELETE [FROM] 테이블명 

DELETE FROM DEPARTMENT 
WHERE DEPT_ID = '90';

-- FOREIGN KEY 제약조건 설정시 삭제옵션으로 부모키 삭제 가능하게 할 수도 있음
-- 삭제 옵션(DELETION OPTION)은 부모키가 삭제될 때, 자식레코드를 어떻게 처리할 것인가
-- ON DELETE SET NULL : 자식레코드를 NULL 로 바꿈
-- ON DELETE CASCADE : 자식레코드도 함께 삭제 (행 삭제)

-- FOREIGN KEY 제약조건의 기본 삭제옵션은 RESTRICTED 임 : 삭제불가능

CREATE TABLE PRODUCT_STATE (
    PSTATE CHAR(1) PRIMARY KEY,
    PCOMMENT VARCHAR2(10)
);

INSERT INTO PRODUCT_STATE VALUES ('A', '최고급');
INSERT INTO PRODUCT_STATE VALUES ('B', '중급');
INSERT INTO PRODUCT_STATE VALUES ('C', '저급');

SELECT * FROM PRODUCT_STATE;

CREATE TABLE PRODUCT (
    PNAME VARCHAR(20) PRIMARY KEY,
    PRICE NUMBER CHECK(PRICE > 0),
    PSTATE CHAR(1) REFERENCES PRODUCT_STATE ON DELETE SET NULL
);

INSERT INTO PRODUCT VALUES ('갤럭시노트', 1250000, 'A');
INSERT INTO PRODUCT VALUES ('G9', 850000, 'C');
INSERT INTO PRODUCT VALUES ('갤럭시S21', 1000000, 'B');

SELECT * FROM PRODUCT;

SELECT * 
FROM PRODUCT
LEFT JOIN PRODUCT_STATE USING (PSTATE);

-- SET NULL 확인
DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'C'; -- 부모키 삭제됨
ROLLBACK;
SELECT * FROM PRODUCT_STATE;
SELECT * FROM PRODUCT;



-- TCL (TRANSACTION CONTROL LANGUAGE : 트랜잭션 제어어)
-- 명령어 : ROLLBACK, COMMIT, SAVEPOINT
--방금 사용한 DELETE 취소가능
ROLLBACK;

--CASCADE 확인
CREATE TABLE PRODUCT2 (
    PNAME VARCHAR(20) PRIMARY KEY,
    PRICE NUMBER CHECK(PRICE > 0),
    PSTATE CHAR(1) REFERENCES PRODUCT_STATE ON DELETE CASCADE
);
INSERT INTO PRODUCT2 VALUES ('갤럭시노트', 1250000, 'A');
INSERT INTO PRODUCT2 VALUES ('G9', 850000, 'C');
INSERT INTO PRODUCT2 VALUES ('갤럭시S21', 1000000, 'B');

SELECT * FROM PRODUCT2;
COMMIT;

-- 부모키 삭제
SELECT * FROM PRODUCT_STATE;

DELETE FROM PRODUCT_STATE
WHERE PSTATE = 'A';

--자식 레코드도 함께 삭제 확인
SELECT * FROM PRODUCT2;
SELECT * FROM PRODUCT;

ROLLBACK;
-- 부모키(값 제공컬럼)가 복합키(여러 개의 컬럼을 하나로 묶은 것)이면
-- FOREIGN KEY 제약조건 설정하는 컬럼(자식레코드)도 같은 복합키로 설정해야 함


-- 참조 테이블(부모키)
CREATE TABLE TEST_COMPLEX (
    ID NUMBER,
    NAME VARCHAR2(10),
    PRIMARY KEY (ID, NAME) -- 복합키
);

INSERT INTO TEST_COMPLEX VALUES(100, 'ORACLE');
INSERT INTO TEST_COMPLEX VALUES(100, 'PYTHON');
INSERT INTO TEST_COMPLEX VALUES(200, 'JAVA');

SELECT * FROM TEST_COMPLEX;

CREATE TABLE TESTFR4 (
    FID NUMBER,
    FNAME VARCHAR2(10),
--    FOREIGN KEY (FID) REFERENCES TEST_COMPLEX (ID)
    -- 복합키는 따로 하나만 사용 못 함
    FOREIGN KEY (FID, FNAME) REFERENCES TEST_COMPLEX
    -- 복합키는 복합키로 참조되어야 함
);



CREATE TABLE CONSTRAINT_EMP (
    EID CHAR(3) CONSTRAINT PKEID PRIMARY KEY,
    ENAME VARCHAR2(20) CONSTRAINT NENAME NOT NULL,
    ENO CHAR(14) CONSTRAINT NENO NOT NULL CONSTRAINT UENO UNIQUE,
    EMAIL   VARCHAR2(25) CONSTRAINT UEMAIL UNIQUE,
    PHONE   VARCHAR2(12),
    HIRE_DATE DATE DEFAULT SYSDATE,
    JID CHAR(2) CONSTRAINT FKJID    REFERENCES  JOB ON DELETE SET NULL,
    SALARY NUMBER,
    BONUS_PCT   NUMBER,
    MARRIAGE CHAR(1) DEFAULT 'Y' CONSTRAINT CHK CHECK (MARRIAGE IN ('Y', 'N')),
    MID CHAR(3) CONSTRAINT FKMID REFERENCES CONSTRAINT_EMP ON DELETE SET NULL,
    DID CHAR(2),
    CONSTRAINT FKDID FOREIGN KEY (DID) REFERENCES DEPARTMENT ON DELETE CASCADE
);



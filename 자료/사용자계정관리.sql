-- oracle 18c xe 에서는 스터디를 위한 사용자계정이 제공이 안됨
-- 11g 까지는 scott, hr 계정이 제공이 되었음

-- 수업을 위한 사용자 계정 만들기함.
-- create user 아이디명 identified by 암호;
-- oracle 18c xe에서 사용자 계정만들 때(아이디) 계정 글자 앞에
-- 반드시 c## 을 붙여야 함. (암호는 마음대로)

create user c##student identified by student;
create user c##scott identified by tiger;

-- 접속 테스트 connect
show user; -- 현재 접속(연결)된 계정 확인
-- 다른 계정에 접속 : connect 아이디명/암호;
-- 오라클에는 축약(줄임말)명령어가 제공됨 : connect --> conn 으로 사용할 수 있음
-- conn 사용자계정/암호;
conn c##student/student; -- 로그온 권한이 없어서 접속 실패

-- 데이터베이스는 사용자계정과 암호 생성(create) 후에 권한을 부여해야 함
-- 권한 부여시 사용되는 명령 구문 : grant 권한종류, 권한종류 to 사용자계정
-- create session(로그온 권한), create table, insert into, update, delete
-- select 등등...
-- 여러 종류의 권한들을 모아 놓은 객체를 이용할 수 있음 : 롤(Role) 이라고 함
-- 오라클이 제공하는 롤 이용할 수 있음 : connect 롤, resource 롤
-- 사용자가 만들어서 사용할 수도 있음
-- grant 롤이름 to 사용자계정;
-- grant 롤이름, 롤이름 to 사용자계정;
grant connect, resource to c##student;
grant connect, resource to c##scott;

conn c##student/student;

-- 오라클 이전 버전 12C 까지는 권한만 부여하면 테이블 생성할 수 있었음
-- 18C부터는 권한 부여후에 테이블 스페이스를 할당 받아야 테이블을 생성할 수 있음
-- TABLESPACE 할당은 사용자 정보를 변경하는 것임
ALTER USER C##STUDENT
QUOTA 1024M ON USERS;

ALTER USER C##SCOTT
QUOTA 1024M ON USERS;

-- 실습 : 과제용 계정 만들고, 권한 부여하고 테이블 스페이스 할당함
-- c##homework/homework
create user c##homework identified by homework;
grant connect, RESOURCE to c##homework;
ALTER user c##homework quota 1024M on users;

-- 데이터베이스 접속시 계정 또는 암호를 오타로 에러를 발생시키면 계정 잠김
-- 잠긴 사용자계정 lock 헤제하려면 unlock 처리함
alter user c##student identified by student account unlock;

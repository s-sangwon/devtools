-- oracle 18c xe ������ ���͵� ���� ����ڰ����� ������ �ȵ�
-- 11g ������ scott, hr ������ ������ �Ǿ���

-- ������ ���� ����� ���� �������.
-- create user ���̵�� identified by ��ȣ;
-- oracle 18c xe���� ����� �������� ��(���̵�) ���� ���� �տ�
-- �ݵ�� c## �� �ٿ��� ��. (��ȣ�� �������)

create user c##student identified by student;
create user c##scott identified by tiger;

-- ���� �׽�Ʈ connect
show user; -- ���� ����(����)�� ���� Ȯ��
-- �ٸ� ������ ���� : connect ���̵��/��ȣ;
-- ����Ŭ���� ���(���Ӹ�)��ɾ ������ : connect --> conn ���� ����� �� ����
-- conn ����ڰ���/��ȣ;
conn c##student/student; -- �α׿� ������ ��� ���� ����

-- �����ͺ��̽��� ����ڰ����� ��ȣ ����(create) �Ŀ� ������ �ο��ؾ� ��
-- ���� �ο��� ���Ǵ� ��� ���� : grant ��������, �������� to ����ڰ���
-- create session(�α׿� ����), create table, insert into, update, delete
-- select ���...
-- ���� ������ ���ѵ��� ��� ���� ��ü�� �̿��� �� ���� : ��(Role) �̶�� ��
-- ����Ŭ�� �����ϴ� �� �̿��� �� ���� : connect ��, resource ��
-- ����ڰ� ���� ����� ���� ����
-- grant ���̸� to ����ڰ���;
-- grant ���̸�, ���̸� to ����ڰ���;
grant connect, resource to c##student;
grant connect, resource to c##scott;

conn c##student/student;

-- ����Ŭ ���� ���� 12C ������ ���Ѹ� �ο��ϸ� ���̺� ������ �� �־���
-- 18C���ʹ� ���� �ο��Ŀ� ���̺� �����̽��� �Ҵ� �޾ƾ� ���̺��� ������ �� ����
-- TABLESPACE �Ҵ��� ����� ������ �����ϴ� ����
ALTER USER C##STUDENT
QUOTA 1024M ON USERS;

ALTER USER C##SCOTT
QUOTA 1024M ON USERS;

-- �ǽ� : ������ ���� �����, ���� �ο��ϰ� ���̺� �����̽� �Ҵ���
-- c##homework/homework
create user c##homework identified by homework;
grant connect, RESOURCE to c##homework;
ALTER user c##homework quota 1024M on users;

-- �����ͺ��̽� ���ӽ� ���� �Ǵ� ��ȣ�� ��Ÿ�� ������ �߻���Ű�� ���� ���
-- ��� ����ڰ��� lock �����Ϸ��� unlock ó����
alter user c##student identified by student account unlock;

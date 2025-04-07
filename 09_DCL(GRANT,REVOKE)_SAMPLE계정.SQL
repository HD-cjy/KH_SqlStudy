--테이블 생성해보기 .           -- CREATE USER SAMPLE IDENTIFIED BY SAMPLE; --접속 권한을 주지 않으면 접속시 오류발생.
                                -- GRANT CREATE SESSION TO SAMPLE;


CREATE TABLE TEST (
    TEST_NO NUMBER
); 
-- ORA-01031: insufficient privileges   --불충분한 권한: SAMPLE 계정에서 CREATE TABLE 작업을 수행하기 위한 권한이 부족하여 오류 발생.



--CREATE TABLE 권한을 부여 받았으나 
--ora-01950: no privileges on tablespace 'SYSTEM' 오류 발생
-- CUZ SAMPLE 계정에 TABLE 을 만들 수 있는 TABLESPACE 저장공간을 할당 받지 못했기 때문에 오류 발생

-- TABLESPACE 저장공간 부여 받은 후 (2MB 부여받음) 
CREATE TABLE TEST (
    TEST_NO NUMBER
); 

INSERT INTO TEST VALUES(1);
SELECT * FROM TEST;

CREATE VIEW V_TEST
AS SELECT * FROM TEST;
-- 00000 -  "insufficient privileges" 불충분한 권한 
-- 뷰 권한 받은다음 
CREATE VIEW V_TEST
AS SELECT * FROM TEST;
SELECT * FROM V_TEST;

--SAMPLE 계정에서 KH 계정에 있는 테이블 접근해보기 ( 서로 다른 계정에 있는 데이터를 접근한다.)
SELECT * FROM KH.EMPLOYEE;
-- ora-00942: table or view does not exist
--접근 조차 못해서 접근 권한 없음.

--접근권한 부여 후 KH 계정에 있는 테이블에 접근 가능
SELECT * FROM KH.EMPLOYEE;
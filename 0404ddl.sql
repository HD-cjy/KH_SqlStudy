/*
DDL (data definition language)
데이터 정의 언ㅇ어

객체들을 생성(CREATE) 하고 수정(ALTER) 하고 삭제(DROP) 하는 구문 

1.ALTER
객체 구조를 수정하는 구문
<테이블 수정>
[표현법]
ALTER TABLE 테이블명 수정할 내용

-- 수정할 내용 
1) 컬럼추가/ 수정/ 삭제 
2) 제약조건 추가 / 삭제 - 수정불가(수정하고 싶다면 삭제 후 새롭게 추가해야한다.)
3) 테이블명/ 컬럼명/ 제약조건명 수정

1) 컬럼 추가 수정 삭제 
-- 컬럼 추가 ADD:  ADD 추가 컬럼명 자료형 default 기본값 (default 값은 생략가능)
*/

SELECT * FROM dept_copy;
--cname 컬럼 추가
ALTER TABLE dept_copy add cname VARCHAR2(20) DEFAULT '한국';
ALTER TABLE dept_copy add lname VARCHAR2(20); -- default 설정 없이 컬럼 추가시 null 값으로 채워짐.


-- 컬렴변경 MODIFY 
--컬럼 자료형 수정: MODIFY 수정할 컬럼명 바꿀 자료형
--default 값 수정: MODIFY 수정할 컬럼명 default 바꿀값
--### DEPT_copy 테이블의 dept_id 컬럼 자료형 char(3) 으로 변경해보기
ALTER TABLE dept_copy MODIFY dept_id char(3);

--DEPT_COPY 테이블의 DEPT_ID 컬럼 자료형을 number로 수정해보기
ALTER TABLE dept_copy MODIFY dept_id NUMBER;
-- 바꿀 자료형과 다른 데이터가 이미 담겨있다면 데이터가 비어있어야 변경 가능합니다. 

ALTER TABLE dept_copy MODIFY dept_id char(1);  
--이미 담겨있는 애들이 2 인데 더 작은걸로 바꾸려고하면 담겨있는 데이터가 더 크다고 오류로 알려줌. 



--한번에 여러개 컬럼명 변경해보기
-- --dept_title 컬럼 자료형을 varchar2(40)으로 
-- location_id 컬럼의 자료형을 varchar2(2)로 
-- -lname 컬럼의 기본값을 미국으로 변경해보기
ALTER TABLE dept_copy
MODIFY dept_title VARCHAR2(40)
MODIFY location_id VARCHAR2(2) 
MODIFY lname DEFAULT '미국';

SELECT * FROM dept_copy;
--lanme 에 default 설정 잘 먹었는지 확인
INSERT INTO DEPT_COPY(DEPT_ID,DEPT_TITLE,LOCATION_ID)
VALUES ('D10','운영부','L1'); --delfult 설정되었기 때문에 새로 들어가는 데이터 적용


--컬럼 삭제 (DROP COLUMN) : DROP column 컬럼명 
CREATE table dept_copy2
as SELECT * from DEPT_COPY;

SELECT * from DEPT_COPY2;

ALTER table dept_copy2 DROP COLUMN dept_id;

--모든 컬럼 지워보기
ALTER TABLE dept_copy2 drop COLUMN dept_title;
SELECT * from DEPT_COPY2;
ALTER TABLE dept_copy2 drop COLUMN location_id;
SELECT * from DEPT_COPY2;
ALTER TABLE dept_copy2 drop COLUMN cname;
SELECT * from DEPT_COPY2;
ALTER TABLE dept_copy2 drop COLUMN lname;
SELECT * from DEPT_COPY2; 
--- 테이블에는 적어도 하나 이상의 컬럼은 존재해야함.
--2) 제약조건 추가 / 삭제
/* 제약조건 추가
- primary key: ADD primary key (컬럼명);
-foreign key: ADD foreign key 컬럼명 REFERENCES 테이블명(컬럼명)
-unique: ADD unique (컬럼명);
-check: ADD check (컬럼명 조건)
-not null: ADD not null (컬럼명);
제약 조건명을 부여하고자 한다면 constraint 제약조건명을 앞에 
*/

-- DEPT COPY 테이블에
-- DEPT 1D컬럼에 PK 추가
-- DEPT TITLE 컬럼에 UNIQUE 추가
-- LNAME 컬럼에 NOT NULL 추가 (제약조건명 DCOPY NN으로)

ALTER TABLE dept_code
add CONSTRAINT DCOPY_PK PRIMARY KEY (DEPT_ID)
add UNIQUE (dept_title)
MODIFY lname CONSTRAINT lname_nn not NULL; --널 이미 있는데다가 낫널이 들어갈 수 없음 ㅇㅇ


SELECT * FROM DEPT_COPY;


/* 
    
    제약조건 삭제
    
    primarykey,foreign key, unique, check : drop constraint 제약조건명
    not null 제약조건 삭제 : MODIFY 컬럼명 null;
*/
--dept_copy 테이블에 있는 제약조건들 지워보기
--pk,notnull,unique 제약조건명 확인
--cname_nn
--Dcopy_pk

-- ALTER TABLE DEPT 
-- DROP CONSTRAINT Dcopy_pk
-- DROP CONSTRAINT SYS_C007208
-- DROP CONSTRAINT SYS_C007208



-- 컬럼명 제약조건명, 테이블명 변경 (rename)
--컬럼명 변경: RENAME COLUMN 기존컬럼명 to 바꿀 컬럼명
--DEPT_copy에서 dept_title 컬럼명을 dept_name 으로 변경

ALTER TABLE dept_copy rename COLUMN dept_title to dept_name;
SELECT * FROM DEPT_COPY;

-- 제약조건명 변경 :RENAME CONSTRAINT 기존 제약조건명 to 바꿀제약조건명
--dept_copy 테이블에SYS_C007192 에서 DEPT_NN으로 변경하기
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007192 to DEPT_NN;  --SYS_C007192 는 테이블 제약조건에서 직접확인하여 삽입

ALTER TABLE dept_copy RENAME to dept_test;
SELECT * from dept_copy; --이름바껴서 없음
SELECT * from dept_test; --바뀐 이름이라 출력
-------------------------------------------------------------------------------------------
/*
    DROP
    객체를 삭제하는 구문
    [표현법]
    DROP 테이블명; 
*/
--삭제 테이블 생성
CREATE TABLE DROPTABLE
AS SELECT * FROM DEPT_TEST;
SELECT * FROM DROPTABLE;

DROP TABLE DROPTABLE;

--부모테이블 삭제하는 경우
--DEPT_TEST 테이블 DEPT_ID 컬럼에 PK 추가
ALTER TABLE DEPT_TABLE ADD CONSTRAINT DTEST_PK PRIMARY KEY (DEPT_ID);

--EMPLOYEE_COPY2 테이블에 DEPT_CODE에 DEPT_TEST DEPT_ID 컬럼참조 제약조건 걸어주기
ALTER TABLE EMPLOYEE_COPY2 
ADD CONSTRAINT ECOPY2_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST;

--부모테이블 삭제하기
DROP TABLE DEPT_TEST; --외래키 참조중이라면 오류 발생합니다.

--삭제방법 2가지
--1. 참조하는 테이블 먼저 삭제 ---- 근본적 해결법은 아님.\
DROP TABLE 자식테이블;
DROP TABLE 부모테이블;


--2. (정석 방법) 테이블을 삭제할때 제약조건까지 삭제하는 방법
--부모테이블 삭제할 때 왜래키 제약조건 삭제 옵션까지 부여하기
--[표현법] DROP TABLE 테이블명 CASCADE CONSTRAINTS;
DROP TABLE DEPT_TEST CASCADE CONSTRAINTS;
SELECT * FROM DEPT_TEST; -- 조회 불가



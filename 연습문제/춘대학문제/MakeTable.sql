-- /*
--     DDL (Data Define Language)
--     데이터 정의 언어
--     객체들을 새롭게 생성 (CREATE) 하고 수정(ALTER) 하고 삭제 (DROP) 하는 구문들
    
--     1. Create 객체 생성 구문
--     2. Alter 객체 수정 구문
--     3. Drop 객체 삭제 구문
    
--     - 테이블 생성 구문
--     *테이블: 행(ROW),열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체 종류 중 하나로
--     모든 데이터는 테이블을 통해서 저장된다,(데이터를 조작하고자 하려면 데이블을 생성하고 데이터를 넣어야함)
--     [표현법]
--     CREATE TABLE 테이블명 (
--         컬럼명 자료형, 
--         컬럼명 자료형, 
--         컬럼명 자료형, 
--         ...
--         );

--         <자료형>
--         -문자 CHAR(크기) / VARCHAR2 (크기)
--         :ㅋ크기는 byte수 이며 ,숫자 영문 툭수문자는 한 글자당 1bte 한글은 3btte를 차지한다
--         char: 고정길이 크기만큼 데이터가 들어오지 않으면 나ㅏㅁ는자리 공백
--         varchar2: 가변길이 (크기보다 적은 데이터가 들어와도 그 값에 맞춰 크기 유지한다.)
--         NUMBER: 정수/ 실수 상관없이 NUMBER로 표기
--         DATE: 날짜 데이터를 담는 자료형 (년/월/일/시/분/초) 형식으로 저장

--     */
--     --회원정보 담을 테이블 (아이디 ,비밀번호 이름 생년월일)
--     CREATE TABLE MEMBER(
--         MEMBER_ID VARCHAR2(20),
--         MEMBER_PWD VARCHAR2(20),
--         MEMBER_NAME VARCHAR2(20),
--         MEMBER_DATE DATE
--     );
--     SELECT *
--     FROM MEMBER;
-- --데이터 딕셔너리 이용하여 테이블 확인
-- --데이터 딕셔너리: 다양한 객체들의 정보를 저장하고있는 시스템 테이블
-- SELECT *
-- FROM USER_TABLES;
-- --컬럼 확인
-- SELECT *
-- FROM USER_TAB_COLUMNS;
-- --현재 사용자가 가지고있는 테이블들의 모든 컬럼을 조회할 수 있는 딕셔너리
-- --comments 적어두기
-- --컬럼에 대한 설명을 달아 둘 수있다.
-- --[표현법] comment on column member.member_id is '주석내용';
-- comment on column member.member_id is '회원 아이디';
-- comment on column member.member_pwd is '회원 비밀번호';
-- comment on column member.member_NAME is '회원 이름';
-- comment on column member.member_DATE is '회원 생년월일';

-- SELECT * FROM MEMBER;


-- --DML: INSERT 사용하여 데이터를 넣어보자 
-- --한 행으로 데이터 추가 구문
-- --[표현법] INSERT INTO 테이블명 VALUE(값,값,값,....); 값의 순서가 중요 (테이블 컬럼 정의 순서와 맞춰야한다.)
-- INSERT INTO MEMBER VALUES ('user01','pass01','김유저','010100');
-- INSERT INTO MEMBER VALUES ('user02','pass02','박유저','011099');--제약조건을 걸지 않았기에 NULL 허용된다. 그래서 수정해줘야한다
-- --위 NULL이 들어가면 안되기 때문에 제약조건을 부여해야한다.
-- SELECT *FROM MEMBER;

-- /*
--     < 제약조건 CONSTRAINT >
--     -원하는 데이터만 유지하기 위해( 보관하기 위해 ) 특정 컬럼마다 설정하는 제약
--     -제약 조건이 부여된 컬럼에 들어올 데이터에 문제가 없는지 검사해준다.
--     -종류: NOT NULL / UNIQUE / CHECK / PRINARY KEY /FOREIGN KEY

--     1. NOT NULL 제약조건
--     해당 컬럼에는 반드시 값이 존재해야하는 경우 사용
--     -NULL값이 들어와서는 안되는 컬럼이 있다면 NOT NULL 제약 조건을 부여한다.
--     -삽입 / 수정시 NULL 값을 허용하지 않게 됨.
--     -부여방식: 컬럼 레벨 방식
--     */

-- CREATE TABLE MEM_NOTNULL(
--     MEM_NO NUMBER NOT NULL,  --컬럼 레벨 방식 (컬럼명 자료형 제약조건)
--     MEM_ID VARCHAR2(20) NOT NULL,
--     MEMBER_PWD VARCHAR2(20) NOT NULL,
--     MEMBER_NAME VARCHAR2(20) NOT NULL,  
--     GENDER CHAR(3),
--     PHONE VARCHAR2(15),
--     EMAIL VARCHAR2(30)
-- );

-- SELECT * FROM MEM_NOTNULL;
-- --데이터 삽입
-- INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01','김유저','남','010-2222-3333','user01@gmail.com');
-- INSERT INTO MEM_NOTNULL VALUES(2,'user02','pass02','박유저','여','010-1111-3232','user02@gmail.com');
-- --INSERT INTO MEM_NOTNULL VALUES(NULL,'user01','pass01','김유저','남','010-2222-3333','user01@gmail.com');
-- --MEM_NO는 NOT NULL 제약조건이 부여되어있어서 NULL값을 허용하지 않고 오류 발생 
-- --제약조건을 사용하여 데이터 무결성을 지킬 수 있다.
-- INSERT INTO MEM_NOTNULL VALUES (3,'user03','pass03','박회원',NULL,NULL,NULL);

-- /*
--     2.UNIQUE 제약 조건 
--     컬럼에 중복값을 제한하는 제약조건 
--     삽입 / 수정시 기존에 중복값이 존재할 경우
--     추가 또는 수정이 되지 않도록 제약한다.

--     부여방식: 컬럼레벨방식/테이블방식
-- */

-- create table MEM_UNIQUE(
--     MEM_NO NUMBER NOT NULL UNIQUE,  --컬럼 하나에 N개의 제약조건 부여가능 (나열로 표시)
--     MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
--     MEMBER_PWD VARCHAR2(20) NOT NULL,
--     MEMBER_NAME VARCHAR2(20) NOT NULL,  
--     GENDER CHAR(3),
--     PHONE VARCHAR2(15),
--     EMAIL VARCHAR2(30)
-- );

-- SELECT * FROM MEM_UNIQUE;
-- INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','김유저','남','010-2222-3333','user01@gmail.com');
-- INSERT INTO MEM_UNIQUE VALUES(1,'user02','pass01','김유저','남','010-2222-3333','user01@gmail.com'); -- 중복이 같음으로 유니크 제약조건 위배 
-- INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass01','김유저','남','010-2222-3333','user01@gmail.com'); -- 중복이 같음으로 유니크 제약조건 위배 
-- --테이블 삭제
-- DROP TABLE MEM_UNIQUE;

-- --제약조건 테이블레벨링 방식으로 부여해보기
-- create table MEM_UNIQUE(
--     MEM_NO NUMBER NOT NULL,  --컬럼 하나에 N개의 제약조건 부여가능 (나열로 표시)
--     MEM_ID VARCHAR2(20) NOT NULL,
--     MEMBER_PWD VARCHAR2(20) NOT NULL,
--     MEMBER_NAME VARCHAR2(20) NOT NULL,  
--     GENDER CHAR(3),
--     PHONE VARCHAR2(15),
--     EMAIL VARCHAR2(30),
--     UNIQUE(MEM_NO,MEM_ID) --테이블 레벨 방식
-- );
-- SELECT * 
-- FROM MEM_UNIQUE;
-- --제약조건명을 별도로 작성하지 않으면 SYS_C~~로 임의 이름을 부여한다.
-- -- 제약조건명은 중복 불가.

-- /*
--     제약조건 명 부여방법
--     -컬럼 레벨 방식

--     CREATE TABLE 테이블명 (
--         컬럼명 자료형,
--         컬럼명 자료형,
--         ...,
--         CONSTRAINT 제약조건명 제약조건 (컬럼)
--         );
-- */

-- CREATE TABLE MEM_CON_NN (
--     MEM_NO NUMBER CONSTRAINT MEM_ID_NN NOT NULL,
--     MEM_ID VARCHAR2 (20) NOT NULL,
--     MEM_PWD VARCHAR2 (20) NOT NULL,
--     MEM_NAME VARCHAR2 (20) NOT NULL,
--     GENDER CHAR (3) ,
--     PHONE VARCHAR2 (15) ,
--     EMAIL VARCHAR2 (30),
--     CONSTRAINT MEM_NO_UQ UNIQUE(MEM_NO)--테이블레벨 방식
-- );


-- DROP TABLE MEM_CON_NN;
-- INSERT INTO MEM_CON_NN VALUES(1,'user01','pass01','김유저','남','010-2222-3333','user01@gmail.com');
-- INSERT INTO MEM_CON_NN VALUES(2,'user02','pass02','박유저','여','010-1111-3333','user02@gmail.com'); -- 중복이 같음으로 유니크 제약조건 위배 
-- INSERT INTO MEM_CON_NN VALUES(3,'user03','pass03','이유저','남','010-5555-3333','user03@gmail.com'); -- 중복이 같음으로 유니크 제약조건 위배 

-- SELECT * from MEM_CON_NN;

-- /* CHECK 제약조건
--     특정 컬럼에 특정 값만 들어갈 수 있도록 제약하는 제약조건 
--     EX)성별에 남 / 여만 들어갈 수 있도록

--     [표현법]
--     CHECK(조건)
-- */



-- INSERT INTO MEM_CHECK VALUES(1,'user01','pass01','김유저','남','010-2222-3333','user01@gmail.com',sysdate);
-- INSERT INTO MEM_CHECK VALUES(2,'user02','pass02','박유저','여','010-1111-3333','user02@gmail.com',sysdate); -- 중복이 같음으로 유니크 제약조건 위배 
-- INSERT INTO MEM_CHECK VALUES(3,'user03','pass03','이유저','중성','010-5555-3333','user03@gmail.com',sysdate); -- 중복이 같음으로 유니크 제약조건 위배 

-- SELECT * 
-- FROM MEM_CHECK;

-- /* 
--     DEFAULT설정
--     특정 컬럼에 데이터가 들어갈때 기본적으로 들어가는 기본값이 있다면
--     해당 값을 기본으로 설정 가능
--     - 제약조건 아님
--     EX)퇴사여부 N / 입사일 SYSDATE /휴학여부 (Y/N) ... 
-- */
-- DROP TABLE MEM_CHECK;

-- CREATE Table MEM_CHECK(
--     MEM_NO NUMBER NOT NULL,
--     MEM_ID VARCHAR2 (20) NOT NULL,
--     MEM_PWD VARCHAR2 (20) NOT NULL,
--     MEM_NAME VARCHAR2 (20) NOT NULL,
--     GENDER CHAR (3) , CHECK(GENDER IN ('남','여')),
--     PHONE VARCHAR2 (15) ,
--     EMAIL VARCHAR2 (30),
--     MEM_DATE DATE DEFAULT SYSDATE NOT NULL
-- );
-- INSERT INTO MEM_CHECK VALUES(1,'user01','pass01','김유저','남','010-2222-3333','user01@gmail.com',SYSDATE);
-- INSERT INTO MEM_CHECK VALUES(2,'user02','pass02','박유저','여','010-1111-3333','user02@gmail.com',DEFAULT); -- 중복이 같음으로 유니크 제약조건 위배 
-- INSERT INTO MEM_CHECK VALUES(3,'user03','pass03','아유저','여','010-2422-3333','user03@gmail.com',DEFAULT); -- 중복이 같음으로 유니크 제약조건 위배 

-- /* 
--     INSERT구문에서 컬럼명을 나열해주면 나열되지 않은 컬럼에 대해서는 기본값이 삽입된다.
--     [표현법]
--     INSERT INTO 테이블명(컬럼1,컬럼2,컬럼3, ... ) VALUES (값1,값2,값3,...);
--     테이블명 뒤에 컬럼을 나열하는데 이때 나열되지 않은 컬럼에는 기본값인 NULL이 들어가고 
--     만약 DEFAULT가 설정 되어있는 컬럼이라면 DEFAULT에 설정한 값이 들어간다.

--     **NOT NULL 제약조건이 걸려있는 컬럼은 컬럼 나열에 꼭 포함되거나 DEFAULT값이 있어야함.
-- */
-- INSERT INTO MEM_CHECK(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (3,'user03','pass03','아유저');

-- SELECT * 
-- FROM MEM_CHECK;

-- /* PRIMARYKEY 기본키 제약조건 
-- 테이블에서 각 행들의 정보를 유일하게 식별할 수 있는 컬럼에 부여하는 제약조건
-- - 각 행들을 구분할 수 있는 식별자의 역할
-- EX) 사번,부서코드,직급코드,... 
-- --NOT NULL 제약조건과 UNIQUE 제약조건이 기본적으로 설정되어있음
-- **한 테이블에는 하나의 컬럼에만 지정가능 (고유식별자 역할)
-- */
-- DROP TABLE MEM_PK;
-- CREATE TABLE MEM_PK(
--     MEM_NO NUMBER CONSTRAINT MEM_NO_PK PRIMARY KEY,
--     MEM_ID VARCHAR2(20), 
--     MEM_PWD VARCHAR2 (20) NOT NULL,
--     MEM_NAME VARCHAR2 (20) NOT NULL,
--     GENDER CHAR (3) ,
--     PHONE VARCHAR2 (15) ,
--     EMAIL VARCHAR2 (30),
--     HIRE_DATE DATE DEFAULT SYSDATE
-- );  
-- INSERT INTO MEM_PK(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (1,'user01','pass01','김유저');

-- SELECT * FROM MEM_PK;

-- CREATE TABLE MEM_PK2(
--     MEM_NO NUMBER CONSTRAINT MEM_NO_PK PRIMARY KEY,
--     MEM_ID VARCHAR2(20), 
--     MEM_PWD VARCHAR2 (20) NOT NULL,
--     MEM_NAME VARCHAR2 (20) NOT NULL,
--     GENDER CHAR (3) ,
--     PHONE VARCHAR2 (15) ,
--     EMAIL VARCHAR2 (30),
--     HIRE_DATE DATE DEFAULT SYSDATE ,
--     CONSTRAINT MEM_ID_PK PRIMARY KEY (MEM_ID) --테이블 레벨 방식 
-- );  

-- CREATE TABLE MEM_PK3(
--     MEM_NO NUMBER,
--     MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
--     MEM_PWD VARCHAR2 (20) NOT NULL,
--     MEM_NAME VARCHAR2 (20) NOT NULL,
--     GENDER CHAR (3) ,
--     PHONE VARCHAR2 (15) ,
--     EMAIL VARCHAR2 (30),
--     HIRE_DATE DATE DEFAULT SYSDATE ,
--     CONSTRAINT MEM_ID_PK PRIMARY KEY (MEM_ID,MEM_NO) --테이블 레벨 방식 
-- );  
-- --MEM NO와 ID의 묶음을 하나의 식별자로 사용함.

-- --복합키로 설정한 두 컬럼에 데이터가 모두 같아야 중복으로 판정
-- --즉, PK로 지정된 값이 2개이상이라면, 최대 00 01 10 11 4개의 값을 넣을 수 있는것 

-- /* 
--     FOREIGN KEY(외래키)
--     해당 컬럼에 다른 테이블에 존재하는 값만 허용하도록 컬럼에 부여하는 제약조건 
--     -다른 테이블을 참조한다.
--     참조된 다른 테이블이 가지고 있는 값만 허용됨
--     JOIN 구문에서 활용할 수 있는 컬럼

-- [표현법]
-- -컬럼레벨 방식
-- 컬럼명 자료형 CONSTRAINT 제약조건명 REFERACNCE 참조테이블명 (참조컬럼명)

-- -테이블 레벨 방식
-- CONSTRAINT 제약조건명 FOREIGN KEY (컬럼명) REFERANCE 참조테이블명(참조컬럼명)

-- -생략가능한 것: CONSTRAINT /참조 컬럼명(생략시 참조테이블의 기본 키로 잡힘)
-- 주의: 참조할 컬럼타입과 외래키로 지정할 컬럼 타입이 같아야함.
-- */
-- CREATE TABLE MEM_GRADE(
--     GRADE_CODE CHAR(2) PRIMARY KEY,
--     GRADE_NAME VARCHAR2(20) NOT NULL
-- );
-- INSERT INTO MEM_GRADE VALUES ('G1','일반회원');
-- INSERT INTO MEM_GRADE VALUES ('G2','우수회원');
-- INSERT INTO MEM_GRADE VALUES ('G3','특별회원');

-- SELECT * FROM MEM_GRADE;
-- CREATE TABLE MEM(
--     MEM_NO NUMBER PRIMARY KEY,
--     MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
--     MEM_PWD VARCHAR2(20) NOT NULL,
--     MEM_NAME VARCHAR2(20) NOT NULL,
--     GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
--     GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE), --컬럼레벨 방식 MEM_GRADE의 GRADE_CODE 컬럼을 참조한다.
--     PHONE VARCHAR2(15),
--     EMAIL VARCHAR2(30),
--     HIRE_DATE DATE DEFAULT SYSDATE 
-- );
-- -- 테이터 삽입 
-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GRADE_ID)
--     VALUES(1,'user01','pass01','김유저','g1'); --부모테이블에 없는 데이터 삽입하려 하면 에러

-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GRADE_ID)
--     VALUES(1,'user01','pass01','김유저','G1'); --부모테이블에 없는 데이터 삽입하려 하면 에러
-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GRADE_ID)
--     VALUES(2,'user02','pass02','김유저','G2');
-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GRADE_ID)
--     VALUES(3,'user03','pass03','김유저','G3'); 

-- SELECT * FROM mem;

-- --외래키로 설정된 컬럼은 조인 조건으로 활용가능
-- SELECT MEM_NO,MEM_ID,MEM_NAME,GRADE_NAME
-- from MEM
-- JOIN MEM_GRADE ON (GRADE_CODE = GRADE_ID);

-- --참조 컬럼에 NULL 삽입해보기
-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME, GRADE_ID)
-- VALUES (4, 'asd1004' , 'QWEQWE123123' , '박천사', NULL);
-- --NOT NULL 제약조건이 없어서 삽입ㄱ능 

-- SELECT * FROM mem;
-- -- 자식 테이블에서 참조되고 있기 떄문에 삭제 불가.
-- -- 기본적으로 외래키에는 삭제시 제한 옵션이 적용되어있음
-- -- 때문에 지우고자한다면 해당 삭제시 제한 옵션을 외래키 설정시 부여해야함.

-- DELETE FROM MEM_GRADE
-- WHERE GRADE_CODE = 'G1'; --G1데이터 행 삭제


-- /* 
--     자식 테이블 생성시 (외래키 제약조건 부여시)
--     부모테이블의 데이터가 삭제 되었을 때 자식 테이블에는 어떻게 처리 할 것인지 옵션으로 지정
    

--     FOREIGN KEY 삭제 옵션
--     -ON DELETE SET NULL: 부모 데이터를 삭제 할 때 해당 데이터를 참조하는 자식 데이터를 NULL로  변경한다.
--     -ON DELETE SET CASCADE: 부모 데이터를 삭제할 때 해당 데이터를 참조하는 자식 데이터를 같이 삭제하겠다.
--     -ON DELETE RESTRICTED: 삭제 제한(기본 값)
-- */ 

-- DROP table mem;

-- CREATE TABLE MEM(
--     MEM_NO NUMBER PRIMARY KEY,
--     MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
--     MEM_PWD VARCHAR2(20) NOT NULL,
--     MEM_NAME VARCHAR2(20) NOT NULL,
--     GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
--     GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE), --컬럼레벨 방식 MEM_GRADE의 GRADE_CODE 컬럼을 참조한다.
--     PHONE VARCHAR2(15),
--     EMAIL VARCHAR2(30),
--     HIRE_DATE DATE DEFAULT SYSDATE 
-- );

-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GRADE_ID)
--     VALUES(1,'user01','pass01','김유저','G1'); --부모테이블에 없는 데이터 삽입하려 하면 에러
-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GRADE_ID)
--     VALUES(2,'user02','pass02','박사원','G2');
-- INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GRADE_ID)
--     VALUES(3,'user03','pass03','김사원','G3'); 



============================================================================================================
CREATE Table TB_DEPARTMENT(
    DEPARTMENT_NO VARCHAR2(10) NOT NULL PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(20)NOT NULL,
    CATEGORY VARCHAR2 (20) , 
    OPEN_YN CHAR(1),
    CAPACITY NUMBER 
);
COMMENT ON COLUMN TB_DEPARTMENT.DEPARTMENT_NO IS '학과 번호';
COMMENT ON COLUMN TB_DEPARTMENT.DEPARTMENT_NAME IS '학과 이름';
COMMENT ON COLUMN TB_DEPARTMENT.CATEGORY IS '계열';
COMMENT ON COLUMN TB_DEPARTMENT.OPEN_YN IS '개설 여부';
COMMENT ON COLUMN TB_DEPARTMENT.CAPACITY IS '정원';


-- 컬럼명 자료형 CONSTRAINT 제약조건명 REFERACNCE 참조테이블명 (참조컬럼명)

DROP TABLE TB_STUDENT;
CREATE Table TB_STUDENT(
    STUDENT_NO VARCHAR2(10) NOT NULL PRIMARY KEY,
    DEPARTMENT_NO VARCHAR2(10) NOT NULL,
    CONSTRAINT FK_DEPARTMENT_NO FOREIGN KEY(DEPARTMENT_NO) REFERENCES TB_DEPARTMENT(DEPARTMENT_NO),
    STUDENT_NAME VARCHAR2(30) NOT NULL,
    STUDENT_SSN VARCHAR2(14),
    STUDENT_ADDRESS VARCHAR2(200),
    ENTRANCE_DATE DATE,
    ABSENCE_YN CHAR(1) DEFAULT 'N',
    COACH_PROFESSOR_NO VARCHAR2(10) REFERENCES TB_DEPARTMENT(DEPARTMENT_NO)
);
COMMENT ON COLUMN TB_STUDENT.STUDENT_NO IS '학생 번호';
COMMENT ON COLUMN TB_STUDENT.DEPARTMENT_NO IS '학과 번호';
COMMENT ON COLUMN TB_STUDENT.STUDENT_NAME IS '학생 이름';
COMMENT ON COLUMN TB_STUDENT.STUDENT_SSN IS '학생 주민번호';
COMMENT ON COLUMN TB_STUDENT.STUDENT_ADDRESS IS '학생 주소';
COMMENT ON COLUMN TB_STUDENT.ENTRANCE_DATE IS '입학 일자';
COMMENT ON COLUMN TB_STUDENT.ABSENCE_YN IS '휴학 여부 ';
COMMENT ON COLUMN TB_STUDENT.COACH_PROFESSOR_NO IS '지도 교수 번호';

CREATE Table TB_CLASS(
    CLASS_NO VARCHAR2(10) NOT NULL PRIMARY KEY,
    DEPARTMENT_NO VARCHAR2(10) NOT NULL,
    CONSTRAINT FK_DEPARTMENT_NO FOREIGN KEY(DEPARTMENT_NO) REFERENCES TB_DEPARTMENT(DEPARTMENT_NO),
    PREATTENDING_CLASS_NO VARCHAR2(10),  -- Added comma here
    CLASS_NAME VARCHAR2(30) NOT NULL,
    CLASS_TYPE VARCHAR2(10)
);
COMMENT ON COLUMN TB_CLASS.DEPARTMENT_NO IS '과목 번호';
COMMENT ON COLUMN TB_CLASS.DEPARTMENT_NAME IS '학과 번호';
COMMENT ON COLUMN TB_CLASS.CATEGORY IS '선수 과목 번호';
COMMENT ON COLUMN TB_CLASS.OPEN_YN IS '과목 이름';
COMMENT ON COLUMN TB_CLASS.CAPACITY IS '과목 구분';

CREATE Table TB_CLASS_PROFESSOR(
    CLASS_NO VARCHAR2(10) NOT NULL,
    PROFESSOR_NO VARCHAR2(10) NOT NULL,
    CONSTRAINT FK_CLASS_NO FOREIGN KEY(CLASS_NO) REFERENCES TB_CLASS(CLASS_NO),
    CONSTRAINT FK_PROFESSOR_NO FOREIGN KEY(PROFESSOR_NO) REFERENCES TB_PROFESSOR(PROFESSOR_NO),
    CONSTRAINT TB_CLASS_PROFESSOR_PK PRIMARY KEY (CLASS_NO,PROFESSOR_NO)
);
COMMENT ON COLUMN TB_CLASS_PROFESSOR.CLASS_NO IS '과목 번호';
COMMENT ON COLUMN TB_CLASS_PROFESSOR.PROFESSOR_NO IS '교수 번호';

-- 교수 테이블 생성
CREATE TABLE TB_PROFESSOR(
    PROFESSOR_NO VARCHAR2(10) NOT NULL PRIMARY KEY,
    PROFESSOR_NAME VARCHAR2(30) NOT NULL,
    PROFESSOR_SSN VARCHAR2(14),
    PROFESSOR_ADDRESS VARCHAR2(100),
    DEPARTMENT_NO VARCHAR2(10),
    CONSTRAINT FK_PROFESSOR_DEPARTMENT FOREIGN KEY(DEPARTMENT_NO) REFERENCES TB_DEPARTMENT(DEPARTMENT_NO)
);

-- 성적 테이블 생성
CREATE TABLE TB_GRADE(
    TERM_NO VARCHAR2(10) NOT NULL,
    CLASS_NO VARCHAR2(10) NOT NULL,
    STUDENT_NO VARCHAR2(10) NOT NULL,
    POINT NUMBER(3,2),
    CONSTRAINT PK_GRADE PRIMARY KEY(TERM_NO, CLASS_NO, STUDENT_NO),
    CONSTRAINT FK_GRADE_CLASS FOREIGN KEY(CLASS_NO) REFERENCES TB_CLASS(CLASS_NO),
    CONSTRAINT FK_GRADE_STUDENT FOREIGN KEY(STUDENT_NO) REFERENCES TB_STUDENT(STUDENT_NO)
);


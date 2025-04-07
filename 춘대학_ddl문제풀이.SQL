CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    CONSTRAINT CATEGORY_PK PRIMARY KEY(NAME),
    USE_YN CHAR(1) DEFAULT 'Y'
);
DROP TABLE TB_CATEGORY;
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(20)
);

-- --기본 데이터 삽입 구문
-- INSERT INTO TB_CATEGORY VALUES('공학','Y');
-- INSERT INTO TB_CATEGORY VALUES('자연과학','Y');
-- INSERT INTO TB_CATEGORY VALUES('의학','Y');

-- --컬럼을 지정해서 데이터 삽입
-- INSERT INTO TB_CLASS_TYPE(NO, NAME) VALUES('01','전공필수');
-- INSERT INTO TB_CLASS_TYPE(NO, NAME) VALUES('02','전공선택');
-- INSERT INTO TB_CLASS_TYPE(NO, NAME) VALUES('03','교양필수');
-- INSERT INTO TB_CLASS_TYPE(NO, NAME) VALUES('04','교양선택');
-- INSERT INTO TB_CLASS_TYPE(NO, NAME) VALUES('05','논문지도');

-- --다중 데이터 삽입
-- INSERT ALL
-- INTO TB_CATEGORY VALUES('예체능','Y')
-- INTO TB_CATEGORY VALUES('인문사회','Y')
-- SELECT * FROM DUAL;

INSERT ALL 
INTO TB_CLASS_TYPE  VALUES('01','전공필수')
INTO TB_CLASS_TYPE  VALUES('02','전공선택')
INTO TB_CLASS_TYPE  VALUES('03','교양필수')
INTO TB_CLASS_TYPE  VALUES('04','교양선택')
INTO TB_CLASS_TYPE  VALUES('05','논문지도')
SELECT * FROM DUAL;

SELECT * FROM TB_CLASS_TYPE;

CREATE TABLE TB_학생일반정보 AS 
                            SELECT STUDENT_NO,STUDENT_NAME,STUDENT_ADDRESS
                            FROM TB_STUDENT;

SELECT * FROM TB_학생일반정보;

SELECT *
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '국어국문학과';
---3 국어국문학과 학생들의 정보만이 포함되어있는 학과정보 테이블을 만들고자 한다.
-- 아래 내용을 참고하여 적절한 sql문을 작성하시오
-- 테이블 이름은 TB_국어국문학과
-- 학생번호, 학생이름, 출생년도 (4자리 년도로 표기), 교수 이름을 포함하는 테이블을 만들고자 한다.
-- 학생번호는 학생테이블에서 가져오고, 출생년도는 학생테이블에서 가져오고, 교수 이름은 교수테이블에서 가져오는 방식으로 만들고자 한다.
CREATE TABLE TB_국어국문학과 AS 
SELECT STUDENT_NO,STUDENT_NAME, 19||SUBSTR(STUDENT_SSN,1,2) AS 출생년도,PROFESSOR_NAME
FROM TB_STUDENT S
LEFT JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
left JOIN TB_PROFESSOR P ON D.DEPARTMENT_NO = P.DEPARTMENT_NO
WHERE D.DEPARTMENT_NAME = '국어국문학과';
SELECT * FROM  TB_국어국문학과;

DROP TABLE TB_국어국문학과;

--현 학과들의 정원을 10% 증가시키게 되었다 이때 sql문을 작성. (단, 반올림을 사용해서 소숫점 자릿수는 없도록 해라)
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY * 1.1, 0);
SELECT * FROM TB_DEPARTMENT;

--학번 A413042인 박건우 학생의 주소가 서울시 종로구 숭인동 181-21로 변경되었다고 한다. 주소지를 정정해라.(update문 사용) 
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
WHERE STUDENT_NO = 'A413042';
SELECT * FROM TB_STUDENT;

--학생테이블을 복사하여 blind_num 테이블을 만들고 , 모든 학생의 주민번호 뒷자리를 * 처리 하는 적절한 sql문 작성
CREATE TABLE TB_BLIND_NUM AS 
SELECT * FROM TB_STUDENT;

UPDATE TB_BLIND_NUM
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 7) || '******';

SELECT * FROM TB_BLIND_NUM;


-- 7. 의학과 김영훈 학생은 2005년 1 학기에 자신이 수강한 피부생리학 점수가
-- 잘못되었다는 것을 발견하고는 정정을 요청하였다. 담당 교수의 확인 받은 결과 해당
-- 과목의 학점을 3.5로 변경기로 결정되었다. 적절한 SQL 문을 작성하시오. (update문, 서브쿼리 사용)

UPDATE TB_GRADE
SET POINT = 3.5
WHERE STUDENT_NO = (SELECT STUDENT_NO 
                    FROM TB_STUDENT 
                    WHERE STUDENT_NAME = '김명훈'
                    AND DEPARTMENT_NO = (SELECT DEPARTMENT_NO 
                                        FROM TB_DEPARTMENT 
                                        WHERE DEPARTMENT_NAME = '의학과'))
AND CLASS_NO = (SELECT CLASS_NO 
                FROM TB_CLASS 
                WHERE CLASS_NAME = '피부생리학')
AND TERM_NO = '200501';

SELECT * FROM TB_GRADE;

SELECT * FROM TB_STUDENT
where ABSENCE_YN = 'Y';

DELETE from TB_GRADE
WHERE STUDENT_NO in (SELECT STUDENT_NO FROM TB_STUDENT
where ABSENCE_YN = 'Y');
ROLLBACK;
SELECT * from TB_GRADE;

-- ==============================DDL 3 완료 
--4. TB-CLASS-TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

--5. 두 테이블에서 컬럼명이 N0인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
-- NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
-- CREATE TABLE TB_CATEGORY(
--     NAME VARCHAR2(10),
--     CONSTRAINT CATEGORY_PK PRIMARY KEY(NAME),
--     USE_YN CHAR(1) DEFAULT 'Y'
-- );
-- DROP TABLE TB_CATEGORY;
-- CREATE TABLE TB_CLASS_TYPE(
--     NO VARCHAR2(5) PRIMARY KEY,
--     NAME VARCHAR2(20)
-- );
-- 6. 두 테이블의 N0 컬럼과 NAME 컬럼의 이름을 각 각 TB- 를 제외한 테이블 이름이 앞에
-- 붙은 형태로 변경한다.
ALTER 

/*

    DML(DATA MANIPULATION LANGUAGE)
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입 (INSERT) 하거나
    기존의 데이터를 수정(UPDATE) 하거나 
    삭제 (DELETE)하는 구문

    1. INSERT: 테이블에 새로운 데이터 행을 추가하는 구문
    [표현법]
    INSERT INTO 테이블명 VALUES(값1,값2...);
    -해당 테이블에 모든컬럼에 데이터를 추가하고자 할때 사용하는 구문
    -컬럼의 순서 자료형 개수를 맞춰서 VALUES괄호 안에 나열해야한다.
    -나열된 데이터가 정해진 컬럼보다 적을 경우: NOT ENOUGH VALUES 오류
    -나열된 데이터가 정해진 컬럼보다 많을 경우: TOO MANY VALUES 오류
*/

SELECT * FROM EMPLOYEE; 
INSERT INTO EMPLOYEE VALUES (900,'최진용','000608-320608','temp5142@naver.com', '010-1111-8888','D5','J5','S5',6800000,0.6,210,SYSDATE,null,DEFAULT);
-- 위와같이 값을 전부 나열하는 방식에서 값이 더 많으면 TOO MANY VALUES , 적으면 NOT ENOUGH VALUES 오류 발생 

/*
    2) INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ... ) VALUES (값1,값2, ....);
    -해당 테이블에 특정 컬럼만 선택하여 해당 컬럼에만 추가할 값 제시할 때 사용
    -한 행 단위로 추가가 되기 때문에 선택되지않은 컬럼은 기본값이 삽입 (기본값 NULL)
    -DEFAULT 설정이 있다면 해당 값이 삽입된다.
    주의: NOT NULL 제약조건이 설정되어있다면 , 선택하여 값을 제시하거나 DEFAULT 값이 설정되어야 한다 
*/
INSERT INTO EMPLOYEE (EMP_ID
,EMP_NAME
,EMP_NO
,DEPT_CODE
,JOB_CODE
,SAL_LEVEL
,SALARY
,BONUS
,MANAGER_ID
,HIRE_DATE
,ENT_DATE
,ENT_YN) VALUES (900,'최진용','000608-320608','D5','J5','S5',6800000,0.6,210,SYSDATE,null,DEFAULT);

SELECT * FROM EMPLOYEE WHERE EMP_ID = 900;


/*
    3) INSERT INTO 테이블명 (서브쿼리);
    -VALUES로 직접 값을 기입하는것이아니라 
    서브쿼리로 조회된 데이터를 INSERT하는 구문 
    여러행을 한번에 INSERT할 수 있다
*/

--테이블 생성 
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

-- 전체 사원들의 사민, 이름, 부서명을 조회한 결과를 EMP 01 테이블에 삽입해보기
--1) 조회
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--ORACLE 구문
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
WHERE DEPT_CODE = DEPT_ID(+);

--조회구문 INSERT하기
INSERT INTO EMP_01 (SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)); --25개..행..? 나 왜 24개지 ㅋㅋ 

SELECT * FROM EMP_01;

/*
    INSERT ALL
    두개 이상의 테이블에 각각 INSERT 할때 사용되는 구문 
    조건: 사용하는 서브쿼리가 동일해야한다.
    [표현법]
    INSERT ALL
    INTO 테이블명1 VALUES (컬럼명,컬럼명,...) 
    INTO 테이블명2 VALUES (컬럼명,컬럼명,...) 
    서브쿼리;
*/
/*

    테스트용 테이블 생성하기
    -TB1 : 급여가 300만원 이상인 사원들의 사변, 사원명,직급명 보관할 테이블
    -테이블명 EMP_JOB / 컬럼: EMP_ID,EMP_NAME,JOB_NAME 
    -TB2 : 급여가 300만원 이상인 사원들의 사변, 사원명,직급명 보관할 테이블
    -테이블명 EMP_DEPT / 컬럼: EMP_ID,EMP_NAME,JOB_TITLE
*/

--테이블 1은 직접 테이블 생성 (NUMBER, VARCHR2(30),VARCHAR2(20) 순서)
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);


--테이블 2는 서브쿼리를 이용하여 기존 형식대로 작성 (SELECT 절에 컬럼명 명시)
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE 1=0; -- 컬럼 형식만 복사 

--EMP_JOB과 EMP_DEPT 테이블에 각각 조회된 데이터 넣어보기
--급여 300만원 이상 받는 사람들의 사번 이름 직급 부서명
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;

--INSERT ALL이용
INSERT ALL
INTO EMP_JOB VALUES (EMP_ID,EMP_NAME,JOB_NAME)
INTO EMP_DEPT VALUES (EMP_ID,EMP_NAME,DEPT_TITLE)
SELECT EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;
COMMIT;
-- INSERT ALL 을 이용한 

INSERT INTO EMP_JOB VALUES (300,'김데모','대표이사');
INSERT INTO EMP_JOB VALUES (301,'김테스','대리');
INSERT INTO EMP_JOB VALUES (302,'데이비드','과장');

ROLLBACK;

INSERT ALL --INSERT ALL은 서브쿼리가 있어야함. 
    INTO EMP_JOB VALUES (300,'김데모','대표이사')
    INTO EMP_JOB VALUES (301,'김테스','대리')
    INTO EMP_JOB VALUES (302,'데이비드','과장')
SELECT * FROM DUAL;   -- 가상테이블로 서브쿼리 구문 작성 (형식을 지키기 위해 사용하는 구문)

/*
    2) INSERT ALL
    WHERE 조건1 THEN
    INTO 테이블명 VALUES (컬럼명1, 컬럼명2)
    WHEN 조건2 THEN
    INTO 테이블명 VALUES (컬럼명1, 컬럼명2)
    
    서브쿼리 
    -조건에 맞는 값들을 삽입하겠다.
*/
-- 테스트용 테이블 생성
--사원들의 사번 사원명 입사일 급여를 담는 테이블 EMP_OLD /EMP_NEW 두개 만들기 
--기존 테이블 형식 복사하기 (데이터 X)
CREATE TABLE EMP_OLD
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
FROM EMPLOYEE
WHERE 0=1;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
FROM EMPLOYEE
WHERE 0=1;
--1) 서브쿼리로 이용할 구문 작성
--2010년 이전, 이후 조건으로 조회
SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
FROM EMPLOYEE
-- WHERE HIRE_DATE < '2010-01-01'; ---2010년 이전 입사자 
WHERE HIRE_DATE >='2010-01-01'; ---2010년 이후 입사자 

INSERT ALL 
    WHEN HIRE_DATE < '2010-01-01' THEN
        INTO EMP_OLD VALUES (EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    WHEN HIRE_DATE >= '2010-01-01' THEN
        INTO EMP_NEW VALUES (EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
------------------------
/*
    UPDATE
    테이블에 저장된 데이터를 수정하는 구문 
    [표현법]
    UPDATE 테이블명
    SET 컬럼명 = 바꿀값, 
        컬럼명 = 바꿀값, --여러개 컬럼값을 같이 변경가능  
        ...
    WHERE 조건; --WHERE절은 생략 가능하지만 생략하면 모든행에 수정작업이 일어난다. 
*/

--복사본 만들기
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;

--DEPT_COPY 테이블에서 D9 부서의 부서명을 전략기획부로 수정하기
UPDATE DEPT_COPY
SET DEPT_TITLE ='전략기획부'
WHERE DEPT_ID='D9';
SELECT * FROM DEPT_COPY;
ROLLBACK;
-- 복사본 테이블 
--테이블명 : EMP_SALARY / 컬럼 : EMP ID,EMP NAME,DEPT CODE,SALARY,BONUS(데이터도 같이 복사)
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS
FROM EMPLOYEE;
SELECT * FROM EMP_SALARY;
--EMP_SALARY 테이블에서 노옹철 사원의 급여 1000만원으로 변경해보기
UPDATE EMP_SALARY
SET SALARY = 10000000
WHERE EMP_NAME = '노옹철';
--EMP_SALARY 테이블에서 선동일 사원의 급여를 700만원으로 보너스를 0.2로 변경해보기
UPDATE EMP_SALARY
SET SALARY = 7000000, BONUS = 0.2
WHERE EMP_NAME = '선동일';
--EMP_SALARY 테이블 전체 사원의 급여를 기존 급여에 20피센트 인상한 금액으로 변경
UPDATE EMP_SALARY
SET SALARY = SALARY * 1.2;
SELECT * FROM EMP_SALARY;

/*
    UPDATE에 서브-쿼리 사용
    서브쿼리를 수행한 결과로 기존값으로부터 변경하겠다.
    
    [표현법]
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    WHERE 조건; -생략가능
*/
--EMP_SALARY 테이블에 있는 김유저 사원의 부서코드를 유하진 사원의 부서코드와 변경하기
--1) 유하진 사원의 부서코드 알아오기
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '유하진';  --- D2

UPDATE EMP_SALARY
SET DEPT_CODE= (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '유하진') 
WHERE EMP_NAME='최진용';

--값 확인해보기
SELECT * FROM EMP_SALARY;

--방명수 사원의 급여와 유재식 사원의 급여와 보너스 값으로 변경해보기.
SELECT * FROM  EMP_SALARY WHERE EMP_NAME ='방명수'; ---1380000
SELECT * FROM  EMP_SALARY WHERE EMP_NAME ='유재식'; ---3400000
COMMIT;
--서브쿼리 이용해 변경
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME ='유재식')
    ,BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME ='유재식')
WHERE EMP_NAME ='방명수';

--위와 같이작업은 번거로워 --다중열 서브쿼리 이용
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY,BONUS
                      FROM EMP_SALARY
                      WHERE EMP_NAME ='유재식')
WHERE EMP_NAME ='방명수';

SELECT * FROM  EMP_SALARY WHERE EMP_NAME ='방명수' OR EMP_NAME ='유재식';

COMMIT; --확정 

--노옹철 사원의 사번을 200번으로 수정 해보기
UPDATE EMPLOYEE
set EMP_ID=200
where EMP_NAME = '노옹철'; ---업데이트 할라해도 제약조건 위배하는 조건이 있으면 거절당함ㅋ 

/*
    4.DELETE
    테이블에 기록된 데이터를 행 단위로 삭제하는 구문
    [표현법]
    DELETE FROM 테이블명
    WHERE 조건; -WHERE절은 생략 가능하지만 생략시 모든 데이터 행 삭제 하니 주의할것.

*/

COMMIT;
--EMPLOYEE 모든 데이터 삭제
DELETE FROM EMPLOYEE; --WHERE절 없어서 다 날아감 
ROLLBACK;
SELECT * FROM EMPLOYEE;

--EMPLOYEE 테이블에서 새로 추가한 김유저 김사원 삭제해보기
DELETE FROM EMPLOYEE
WHERE EMP_NAME IN ('김유저','최진용'); 
ROLLBACK;

/*  (DDL) -- DDL은 작업 수행후 COMMIT을 자동으로 해주기 때문에 ROLLBACK 불가/

    TRUNCATE: 테이블의 전체 행을 삭제 할 때 사용하는 구문 (절삭) 
            DELETE 보다 수행 속도가 빠르고 별도의 조건을 제시하지 않음.
            테이블 데이터가 절삭 되어 ROLLBACK으로 되돌릴 수 없다.
            
            [표현법]
            TRUNCATE TABLE 테이블명; 
*/


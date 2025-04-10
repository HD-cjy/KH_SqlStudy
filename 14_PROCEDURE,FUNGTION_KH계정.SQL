/*
    <PROCEDURE>
    PL/SQL 구문을 저장하여 이용하는 객체
    필요할때마다 작성해놓은 PL/SQL 구문을 호출하여 실행할 수있음

    [표현법]
    CREATE [OR REPLACE] PROCEDURE 프로시저명[(매개변수1,매개변수2,...)]
    IS
    BEGIN
        PL/SQL 구문;
    END;
    /
*/
--EMPLOYEE 테이블을 복사한 COPYTABLE생성 
CREATE TABLE PRO_TEST
AS SELECT * FROM EMPLOYEE;
SELECT * FROM PRO_TEST;
DROP TABLE PRO_TEST;
--프로시저 생성
CREATE OR REPLACE PROCEDURE DELETE_DATA
IS
BEGIN
    DELETE FROM PRO_TEST;  --PRO_TEST 테이블의 모든 데이터 삭제(DML)
    COMMIT;  --커밋 처리
END;
/

SELECT * FROM USER_PROCEDURES;

BEGIN
    DELETE_DATA();
    DBMS_OUTPUT.PUT_LINE('프로시저 호출 완료');
END;
/

SELECT * FROM PRO_TEST;

-- 전달값이나 반환값 없는 프로시저의 경우 간단히 수행가능
EXEC DELETE_DATA; --소괄호 없이 그냥 객체 자체로 호출해도 됨 (매개변수 없으니까 가능)

/*
매개변수 선언하여 사용하는 프로시저
IN: 프로시저 실행시 필요한 값을 받는 변수 (자바 매개변수와 동일)
OUT: 프로시저를 호출한 곳으로 되돌려주는 변수 (결과값) 
*/
CREATE OR REPLACE PROCEDURE TEST_PROCEDURE(
    --변수명 IN/OUT 자료형
                                            V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
                                            V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
                                            V_SALARY OUT EMPLOYEE.SALARY%TYPE,
                                            V_BONUS OUT EMPLOYEE.BONUS%TYPE)
IS
BEGIN
    SELECT EMP_NAME,SALARY,BONUS
    INTO V_EMP_NAME,V_SALARY,V_BONUS  -- 조회된거 OUT 변수에 넣어주기
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID; --IN으로 전달받은 데이터 조건에 넣기

END;
/



SELECT * FROM USER_PROCEDURES;

DECLARE 
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    ESAL EMPLOYEE.SALARY%TYPE;
    EBONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    --프로시저를 호출하여 IN으로 선언된 곳에 전달값 전해주고 OUT으로 선언된 곳에 결과값 받아오기
    PRO_SELECT(200,ENAME,ESAL,EBONUS);

    DBMS_OUTPUT.PUT_LINE('사원명: ' || ENAME || ', 급여:  ' || ESAL || ', 보너스: ' || EBONUS);
END;
/
--사원 정보를 삽입하고 해당 사원 정보를 수정하는 구문을 트렌젝션으로 묶어보기.
--EMP_ID
--EMP_NAME
--EMP_NO
--DEPT_CODE
--JOB_CODE
--SAL_LEVEL

CREATE OR REPLACE PROCEDURE EMP_PROTEST(
    EID IN EMPLOYEE.EMP_ID%TYPE,
    ENAME IN EMPLOYEE.EMP_NAME%TYPE,
    ENO IN EMPLOYEE.EMP_NO%TYPE,
    DCODE IN EMPLOYEE.DEPT_CODE%TYPE,
    JCODE IN EMPLOYEE.JOB_CODE%TYPE,
    SLEVEL IN EMPLOYEE.SAL_LEVEL%TYPE)
IS
BEGIN
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE,JOB_CODE,SAL_LEVEL)
                    VALUES(EID,ENAME,ENO,DCODE,JCODE,SLEVEL);
    UPDATE EMPLOYEE
    SET EMP_NAME = ENAME
    WHERE EMP_ID = EID;
    COMMIT;


END;
/

EXECUTE EMP_PROTEST(900,'른오후','250408-1234567','D4','J1','S2');


SELECT * FROM EMPLOYEE;
/*
프로시저 장점
1. 처리속도 빠름
2. 대량 자료처리 효율적
EX) DB에서 대용량 데이터 SELECT로 받아서 자바에서 처리하는 경우
DB에서 대용량 데이터를 SELECT 한 후 자바로 넘기지 않고 직접 처리하는 경우
- 위 상황중 DB에서 처리하는게 데이터를 자바로 전달 할 때 발생하는 네트워크 비용을 감소시킬수 있음
3. 코드 재사용성 높음
4. 유지보수 쉬움

프로시저 단점
1. DB자원을 직접 사용하는 것이기 때문에 DB에 부하를 줄 수 있음.
2. 유지 보수 측면에서 본다만 자바소스와 오라클 코드를 동시에 관리하기 어려움이 있다.
*/

DROP TABLE PRO_TEST;
CREATE TABLE PRO_TEST
AS SELECT * FROM EMPLOYEE;

SELECT * FROM PRO_TEST;
--1)프로시져을 이용하여 PRO_TEST 테이블에 있는 모든 사원의 급여를 인상시키는 작업을 수행
--SALARY_UPDATE 프로시저 생성   20입력받으면 20% 인상
--전달받은 값 만큼의 퍼센트 에이지로 급여 인상 프로시저 작성 (매개변수명 자유)
CREATE OR REPLACE PROCEDURE SALARY_UPDATE(
    P_PERCENT IN NUMBER)
IS
BEGIN
    UPDATE PRO_TEST
    SET SALARY = SALARY * (1 + P_PERCENT / 100);
    
    DBMS_OUTPUT.PUT_LINE('급여가 ' || P_PERCENT || '% 인상되었습니다.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('급여 인상 중 오류가 발생했습니다.');
END;
/
-- 급여 인상 프로시저 테스트
SELECT * FROM PRO_TEST; -- 인상 전 급여 확인

-- 급여 20% 인상 실행
EXEC SALARY_UPDATE(20);

SELECT * FROM PRO_TEST; -- 인상 후 급여 확인

-- 급여 10% 인상 실행 
EXEC SALARY_UPDATE(10);

SELECT * FROM PRO_TEST; -- 두 번째 인상 후 급여 확인

-- 잘못된 값으로 테스트 (음수 퍼센트)
EXEC SALARY_UPDATE(-50);

--2)프로시저에 사원번호를 전달받고 전달받은 사원번호로 사원정보를 조회하여 
--번호가 있으면 사원정보 사원명,핸드폰번호, 이메일주소 출력해보기.
CREATE OR REPLACE PROCEDURE EMP_PROTEST(
    P_EMP_ID IN EMPLOYEE.EMP_ID%TYPE)
IS
    V_EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    V_PHONE EMPLOYEE.PHONE%TYPE;
    V_EMAIL EMPLOYEE.EMAIL%TYPE;
BEGIN
    SELECT EMP_NAME, PHONE, EMAIL
    INTO V_EMP_NAME, V_PHONE, V_EMAIL
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;
    
    DBMS_OUTPUT.PUT_LINE('사원명: ' || V_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('전화번호: ' || V_PHONE);
    DBMS_OUTPUT.PUT_LINE('이메일: ' || V_EMAIL);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원번호가 존재하지 않습니다.');
END;
/

-- 실행하기 전에 출력 활성화 필요
SET SERVEROUTPUT ON;

-- 프로시저 실행
EXEC EMP_PROTEST(200);

SELECT * FROM EMPLOYEE;

/*
    FUNCTION
    프로시저와 유사하지만 실행 결과를 반환 받을 수 있다.


    [표현법]
    CREATE [OR REPLACE] FUNCTION 함수명[(매개변수1,매개변수2,...)]
    RETURN 자료형(반환타입)
    IS
    BEGIN
        RETURN 값;
    END;
    /

    실행법
    함수명(전달값);
*/

CREATE OR REPLACE FUNCTION FNC_TEST(STR VARCHAR2)--바차2의 바이트 크기는 전달 받은 곳에서 작성할 것.
RETURN VARCHAR2
IS  
    RESULT VARCHAR2(100);
BEGIN
    DBMS_OUTPUT.PUT_LINE('STR: ' || STR);
    RESULT := STR || '입니다.';
    RETURN RESULT;
END;
/
--기존 함수 사용하듯 사용 / 프로시저처럼 단독 사용 불가능

SELECT FNC_TEST('재미있는 SQL 정보 확인 시간') FROM DUAL;
SELECT FNC_TEST('그냥 프린트랑 별로 차이 안나는 함수') FROM DUAL;
SELECT FNC_TEST('가장 졸린 시간 ') FROM DUAL;
SELECT FNC_TEST('화요일은 재미없고 지루한 날 ') FROM DUAL;

-- 함수 삭제
DROP FUNCTION FNC_TEST;


-- EMP ID를 전달받아 연봉을 계산하여 출력해주는 함수 만들기
-- EMPLOYEE 테이블 ROWTYPE으로 설정하여 조회결과 넣고
-- 반환값을 이용하여 사번,사원명,연봉 조회해보기
CREATE OR REPLACE FUNCTION FNC_EMP_SAL(
    P_EMP_ID IN EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER -- 연봉을 반환하도록 수정
IS
    V_EMP EMPLOYEE%ROWTYPE;
    V_ANNUAL_SALARY NUMBER;
BEGIN
    SELECT * INTO V_EMP
    FROM EMPLOYEE
    WHERE EMP_ID = P_EMP_ID;
    
    -- 연봉 계산 (월급 * 12 + 보너스가 있다면 월급 * 보너스율 * 12)
    V_ANNUAL_SALARY := V_EMP.SALARY * 12 + (V_EMP.SALARY * NVL(V_EMP.BONUS, 0) * 12);
    
    -- 사번, 사원명, 연봉 정보 출력
    DBMS_OUTPUT.PUT_LINE('사번: ' || V_EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('사원명: ' || V_EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('연봉: ' || TO_CHAR(V_ANNUAL_SALARY, 'FM999,999,999') || '원');
    
    RETURN V_ANNUAL_SALARY;
END;
/

-- 테스트 구문
SELECT EMP_ID, EMP_NAME, FNC_EMP_SAL(EMP_ID) AS 연봉
FROM EMPLOYEE
WHERE EMP_ID = '200';

SELECT * FROM EMPLOYEE;

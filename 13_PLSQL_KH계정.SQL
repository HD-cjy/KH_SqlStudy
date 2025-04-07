/*
    PL/ SQL
    오라클 내에 내장되어있는 절차적 언어로 sql 문장 내에서 변수의 정의, 조건처리(IF),
    반복처ㄹ리(LOOP,FOR,WHILE), 예외처리등을 지원하여 SQL문 단점을 보완한다
    다수의 SQL문을 한번에 수행가능

    PL,SLQ문 구조
    [선언부(DECLARE SECTION)]: DELCARE로 시작변수나 상수를 선언 및 초기화 하는 영역
    [실행부 (EXECUTABLE SECTION)]: BEGIN으로 SQL문 또는 제어문등의 로직을 작성하는 영역
    [예외처리부(EXCEPTION SECTION)]: EXCEPTION으로 시작, 예외발생시 해결하기 위한 구문을 기술하는 부분

*/
--출력 확인을 위해 설정하기
--아웃풋 옵션 켜기

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTOUT.PUT_LINE('HELLO ORACLE!');
END;
/
--슬래시 단독처리


/* 
    1.DECLARE 선언부
    변수나 상수를 선언하는 공간(선언과 동시에 초기화 가능)
    일반 타입 변수, 레퍼런스 변수 , ROW 타입 변수
    1-1) 일반 타입 변수 선언 및 초기화
    [표현법] 변수명 [CONSTANT] 자료형 [:= 값];
*/
--( := ) - 대입연산자
DECLARE
    EID NUMBER;
    ENAME VARCHAR2 (20);
    PI CONSTANT NUMBER :=3.14;   --상수처리
BEGIN 
    EID := &번호;
    ENAME:= '&이름';
--출력
    -- DBMS_OUTPUT.PUT_LINE('EID: '|| EID);
    DBMS_OUTPUT.PUT_LINE('EID: '|| EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('PI: '|| PI);

END;
/

--이름 나이 성별 입력받아 화면출력
--NAME,AGE,GENDER 자료형 자유롭게

DECLARE 
    NAME BARCHR2 (20);
    AGE NUMBER;
    GENDER BARCHA2 (6);
BEGIN
    NAME := '&이름';
    AGE := 번호;
    GENDER := '&성별';
    DBMS_OUTPUT.PUT_LINE('NUMBER: '|| NUMBER);
    DBMS_OUTPUT.PUT_LINE('AGE: '|| NUMBER);
    DBMS_OUTPUT.PUT_LINE('GENDER: '|| BARCHA2);
END;
/
-- --레피런스 타입 변수로 EID,ENAME,JCODE,DTITLE,SAL을 선언하고
-- 각 자료형은 EMPLOYEE 테이블과 DEPARTMENT 테이블을 참조하여 선언
-- 사용자가 입력한 사변에 대한 사원 정보를 출력해보세요.
-- 출력은 변수명 : 담긴값 형대로 치리해보기

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    EID := '&사번';
    SELECT EMP_ID,EMP_NAME,JOB_CODE,DEPT_TITLE,SALARY
    INTO EID,ENAME,JCODE,DTITLE,SAL
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = EID;

    DBMS_OUTPUT.PUT_LINE('사번 : '|| EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('직급 : '|| JCODE);
    DBMS_OUTPUT.PUT_LINE('부서 : '|| DTITLE);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| SAL);
END;
/
/*
    1-3) ROW 타입 변수 선언
    테이블의 한 행에 대한 모든 컬럼값을 담을 수 있는 변수
    [표현식] 테이블명%ROWTYPE;
 */

SELECT * FROM EMPLOYEE;

DECLARE
    E EMPLOYEE%ROWTYPE;  --EMPLOYEE 테이블의 모든 컬럼을 담을 수 있는 변수
BEGIN
    SELECT *
    INTO E -- 조회된 한 행을 E 변수에 담아주기
    FROM EMPLOYEE -- 조회할 테이블
    WHERE EMP_ID = '&사번'; -- 조회할 조건

    DBMS_OUTPUT.PUT_LINE('사번 : '|| E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : '|| E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('성별 : '|| E.EMP_NO);

END;
/

--DEPARTMENT 테이블 ROW 타입 변수로 설정한 뒤 
--사용자에게 부서코드를 입력받아 해당 부서정보 출력해보기.

SELECT * FROM DEPARTMENT;

DECLARE
    D DEPARTMENT%ROWTYPE;
BEGIN
    SELECT *
    INTO D
    FROM DEPARTMENT 
    WHERE DEPT_ID = '&부서코드'; 
    DBMS_OUTPUT.PUT_LINE('부서 코드'||D.DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('부서 이름'||D.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('지역 번호'||D.LOCATION_ID);
END;
/

/*
    VW_PLSQL 이름의 뷰를 생성하여 사원명 부서명 직급명을 갖게 생성하고
    해당 뷰를 이용하여 ROWTYPE 설정 후  사번을 입력받아 해당 정보를 출력하는 구문 작성해보기
*/

CREATE VIEW VW_PLSQL
AS SELECT EMP_NAME,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);





SELECT * FROM VW_PLSQL;

DECLARE
    E VW_PLSQL%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM VW_PLSQL
    -- WHERE EMP_ID = '&사번';
    WHERE 사원명 = (SELECT EMP_NAME
                    FROM EMPLOYEE
                    WHERE EMP_ID = '&사번');

    DBMS_OUTPUT.PUT_LINE('사번 : '|| E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : '|| E.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('직급 : '|| E.JOB_NAME);
END;
/



/*
    조건문
    IF 조건문 
        THEN 실행내용 
        [ELSE 실행내용]
    END IF;

    IF 조건문 
        THEN 실행내용 
        [ELSE IF 조건문 THEN 실행내용]
    사번을 입력받고 해당 사원의 사번 이름 급여 보너스를 출력
    단, 보너스를 받지 않는 사원은 보너스 출력전, 보너스를 지급받지 않는 사원입니다. 출력하기 
*/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS,0)
    INTO EID, ENAME,SAL,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';

    DBMS_OUTPUT.PUT_LINE('사번 : '|| EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| SAL);

    --보너스 안받는 사원 출력문 
    IF BONUS = 0 
    THEN
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스 : '|| BONUS);
    END IF;
END;
/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY,NVL(BONUS,0)
    INTO EID, ENAME,SAL,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';

    DBMS_OUTPUT.PUT_LINE('사번 : '|| EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| SAL);

    --보너스 안받는 사원 출력문 
    IF BONUS = 0 
    THEN
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스 : '|| BONUS);
    END IF;
END;
/
--------------------------------
-- 레퍼런스 타입변수 (EID,ENAME,DTITLE,NCODE)와 일반 타입 변수 TEAM VARCHAR2(10) 사용
--참조할 컬럼은 EMP_ID, EMP_NAME, DEPT_TITLE,NATIONAL_CODE 이다.
--사용자가 입력한 사번에 대한 사번, 이름, 부서명, 근무국가코드를 조회하고
--NCODE의 값이 KO 일 경우 TEAM 변수에 '한국팀' 대입
--KO 가 아닐 경우 해외팀 대입
--사번 이름 부서 소속 (TEAM 출력 )

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE; -- EMPLOYEE 테이블에는 NATIONAL_CODE가 없음
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE) -- LOCATION 테이블과 조인 추가
    WHERE EMP_ID = '&사번';

    DBMS_OUTPUT.PUT_LINE('사번 : '|| EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 : '|| DTITLE);

    IF NCODE = 'KO'
    THEN
        TEAM := '한국팀';
    ELSE
        TEAM := '해외팀';
    END IF;

    DBMS_OUTPUT.PUT_LINE('소속 : '|| TEAM);
END;
/   
/*
    레퍼런스 변수로 sal ename 설정하고 일반 타입 변수로 grade varchr2(10)설정
    사번을 입력받아 해당 사원의 급여등급 측정해보기
    급여가 500만원 이상이면 고급
    급여가 500만원 미만 300만원 이상이면 중급
    그 외는 초급을 grade 변수에 담아 출력문 해당 사원의 급여 등급은 xx입니다. 를 출력해보세요
    사번 이름 급여 등급 출력
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);

BEGIN
    SELECT EMP_ID,EMP_NAME,SALARY
    INTO EID,ENAME,SAL
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';

    IF SAL >= 5000000 THEN
        GRADE := '고급';
    ELSIF SAL >= 3000000 THEN
        GRADE := '중급';
    ELSE
        GRADE := '초급';
    END IF;

    DBMS_OUTPUT.PUT_LINE('사번 : '|| EID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| SAL);
    DBMS_OUTPUT.PUT_LINE('등급 : '|| GRADE);
END;
/

/*
    사원의 사번을 입력받아 사원명,부서명,지역명,국가명을 조회하는 view를 생성
    rowtype 변수에 담고 
    일반타입 변수 str varchar2 (20)을 만들어 입력한 사원의 국가에 따라서 000 사원님 (해당 국가 인사말) 을 str 변수에 대입하고 출력하기
    ex) 한국: 선동일 사원님 안녕하세요   / 일본: 김창선 사원님 こんにちは 오래しました  / 미국: 최 사원님 hello
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCATION_ID, NATIONAL_CODE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
LEFT JOIN NATIONAL ON (NATIONAL_CODE = NATIONAL_CODE);

DECLARE
    E VW_EMPLOYEE%ROWTYPE;
    STR VARCHAR2(100);
BEGIN
    SELECT *
    INTO E
    FROM VW_EMPLOYEE 
    WHERE EMP_ID = '&사번';

    IF E.NATIONAL_CODE = 'KO' THEN
        STR := '안녕하세요';
    ELSIF E.NATIONAL_CODE = 'JP' THEN
        STR := 'こんにちは';
    ELSIF E.NATIONAL_CODE = 'CH' THEN
        STR := '니하오';
    ELSIF E.NATIONAL_CODE = 'RU' THEN
        STR := 'привет (프리비엣)';
    ELSE
        STR := 'hello,welcome ';
    END IF;

    DBMS_OUTPUT.PUT_LINE(E.EMP_NAME || ' 사원님 ' || STR);
    DBMS_OUTPUT.PUT_LINE('부서: ' || E.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('지역: ' || E.LOCATION_ID);
    DBMS_OUTPUT.PUT_LINE('국가: ' || E.NATIONAL_CODE);

END;
/

/*
사원의 연봉을 구하는 PL/sql 구문작성해보기
사원이 보너스가 없다면 급여 *12 연봉 출력
rowtype 변수로 employee 이용
연봉담을 변수로 yearsal number 이용하여 처리해보기
사번을 입력받아 ooo님이 연봉은  (원화표시)\000,000,000 원 입니다 형식으로 출력해보기 */

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    YEARSAL NUMBER;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';

    IF BONUS IS NULL THEN
        YEARSAL := SAL * 12;
    ELSE
        YEARSAL := SAL * 12 + (SAL * BONUS);
    END IF;

    DBMS_OUTPUT.PUT_LINE(ENAME || '님의 연봉은 ' || TO_CHAR(YEARSAL, '999,999,999') || '원 입니다.');
END;
/

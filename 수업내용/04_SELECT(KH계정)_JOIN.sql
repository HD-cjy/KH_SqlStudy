/*
    --파일명 : 04_SELECT(KH계정)_JOIN.SQL      
    <JOIN>
    두개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용하는 구문 - SELECT
    조회 결과는 하나의 결과 집합 (RESULT SET) 으로 나온다.
    
    JOIN을 사용하는 이유 
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있다.
    사원 정보는 사원 테이블,직급 정보는 직급 테이블 등등 -중복 데이터 최소화
    -JOIN 구문을 이용하여 서로 다른 테이블간의 관계를 맺어 데이터를 같이 조회하는 목적
    -JOIN 구문을 사용할땐 연관된 데이터를 이용하여 관계를 맺어 조회한다.
    
    문법상 분류 : JOIN은 크게 오라클 전용 구문과 ANSI(미국 국립 표준 협회) 구문으로 나뉘어진다.
    
    오라클 전용 구문               | ANSI 구문 (오라클+다른 DBMS)
    ==============================================================
        등가 조인(EQUAL JOIN)     | 내부조인 (INNER JOIN -> JOIN USING/ON)
    ----------------------------------------------------------------------
        포괄조인                  | 외부조인(OUTER JOIN -> JOIN USING)
        LEFT OUTER JOIN          | 왼쪽 외부 조인(LEFT OUTER JOIN)
        RIGHT OUTER JOIN         | 오른쪽 외부 조인 (RIGHT OUTER JOIN)
                                 | 전체 외부 조인(FULL OUTER JOIN) : 오라클에서는 불가
    ------------------------------------------------------------------------
    카테시안곱(CARTESIAN PRODUCT)  | 교차조인(CROSS JOIN)
    -----------------------------------------------------------------
                            자체 조인 (SELF JOIN)
                            비 등가 조인(NON EQUAL JOIN)
                            다중 조인 (테이블 3개 이상)

*/

--JOIN을 사용하지 않는 예시
--전체 사원들의 사번,사원명,부서코드,부서명을 조회하고자 한다.
--사번,사원명,부서코드를 갖는 테이블과 부서명을 갖는 테이블이 다르기 때문에 각각 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE;


--부서코드,부서명 
SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT;

--위와 같이 다른 테이블에 있는 데이터를 하나의 결과집합으로 조회하기 위해서 JOIN구문을 사용한다.

/*
    1.등가조인(EQUAL JOIN) / 내부조인 (INNER JOIN)
    연결 시키고자 하는 컬럼의 값이 일치하는 행들만 조인되어 조회된다.
    -일치하지 않는 값들은 조회결과에서 제외된다.
    -동등비교 연산자 = 를 이용하여 일치한다라는 조건을 제시
    
    [표현법]
    등가조인 (오라클 구문)
    SELECT 컬럼명 나열
    FROM 조인하고자하는 테이블명 나열
    WHERE 연결할 컬럼 = 조건 제시
    
    내부조인(ANSI 구문)
    SELECT 컬럼명 나열
    FROM 기준 테이블 작성
    JOIN 조인하고자하는 테이블명 ON (연결컬럼 제시)  
    
    *ANSI구문에서 조인에 사용할 컬럼명이 같은 경우 아래와 같이 USING구문 사용 가능
    SELECT 컬럼명 나열
    FROM 기준 테이블 작성
    JOIN 조인하고자하는 테이블명 USING(연결컬럼 제시)  
    
    *오라클 구문에서 조건에 사용할 컬럼명이 같을땐 테이블명 또는 테이블 별칭을 이용한다.

*/

--오라클 전용 구문
--사번,사원명,부서코드,부서명 조회 
--연결 테이블 (EMPLOYEE / DEPARTMENT)
--연결 컬럼(EMPLOYEE 테이블의 DEPT_CODE / DEPARTMENT 테이블의 DEPT_ID)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_ID,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
ORDER BY 2;
--사원 정보중 DEPT_CODE가 NULL인 사원의 데이터는 조회되지 않았다.
--DEPARTMENT 테이블의 DEPT_ID 컬럼에 NULL에 대한 정의는 없기 때문에
--NULL과 일치하는 DEPT_ID 데이터가 없어서 조회되지 않음
SELECT * FROM EMPLOYEE;

--전체 사원들의 사번 사원명 직급코드 직급명을 조회해보자 
--조인할 테이블 EMPLOYEE,JOB
--연결할 컬럼 JOB_CODE  (컬럼명이 같다)

SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE = JOB_CODE;--column ambiguously defined(컬럼 모호함)
--같은 컬럼명을 사용하려면 어떤 테이블의 컬럼인지를 명확하게 작성하여야한다.
--방법1. 테이블명.컬럼명  
--방법2. 테이블명에 별칭 부여 후 별칭.컬럼명

--방법1. 테이블명 지정
SELECT EMP_ID
      ,EMP_NAME
      ,EMPLOYEE.JOB_CODE
      ,JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

--방법2. 테이블에 별칭 지정
SELECT EMP_ID 
      ,EMP_NAME
      ,E.JOB_CODE
      ,JOB_NAME
FROM EMPLOYEE E,JOB J --테이블에 별칭 부여 
WHERE E.JOB_CODE = J.JOB_CODE;

--ANSI 표준 구문 이용해보기 
--FROM절엔 기준테이블 
--조인하고자 하는 테이블을 JOIN 구문과 함께 사용 
--컬럼명이 같다면 USING,다르다면 ON 사용


--사번,사원명,부서코드,부서명 조회 
--연결 테이블 (EMPLOYEE / DEPARTMENT)
--연결 컬럼(EMPLOYEE 테이블의 DEPT_CODE / DEPARTMENT 테이블의 DEPT_ID)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE
/*INNER*/JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID); --기본적으로 INNER JOIN이라서 생략되어있음

--전체 사원들의 사번 사원명 직급코드 직급명을 조회해보자 
--조인할 테이블 EMPLOYEE,JOB
--연결할 컬럼 JOB_CODE  (컬럼명이 같다)
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); --컬럼명이 같은경우 USING구문을 사용하면 알아서 매칭시켜 조회한다.

--컬럼명이 같을때 ON 구문 사용 
--컬럼명이 모호하기때문에 어떤 테이블의 컬럼인지 명확하게 지정(테이블명 또는 별칭)
SELECT EMP_ID,EMP_NAME,EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (EMPLOYEE.JOB_CODE=JOB.JOB_CODE);

--자연조인 (NATURAL JOIN) : 등가조인 방법중 하나로
--동일한 이름과 타입을 가진 컬럼을 조인 조건으로 이용하는 방법 
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

--조인시 추가적인 조건 부여 가능 
--직급이 대리인 사원들의 정보를 조회(사번,사원명,월급,직급명)
--오라클 전용구문
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '대리';
--ANSI 표준구문 
SELECT EMP_ID,EMP_NAME,SALARY,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

--연습 문제 (모두 오라클,ANSI 로 각각 해보기)
--1.부서가 인사관리부인 사원들의 사번 사원명 보너스 조회 
--오라클
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '인사관리부';

--ANSI
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

--2.부서가 총무부가 아닌 사원들의 사원명 급여 입사일 조회
--오라클 
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '총무부';

--ANSI
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '총무부';

--3.보너스를 받는 사원들의 사번 사원명 보너스 부서명 조회
--오라클
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL;

--ANSI
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

--4. 아래의 두 테이블을 참고해서 부서코드 부서명 지역코드 지역명(LOCAL_NAME) 조회
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION; 

--오라클 
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT,LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

--ANSI
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE);

/*
    2. 포괄 조인 / 외부조인(OUTER JOIN)
    
    테이블간의 JOIN시 조건에 일치하지 않는 행도 포함시켜 조회할 수 있다.
    단, 기준이 되는 테이블을 지정하여야한다.
    (LEFT,RIGHT, (+)) 
    
    조건에 일치하는 행 + 기준이 되는 테이블의 일치하지 않는 행까지 포함
*/
SELECT EMP_NAME,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; --21명 조회됨 (데이터 일치하지 않은 2명의 데이터는 조회되지 않는다)

--전체 사원들의 사원명,급여,부서명
--1)LEFT OUTER JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN처리 
--                    왼편에 있는 테이블 데이터는 전부 조회하게 된다.

--ANSI 구문
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE 
LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID); --23명 조회
--DEPT_CODE와 DEPT_ID가 일치하지 않아서 조회되지 않았던 데이터의 DEPT_TITLE은 NULL로 표현된다.

--ORACLE 구문 - (+)
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID(+); --기준테이블의 반대 테이블 연결 컬럼 뒤에 (+) 를 붙인다.

--2)RIGHT OUTER JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN 
--                     오른편에 기술된 테이블 정보를 전부 조회

--ANSI
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
RIGHT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--ORACLE
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

--3)FULL OUTER JOIN : 두 테이블이 가진 모든 행을 조회

--ANSI
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

--ORACLE 구문에서는 불가능
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+); --오라클 구문에서 (+) OUTER JOIN 은 한쪽만 가능

/*
    3. 카타시안 곱 / 교차조인
    모든 테이블의 각 행이 서로 매핑된 데이터가 조회된다.
    두 테이블의 행들이 모두 곱해진 행들의 조합 출력
    -각각 N개 M개 행을 가진 테이블들의 결과는 N*M
    -모든 경우의 수를 조회
    -방대한 데이터를 조회하기 때문에 과부하 위험이 있다 
     때문에 실수로 조인 조건을 넣지 않는것을 주의해야함
*/

--사원명,부서명
--오라클 
SELECT EMP_NAME,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT;--23 * 9 : 207행 조회
--오라클 조인 구문의 경우 조인 조건을 작성하지 않으면 모든 경우의 수를 조회해버린다.(주의)

--ANSI 
SELECT EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;--207행 조회

/*
    4. 비등가 조인 (NON EQUAL JOIN)
    
    = 등호를 사용하지 않는 조인 구문 - 비교연산자를 이용한 방식 
    EX) >,<,>=,<=,BETWEEN A AND B
    지정한 컬럼값이 일치하는 경우가 아닌 범위에 포함되는 경우 조회하겠다.
    
    등가조인 : 일치하는 경우
    비등가 조인 : 범위에 포함되는 경우
*/
--사원명,급여
SELECT EMP_NAME,SALARY
FROM EMPLOYEE;

--SAL_GRADE 테이블 조회
SELECT *
FROM SAL_GRADE;
--SAL_GRADE 테이블에 있는 범위를 이용하여 비등가조인 확인해보기 
--오라클
SELECT EMP_NAME,SALARY,SAL_GRADE.SAL_LEVEL --SAL_GRADE테이블의 SAL_LEVEL 조회
FROM EMPLOYEE,SAL_GRADE
WHERE SALARY >= MIN_SAL --비등가조인(범위안에 포함되었다면)
AND   SALARY <=MAX_SAL;

--ANSI
SELECT EMP_NAME,SALARY,S.SAL_LEVEL
FROM EMPLOYEE
--JOIN SAL_GRADE S ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);
JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL); --BETWEEN A AND B 이용
--비등가조인에서 USING은 불가능

/*
    5. 자체조인 (SELF JOIN)
    같은 테이블끼리 조인하는 경우
    자체 조인의 경우 테이블에 반드시 별칭을 부여해야한다.
    같은 테이블이지만 다른 테이블인것처럼 조인하기 위해
*/
--사원정보
SELECT * 
FROM EMPLOYEE;

--사수정보
SELECT *
FROM EMPLOYEE;

--사원의 사번,사원명, 사수의 사번,사수명
SELECT EMP_ID "사원 사번"
      ,EMP_NAME "사원 이름"
      ,MANAGER_ID "사수 사번"
      ,EMP_NAME "사수 이름"
FROM EMPLOYEE;

--같은 EMPLOYEE 테이블에서 사원명과 사수명을 조회하려면 자체조인을 이용한다 
--ORACLE
SELECT E.EMP_ID "사원 사번"
      ,E.EMP_NAME "사원 이름"
      ,E.MANAGER_ID "사수 사번"
      ,M.EMP_NAME "사수 이름"
FROM EMPLOYEE E,EMPLOYEE M --사원 테이블은 E 사수 테이블은 M 
WHERE E.MANAGER_ID = M.EMP_ID; --사원 테이블의 사수 사번과 사수 테이블의 사번 
--위 구문 조회 결과는 사수가 있어야만 조회되기 때문에 등가조인(INNER JOIN)
--총 15명의 사원 정보밖에 볼 수 없다.
--모든 사원의 정보를 보고싶다면 ? OUTER JOIN 사용

SELECT E.EMP_ID "사원 사번"
      ,E.EMP_NAME "사원 이름"
      ,E.MANAGER_ID "사수 사번"
      ,M.EMP_NAME "사수 이름"
FROM EMPLOYEE E,EMPLOYEE M --사원 테이블은 E 사수 테이블은 M 
WHERE E.MANAGER_ID = M.EMP_ID(+);

--ANSI 
SELECT E.EMP_ID "사원 사번"
      ,E.EMP_NAME "사원 이름"
      ,E.MANAGER_ID "사수 사번"
      ,M.EMP_NAME "사수 이름"
FROM EMPLOYEE E --사원테이블 E 
JOIN EMPLOYEE M ON (E.MANAGER_ID=M.EMP_ID); --사수테이블 M 
--위 조회 결과는 15행 (사수 있는 사원만 조회됨) 
--모든 사원 조회하려면?
SELECT E.EMP_ID "사원 사번"
      ,E.EMP_NAME "사원 이름"
      ,E.MANAGER_ID "사수 사번"
      ,M.EMP_NAME "사수 이름"
FROM EMPLOYEE E --사원테이블 E 
LEFT /*OUTER*/ JOIN EMPLOYEE M ON (E.MANAGER_ID=M.EMP_ID); --사수테이블 M 

/*
    <다중 조인>
    
    3개이상의 테이블을 조인하여 조회
    조인 순서가 중요하다.
*/

--사번,사원명,부서명,직급명
--오라클
SELECT EMP_ID
      ,EMP_NAME
      ,DEPT_TITLE
      ,JOB_NAME
FROM EMPLOYEE E,DEPARTMENT,JOB J
WHERE DEPT_CODE = DEPT_ID(+)
AND E.JOB_CODE = J.JOB_CODE;

--ANSI
SELECT EMP_ID
      ,EMP_NAME
      ,DEPT_TITLE
      ,JOB_NAME
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

--사원명 부서명 지역명 조회 
--ORACLE 
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE,DEPARTMENT,LOCATION
WHERE DEPT_CODE = DEPT_ID(+)
AND LOCATION_ID = LOCAL_CODE(+);

--ANSI
--ANSI구문은 조인구문의 순서에 따라서 처리되기 때문에 순서 주의하기.
SELECT EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE); 



































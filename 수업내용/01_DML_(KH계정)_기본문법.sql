--01_DML(SELECT)_기본문법.SQL                (파일명)

--DML : 데이터 조작, SELECT(DQL),INSERT,UPDATE,DELETE
--DDL : 데이터 정의, CREATE,ALTER,DROP
--TCL : 트랜잭션 제어 ,COMMIT, ROLLBACK
--DCL : 권한부여,GRANT,REVOKE

/*
    <SELECT>
    데이터를 조회하거나 검색할때 사용하는 명령어
    -RESULT SET : SELECT 구문을 통해 조회된 데이터의 결과물을 의미
                  조회된 행들의 집합이다.
                  
    [표현법]
    SELECT 조회하고자 하는 컬럼명,컬럼명2
    FROM 해당 컬럼이 있는 테이블명;
*/

--EMPLOYEE 테이블에서 전체사원들의 사번,이름,급여 컬럼만 조회해보기 
SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

--대소문자 구분하지 않음
select emp_id,emp_name,salary
from employee; 

--전체컬럼에 대해서 조회하고자 한다면?
--EMPLOYEE 테이블 전체 컬럼 조회 
SELECT *
FROM EMPLOYEE;

--EMPLOYEE 테이블의 전체 사원들의 이름,이메일,휴대폰번호 조회
SELECT EMP_NAME,EMAIL,PHONE
FROM EMPLOYEE;

--1. JOB 테이블 모든 컬럼 조회
SELECT * 
FROM JOB;
--2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;
--3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;
--4. EMPLOYEE 테이블의 직원명,이메일,전화번호, 입사일 컬럼만 조회
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE
FROM EMPLOYEE;
--5. EMPLOYEE 테이블의 입사일,직원명,급여 컬럼만 조회
SELECT HIRE_DATE,EMP_NAME,SALARY
FROM EMPLOYEE;

/*
    컬럼값을 통한 산술연산
    조회하려는 컬럼들을 나열하는 SELECT절에 산술연산(+-/*)을 기술하여 결과값을 조회할 수 있다.
*/

--EMPLOYEE 테이블로부터 직원명,월급,연봉(==월급*12)
SELECT EMP_NAME,SALARY,SALARY*12
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직원명,월급,보너스,보너스가 포함된 연봉을 조회 
SELECT EMP_NAME,SALARY,BONUS,(SALARY+ (BONUS*SALARY))*12
FROM EMPLOYEE;--산술연산 과정에서 NULL값이 존재할 경우 계산결과도 NULL값이 된다.

--EMPLOYEE 테이블로부터 직원명,입사일,근무일수(오늘날짜-입사일) 조회
--DATE 타입끼리도 연산처리가 가능하다 
--오늘 날짜 : SYSDATE 
SELECT EMP_NAME,HIRE_DATE,SYSDATE-HIRE_DATE
FROM EMPLOYEE;
--DATE가 시 분 초 까지 표현하기때문에 해당 연산처리까지 되어서 소수점 표현이 되어버린것
--추후 함수를 이용하여 올림,버림,반올림 처리등등 하게 될 것

/*
    컬럼명에 별칭 부여하기
    [표현법]
    컬럼명 AS 별칭,컬럼명 AS "별칭", 컬럼명 별칭, 컬럼명 "별칭"
    
    AS를 붙이거나 안붙이거나 별칭에 특수문자나 띄어쓰기가 포함될 경우는 
    반드시 "" 로 묶어서 표현
*/
--EMPLOYEE 테이블로부터 직원명,월급,연봉(==월급 *12)
SELECT EMP_NAME AS 직원명
      ,SALARY AS "월급"
      ,SALARY*12 AS 연봉
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직원명,월급,보너스, 보너스가 포함된 연봉 
SELECT EMP_NAME 직원명
      ,SALARY 월급
      ,BONUS 보너스 
      ,(SALARY+(SALARY*BONUS))*12 "보너스가 포함된 연봉"
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직원명,입사일,근무일수(오늘날짜-입사일) 조회
SELECT EMP_NAME AS "직원명"
      ,HIRE_DATE AS "입사일"
      ,SYSDATE-HIRE_DATE AS "근무 일 수"
FROM EMPLOYEE;

/*
    <리터럴>
    임의로 지정한 문자열('')을 SELECT 절에 기술하면 
    실제 그 테이블에 존재하는 데이터처럼 조회가 가능하다.
*/
--EMPLOYEE 테이블로부터 사번,사원명,급여,단위(원) 조회하기
SELECT EMP_ID,EMP_NAME,SALARY,'원' AS 단위
FROM EMPLOYEE;

/*
    <DISTINCT>
    조회하고자 하는 컬럼에 중복된 값을 한번만 조회하고자 할 때 사용
    해당 컬럼명 앞에 기술하며 SELECT절에는 하나의 DISTINCT 구문만 가능하다 
    
    [표현법]
    SELECT DISTINCT 컬럼명
    FROM 테이블명;
*/

--EMPLOYEE 테이블에서 부서코드들만 조회
SELECT DEPT_CODE
FROM EMPLOYEE;
--DISTINCT
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 직급코드들만 조회
SELECT JOB_CODE
FROM EMPLOYEE;
--DISTINCT
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

--DEPT_CODE,JOB_CODE 값을 세트로 묶어 중복 판별
SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE;
--DISTINCT
SELECT DISTINCT DEPT_CODE,JOB_CODE
FROM EMPLOYEE;
----------------------------------------------------------
/*
    <WHERE 절>
    조회하고자 하는 테이블에 특정 조건을 제시하여
    그 조건에 만족하는 데이터들만 조회하고자 할때 기술하는 구문
    
    [표현법]
    SELECT 컬럼명,컬럼명,...
    FROM 테이블명
    WHERE 조건절; - 조건에 해당하는 행들을 조회하겠다.

    실행되는 순서
    FROM -> WHERE ->SELECT
    
    <비교연산자>
    > , < , >= , <= 
    =(일치하는가 ? - 자바에서는 == 지만 오라클에선 = 표기) 
    != ,^=, <> (일치하지 않는가?)
*/
--EMPLOYEE 테이블로부터 급여가 400만원 이상인 사원들만 조회(모든 컬럼)
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 4000000;

--EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명,부서코드,급여 조회 
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--EMPLOYEE 테이블로부터 부서코드가 D9가 아닌 사원들의 사원명,부서코드,급여 조회
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE <> 'D9';
WHERE DEPT_CODE ^= 'D9';

--1. EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름,급여,입사일 조회
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;
--2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름,급여,보너스 조회
SELECT EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';
--3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번 이름 입사일 조회
SELECT EMP_ID,EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';
--4. EMPLOYEE 테이블에서 연봉(급여*12) 이 5000만원 이상인 사원들의 이름 급여 연봉 입사일 조회
SELECT EMP_NAME 이름
      ,SALARY 급여
      ,SALARY*12 연봉 
      ,HIRE_DATE 입사일 
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE 연봉 > 50000000;
--SELECT절에서 사용한 별칭을 WHERE에서는 사용 불가능하다 (실행시점차이) FROM -> WHERE -> SELECT 순서로 실행

/*
    < 논리 연산자 >
    여러개의 조건을 엮을 때 사용한다
    AND :~이면서,그리고
    OR  : ~이거나, 또는
    *자바에서는 &&와 || 를 사용했지만 오라클에서는 AND,OR 로 사용한다 
*/

--EMPLOYEE 테이블에서 부서코드가 D9이며 급여가 500만원 이상인 사원들 이름 부서코드 급여 조회
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
AND SALARY >= 5000000;

--EMPLOYEE 테이블에서 부서코드가 D6 이거나 급여가 300만원 이상인 사원들 이름 부서코드 급여 조회
SELECT EMP_NAME
      ,DEPT_CODE
      ,SALARY 
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D6' 
OR SALARY >= 3000000;
--EMPLOYEE 테이블에서 급여가 350만원 이상이고 600만원 이하인 사원들의 이름 사번 급여 직급코드 조회
SELECT EMP_NAME
      ,EMP_ID
      ,SALARY
      ,JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000
AND SALARY <= 6000000;
--WHERE 3500000 <= SALARY <= 6000000; 불가능

/*
    BETWEEN A AND B 
    ~이상 ~ 이하 범위표현에 사용되는 연산자
    [표현법]
    비교대상 BETWEEN 하한값 AND 상한값
*/
--급여가 350만원 이상이고 600만원 이하인 사원들의 이름,사번,급여,직급 코드 조회
SELECT EMP_NAME
      ,EMP_ID
      ,SALARY
      ,JOB_CODE
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000;

--급여가 350만원 미만이고 600만원 초과인 사원들의 이름,사번,급여,직급 코드 조회
SELECT EMP_NAME
      ,EMP_ID
      ,SALARY
      ,JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
--오라클에서 NOT 은 자바에서 !와같이 논리부정 연산자로 쓰인다 
-- NOT은 비교컬럼 앞 또는 뒤에 붙여서 사용

--*BETWEEN 연산자는 DATE 형식도 가능 
-- 입사일이 '90/01/01' ~ '03/01/01' 인 사원들의 모든 컬럼 조회 
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE >= '90/01/01'
AND HIRE_DATE <= '03/01/01';

--BETWEEN
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

-- 입사일이 '90/01/01'~'03/01/01'이 아닌 사원들 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '03/01/01';

/*
    < LIKE '특정패턴' >
    비교하고자 하는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상 컬럼명 LIKE '특정패턴'
    -옵션 : 특정패턴 부분에 와일드카드인 '%' '_'를 가지고 제시할 수 있음 
    
    
    '%' : 0글자 이상
        비교대상 컬럼명 LIKE '문자%' - 컬럼값 중에 '문자'로 시작하는것을 조회
        비교대상 컬럼명 LIKE '%문자' - 컬럼값 중에 '문자'로 끝나는것을 조회
        비교대상 컬럼명 LIKE '%문자%' - 컬럼값중에 '문자'가 포함되는것을 조회 
        
    '_' : 1글자 
        비교대상 컬럼명 LIKE '_문자' - 해당 컬럼값 중에 '문자' 앞에 무조건 1글자가 존재하는 경우 조회
        비교대상 컬럼명 LIKE '__문자' - 해당 컬럼값 중에 '문자' 앞에 무조건 2글자가 존재하는 경우 조회
     
    패턴에서 '%' 또는 '_' 을 문자로써 사용하고자 할때 
    ESCAPE 문자를 지정하여 해당 문자 뒤에 입력해주면 문자로써 사용 가능하다.
*/

--성이 전씨인 사원들의 이름,급여,입사일을 조회
SELECT EMP_NAME
      ,SALARY
      ,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

--이름 중에 하 가 포함된 사원들의 이름 주민번호 부서코드 조회
SELECT EMP_NAME
      ,EMP_NO
      ,DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

--전화번호 4번째 자리가 9로 시작하는 사원들의 사번 사원명 전화번호 이메일 조회
SELECT EMP_ID
      ,EMP_NAME
      ,PHONE
      ,EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--이름 가운데 글자가 '지' 인 사원들의 모든 컬럼 
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_지_';
--그 외의 사원들 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '_지_';
--WHERE NOT EMP_NAME LIKE '_지_';

--1. 이름이 '연'으로 끝나는 사원들의 이름 입사일 조회
SELECT EMP_NAME
      ,HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
--2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름 전화번호 조회
SELECT EMP_NAME
      ,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
      
--3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%해외영업%';

--ESCAPE 문자 사용 
--이메일 주소에서 _ 앞에 3글자가 있는 사원들만 조회 
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';--ESCAPE로 지정한 문자 뒤에 오는 _ 또는 %는 문자로써 인식된다


/*
    < IS NULL > 
    해당 값이 NULL인지 비교하기 
    
    [표현법]
    비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
    비교대상컬럼 IS NOT NULL : 컬럼값이 NULL이 아닌 경우
*/
SELECT * 
FROM EMPLOYEE;

--보너스를 받지 않는 사원들 (BONUS 컬럼값이 NULL인) 사번,이름,급여,보너스
SELECT EMP_ID
      ,EMP_NAME
      ,SALARY
      ,BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--사수가 없는 사원들의 사원명,사수사번,부서코드 조회
SELECT EMP_NAME
      ,MANAGER_ID
      ,DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;
--사수도 없고 부서배치도 받지 않은 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL
AND DEPT_CODE IS NULL;
--부서배치는 받지 않았지만 보너스는 받는 사원들 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL
AND BONUS IS NOT NULL;

/*
    < IN > 
    비교 대상 컬럼 값에 제시한 목록들 중 일치하는 값이 있는지 판별 
    
    [표현법]
    비교대상컬럼 IN (값,값,값,..)
*/
--부서코드가 D6이거나 D8이거나 D5인 사원들의 이름,부서코드,급여 조회
SELECT EMP_NAME
      ,DEPT_CODE
      ,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' 
OR DEPT_CODE = 'D8'
OR DEPT_CODE = 'D5';

--IN 연산자 이용 
SELECT EMP_NAME
      ,DEPT_CODE
      ,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D5','D8');

--직급코드가 J1 또는 J3 또는 J4인 사원들 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1','J3','J4');
--그 외 사원들 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN ('J1','J3','J4');

/*
    < 연결연산자 || >
    여러 컬럼값들을 마치 하나의 컬럼인것처럼 연결시켜주는 연산자
    컬럼과 리터럴을 연결 가능하다 
*/

SELECT EMP_ID,EMP_NAME,SALARY 
FROM EMPLOYEE;

SELECT EMP_ID || EMP_NAME || SALARY AS "연결된 컬럼"
FROM EMPLOYEE;

-- xxx번 xxx의 월급은 xxx원 입니다. 
SELECT EMP_ID||'번 '||EMP_NAME||'의 월급은 '||SALARY||'원 입니다.' AS "급여정보"
FROM EMPLOYEE;

-------------------------------------------------------------------
/*
    <연산자 우선순위>
    0. ()
    1. 산술연산자
    2. 연결연산자 
    3. 비교연산자
    4. IS NULL,LIKE,IN
    5. BETWEEN AND
    6. NOT 
    7. AND (논리연산자)
    8. OR (논리연산자)
*/
---------------------------------------------------------
/*
    < ORDER BY 절 >
    SELECT 문 가장 마지막에 기입하는 구문뿐만 아니라 가장 마지막에 실행되는 구문 
    최종 조회된 결과물들에 대해서 정렬 기준을 세워주는 구문 
    
    [표현법]
    SELECT 조회할 컬럼1,컬럼2,...
    FROM 조회할테이블명
    WHERE 조건식 (생략가능)
    ORDER BY [정렬기준컬럼/별칭/컬럼순번] [ASC/DESC](생략가능) [NULLS FIRST/NULLS LAST] (생략가능)

    오름차순 / 내림차순
    -ASC : 오름차순(생략 시 기본값)
    -DESC : 내림차순 
    
    정렬하고자 하는 컬럼값에 NULL이 있는 경우
    -NULLS FIRST : 해당 NULL값들을 앞으로 배치하겠다 (내림차순 정렬일 경우 기본값)
    -NULLS LAST : 해당 NULL값들을 뒤로 배치하겠다. (오름차순 정렬일 경우 기본값)
*/

--월급이 높은 사람들 부터 조회 (내림차순)
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT *
FROM EMPLOYEE
ORDER BY SALARY; --ASC 생략 (기본값)

--보너스 기준 정렬
SELECT EMP_NAME AS 사원명
      ,BONUS AS 보너스 
FROM EMPLOYEE
--ORDER BY BONUS; -- ASC (오름차순,NULLS LAST)
--ORDER BY BONUS DESC; -- DESC(내림차순,NULLS FIRST)
--ORDER BY 보너스; --별칭 이용 가능 
ORDER BY 사원명,보너스 DESC; -- 첫번째로 제시한 정렬기준이 일치할 경우 두번째 제시한 정렬기준 적용

--연봉 기준 정렬
SELECT EMP_NAME 
      ,SALARY
      ,(SALARY*12) AS 연봉
FROM EMPLOYEE
--ORDER BY (SALARY*12) DESC; --연봉 역순 
ORDER BY 연봉 DESC;
--ORDER BY 1 DESC; --순번 조회된 컬럼 순번 (1번부터)

--날짜(DATE) 기준 정렬
SELECT *
FROM EMPLOYEE
ORDER BY HIRE_DATE;

--ORDER BY는 숫자 뿐만 아니라 문자열,날짜도 정렬 가능하다 

















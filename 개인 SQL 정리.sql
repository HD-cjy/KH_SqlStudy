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

/* 
    --02_SELECT(KH계정)_FUNCTION.SQL
    

    함수 FUNCTION
    자바로 생각한다면 메소드와 같은 존재
    매개변수로 전달된 값들을 읽어 계산한 결과를 반환한다.
    
    -단일행 함수 : N개의 값을 읽어서 N개의 값을 반환한다(매 행마다 함수를 실행하여 결과를 반환함)
    -그룹 함수 : N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행 후 결과 반환)
    
    단일행 함수와 그룹함수는 함께 사용할 수 없다 : 결과 행 수가 다르기 때문에.

    단일 행 함수 
    -문자열과 관련된 함수
    LENGTH / LENGTHB
    -LENGTH(문자열) : 해당 문자열의 글자수 반환
    -LENGTHB(문자열) : 해당 전달 문자열의 바이트 수 반환
    
    결과값은 숫자로 반환 
    
    한글은 한글자당 3BYTE 크기
    영문,특수문자,숫자 1BYTE 크기
*/
--길이 3 , 바이트수 9
SELECT LENGTH('오라클'),LENGTHB('오라클')
FROM DUAL; -- DUAL : 가상테이블로 산술연산이나 가상컬럼 등 임의의 값을 조회하고자 할때 사용하는 테이블

--길이 6 , 바이트 6 
SELECT LENGTH('ORACLE'),LENGTHB('ORACLE')
FROM DUAL;

--테이블을 지정하여 함수 사용해보기 
SELECT EMAIL
      ,LENGTH(EMAIL) "이메일 길이"
      ,LENGTHB(EMAIL) "이메일 바이트수"
FROM EMPLOYEE;

SELECT EMP_NAME
      ,LENGTH(EMP_NAME) 
      ,LENGTHB(EMP_NAME)
FROM EMPLOYEE;

/*
    INSTR 
    -INSTR(문자열,특정문자,찾을위치,순번) : 문자열로부터 특정 문자의 위치값 반환 
    
    찾을 위치,순번은 생략가능
    결과값은 NUMBER 타입으로 반환
    
    찾을 위치 : 1 또는 -1
    1 : 앞에서부터 찾겠다(생략시 기본)
    -1 : 뒤에서부터 찾겠다.
*/

SELECT INSTR('AAABBCCBBAAA','B')
FROM DUAL;--앞에서부터 B를 찾아 해당 위치값 반환 (순번은 1부터)

SELECT INSTR('AAABBCCBBAAA','B',1,3)
FROM DUAL;--앞에서부터 3번째 위치한 B를 찾아서 위치값 반환 

SELECT INSTR('AAABBCCBBAAA','C',-1)
FROM DUAL;--뒤에서부터 첫번째 위치한 C를 찾아 위치값 반환

SELECT INSTR('ASD','C')
FROM DUAL; -- 찾을 수 없는 문자이기 때문에 0 반환

SELECT INSTR('ASD','A',1,3)
FROM DUAL; -- 3번째 순번을 찾을 수 없기 때문에 0 반환

SELECT INSTR('ASD','A',1,0)
FROM DUAL;--0번째 순번은 있을 수 없기 때문에 오류발생(범위오류)

--EMPLOYEE 테이블의 모든 사원의 이메일 @ 위치를 찾아보기
SELECT EMAIL,INSTR(EMAIL,'@')
FROM EMPLOYEE;

/*
    SUBSTR
    문자열로부터 특정 문자열을 추출하는 함수
    -SUBSTR(문자열,처음위치,추출할문자 개수)
    
    결과값은 CHARACTER 타입으로 반환(문자열)
    추출할 문자 개수는 생략가능 ( 생략시 끝까지 추출)
    처음위치는 음수로 제시 가능 ( 뒤에서부터 N번째 위치로 추출)
*/

SELECT SUBSTR('HELLO WORLD',5)
FROM DUAL; 

SELECT SUBSTR('HELLO WORLD',1,5)
FROM DUAL;--1번 위치부터 5개

SELECT SUBSTR('HELLO WORLD',3,5)
FROM DUAL;--3번 위치부터 5개

SELECT SUBSTR('HELLO WORLD',15)
FROM DUAL;--15번 위치 없으니 NULL반환

SELECT SUBSTR('HELLO WORLD',-3)
FROM DUAL;--뒤에서부터 3번째 위치부터 추출

--EMPLOYEE 테이블의 주민등록번호 데이터에서 성별만 추출해보기 
--000101-1122333
SELECT SUBSTR(EMP_NO,8,1) 성별,EMP_NO
FROM EMPLOYEE; --성별위치만 추출

--EMPLOYEE 테이블에서 사원들의 이메일중 ID 부분만 추출해보기
--사원명,아이디,이메일 조회해보세요 
SELECT EMP_NAME
      ,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) 아이디 --SUBSTR과 INSTR을 이용하여 아이디 추출 (@전까지)
      ,EMAIL
FROM EMPLOYEE;
--EMPLOYEE 테이블의 남자사원들 조회해보기 (SUBSTR)
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

--EMPLOYEE 테이블의 여자사원들 조회해보기 (SUBSTR)
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

/*
    LPAD,RPAD (문자열,최종길이(BYTE),덧붙일문자)
    문자열을 최종적으로 반환할 문자의 길이,덧붙이고자 하는 문자를 붙여 최종 길이를 반환
    결과값은 CHARACTER 타입(문자열)
    덧붙이고자 하는 문자는 생략가능 (생략시 공백 기본값)
*/

SELECT LPAD(EMAIL,20)
FROM EMPLOYEE;--왼쪽에 공백문자 총 20바이트가 되도록 채워짐 

SELECT LPAD(EMAIL,20,'#')
FROM EMPLOYEE;--문자 채우기 

SELECT RPAD(EMAIL,20,'@')
FROM EMPLOYEE;--오른쪽에 @ 문자를 총 20바이트가 되도록 채워짐 

SELECT RPAD(EMAIL,20)
FROM EMPLOYEE;--오른쪽에 공백채워짐

--주민번호 성별 뒤쪽은 *로 처리하기 
--주민번호를 성별까지 추출하고 나머지 총 자리수를 *로 채우는 처리 
SELECT SUBSTR(EMP_NO,1,8)
FROM EMPLOYEE; --성별까지 추출

--000101-1122333  (총 14자리)
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*') "주민 번호"
FROM EMPLOYEE;

/*
    LTRIM / RTRIM 
    
    -LTRIM/RTRIM (문자열,제거시킬문자)
    문자열의 왼쪽 또는 오른쪽에서 제거시키고자 하는 문자 제거 함수 
    제거시킬 문자 생략시 공백 제거 
    결과값은 CHARACTER (문자열)
*/

SELECT LTRIM('    K    H   ')
FROM DUAL; --왼쪽 공백 제거(제거시킬문자 생략시 공백이 기본값)

SELECT RTRIM('    K    H    ')
FROM DUAL;--오른쪽 공백 제거

SELECT LTRIM('AAABBBCCC','A')
FROM DUAL; -- 왼쪽에 있던 A 전부 지워짐

SELECT RTRIM('0001234560000','0') 
FROM DUAL; -- 오른쪽에 있던 0이 전부 지워짐

SELECT LTRIM('1234567890','123')
FROM DUAL; -- 왼쪽에 있던 123 모두 지워짐

SELECT LTRIM('123213212325678','123')
FROM DUAL;--지우고자하는 문자열을 통째로 지우는것이 아니라 각 문자를 비교해보고 지워주는 원리(없는 문자만나면 끝)

/*
    TRIM
    -TRIM(BOTH/LEADING/TRAILING '제거문자' FROM '문자열')
    :문자열의 양쪽,앞쪽,뒤쪽에 있는 특정 문자를 제거한 나머지 문자열 반환
    
    결과값은 CHARACTER형(문자열)
    BOTH/LEADING/TRAILING : 생략가능 생략시 기본값 BOTH(양쪽)
*/
SELECT TRIM('   K    H    ')
FROM DUAL;--양쪽 공백 제거 (문자 생략시 공백)

SELECT TRIM(LEADING 'A' FROM 'AAABBCCCC')
FROM DUAL;-- 왼쪽 A 지운값 반환

SELECT TRIM(TRAILING 'C' FROM 'AAABBCCCC')
FROM DUAL;--오른쪽 C 지운값 반환

--LTRIM,RTRIM 처럼 문자열을 지우는것은 불가능 (한글자만)
SELECT TRIM(TRAILING 'CB' FROM 'AAABBCCCC')
FROM DUAL;--오른쪽 C 지운값 반환

/*
    LOWER / UPPER / INITCAP 
        
    -LOWER(문자열) :소문자 변경
    -UPPER(문자열) :대문자 변경 
    -INITCAP(문자열) :첫글자만 대문자 변경
*/
SELECT LOWER('HELLO WORLD')
      ,UPPER('hello woRld')
      ,INITCAP('hello world')
      ,INITCAP('hello world,bye world!!!hi oracle') --구분되어지는 특수문자 뒤로 나오는 첫글자 대문자
FROM DUAL;

/*
    CONCAT 
    CONCAT(문자열1,문자열2)
    전달된 두문자열을 하나의 문자열로 반환
    결과는 CHARACTER (문자열)
*/

SELECT CONCAT('안녕','하세요')
FROM DUAL;

SELECT CONCAT('안녕','하세요','반갑','습니다')
FROM DUAL;--여러개 사용 불가능 합칠 수 있는 문자열은 두개뿐 

--CONCAT으로 여러개 붙이려면 중첩해서 사용해야함
SELECT CONCAT('안녕',CONCAT('하세요',CONCAT('반갑','습니다')))
FROM DUAL;
--중첩해서 사용한다면 가독성이 떨어지기 때문에 단순 2개의 문자열을 더하는게 아니라면
--연결 연산자 이용 

/*
    REPLACE
    -REPLACE(문자열,찾을문자,바꿀문자)
    :문자열로부터 찾을 문자를 바꿀문자로 변경한 문자열 반환
    
    결과값은 CHARACTER (문자열)
*/
SELECT REPLACE('영등포구 당산동','당산동','양평동')
FROM DUAL;

--EMPLOYEE 테이블에서 사원들의 이메일 주소가 gmail.com로 변경되었다 
SELECT REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

--------------------------------------------------------------------------
/*
    <숫자 관련 함수>
    
    -ABS(숫자) : 절대값구하는 함수 
    결과는 NUMBER
*/

SELECT ABS(-15)
FROM DUAL;-- 15

/*
    MOD 
    -MOD(숫자,나눌값) : 두수를 나눈 나머지값을 반환
    결과값 NUMBER
*/

SELECT MOD(10,3)
FROM DUAL; -- 1 

SELECT MOD(-10,3)
FROM DUAL; -- -1

SELECT MOD(19.9,3)
FROM DUAL; -- 1.9

/*
    ROUND 
    -ROUND(반올림할 수, 반올림 위치) : 반올림 처리 함수
    반올림위치 : 소수점 아래 N번째수에서 반올림 (생략가능 생략시 기본값 0)
    결과값 NUMBER
*/
SELECT ROUND(123.456)
FROM DUAL;--123

SELECT ROUND(123.456,1)
FROM DUAL; -- 123.5 소수점 첫번째자리

SELECT ROUND(123.456,2)
FROM DUAL; -- 123.46 소수점 두번째자리 

SELECT ROUND(123.456,-1)
FROM DUAL; --120 음수입력시 정수자리수 반올림

SELECT ROUND(123.456,-2)
FROM DUAL; --100

/*
    CEIL
    -CEIL(올림처리할 숫자) : 소수점 아래수를 무조건 올림처리하는 함수
    
    반환타입 NUMBER
*/

SELECT CEIL(123.119)
FROM DUAL;--124

SELECT CEIL(123.001)
FROM DUAL; --124

/*
    FLOOR
    -FLOOR(버림처리할숫자) : 소수점 아래를 버림처리하는 함수
    반환타입 NUMBER
*/
SELECT FLOOR(123.456)
FROM DUAL;--123

SELECT FLOOR(222.999)
FROM DUAL;--222

--직원 근무일수 조회 
SELECT SYSDATE-HIRE_DATE
FROM EMPLOYEE;-- 소수점 버려보기 

SELECT EMP_NAME
      ,FLOOR(SYSDATE-HIRE_DATE)||'일' "근무 일 수"
FROM EMPLOYEE;

/*
    TRUNC
    -TRUNC(버림처리숫자,위치) : 위치가 지정가능한 버림 처리 함수
    
    반환타입 NUMBER
    위치 생략가능 생략시 기본값 0
*/
SELECT TRUNC(123.456)
FROM DUAL;--123

SELECT TRUNC(123.456,1)
FROM DUAL;--123.4

SELECT TRUNC(123.456,2)
FROM DUAL;--123.45

SELECT TRUNC(123.456,-1)
FROM DUAL;--음수 지정시 정수자리수로 버림처리 120

---------------------------------------------------------
/*
    < 날짜 관련 함수 >
    DATE 타입 : 년,월,일,시,분,초를 다 포함한 자료형
    SYSDATE : 현재 시스템 날짜와 시간 반환
*/

--1.
--MONTHS_BETWEEN(DATE1,DATE2) : 두 날짜 사이의 개월수 반환 (결과값 NUMBER)
--DATE2가 더 미래일 경우 음수가 반환된다
--각 직원별 근무일수 근무 개월수를 조회해보자 
SELECT EMP_NAME 사원명
      ,FLOOR(SYSDATE-HIRE_DATE)||'일' "근무 일 수"
      ,FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))||'개월' "근무 개월 수"
FROM EMPLOYEE;

--2번째 전달값이 더 미래라면 음수로 처리됨
SELECT EMP_NAME 사원명
      ,FLOOR(SYSDATE-HIRE_DATE)||'일' "근무 일 수"
      ,FLOOR(MONTHS_BETWEEN(HIRE_DATE,SYSDATE))||'개월' "근무 개월 수"
FROM EMPLOYEE;

--2.
--ADD_MONTHS(DATE,NUMBER) : 특정 날짜에 해당 숫자만큼 개월수를 더한 날짜를 반환 (반환타입 DATE)
--오늘로부터 5개월 후 
SELECT ADD_MONTHS(SYSDATE,5)
FROM DUAL;

--전체 사원들의 1년 근속일(입사 1년)을 사원명,입사일,근속일 순으로 조회해보기 
SELECT EMP_NAME
      ,HIRE_DATE
      ,ADD_MONTHS(HIRE_DATE,12) --12개월뒤 
FROM EMPLOYEE;

--3.
--NEXT_DAY(DATE,요일(문자/숫자)) : 특정날짜에서 가장 가까운 해당 요일을 찾아 날짜를 반환( 반환타입 DATE)
SELECT NEXT_DAY(SYSDATE,'일요일')
FROM DUAL;--25/03/30 오늘 날짜 기준 가장 가까운 일요일

SELECT NEXT_DAY(SYSDATE,'토')
FROM DUAL;--25/03/29 오늘 기준 가장 가까운 토요일

SELECT NEXT_DAY(SYSDATE,1)
FROM DUAL;--25/03/30 -- 1: 일요일 2: 월요일 ~~~ 7:토요일

--영어로 요일 입력해보기
SELECT NEXT_DAY(SYSDATE,'MONDAY')
FROM DUAL;--영어로 입력하면 오류 발생(현재 컴퓨터의 언어가 한국어 설정이기 때문)

--영어로 처리하려면 언어세팅을 영어로 변경해야한다.
--DDL (데이터 정의언어)
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

--언어 변경 후 확인 
SELECT NEXT_DAY(SYSDATE,'MONDAY')
FROM DUAL; -- 25/03/31 

SELECT NEXT_DAY(SYSDATE,'월요일')
FROM DUAL; -- 언어세팅 영어로 변경해서 한글이 적용불가 

--한국어 세팅하기 
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--4.
--LAST_DAY(DATE) : 특정 날짜 달의 마지막 날짜를 반환 (반환타입 DATE)
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--사원의 이름,입사일,입사한 월의 마지막 날짜 확인
SELECT EMP_NAME
      ,HIRE_DATE
      ,LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

--5. 
/*
    EXTRACT : 년,월,일 정보 추출하여 반환(NUMBER타입)
    -EXTRACT(YEAR FROM 날짜) : 특정 날짜로부터 년도만 추출
    -EXTRACT(MONTH FROM 날짜) : 특정 날짜로부터 월만 추출
    -EXTRACT(DAY FROM 날짜) : 특정 날짜로부터 일만 추출
*/

SELECT EXTRACT(YEAR FROM SYSDATE) --2025
      ,EXTRACT(MONTH FROM SYSDATE) -- 3 
      ,EXTRACT(DAY FROM SYSDATE) --26
FROM DUAL;

--사원명,입사년도,입사월,입사일 조회 
SELECT EMP_NAME 사원명
      ,EXTRACT(YEAR FROM HIRE_DATE) 입사년도
      ,EXTRACT(MONTH FROM HIRE_DATE) 입사월
      ,EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE;

---------------------------------------------------
/*
    < 형변환 함수 >
    NUMBER / DATE => CHARACTER 
    
    - TO_CHAR(NUMBER/DATE,포맷)
    :숫자형 또는 날짜형 데이터를 문자형 타입으로 반환(입력한 포맷에 맞춰서)
*/

SELECT TO_CHAR(1234)
FROM DUAL;

--숫자를 문자열로 바꿀때 포맷 형식 (자리수 지정)
SELECT TO_CHAR(1234,'00000') 수
FROM DUAL; --'01234' 빈자리를 0으로 자리채우기

SELECT TO_CHAR(1234,'99999') 수
FROM DUAL; --'1234' 빈자리 공백(0으로 채워지지 않음)

SELECT TO_CHAR(1234,'FM99999') 수
FROM DUAL; 

SELECT TO_CHAR(1234,'L00000') 수
FROM DUAL;-- 로컬 원화 기호가 붙는다  01234

SELECT TO_CHAR(1234,'L99999') 수
FROM DUAL;-- 0 표시없이 처리 

SELECT TO_CHAR(1234567,'L999,999,999') 돈
FROM DUAL; --앞쪽 공백 처리 (자리수)

SELECT TO_CHAR(1234567,'FML999,999,999') 돈
FROM DUAL; --공백 없이 원화 포맷 표시

--날짜를 문자열로 
SELECT SYSDATE 날짜
FROM DUAL;

SELECT TO_CHAR(SYSDATE) 날짜
FROM DUAL;--문자열로 변환되었기 때문에 시간정보가 따로 나오지 않음 '25/03/26' 라는 문자열로 변환됨

--SYSDATE (DATE타입) 에서 추출할 수 있는 데이터 포맷에 맞춰 문자열 반환
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS')
FROM DUAL;
--시 분 초 : HH MI SS 
--년 월 일 : YY MM DD
--24시 기준 : HH24
--오전 오후 : PM
--요일 : DAY 
--O요일에서 앞에만 표기 : DY

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD DAY PM HH24:MI:SS')
FROM DUAL; -- 2025-03-26 수요일 오후 15:35:33
-- 별도의 문자열 넣고자 한다면 "" 형식에 작성 
--기본 포맷 형식에서 특수문자는 ( : / - ) 표기 
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD DY "요일" PM HH24:MI:SS')
FROM DUAL;

--년도로 사용할 수 있는 포맷 
SELECT TO_CHAR(SYSDATE,'YYYY') --2025
      ,TO_CHAR(SYSDATE,'RRRR') --2025
      ,TO_CHAR(SYSDATE,'YY') --25
      ,TO_CHAR(SYSDATE,'RR') --25
      ,TO_CHAR(SYSDATE,'YEAR') -- TWENTY TWENTY-FIVE
FROM DUAL;

--YY 와 RR의 차이 
--R : 반올림
--YY : 앞에 20이 붙어서 만약 80이라면 2080이 된다.
--RR : 50년 기준으로 작으면 20 크면 19가 붙는다 80이면 1980 

SELECT TO_DATE('80','YY')
FROM DUAL;

SELECT TO_DATE('80','RR')
FROM DUAL;

--월표기
SELECT TO_CHAR(SYSDATE,'MM') --03
      ,TO_CHAR(SYSDATE,'MON') --3월 (영문기준이면 약어형태)
      ,TO_CHAR(SYSDATE,'MONTH') --3월
      ,TO_CHAR(SYSDATE,'RM') --III 로마표기
FROM DUAL;

--ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--일표기 
SELECT TO_CHAR(SYSDATE,'D')  --4 일주일 기준으로 일요일부터 숫자 
      ,TO_CHAR(SYSDATE,'DD') --26 월기준 1일부터 숫자 
      ,TO_CHAR(SYSDATE,'DDD') -- 085 1년기준 1월1일부터 숫자
FROM DUAL;

-----------------------------------------------------------
/*
    TO_DATE 
    NUMBER / CHARACTER - DATE
    TO_DATE(NUMBER/CHARACTER,포맷) : 숫자형 또는 문자형 데이터를 날짜형으로 변환(변환타입 DATE)
*/

SELECT TO_DATE(850101)
FROM DUAL;--RR/MM/DD 포맷 

SELECT TO_DATE(000505)
FROM DUAL;-- 숫자에서 앞에오는 0은 표현되지 않기 때문에 오류발생(000505를 505로 인식)
--때문에 위처럼 숫자에 0부터 오는 경우는 문자열 표기로 처리해야함

SELECT TO_DATE('000505')
FROM DUAL;--문자열로 날짜 변환

--포맷 지정하여 날짜 표기
SELECT TO_DATE('250130 182001','RRMMDD HH24:MI:SS') 날짜
FROM DUAL;

--YY포맷을 지정하여 년도 표기 
SELECT TO_DATE('990101','YYMMDD') 날짜
FROM DUAL;--YY형식을 입력하면 년도 앞쪽에 20이 붙어서 2099가 된다.
--두자리 년도 형식에 YY를 부여하면 20이 붙고 RR을 부여하면 50기준 작으면 20 크면 19가 붙는다

--RR포맷을 지정하여 년도 표기 
SELECT TO_DATE('500101','RRMMDD') 날짜
FROM DUAL;
--50미만이면 현재 세기 표현(1~49)
--50이상이면 이전 세기 표현(50~99)

------------------------------------------------------------------
/*
    CHARACTER -> NUMBER
    TO_NUMBER(문자,포맷) : 문자형 데이터를 숫자형으로 변환(NUMBER)
*/

--자동형변환의 예시 
SELECT '123'+123
FROM DUAL; -- 246 (문자를 숫자로 자동형변환 후 산술연산까지 처리)

SELECT '123,000' + '256,000'
FROM DUAL;--오류발생 : 문자열에 숫자만 있는것이 아닌 문자인 , 기호까지 있기 때문에 자동형변환 불가

SELECT TO_NUMBER('123,000','999,999,999') + TO_NUMBER('256,000','999,999,999') 계산
FROM DUAL;--포맷형식에 맞춰 형변환 후 산술 연산까지 처리 가능 

SELECT TO_NUMBER('000123')
FROM DUAL;-- 123 / 0으로 시작하는 숫자 문자열도 변환 가능

SELECT EMP_NAME
      ,EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 2; --자동형변환 처리가 되기 때문에 문자가 아닌 숫자도 가능 

---------------------------------------------------------------------------------
/*
    NULL 관련 함수
    
    NVL(컬럼명,해당컬럼값이 NULL일 경우 치환할 값);
    -해당 컬럼값이 존재할 경우 기존 컬럼값 반환
    -해당 컬럼값이 존재하지 않을 경우 (NULL일 경우) 제시한 값 반환
*/

SELECT EMP_NAME,BONUS,NVL(BONUS,0)
FROM EMPLOYEE;

--보너스 포함 연봉 계산해서 사원명과 함께 조회해보기 
SELECT EMP_NAME 사원명
      ,(SALARY+(SALARY*BONUS))*12 "보너스 포함 연봉"
      ,(SALARY+(SALARY*NVL(BONUS,0)))*12 "보너스 포함 연봉"
FROM EMPLOYEE; --보너스가 없는 경우 0으로 변경되어 계산 처리 완료

--부서코드가 없는 사원은 부서없음 으로 조회해보기
SELECT EMP_NAME 사원명
      ,NVL(DEPT_CODE,'부서없음') 부서코드
FROM EMPLOYEE;

--NVL2(컬럼명,결과값1,결과값2)
--해당 컬럼값이 존재할경우 (NULL이 아닐 경우) - 결과값1 반환
--해당 컬럼값이 존재하지 않을 경우 (NULL일 경우) - 결과값2 반환

--보너스가 있는 사원은 보너스 있음 보너스가 없는 사원은 보너스 없음 조회해보기 
SELECT EMP_NAME
      ,NVL2(BONUS,'보너스 있음','보너스 없음') "보너스 유무"
FROM EMPLOYEE;

--부서가 있는 사원은 부서 배치 완료, 부서가 없는 사원은 부서 미배치 로 조회해보기 
--사원명,부서정보 조회
SELECT EMP_NAME 사원명
      ,NVL2(DEPT_CODE,'부서 배치 완료','부서 미배치') 부서정보
FROM EMPLOYEE;

--NULLIF(비교대상1,비교대상2) : 동등비교
--두 값이 동일할 경우 NULL 반환
--두 값이 동일하지 않을 경우 비교대상 1 반환 

SELECT NULLIF('123','123')
FROM DUAL; -- 두 값이 동일하기 때문에 NULL값 반환

SELECT NULLIF('213','123')
FROM DUAL; --두 값이 동일하지 않을 경우 비교대상 1 반환 

----------------------------------------------------------------------------------
/*
    < 선택 함수 > 
    DECODE(비교대상,조건값1,결과값1,조건값2,결과값2,...조건값N,결과값N,결과값)
    
    자바에서 SWITCH문과 유사한 형태로 
    
    비교대상과 비교한 조건값으로 해당 결과값을 내보내는 함수 
    비교대상에는 컬럼명,산술연산(숫자),함수(리턴값)이 들어갈 수 있다.
    비교대상과 조건값이 모두 일치하지 않으면 마지막에 작성한 결과값으로 반환된다.
    마지막 결과값은 SWITCH문에서 DEFAULT 역할
    생략도 가능하지만 생략한다면 조건에 일치하는게 없을 경우 NULL이 반환된다.
*/

--사번,사원명,주민번호,성별 1이면 남자,2면 여자로 조회해보기 
SELECT EMP_ID 사번
      ,EMP_NAME 사원명
      ,EMP_NO 주민번호
      ,DECODE(SUBSTR(EMP_NO,8,1),'1','남자','2','여자','3','남자','4','여자') "성별"
FROM EMPLOYEE;

--직원들의 급여를 인상시켜 조회해보기
--직급코드가 J7인 사원은 급여 10% 인상해서 조회
--직급코드가 J6인 사원은 급여 15% 인상해서 조회
--직급코드가 J5인 사원은 급여 20% 인상해서 조회
--그 외의 사원들은 급여 5% 인상해서 조회
--사원명 직급코드 급여 인상 후 급여 로 조회해보기

SELECT EMP_NAME 사원명
      ,JOB_CODE 직급코드
      ,SALARY 급여 
      ,DECODE(JOB_CODE,'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2,SALARY*1.05) "인상 후 급여"
FROM EMPLOYEE;

/*
    < CASE WHEN THEN >
    [표현법]
    CASE WHEN 조건1 THEN 결과1
         WHEN 조건2 THEN 결과2
         ....
         ELSE 결과값
    END
    
    DECODE는 동등비교로 수행하지만 CASE WHEN THEN 구문은 범위 비교도 가능하다 
    자바에서 IF문처럼 사용 
*/

--사번,사원명,주민번호,성별1이면 남자 2면 여자 "성별"로 조회해보기 
SELECT EMP_ID 사번
      ,EMP_NAME 사원명
      ,EMP_NO 주민번호
      ,CASE 
        WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남자'
--        WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여자'
        ELSE '여자'
        END "성별"
FROM EMPLOYEE;

--직원들의 급여를 인상시켜 조회해보기
--직급코드가 J7인 사원은 급여 10% 인상해서 조회
--직급코드가 J6인 사원은 급여 15% 인상해서 조회
--직급코드가 J5인 사원은 급여 20% 인상해서 조회
--그 외의 사원들은 급여 5% 인상해서 조회
--사원명 직급코드 급여 인상 후 급여 로 조회해보기
SELECT EMP_NAME
      ,JOB_CODE
      ,SALARY
      ,CASE 
         WHEN JOB_CODE='J7' THEN SALARY*1.1
         WHEN JOB_CODE='J6' THEN SALARY*1.15
         WHEN JOB_CODE='J5' THEN SALARY*1.2
         ELSE SALARY*1.05
        END "인상 후 급여"
FROM EMPLOYEE;

--사원명,급여,급여등급 조회
--급여등급은 급여가 500만원 초과일 경우 '고급'
--급여가 500만원 이하 350만원 초과일 경우 '중급'
--급여가 350만원 이하일 경우 '초급' 으로 조회해보기 

SELECT EMP_NAME
      ,SALARY
      ,CASE 
         WHEN SALARY > 5000000 THEN '고급'
         WHEN SALARY > 3500000 THEN '중급'
         ELSE '초급'
        END "급여 등급"
FROM EMPLOYEE;

--------------------위쪽은 단일행 함수들-------------------------------

-------------------------그룹함수--------------------------------
--그룹함수 : 데이터들의 합,평균,최대값,최소값 등등을 구할 수 있는 함수
-- N개의 값을 읽어서 1개의 값을 반환해주는 함수 (하나의 그룹을 기준으로 실행결과를 반환한다)

--1.SUM(숫자) : 해당 컬럼값들의 총 합계를 반환해주는 함수 
--전체 사원들의 총 급여 합계
SELECT SALARY
FROM EMPLOYEE;

SELECT SUM(SALARY)
FROM EMPLOYEE;

--부서코드가 D5인 사원들의 급여합계를 구해주세요
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE ='D5';

--남자사원들의 급여 합계
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2.AVG(숫자) : 해당 컬럼값들의 평균값을 구해서 반환
--전체 사원들의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

--3.MIN(아무타입) : 해당 컬럼값들 중 가장 작은 값 반환
--전체사원들중 최저급여,가장작은 이름,가장 작은 이메일,가장 작은 입사날짜
SELECT MIN(SALARY) 최저급여
      ,MIN(EMP_NAME) 이름
      ,MIN(EMAIL) 이메일
      ,MIN(HIRE_DATE) 입사일
FROM EMPLOYEE;
--MIN함수는 해당 컬럼을 오름차순 했을때 가장 위에 올라오는 값을 보여주게 된다.

--4.MAX(아무타입) : 해당 컬럼값들 중 가장 큰 값 반환
--전체 사원들중 급여,이름,이메일,입사일이 가장 큰 데이터 확인
SELECT MAX(SALARY) 최고급여
      ,MAX(EMP_NAME) 이름
      ,MAX(EMAIL) 이메일
      ,MAX(HIRE_DATE) 입사일
FROM EMPLOYEE;
--MAX함수는 해당 컬럼을 내림차순 했을때 가장 위에 올라오는 값을 보여준다 

--5. COUNT(컬럼명/DISTINCT 컬럼명) : 조회된 행의 개수를 반환
--COUNT(*) : 조회결과에 해당하는 모든 행의 개수 반환
--COUNT(컬럼명) : 제시한 해당 컬럼값이 NULL이 아닌 행의 개수를 반환
--COUNT(DISTINCT 컬럼명) : 제시한 해당 컬럼값이 중복이 있을 경우 하나만 세어 반환(NULL 미포함)

--전체 사원 수 
SELECT COUNT(*)
FROM EMPLOYEE; --23 

SELECT * 
FROM EMPLOYEE;

--여자 사원 수를 구해보자 
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '2'; --8명

--부서배치된 사원 수 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL; -- 21명

--COUNT함수에 컬럼명을 넣어 NULL이 아닌 데이터행 수 반환 받기
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

--사수가 있는 사원들 수 조회
SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE; --16

SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL; --16행

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- 7행 (NULL포함)


SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE; --6 (NULL제외)

--사원들이 속해있는 직급 조회 
SELECT JOB_CODE
FROM EMPLOYEE;

SELECT COUNT(JOB_CODE)
FROM EMPLOYEE;--23

SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE; --7

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; --7행

/*
    파일명 : 03_SELECT(KH계정)_GROUP BY절.SQL
    
    <GROUP BY절>
    
    그룹을 묶어줄 기준을 제시할 수 있는 구문 -> 그룹함수와 같이 사용된다.
    해당 제시된 기준별로 그룹을 묶을 수 있다.
    여러개의 값들을 하나의 그룹으로 묶어 처리할 목적으로 사용
    
    [표현법]
    GROUP BY 묶어줄 기준 컬럼
*/

--각 부서별로 총 급여의 합계
SELECT SUM(SALARY)
FROM EMPLOYEE;--전체 데이터가 하나의 그룹으로 처리 

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE ='D9'; -- D9 부서코드를 가진 사원들의 급여합 

--각 부서별로 그룹처리 해보기
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- EMPLOYEE 테이블에 있는 DEPT_CODE 별로 그룹화하기 

--묶은 그룹 별로 그룹함수를 사용해보기
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; --DEPT_CODE 별로 그룹화된 그룹의 급여 합계

--부서별 사원 수 조회
SELECT DEPT_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--직급별 직급코드,급여합,사원수,보너스 받는 사원수,평균 급여,최소급여,최고 급여 조회해보기
SELECT JOB_CODE
      ,SUM(SALARY)
      ,COUNT(*)
      ,COUNT(BONUS)
      ,AVG(SALARY)
      ,MIN(SALARY)
      ,MAX(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--각 부서별 총 급여의 합을 부서별 오름차순 정렬 후 조회
SELECT DEPT_CODE
      ,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;
--각 부서별 부서코드,사원수,보너스받는사원수,사수가 있는 사원수,평균급여를 부서별 오름 차순 정렬 조회
SELECT DEPT_CODE
      ,COUNT(*)
      ,COUNT(BONUS)
      ,COUNT(MANAGER_ID)
      ,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--성별 별 사원수 
SELECT SUBSTR(EMP_NO,8,1) --성별을 확인할 수 있는 정보 추출
      ,COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1); --함수처리 결과로 그룹화 하기  

--DECODE를 이용하여 남 / 여 로 조회하기 
--남 / 여 사원수를 조회해보세요
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') 성별 --함수처리 결과 조회데이터 변경
      ,COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1); --함수 처리 결과로 그룹화

--각 부서별로 평균 급여가 300만원 이상인 부서 조회
SELECT DEPT_CODE
      ,ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE ROUND(AVG(SALARY)) >= 3000000 -- WHERE절에는 그룹함수 사용될 수 없음 (WHERE 절은 단일행 처리)
GROUP BY DEPT_CODE;

/*
    <HAVING 절>
    그룹에 대한 조건을 제시하고자 할때 사용하는 구문
    (주로 그룹 함수를 이용하여 조건 제시 ) - GROUP BY절과 함께 사용된다.
    위치는 GROUP BY 뒤
        
    SELECT 구문 실행 순서
    1. FROM : 조회하고자 하는 테이블명
    2. WHERE : 조건식(그룹함수 불가능)
    3. GROUP BY : 그룹 기준에 대한 컬럼 또는 함수식 
    4. HAVING : 그룹함수식에 대한 조건식 (그룹조건)
    5. SELECT : 조회하고자하는 컬럼들 나열 
    6. ORDER BY : 정렬기준 작성
*/

--각 부서별로 평균 급여가 300만원 이상인 부서 조회
SELECT DEPT_CODE
      ,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000; --그룹함수를 이용한 조건처리

--각 직급 별 총 급여합이 1000만원 이상인 직급코드 급여합 조회
SELECT JOB_CODE
      ,SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

--각 직급별 급여 평균이 300만원 이상인 직급코드,평균급여,사원수,최고급여,최소급여 조회하기
SELECT JOB_CODE
      ,ROUND(AVG(SALARY))
      ,COUNT(*)
      ,MAX(SALARY)
      ,MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING AVG(SALARY) >= 3000000;
--각 부서별 보너스를 받는 사원이 없는 부서만을 조회 (부서코드 사원수)
SELECT DEPT_CODE
      ,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS)=0; --COUNT(컬럼) - NULL을 세지 않기 때문에 0 이라면 보너스를 받는 사원이 없다

--각 부서별 평균 급여가 350만원 이하인 부서만 조회 (부서코드,평균급여)
SELECT DEPT_CODE
      ,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) <= 3500000;

--COUNT에 선택함수 활용
SELECT DEPT_CODE "부서 코드"
      ,COUNT(*) "부서별 사원 수"
      ,COUNT(CASE WHEN SALARY >= 3000000 THEN 1 END) "300이상 사원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT COUNT(1)
FROM EMPLOYEE;-- 전체 사원수 처럼 처리됨 (* 와같이)

---------------------------------------------------------------------------
/*
    < 집합 연산자 SET OPERATOR >
    
    여러개의 쿼리문을 가지고 하나의 쿼리문을 만드는 연산자
    
    UNION(합집합) 두 쿼리문을 수행한 결과값을 더한 후 중복되는 부분은 한번만 제거한 결과
    UNION ALL : 두 쿼리문을 수행한 결과값을 더한 후 중복 제거를 하지 않은 결과 
    INTERSECT(교집합) : 두 쿼리문을 수행한 결과값의 중복되는 부분
    MINUS (차집합) : 선행 쿼리문 결과값에서 후행 쿼리문 결과값을 뺀 나머지 부분
                    -선행 쿼리문 결과값 - 교집합
*/

--1. UNION (합집합) 두 쿼리문을 수행한 결과값을 더하고 중복값은 한번만 포함되는 결과
--부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회 (사번,사원명,부서코드,급여)

--부서코드가 D5인 사원들 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'; --6명(206,207,208,209,210,215)

--급여가 300만원 초과인 사원들 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8명(200,201,202,204,205,209,215,217) 

--UNION을 이용하여 위 두 조회구문을 하나로 합치기
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 12명(200,201,202,204,205,206,207,208,209,210,215,217)
--같은 테이블일 경우 OR연산으로 가능하지만 다른 테이블끼리의 조회 결과를 하나로 합치고자한다면 집합연산자 이용)

--직급코드가 J6이거나 부서코드가 D1인 사원들 조회(사번,사원명,부서코드,직급코드)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE ='J6'; --6명 (전형돈,장쯔위,하동운,차태연,전지연,이태림)

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; --3명 (방명수,차태연,전지연)

--UNION으로 조회결과 합치기
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE ='J6'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; --7명 (전형돈,장쯔위,하동운,방명수,차태연,전지연,이태림)

--UNION ALL : 여러 쿼리 결과를 더하여 보여주는 연산자(중복제거 하지 않음)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;--14명(중복제거 하지 않음)


SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE ='J6'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; --9명(중복제거 하지 않음)

--INTERSECT : 교집합, 여러 쿼리결과의 중복된 결과만 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; --중복된 데이터만 조회(교집합)

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE ='J6'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; --2명(중복된 데이터만 조회(교집합))

--MINUS :차집합, 선행쿼리 결과에 후행 쿼리 결과를 뺀 나머지
--직급코드가 J6인 사원들 중에서 부서코드가 D1인 사원들을 제외한 나머지 사원들 조회(사번,사원명,부서코드,직급코드)

--직급코드 J6 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'; --6명(전형돈,장쯔위,하동운,차태연,전지연,이태림)
--부서코드 D1 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';--3명(방명수,차태연,전지연)

SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
MINUS
SELECT EMP_ID,EMP_NAME,DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';--4명(전형돈,장쯔위,하동운,이태림) 중복데이터 2명이 제외된 나머지 조회됨


CREATE TABLE COPY_EMP
AS SELECT * FROM EMPLOYEE; -- 테이블복사 

ALTER TABLE COPY_EMP RENAME COLUMN JOB_CODE TO J_CODE;
ALTER TABLE COPY_EMP RENAME COLUMN EMP_NAME TO E_NAME;

SELECT * FROM COPY_EMP;

SELECT EMP_NAME,JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
UNION ALL
SELECT EMAIL,EMP_ID
FROM COPY_EMP
WHERE DEPT_CODE = 'D9';

--집합연산자를 이용하기 위해서는 컬럼 수,자료형을 맞춰서 조회해야한다.

DROP TABLE COPY_EMP; --테이블 삭제 

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
--연결 컬럼(EMPLOYEE 테이블의 DEPT_CODE / DEPARTMENT 테이블의 DEPARTMENT)
select EMP_ID,EMP_NAME,DEPT_CODE,DEPT_ID,DEPT_TITLE
from DEPARTMENT,EMPLOYEE
where DEPT_CODE = DEPT_ID
order by 1;



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
select emp_id,EMP_NAME,Job_CODE, job_name
from 
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

/*
    --05_SELECT(KH계정)_SUBQUERY.SQL  
    
    <SUBQUERY 서브쿼리>
    하나의 주된 SQL문 안에 포함된 또 하나의 SELECT 문
    메인 SQL문을 위해 보조 역할로 사용된다.
    EX) SELECT,INSERT,CREATE,UPDATE

*/
--노옹철 사원과 같은 부서인 사원들
--1) 노옹철 사원의 부서코드를 알아오기 
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; --D9

--2)D9 부서코드를 가진 사원들 조회
SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--위 작업을 하나로 합치기 
SELECT EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME ='노옹철');

--전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번 이름 직급코드 조회
--1)전체 사원의 평균 급여 알아내기
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE; --3047662.60869565217391304347826086956522
--2)구해낸 평균 급여로 조건 넣어주기
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE
WHERE SALARY > 3047662.60869565217391304347826086956522;

--3)위 두작업 하나로 합치기 (서브쿼리)
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
/*
    서브쿼리 구분
    서브쿼리의 수행 결과값이 몇행 몇열이냐에 따라서 분류된다
    
    -단일행 단일열 서브쿼리 : 서브쿼리를 수행한 결과값이 1개일때 (한칸의 컬럼값으로 조회될때)
    -다중행 단일열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러행이고 하나의 열일때 
    -단일행 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 하나의 행에 여러 컬럼으로 나뉠때
    -다중행 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러행과 여러 컬럼으로 나뉠때
    
    *서브쿼리를 수행한 결과 유형에 따라서 사용가능한 연산자가 다르다.
    
   
*/

/*
     1.단일행(단일열)서브쿼리 
      서브쿼리의 조회 결과가 오로지 1개일때 
      일반 연산자 사용가능(=,!=,>=,<=,<,>) 
*/
--전 직원의 평균 급여보다 더 적게 받는 사원들의 사원명 직급코드 급여 조회 
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE); -- 3047662.60869565217391304347826086956522

--최저 급여를 받는 사원의 사번,사원명,직급코드,급여,입사일 조회
--최저 급여 조회
SELECT MIN(SALARY)
FROM EMPLOYEE;--1380000

SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = 1380000;

--합치기
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY,HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

--노옹철 사원의 급여보다 더 많이 받는 사원들의 사번,이름,부서코드,급여 조회
--노옹철 사원 급여 조회 
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -- 3700000

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3700000;

--합치기
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
--노옹철 사원의 급여보다 많이 받는 사원들의 사번,이름,부서명,급여조회
--노옹철 사원 급여
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

--ORACLE 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,SALARY
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+)
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '노옹철');

--ANSI
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');

--부서별 급여 합이 가장 큰 부서 하나만 부서코드,부서명,급여합 조회(SUBQUERY,JOIN,GROUP BY,HAVING)
--부서별 급여 합 가장 큰 부서의 급여합
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; --부서별  17700000

SELECT DEPT_CODE,DEPT_TITLE,SUM(SALARY)
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE,DEPT_TITLE
HAVING SUM(SALARY) = 17700000;

--합치기
--ORACLE 
SELECT DEPT_CODE,DEPT_TITLE,SUM(SALARY)
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
GROUP BY DEPT_CODE,DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

--ANSI
SELECT DEPT_CODE,DEPT_TITLE,SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE,DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

/*
    2.다중행 단일열 서브쿼리 
    서브쿼리의 조회 결과값이 여러 행일 경우 
    
    - IN (10,20,30) 서브쿼리 : 여러개의 결과값 중에서 하나라도 일치하는것이 있다면 /NOT IN : 없다면
    - > ANY (10,20,30) 서브쿼리 : 여러개의 결과값 중에서 하나라도 클 경우 (여러개의 결과값중 가장 작은값보다 클 경우)
    - < ANY (10,20,30) 서브쿼리 : 여러개의 결과값 중에서 하나라도 작을 경우 (여러개의 결과값중 가장 큰 값보다 작을 경우)
    - > ALL : 여러개의 결과값의 모든 값보다 클 경우 (가장 큰 값보다 클 경우)
    - < ALL : 여러개의 결과값의 모든 값보다 작을 경우 (가장 작은 값보다 작을 경우)
*/

--각 부서 별 최고 급여를 받는 사원의 이름 직급코드 급여 조회
--1) 각 부서 별 최고 급여 조회 (다중행,단일열)
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2) 위 급여를 받는 사원들 정보 조회
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000,3660000,8000000,3760000,3900000,2490000,2550000);

--3) 합치기
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                 FROM EMPLOYEE
                 GROUP BY DEPT_CODE);

--선동일 또는 유재식 사원과 같은 부서인 사원들을 조회 (사원명,부서코드,급여)
--선동일 또는 유재식 사원 부서 코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('선동일','유재식'); -- D9,D6

SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9','D6');

--합치기
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('선동일','유재식'));

--이오리 또는 하동운 사원과 같은 직급인 사원들 조회 (사원명,직급코드,부서코드,급여)
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('이오리','하동운'); --J6,J7

SELECT EMP_NAME,JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J6','J7');

--합치기
SELECT EMP_NAME,JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME IN ('이오리','하동운'));
                   
--대리 직급임에도 과장 직급의 급여보다 많이 받는 사원들 조회(사번,사원명,직급명,급여)
--과장 직급들의 급여 조회
SELECT SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME ='과장'; --220,250,376

--위 급여중에서 하나라도 더 많이 받는 사원들 조회 
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY > ANY (2200000,2500000,3760000);

--위 구문 합치고 대리직급 조건 추가 
--ORACLE 
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY > ANY (SELECT SALARY
                  FROM EMPLOYEE E,JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME ='과장')
AND JOB_NAME = '대리';
                  
--ANSI
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE E,JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE
                    AND JOB_NAME ='과장')
AND JOB_NAME = '대리';

--과장 직급임에도 모든 차장 직급의 급여보다 많이 받는 직원 조회(사번,이름,직급명,급여)
--ALL 이용하기
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장'; -- 280,155,249,248

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY > ALL(2800000,1550000,2490000,2480000);

--위 구문 합치고 과장 조건 추가 
--ANSI
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY > ALL(SELECT SALARY
                   FROM EMPLOYEE
                   JOIN JOB USING(JOB_CODE)
                   WHERE JOB_NAME = '차장')
AND JOB_NAME = '과장';

--ORACLE 
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J 
WHERE E.JOB_CODE = J.JOB_CODE
AND SALARY > ALL(SELECT SALARY
                 FROM EMPLOYEE E,JOB J
                 WHERE E.JOB_CODE = J.JOB_CODE
                 AND JOB_NAME = '차장')
AND JOB_NAME = '과장';

/*
    3.(단일행)다중열 서브쿼리
    
    서브쿼리 조회 결과가 한 행이지만 컬럼 개수가 여러개로 조회될때 (다중열)
*/
--하이유 사원과 같은 부서코드,직급코드에 해당하는 사원들 조회(사원명,부서코드,직급코드,고용일)
--1)하이유 사원의 부서코드와 직급코드 조회
SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='하이유';--D5,J5

--2)D5와 J5를 가진 사원들 조회
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
AND JOB_CODE = 'J5';

--3) 위 구문 합쳐보기 (단일행 단일열 서브쿼리로 )
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME ='하이유')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME ='하이유');
                
--4)다중열 서브쿼리 이용해서 합쳐보기 (조회컬럼과 비교컬럼 맞추기)
SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) = (SELECT DEPT_CODE,JOB_CODE
                              FROM EMPLOYEE
                              WHERE EMP_NAME ='하이유');
                              
--박나라 사원과 같은 직급코드,같은 사수사번을 가진 사원들의 사번,이름,직급코드,사수사번 조회
SELECT JOB_CODE,MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라'; -- J7,207

SELECT EMP_ID,EMP_NAME,JOB_CODE,MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE,MANAGER_ID) = (SELECT JOB_CODE,MANAGER_ID
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '박나라');

/*
    4. 다중행 다중열 서브쿼리 
    
      서브쿼리의 조회 결과가 다중행,다중열인 경우 
*/
--각 직급별 최소 급여를 받는 사원들 조회(사번,사원명,직급코드,급여)
--1)직급별 최소 급여 조회
SELECT JOB_CODE,MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE; -- 직급별 묶음 

--위 조회 결과와 일치하는 사원들 조회 
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE,MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

--각 부서별 최고 급여를 받는 사원들 조회(사번,사원명,부서코드,급여)
SELECT DEPT_CODE,MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--위 조회 결과를 이용해 사원 조회 
SELECT EMP_ID
      ,EMP_NAME
      ,NVL(DEPT_CODE,'부서 없음')
      ,SALARY 
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'부서 없음'),SALARY) IN (SELECT NVL(DEPT_CODE,'부서 없음'),MAX(SALARY)
                                             FROM EMPLOYEE
                                             GROUP BY DEPT_CODE);
                                             
---------------------------------------------------------------------------------------
/*
    5. 인라인 뷰 (INLINE VIEW)
    FROM 절에서 서브쿼리를 제시하여 
    조회된 결과(RESULT SET)를 테이블처럼 사용하는 구문 
*/
--보너스 포함 연봉이 3000만원 이상인 사원들의 사번,이름,보너스포함연봉,부서코드를 조회
SELECT EMP_ID 사번
      ,EMP_NAME 사원명
      ,(SALARY+(SALARY*NVL(BONUS,0)))*12 "보너스포함연봉"
      ,NVL(DEPT_CODE,'부서 없음') 부서코드
FROM EMPLOYEE
WHERE (SALARY+(SALARY*NVL(BONUS,0)))*12 >= 30000000;

--인라인뷰를 이용하여 보너스 포함 연봉 조회 결과를 테이블 처럼 이용해보기 
SELECT *
FROM (SELECT EMP_ID 사번
            ,EMP_NAME 사원명
            ,(SALARY+(SALARY*NVL(BONUS,0)))*12 "보너스포함연봉"
            ,NVL(DEPT_CODE,'부서 없음') 부서코드
      FROM EMPLOYEE)
WHERE 보너스포함연봉 >= 30000000 --인라인뷰에서 작성한 별칭을 컬럼명으로 사용
AND 사원명 = '이오리';

--인라인뷰가 주로 사용되는 예시
--TOP-N 분석 : 데이터베이스상에 있는 자료중 최상위 N 개의 자료를 보기위해 사용하는 기능

--전 직원 중 급여가 가장 높은 상위 5명 조회(순위,사원명,급여)
--ROWNUM : 오라클에서 제공하는 객체로 1부터 순번을 부여하는 객체
SELECT ROWNUM,EMP_NAME,SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC; --급여 내림차순 정렬 
--실행 순서가 FROM - SELECT - ORDER BY 순서이기 때문에 
--SELECT절에서 ROWNUM이 이미 순번을 부여한 이후에 ORDER BY 절로 정렬되어 순번이 엉키게 된다.

--해결방법
--급여 내림차순 정렬 후 순번 부여하기 
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

--위 조회구문을 인라인뷰로 사용하기 
SELECT ROWNUM,EMP_NAME,SALARY
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

--각 부서별 평균 급여가 높은 3개의 부서의 부서코드, 평균 급여 조회
--1) 부서 별 평균 급여 조회 
SELECT DEPT_CODE,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE 
ORDER BY 2 DESC;

--2)평균 급여가 높은 3 개의 부서 조회
--SELECT DEPT_CODE,ROUND(AVG(SALARY))
SELECT 부서코드,평균급여
FROM (SELECT DEPT_CODE 부서코드,ROUND(AVG(SALARY)) 평균급여
      FROM EMPLOYEE
      GROUP BY DEPT_CODE 
      ORDER BY 2 DESC);

SELECT DEPT_CODE,"ROUND(AVG(SALARY))" --인라인뷰에서 함수 또는 특수문자가 컬럼명인 경우 ""로 처리
FROM (SELECT DEPT_CODE,ROUND(AVG(SALARY))
      FROM EMPLOYEE
      GROUP BY DEPT_CODE 
      ORDER BY 2 DESC);

SELECT ROWNUM 순위,DEPT_CODE 부서코드,"ROUND(AVG(SALARY))" 평균급여
FROM (SELECT DEPT_CODE,ROUND(AVG(SALARY))
      FROM EMPLOYEE
      GROUP BY DEPT_CODE 
      ORDER BY 2 DESC)
WHERE ROWNUM <= 3; --상위 3개 데이터 조회

--가장 최근에 입사한 사원 5명 조회 (사원명,급여,입사일,순번)
SELECT EMP_NAME,SALARY,HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

--위 정렬된 조회 결과를 인라인뷰로 활용
SELECT ROWNUM,A.* --별칭.* 로 인라인뷰 컬럼 모두 조회 
FROM (SELECT EMP_NAME,SALARY,HIRE_DATE
      FROM EMPLOYEE
      ORDER BY HIRE_DATE DESC) A --인라인뷰에 별칭 부여
WHERE ROWNUM <=5; 

/*
    6. 순위 매기는 함수 
    RANK() OVER(정렬기준)
    DENSE_RANK() OVER(정렬기준)
    
    -RANK() OVER : 공동 1위가 3명이라면 그 다음 순위를 4위로 하겠다.
    -DENSE_RANK() OVER : 공동 1위가 3명이라해도 그 다음 순위를 2위로 하겠다.
    
    정렬기준 : ORDER BY절 (정렬기준컬럼,오름차순/내림차순) 
    
    ** RANK() OVER함수는 SELECT 절에서만 사용 가능
*/
--사원들의 급여가 높은 순서대로 사원명,급여,순위 조회 
--RANK() OVER
SELECT EMP_NAME
      ,SALARY
      ,RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE; -- 공동 19위로 20위 없이 21위 표현됨 

--DENSE_RANK() OVER
SELECT EMP_NAME
      ,SALARY
      ,DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;-- 공동 19위지만 다음 순위 20위 표현

--10위까지만 표현 
SELECT EMP_NAME
      ,SALARY
      ,DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
WHERE DENSE_RANK() OVER(ORDER BY SALARY DESC) <= 10;
--SELECT 절에서만 사용 가능하다 

--인라인뷰를 이용하여 순위 처리
SELECT *
FROM (SELECT EMP_NAME
            ,SALARY
            ,DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
      FROM EMPLOYEE)
WHERE 순위 <=10;

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






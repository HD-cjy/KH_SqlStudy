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

--WITH :서브쿼리를 미리 선언해놓고 사용( 해당 SELECT 절에서 사용가능 )
--서브쿼리 구문이 길어진다면 해당 구문을 미리 선언해 놓고 테이블처럼 이용가능
WITH SAL_TOTAL as (SELECT NVL (DEPT TITLE, '부서미지정' ) , 부서명 , SUM(SALARY) 급여합
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT CODE =DEPT ID)
GROUP BY DEPT TITLE;
SELECT * 
FROM SAL_TOTAL
WHERE 급여합>(SELECT SUM(SALARY)*0.2
            FROM EMPLOYEE);
            

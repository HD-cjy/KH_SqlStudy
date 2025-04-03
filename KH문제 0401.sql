-- 1. 70년대  생(1970~1979)  중  여자이면서  전씨인  사원의  이름과  주민번호,  부서  명,  직급  조회 

-- 2.  나이  상  가장  막내의  사원  코드,  사원  명,  나이,  부서  명,  직급  명  조회 

-- 3.  이름에  ‘형’이  들어가는  사원의  사원  코드,  사원  명,  직급  조회 

-- 4.  부서코드가  D5이거나  D6인  사원의  사원  명,  직급  명,  부서  코드,  부서  명  조회 

-- 5.  보너스를  받는  사원의  사원  명,  부서  명,  지역  명  조회 

-- 6.  사원  명,  직급  명,  부서  명,  지역  명  조회 

-- 7.  한국이나  일본에서  근무  중인  사원의  사원  명,  부서  명,  지역  명,  국가  명  조회 

-- 8.  한  사원과  같은  부서에서  일하는  사원의  이름  조회 

-- 9.  보너스가  없고  직급  코드가  J4이거나  J7인  사원의  이름,  직급  명,  급여  조회(NVL  이용) 

-- 10.  보너스  포함한  연봉이  높은  5명의  사번,  이름,  부서  명,  직급,  입사일,  순위  조회 

-- 11.  부서  별  급여  합계가  전체  급여  총  합의  20%보다  많은  부서의  부서  명,  부서  별  급여  합계  조회 
--  11-1. JOIN과  HAVING  사용 
--  11-2.  인라인  뷰  사용 
--  11-3. WITH  사용 

-- 12.  부서  명과  부서  별  급여  합계  조회
SELECT 
    D.DEPT_TITLE,
    SUM(E.SALARY)
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
ORDER BY SUM(E.SALARY) DESC;

-- 12.  부서  명과  부서  별  급여  합계  조회(ORACLE 구문으로 작성)
SELECT 
    D.DEPT_TITLE,
    SUM(E.SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
ORDER BY SUM(E.SALARY) DESC;
-- 12.  부서  명과  부서  별  급여  합계  조회(ORACLE 구문으로 작성)


-- 13. WITH를  이용하여  급여  합과  급여  평균  조회\







--기타 춘 문제 
-- 1. 급여가 300만원 이상인 사원의 사번, 이름, 부서명, 급여를 조회
-- ANSI 구문
-- SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY
-- FROM EMPLOYEE E
-- JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
-- WHERE SALARY >= 3000000;

-- ORACLE 구문 
-- SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY
-- FROM EMPLOYEE E, DEPARTMENT D
-- WHERE E.DEPT_CODE = D.DEPT_ID
-- 위 WHERE절에서 E.DEPT_CODE와 D.DEPT_ID를 연결하는 이유:
-- 1. EMPLOYEE(E) 테이블의 DEPT_CODE: 사원이 소속된 부서 코드
-- 2. DEPARTMENT(D) 테이블의 DEPT_ID: 부서의 고유 식별자(ID)
-- 3. 두 컬럼은 같은 부서를 가리키는 연결고리 역할을 함
-- 4. 이를 통해 사원과 해당 사원이 속한 부서 정보를 연결하여 조회 가능
-- AND SALARY >= 3000000;

-- 2. 직급이 '과장'인 사원들의 사번, 이름, 직급명, 부서명을 조회
-- ANSI 구문
-- SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE
-- FROM EMPLOYEE E
-- JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
-- JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
-- WHERE J.JOB_NAME = '과장';

-- ORACLE 구문
-- SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, D.DEPT_TITLE
-- FROM EMPLOYEE E, JOB J, DEPARTMENT D
-- WHERE E.JOB_CODE = J.JOB_CODE
-- AND E.DEPT_CODE = D.DEPT_ID
-- AND J.JOB_NAME = '과장';

-- 3. 부서가 '총무부'이면서 급여가 200만원 이상인 사원의 이름, 급여, 부서명, 직급명 조회
-- ANSI 구문
-- SELECT E.EMP_NAME, E.SALARY, D.DEPT_TITLE, J.JOB_NAME
-- FROM EMPLOYEE E
-- JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
-- JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
-- WHERE D.DEPT_TITLE = '총무부'
-- AND E.SALARY >= 2000000;

-- ORACLE 구문
-- SELECT E.EMP_NAME, E.SALARY, D.DEPT_TITLE, J.JOB_NAME
-- FROM EMPLOYEE E, DEPARTMENT D, JOB J
-- WHERE E.DEPT_CODE = D.DEPT_ID
-- AND E.JOB_CODE = J.JOB_CODE
-- AND D.DEPT_TITLE = '총무부'
-- AND E.SALARY >= 2000000;

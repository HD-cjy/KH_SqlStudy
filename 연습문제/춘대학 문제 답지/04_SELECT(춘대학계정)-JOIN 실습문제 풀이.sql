--04_SELECT(춘대학계정)-JOIN 실습문제 풀이
--1.
SELECT STUDENT_NAME "학생 이름"
      ,STUDENT_ADDRESS "주소지"
FROM TB_STUDENT
ORDER BY 1;

--2.
SELECT STUDENT_NAME,STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

--3.
SELECT STUDENT_NAME 학생이름
      ,STUDENT_NO 학번
      ,STUDENT_ADDRESS "거주지 주소" 
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%강원도%'
OR STUDENT_ADDRESS LIKE '%경기도%')
AND STUDENT_NO LIKE '9%'
ORDER BY 학생이름;

--4.
SELECT DEPARTMENT_NO,DEPARTMENT_NAME
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME='법학과'; --005

SELECT PROFESSOR_NAME,PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

--5.
SELECT STUDENT_NO,POINT
FROM TB_GRADE
WHERE TERM_NO = '200402'
AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC,STUDENT_NO;

--6. JOIN
--ORACLE
SELECT STUDENT_NO,STUDENT_NAME,DEPARTMENT_NAME
FROM TB_STUDENT S,TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY 2;

--ANSI
SELECT STUDENT_NO,STUDENT_NAME,DEPARTMENT_NAME
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2;

--7.
--ORACLE
SELECT CLASS_NAME,DEPARTMENT_NAME
FROM TB_CLASS C,TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO;

--ANSI
SELECT CLASS_NAME,DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

--8.
--ORACLE 
--과목테이블과 교수 테이블을 연결시킬 과목별 교수 테이블을 이용하기 
SELECT CLASS_NAME,PROFESSOR_NAME
FROM TB_CLASS C,TB_CLASS_PROFESSOR CP,TB_PROFESSOR P
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO =  P.PROFESSOR_NO;

--ANSI
SELECT CLASS_NAME,PROFESSOR_NAME
FROM TB_CLASS 
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

--9.
--ORACLE 
SELECT CLASS_NAME,PROFESSOR_NAME
FROM TB_CLASS C,TB_CLASS_PROFESSOR CP,TB_PROFESSOR P,TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO = P.PROFESSOR_NO
AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND CATEGORY = '인문사회';

--ANSI
SELECT CLASS_NAME,PROFESSOR_NAME
FROM TB_CLASS 
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY ='인문사회';

--10.
--ORACLE
SELECT S.STUDENT_NO 학번
      ,STUDENT_NAME "학생 이름"
      ,ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT S,TB_GRADE G,TB_DEPARTMENT D
WHERE S.STUDENT_NO =  G.STUDENT_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME ='음악학과'
GROUP BY S.STUDENT_NO,STUDENT_NAME
ORDER BY 1;

--ANSI
SELECT STUDENT_NO 학번
      ,STUDENT_NAME "학생 이름"
      ,ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT 
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO,STUDENT_NAME
ORDER BY 1;

--11
--ORACLE
SELECT DEPARTMENT_NAME 학과이름
      ,STUDENT_NAME 학생이름
      ,PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT S,TB_DEPARTMENT D,TB_PROFESSOR P
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
AND S.STUDENT_NO = 'A313047';

--ANSI
SELECT DEPARTMENT_NAME 학과이름
      ,STUDENT_NAME 학생이름
      ,PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
WHERE STUDENT_NO = 'A313047';

--12
--ORACLE
SELECT STUDENT_NAME,TERM_NO "TERM_NAME"
FROM TB_STUDENT S,TB_GRADE G,TB_CLASS C
WHERE S.STUDENT_NO = G.STUDENT_NO
AND G.CLASS_NO = C.CLASS_NO
AND CLASS_NAME = '인간관계론'
AND TERM_NO LIKE '2007%';

--ANSI
SELECT STUDENT_NAME,TERM_NO "TERM_NAME"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE CLASS_NAME = '인간관계론'
AND TERM_NO LIKE '2007%';

--13.
--ORACLE
SELECT CLASS_NAME,DEPARTMENT_NAME
FROM TB_CLASS C,TB_DEPARTMENT D,TB_CLASS_PROFESSOR CP
--TB_CLASS_PROFESSOR 테이블에 있는 정보는 이미 담당교수가 있는 정보들이기때문에 
--CLASS 정보가 나오지 않게된다
WHERE C.CLASS_NO = CP.CLASS_NO(+) --왼쪽 포괄조인(LEFT OUTER JOIN) 
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND PROFESSOR_NO IS NULL
AND CATEGORY = '예체능' ;

--ANSI
SELECT CLASS_NAME,DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE PROFESSOR_NO IS NULL
AND CATEGORY='예체능';

--14
--ORACLE
SELECT STUDENT_NAME 학생이름
      ,NVL(PROFESSOR_NAME,'지도교수 미지정') 지도교수
FROM TB_STUDENT S,TB_PROFESSOR P,TB_DEPARTMENT D
WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+) --지도교수 없어도 나와야하니까 포괄조인
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME ='서반아어학과';

--ANSI
SELECT STUDENT_NAME 학생이름
      ,NVL(PROFESSOR_NAME,'지도교수 미지정') 지도교수
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR P ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME ='서반아어학과';

--15.
--ORACLE
SELECT S.STUDENT_NO 학번
      ,STUDENT_NAME 이름
      ,DEPARTMENT_NAME "학과 이름"
      ,AVG(POINT) 평점
FROM TB_STUDENT S,TB_DEPARTMENT D,TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.STUDENT_NO = G.STUDENT_NO
AND ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO,STUDENT_NAME,DEPARTMENT_NAME
HAVING AVG(POINT) >=4.0
ORDER BY 1;

--ANSI
SELECT STUDENT_NO 학번
      ,STUDENT_NAME 이름
      ,DEPARTMENT_NAME "학과 이름"
      ,AVG(POINT) 평점
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN='N'
GROUP BY STUDENT_NO,STUDENT_NAME,DEPARTMENT_NAME
HAVING AVG(POINT) >=4.0
ORDER BY 1;

--16.
--ORACLE
SELECT C.CLASS_NO
      ,CLASS_NAME
      ,AVG(POINT) 
FROM TB_CLASS C,TB_GRADE G,TB_DEPARTMENT D
WHERE C.CLASS_NO = G.CLASS_NO
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME = '환경조경학과'
AND CLASS_TYPE LIKE '전공%'
GROUP BY C.CLASS_NO,CLASS_NAME
ORDER BY 1;

--ANSI
SELECT CLASS_NO
      ,CLASS_NAME
      ,AVG(POINT) 
FROM TB_CLASS 
JOIN TB_GRADE USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '환경조경학과'
AND CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NO,CLASS_NAME
ORDER BY 1;
--17 
SELECT DEPARTMENT_NO
FROM TB_STUDENT
WHERE STUDENT_NAME ='최경희';

SELECT STUDENT_NAME,STUDENT_ADDRESS
from TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                        FROM TB_STUDENT
                        WHERE STUDENT_NAME ='최경희');
---18
--국어국문학과 총 평점 내림차 정렬 조회
SELECT STUDENT_NO, STUDENT_NAME,AVG(point)
from TB_STUDENT
join TB_GRADE using (STUDENT_NO)
join TB_DEPARTMENT using (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO,STUDENT_NAME
ORDER BY 3 DESC;--평점 내림차
--위 구문에서 첫번째 학생정보 추출
--인라인 뷰 이용 
SELECT * 
FROM (SELECT STUDENT_NO, STUDENT_NAME,AVG(point)
      from TB_STUDENT
      join TB_GRADE using (STUDENT_NO)
      join TB_DEPARTMENT using (DEPARTMENT_NO)
      WHERE DEPARTMENT_NAME = '국어국문학과'
      GROUP BY STUDENT_NO,STUDENT_NAME
      ORDER BY 3 DESC)
WHERE ROWNUM = 1;
--19. 환경 조경학과와 같은 계열 학과 조회
SELECT CATEGORY,DEPARTMENT_NAME
from TB_DEPARTMENT
WHERE category = (SELECT category  
                  FROM TB_DEPARTMENT
                  where department_name = '환경조경학과');

SELECT department_name "계열 학과명",round(avg(point),1) 전공평점
from TB_DEPARTMENT
JOIN TB_CLASS using(DEPARTMENT_NO)
join TB_GRADE using (class_no)
where categoty = (SELECT category  
                  FROM TB_DEPARTMENT
                  where department_name = '환경조경학과')
AND
class_type like '전공%'
GROUP by department_name
ORDER by 1;
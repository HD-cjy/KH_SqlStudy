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


























        










































































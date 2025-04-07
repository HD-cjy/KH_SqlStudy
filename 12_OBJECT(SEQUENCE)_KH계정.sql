/*
    <시퀀스 sequence>
    자동으로 번호를 발생시켜주는 객체
    정수값을 순차적으로 발생시킨다,
    EX) 회원번호, 사번,게시글번호등등 순차적으로 겹치지 않는 숫자로 채번할 때 사용

시퀀스 객체 생성 구문
[표현법]
create sequence 시퀀스명
start with 시작숫자
increase by 증가값
maxvalue 
minvalue
cycle/nocycle 
cache 바이트크기 /nocache (cache_size 기본값 20byte )

캐시 메모리
-시퀀스로부터 미리 발생될 값들을 지정하여 저장한다
캐시메모리에 미리 생성된 값을 저장하고 가져다 쓰게 되면 
매번 숫자를 발행 시키는것보다 속도가 더 빠르지만 
접속이 끊긴뒤 다시 접속할 경우 기존 캐시메모리에 저장해놓은 값이 사라지고 
그 다음 번호부터 발행된다.


*/

CREATE SEQUENCE seq_test;
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE seq_empno
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE; 

/*
    시퀸스 사용구문
    시퀸스명.currval 현재 시퀀스 값의 (마지막으로 발생한 nextval의 값)
    시퀀스명. nextval: 현재 시퀀스의 값을 증가시키고 증가된 시퀀스의 값

    -스퀀스 생성 후 첫 nextval은 start with로 지정된 시작값으로 발생된다.
    시퀀스 생성 후 nextval 을 사용하지않고 currval을 수행할 수 없다/

*/

SELECT seq_empno.currval 
from dual; -- 값을 한번도 출력한적 없어서 에러.

SELECT seq_empno.nextval
from dual;

SELECT seq_empno.currval
from dual;

SELECT seq_empno.nextval
from dual;

SELECT seq_empno.nextval
from dual;

SELECT seq_empno.currval
from dual;

-- 맥스 번호에 도달시 다음번호 발행 불가능 
--마지막에 성공적으로 발행된 번호를 보여줌.

/*
시퀀스 변경
[표현법]
alter sequence 시퀀스명
[increment by 증가값]
[maxvalue 최대값]
[minvalue 최소값]
[cycle/nocycle 순환여부]
[cache 바이트크기/nocache 캐시메모리 사용여부]


--시퀀스 수정구문으로 start with 수정 불가능.
만야 start with 값을 수정하고 싶다면 시퀀스 삭제 후 재생성 해야함.
*/

ALTER SEQUENCE seq_empno
INCREMENT by 10
maxvalue 400;

SELECT * 
from USER_SEQUENCES;


SELECT seq_empno.currval
from dual;

SELECT seq_empno.nextval
from dual;
drop SEQUENCE seq_empno;
--매번 새로운 사번이 발생되는 시퀀스 생성해보기
-- 시작값 300, 최대값 400 
-- 만들어진 시퀀스 이용하여 
--사원정보 insert 에 이용해보기
--나머지 데이터는 자유롭게 설정하여 300번 301번 사원

CREATE SEQUENCE seq_empno
START WITH 300
INCREMENT BY 1
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT seq_empno.nextval
from dual;

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, SALARY, ENT_DATE, ENT_YN)
VALUES(seq_empno.nextval, '홍길동', '111111-1111111', 'J7', 'S3', 3000000, SYSDATE, 'Y');
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, SALARY, ENT_DATE, ENT_YN)
VALUES(seq_empno.nextval, '김길동', '111111-1111111', 'J3', 'S5', 3000000, SYSDATE, 'Y');

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, SALARY, ENT_DATE, ENT_YN)
VALUES(seq_empno.nextval, '이길동', '111111-1111222', 'J3', 'S5', 3000000, SYSDATE, 'Y');

select * 
from employee;




    
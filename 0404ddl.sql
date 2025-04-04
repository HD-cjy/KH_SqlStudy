/*
DDL (data definition language)
데이터 정의 언ㅇ어

객체들을 생성(CREATE) 하고 수정(ALTER) 하고 삭제(DROP) 하는 구문 

1.ALTER
객체 구조를 수정하는 구문
<테이블 수정>
[표현법]
ALTER TABLE 테이블명 수정할 내용

-- 수정할 내용 
1) 컬럼추가/ 수정/ 삭제 
2) 제약조건 추가 / 삭제 - 수정불가(수정하고 싶다면 삭제 후 새롭게 추가해야한다.)
3) 테이블명/ 컬럼명/ 제약조건명 수정

1) 컬럼 추가 수정 삭제 
-- 컬럼 추가 ADD:  ADD 추가 컬럼명 자료형 default 기본값 (default 값은 생략가능)
*/

SELECT * FROM dept_copy;
--cname 컬럼 추가
ALTER TABLE dept_copy add cname VARCHAR2(20) DEFAULT '한국';
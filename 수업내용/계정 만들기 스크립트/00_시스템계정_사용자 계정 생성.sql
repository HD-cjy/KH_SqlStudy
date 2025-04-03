--한 줄 주석 

/*
    여러줄 주석 
*/

--계정 생성
--일반 사용자 계정을 만들 수 있는 권한은 관리자 계정에 있다(시스템계정)
--사용자 계정 생성 방법
--[표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH;  -- CTRL + ENTER 한줄 실행
GRANT RESOURCE,CONNECT TO KH;
--생성된 사용자 계정에게 최소한의 권한 부여하기 
-- 접속 및 데이터 관리 권한 
--[표현법] GRANT 권한1,권한2,... TO 계정명; 
GRANT RESOURCE,CONNECT TO KH;

--관리자 계정 : DB의 생성과 관리를 담당하는 계정이며,모든 권한과 책임을 가지는 계정
--사용자 계정 : DB에 대해서 질의,갱신,보고서 작성등의 작업을 수행할 수 있는 계정, 업무에 필요한 최소한의 권한만
--            가지는것을 원칙으로 한다.

--ROLE 권한
--CONNECT : 사용자가 데이터베이스에 접속 가능하도록 하기 위한 CREATE SESSION 권한이 있는 ROLE 
--RESOURCE : CREATE 구문을 통해 객체를 생성할 수 있는 권한과 
--           INSERT,UPDATE,DELETE 구문을 사용할 수 있는 권한을 모아놓은 ROLE


 
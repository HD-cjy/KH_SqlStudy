--ddl 전용 계정생성
CREATE USER CHUNDDL IDENTIFIED BY CHUNDDL;
--최소한의 권한 부여
GRANT RESOURCE,CONNECT TO CHUNDDL;
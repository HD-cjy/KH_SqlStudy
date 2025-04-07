/*
계정에서 시스템 권한 또는 객체 접근 권한을 부여 (GRANT)하거나 회수(REVOKE) 하는 언ㅇ어


-권한부여(GRANT)
시스템 권한: 특정 DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
객ㄹ체 접근 권한: 특정 객체들에 접근하여 조작 할 수있는 권한

[표현법]
GRANT 권한1, 권한2, ... TO 계정명; 
-시스템 권한 종류
CREATE SESSION : 계정 접속 권한
create TABLE : 테이블 생성 권한
create VIEW : 뷰 생성 권한
CREATE SEQUENCE :  시퀸스 생성 권한
CREATE USER :  계정 생성 권한
*/ 
CREATE USER SAMPLE IDENTIFIED BY SAMPLE; --접속 권한을 주지 않으면 접속시 오류발생.
GRANT CREATE SESSION TO SAMPLE;

--3 SMAPLE 계정에 테이블 생성 권한 부여 (CREATE TABLE)
GRANT CREATE TABLE TO SAMPLE;
--4. SAMPLE 계정에 TABLE SPACE 할당해주기: 이미 만들어진 계정에다 부여하는 거기 때문에 ALTER구문 사용
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--2MB 만큼 크기를 할당. 

--5. SAMPLE 계정에 VIEW 생성 권한 부여하기
GRANT CREATE VIEW  TO SAMPLE;

/*
    OBJECT 접근권한
    SELECT INSERT UPDATE DELETE

    [표현법]
    GRANT 권한종류 ON 대상OBJECT TO 계졍명

    권한종류 별 대상 OBJECT
    SELECT: TABLE,VIEW,SEQUENCE
    INSERT: TABLE,VIEW
    UPDATE: TABLE,VIEW
    DELETE: TABLE,VIEW
*/

--6. SAMPLE 계정에 KH 계정 EMPLOYEE 테이블 SELECT 권한 부여
    GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 
-- 역대 올림픽 정보 데이터베이스는 역대 올림픽 경기와 관련된 데이터가 들어있는 테이블로 이루어져 있습니다.
-- athletes 테이블에는 역대 올림픽 참가 선수의 이름이 들어 있습니다. events 테이블에는 종목과 경기 이름이 들어 있습니다.
--  games 테이블에는 올림픽 개최 연도, 개최 도시와 시즌 정보가 기록되어 있습니다.
--  records 테이블에는 역대 올림픽 참가 선수들의 신체 정보와 획득한 메달 정보가 기록되어 있습니다. 
-- 이 테이블은 다른 테이블과 매핑할 수 있는 ID 정보도 가지고 있습니다. teams 테이블에는 국가 정보가 기록되어 있습니다.
-- 위 테이블 중 events 테이블과 records 테이블을 활용해 올림픽 골프 종목에 참가한 선수의 ID를 모두 조회하는 쿼리를 작성해주세요.
--조인문을 써서 작성






    
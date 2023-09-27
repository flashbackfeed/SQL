-- 26_View_Exam.sql
-- 뷰 연습문제

--   1) 20번 부서에(DNO) 소속된 사원의 사원번호와(ENO) 
--     이름과(ENAME) 부서번호를(DNO) 출력하는 
--     VIEW를 정의하시오.(VW_EMP_DNO)
--     대상테이블 : EMPLOYEE
-- 뷰 : SQL 문을 특정 이름으로 정해놓은 가상 테이블

CREATE OR REPLACE VIEW VW_EMP_DNO
AS
SELECT ENO,ENAME,DNO
FROM EMPLOYEE
WHERE DNO = 20;

SELECT * FROM VW_EMP_DNO;
-- 2) 이미 생성되어 있는 상기 뷰에(1번뷰) 대해 급여(SALARY) 
--     역시 출력하도록 수정해서 재생성하세요
--    (VW_EMP_DNO)
--    대상테이블 : EMPLOYEE

CREATE OR REPLACE VIEW VW_EMP_DNO
AS
SELECT ENO,ENAME,DNO,SALARY
FROM EMPLOYEE
WHERE DNO = 20;
SELECT * FROM VW_EMP_DNO;

-- 3) 생성된 뷰를 제거하세요(VW_EMP_DNO)

DROP VIEW VW_EMP_DNO;

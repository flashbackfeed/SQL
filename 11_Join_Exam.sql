-- 11_Join_Exam.sql
-- 조인 연습문제
-- 1) = 조인을 이용해서 SCOTT 사원의 (ENAME) 부서번호(DNO)와
--      부서이름을(DNAME) 출력하시오.
-- 대상 ㅣ EMPLOYEE(사원), DEPARTMENT(부서)
SELECT EMP.ENAME,EMP.DNO,DEP.DNAME FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO;
-- 대상 : EMPLOYEE(사원) EMP, DEPARTMENT(부서) DEP
-- 공통컬럼 : EMP.DNO = DEP.DNO
-- 사용법) SELECT 컬럼명, ...
--         FROM EMPLOYEE EMP, DEPARTMENT DEP
--         WHERE EMP.DNO = DEP.DNO;

-- 2) 모든 사원의 사원이름과(ENAME) 그 사원이 소속된 부서이름(DNAME)과 
--   지역명(LOC)을 출력하시오
-- 사원테이블 : EMPLOYEE
-- 부서테이블 : DEPARTMENT 
-- 조인 : 공통컬럼 : 1) 이름이 똑같은 컬럼 + 자료형도 똑같은 컬럼
-- 부서 : DNO(부서번호) , 사원:DNO(부서번호)
SELECT EMP.ENAME,DEP.DNAME,DEP.LOC FROM EMPLOYEE EMP,DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO; -- (공통컬럼 = 연결)

-- 3) 10번 부서에 속하는 사원(번호)에(ENO) 대해 직급과(JOB) 
--      지역명(LOC)을 출력하시오. 
-- 사원테이블 : EMPLOYEE
-- 부서테이블 : DEPARTMENT
-- 공통컬럼 : DNO(부서번호)
SELECT EMP.DNO,EMP.ENO,EMP.JOB,DEP.LOC 
FROM EMPLOYEE EMP,DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO 
AND EMP.DNO = 10; -- 조건
 
-- 4) 커미션을(COMMISSION) 받는 모든 사원의 이름(ENAME),
--    부서이름(ENAME), 지역명(LOC)을 출력하시오.
-- 힌트 ) 커미션 받는다 의미) : COMMISSION이 NULL이 아니다라는 의미
-- 공통컬럼 : DNO(부서번호)
SELECT EMP.ENAME,EMP.ENAME,DEP.LOC
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO
AND EMP.COMMISSION IS NOT NULL;
-- 5) = 조인과 Like 검색(와일드카드(%))를 사용하여 
--     이름에(ENAME) A가 포함된(조건) 모든 사원의 이름과(ENAME)
--    부서명을(DNAME) 출력하시오.
-- 공통컬럼 : DNO(부서번호)
SELECT  EMP.ENAME,DEP.DNAME
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO
AND EMP.ENAME LIKE ('%A%');
-- 6) NEW YORK 에 근무하는(LOC)(조건) 모든 사원의 이름(ENAME), 
--     업무(JOB), 부서번호(DNO) 
--     및 부서명을(DNAME) 출력하시오.
-- 사원테이블 : EMPLOYEE
-- 부서테이블 : DEPARTMENT
-- 공통컬럼 : DNO(부서번호)
SELECT EMP.ENAME, EMP.JOB, DEP.LOC, DEP.DNO
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO
AND DEP.LOC = 'NEW YORK';

-- 고급 응용 문제
-- 7) 각 부서에 대해 부서번호(DNO)별, 부서명(DNAME)별, 위치(LOC)별로
--   사원수(COUNT), 부서 내의 모든 사원의 평균 급여(AVG)를 출력하세요
--   컬럼별칭을 사용해서 부서번호, 부서명, 위치, 사원수 출력하세요
-- 평균급여는 소수점 2째자리에서 반올림하세요.
-- 사원테이블 : EMPLOYEE
-- 부서테이블 : DEPARTMENT
-- 힌트 : 그룹함수 사용, GROUP BY 사용

SELECT DEP.DNO AS 부서번호
      ,DEP.DNAME AS 부서명
      ,DEP.LOC AS 위치
      ,COUNT(*) AS 사원수 
      ,ROUND(AVG(EMP.SALARY),1) AS 평균급여
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO
GROUP BY DEP.DNO, DEP.DNAME, DEP.LOC;
-- 8) 각 부서명(DNAME)별, 급여별(SALARY) 사원수(COUNT)를 출력하세요
--   단, 부서명, 급여, 사원수의 별칭을 써서 출력하세요
-- 사원테이블 : EMPLOYEE
-- 부서테이블 : DEPARTMENT
SELECT DEP.DNAME AS 부서명
      ,EMP.SALARY AS 급여
      ,COUNT(*) AS 사원수
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO
GROUP BY DEP.DNAME,EMP.SALARY;

-- 9) 각 부서명(DNAME)별, 담당업무별(JOB) 
--   급여(SALARY) 총액에서 5000 이상인 결과만 출력하세요
-- 사원테이블 : EMPLOYEE
-- 부서테이블 : DEPARTMENT
-- 힌트) HAVING 사용
SELECT DEP.DNAME, EMP.JOB, SUM(EMP.SALARY)
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO
GROUP BY DEP.DNAME, EMP.JOB
HAVING SUM(EMP.SALARY) >= 5000;

-- 10) 급여가(SALARY) 2000 초과인 사원들의 
--    부서번호(DNO), 부서명(DNAME), 사원번호(ENO), 사원명(ENAME), 급여를 출력하세요
SELECT EMP.DNO,DEP.DNAME,EMP.ENO,EMP.ENAME, EMP.SALARY
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO AND EMP.SALARY > 2000;

-- 11 각 부서별(DNO) 평균 급여(SALARY), 최대급여, 최소급여, 사원수를 출력해 보세요
SELECT DNO, ROUND(AVG(SALARY),0),MAX(SALARY),MIN(SALARY),COUNT(*)
FROM EMPLOYEE
GROUP BY DNO;

-- 12) 부서번호로 right outer join 하여 모든 부서 정보와 사원정보를 출력하세요
-- 단 부서번호, 사원명으로 오름차순 정렬하세요
-- 힌트) 단순 외부조인 , 그룹핑 없음
-- SQL-99
SELECT EMP.* ,DEP.*
FROM EMPLOYEE EMP RIGHT OUTER JOIN DEPARTMENT DEP ON(EMP.DNO = DEP.DNO)
ORDER BY DEP.DNO, EMP.ENAME;
-- 오라클
SELECT EMP.* , DEP.*
FROM EMPLOYEE EMP, DEPARTMENT DEP
WHERE EMP.DNO(+) = DEP.DNO
ORDER BY DEP.DNO, EMP.ENAME;
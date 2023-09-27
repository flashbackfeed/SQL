-- 10_Join.sql
-- JOIN(*****)
-- 예제 1) 사원번호가(ENO) 7788 인 사원의 부서명(DNAME)은 뭘까요?
-- 사원 : EMPLOYEE
-- 부서 : DEPARTMENT
-- 1) 사원테이블에서 ENO=7788인 사람의 부서번호(DNO) 를 알아낸 뒤 (1번)
SELECT * FROM EMPLOYEE
WHERE ENO = 7788;

-- 2) 부서테이블에서 그 부서번호에 해당하는 부서명을 출력하면 됨 (2번)
SELECT * FROM DEPARTMENT
WHERE DNO = 20;
--결과 : 조회 성능이 저하됨( SQL문 1번 실행하는 것이 가장 좋음)
--       1) 코딩(SQL) : 해석(시간 소요)
--       2) 네트웤을 통해서 : 접속툴 <-> DB서버간 통신(시간 소요)

-- 2) JOIN을 사용 : 위의 2번 조회를 1번 조회로 수정할 수 있음 (성능 증가)
--  특징) 테이블 여러개를 공통컬럼을 이용해서 연결할 수 있음 ( 권장 : 4개 이내)
-- 예제 2) 사원번호가(ENO) 7788 인 사원의 부서명(DNAME)은 뭘까요?
-- 사용법) SELECT 별칭1.컬럼명, 별칭2.컬럼명
--         FROM 테이블1 별칭1
--            ,테이블2 별칭2
--         WHERE 별칭1.공통컬럼 = 별칭2.공통컬럼
SELECT EMP.*, DEP.*
FROM EMPLOYEE EMP,DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO; -- 공통컬럼으로 연결함(2개의 테이블)

-- 조인 의미
-- 사원 테이블
SELECT * FROM EMPLOYEE
ORDER BY DNO;

-- 부서 테이블
SELECT * FROM DEPARTMENT
ORDER BY DNO;

-- 예제 1) 사원 번호(ENO)가 7499 또는 7900 인 사원들의 소속된 부서정보를 모두 출력하세요
-- 부서정보 : 부서번호, 부서명, 부서위치
-- 힌트) 조인 및 조건 사용
-- 힌트) 조인조건) EMP.DNO = DEP.DNO
SELECT EMP.*, DEP.* FROM DEPARTMENT DEP, EMPLOYEE EMP
WHERE EMP.DNO=DEP.DNO 
AND EMP.ENO IN ('7499','7900');

-- 연습 1) 조인하고 아래 조건을 추가하세요
--       1-1) 사원번호가 7500~7700 사이에 있는 사원들의 소속된 부서정보를 출력하되
--       1-2) 부서이름이 SALES 인 부서만 출력하세요
-- 대상 : EMPLOYEE, DEPARTMENT
SELECT EMP.*, DEP.* FROM DEPARTMENT DEP, EMPLOYEE EMP
WHERE EMP.DNO = DEP.DNO -- 공통컬럼 연결(이퀄(equal(=)) 조인
AND EMP.ENO BETWEEN 7500 AND 7700
AND DEP.DNAME = 'SALES';


-- 특수한 조인
-- 1) 범위 조인 : BETWEEN A AND B( A~B 사이의 값 )
-- 단점 : 성능 대폭 하락
-- 급여등급 테이블 : SALGRADE
-- 가장 낮은 등급  : LOSAL 컬럼
-- 가장 높은 등급  : HISAL 컬럼
SELECT ENAME, SALARY, GRADE
FROM EMPLOYEE EMP,
     SALGRADE SAL
WHERE EMP.SALARY BETWEEN SAL.LOSAL AND SAL.HISAL;

-- 2) 아우터 조인(OUTER JOIN)(**) :
-- 이퀄조인(=) : 두 테이블의 공통컬럼에 NULL 값이 있으면 NULL 값을 제외하여 연결됨
-- MANAGER 컬럼 : 관리자 사원번호
-- 용도 : NULL을 포함한 데이터도 화면에 표시하고 싶을 때 사용함
-- 사용법 : = 조인을 하되 NULL 값이 있는 쪽에 (+) 붙이면 됨
SELECT EMP.ENAME
      ,MAN.ENAME AS MANAGER
      FROM EMPLOYEE EMP
          ,EMPLOYEE MAN
WHERE EMP.MANAGER = MAN.MANAGER(+);

-- 3) SQL-99 표준 표기법 : 오라클 DB/MYSQL DB 등에서 지원함
-- 전세계 SQL(질의어) 표준 : ANSI SQL(표준기구)
-- 예제 1) 사원 X 부서 조인 : SQL-99 표기법
-- 오라클 조인
SELECT ENO,DNAME, EMP.DNO , DEP.DNO
FROM EMPLOYEE EMP,
     DEPARTMENT DEP
WHERE EMP.DNO = DEP.DNO;

-- SQL-99 표기법 : DB 상에 100% 호환됨
-- 사용법) SELECT 별칭1.컬럼명, 별칭2.컬럼명
--        FROM 테이블명1 별칭1 JOIN 테이블명2 별칭2 ON(별칭1.공통컬럼=별칭2.공통컬럼);
SELECT ENO,DNAME, EMP.DNO , DEP.DNO
FROM EMPLOYEE EMP JOIN DEPARTMENT DEP ON(EMP.DNO = DEP.DNO);

-- 레프트 아우터 조인 : 오라클
-- WHERE 절에 (+) 없는 쪽을 기준으로 명칭을 부여함 : 왼쪽 외부 조인(LEFT OUTER JOIN)
SELECT EMP.ENAME
      ,MAN.ENAME AS MANAGER
      FROM EMPLOYEE EMP
          ,EMPLOYEE MAN
WHERE EMP.MANAGER = MAN.MANAGER(+);

-- 라이트 아우터 조인 : 오라클
-- WHERE 절에 (+) 없는 쪽을 기준으로 명칭을 부여함 : 오른쪽 외부 조인(RIGHT OUTER JOIN)
SELECT EMP.ENAME
      ,MAN.ENAME AS MANAGER
      FROM EMPLOYEE EMP
          ,EMPLOYEE MAN
WHERE EMP.MANAGER(+) = MAN.MANAGER;


-- SQL-99 표기법 : DB상에 100% 호환됨
SELECT EMP.ENAME
      ,MAN.ENAME AS MANAGER
      FROM EMPLOYEE EMP LEFT OUTER JOIN EMPLOYEE MAN ON(EMP.MANAGER = MAN.MANAGER); -- 레프트 아우터 조인
      
      
      
-- 05_Function_2.sql
-- 1 숫자 함수 

-- 1) 반올림 : ROUND()
-- 사용법) ROUND(대상컬럼, 자리수)
-- 참고) 자리수가 음수일 경우 일의 자리부터 반올림이 됨
SELECT 98.7654,
       ROUND(98.7654), -- 소수 첫번째 자리에서 반올림
       ROUND(98.7654,2), -- 반올림해서 소수 두번째 자리 까지 표시 
       ROUND(98.7654,1), -- 반올림해서  소수 첫번째 자리 까지 표시
       ROUND(98.7654,-1) -- 정수 첫번째자리를 반올림
       FROM DUAL;
       
-- 2) TRUNC : 버림(내림), 특정자리수에서 버림
-- 사용법) TRUNC(대상컬럼, 자리수)
-- 참고) 자리수가 음수일 경우 일의 자리부터 버림이 됨
SELECT 98.7654,
       TRUNC(98.7654), -- 소수 첫째 자리에서 버림
       TRUNC(98.7654, 2), -- 소수 둘째자리 아래로는 다버림
       TRUNC(98.7654, -1) -- 정수 첫째자리 버림
       FROM DUAL;

-- 3) MOD : 나머지 연산 함수  ( == % : 나머지 연산자(js))
-- 사용법) MOD(대상컬럼, 나눌숫자) : 결과 나머지가 RETURN 됨
SELECT MOD(31, 2),
       MOD(31, 5),
       MOD(31, 8)
       FROM DUAL;
       
-- 연습 1) 모든 사원의 급여를 각각 500으로 나눈 나머지를 계산해서 출력하세요
-- 사원 : EMPLOYEE
-- 급여 : SALARY
SELECT MOD(SALARY,500) FROM EMPLOYEE;

-- 2 날짜 함수
-- 1) SYSDATE : 시스템에 저장된 현재 날짜를 RETURN 하는 함수(*****)
-- DB의 자료형 : 문자열(VARCHAR2 형,CHAR 형), 숫자(NUMBER 형), 날짜(DATE 형)
SELECT SYSDATE FROM DUAL;

-- 예제 1) 오늘 , 어제, 내일 날짜를 출력해 보세요
-- 참고) 날짜와 산술연산이 됨
SELECT SYSDATE-1 AS "어제",
       SYSDATE AS "오늘",
       SYSDATE +1 AS "내일"
FROM DUAL;

-- 예제 2) 사원테이블에서 근무일수 계산해서 조회하기
-- 공식 : 현재시간(SYSDATE) - 입사일(HIREDATE) : 근무일수
SELECT ROUND(SYSDATE - HIREDATE , 0) AS "근무일수" FROM EMPLOYEE;

-- 2) MONTHS_BETWEEN(현재날짜, 과거날짜) : 두 날짜 사이의 개월수를 RETURN하는 함수
-- 예제 3) 각 사원들이 근무한 개월 수 구하기
SELECT ENAME, SYSDATE, HIREDATE
, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "개월수" FROM EMPLOYEE;

-- 3) ADD_MONTHS(날짜컬럼,숫자)
-- 예제 4) 입사일에서 6개월이 지난 날짜 구하기
SELECT ENAME,HIREDATE,
TRUNC(ADD_MONTHS(HIREDATE, 6)) FROM EMPLOYEE;

-- 4) NEXT_DAY(날짜컬럼, '요일')
--    날짜컬럼에서 최초로 도래하는 요일의 날짜를 RETURN 함수
-- 예제 5) 오늘을 기준으로 최초로 도래하는 토요일의 날짜 구하기
SELECT SYSDATE, NEXT_DAY(SYSDATE,'토요일')
FROM DUAL;

-- 5) LAST_DAY(날짜컬럼)
--   날짜컬럼의 그 달(월)의 마지막 날의 날짜를 구해주는 함수
-- 예제 6) 입사한 날의 그 달의 마지막 날 구하기
SELECT ENAME, HIREDATE,LAST_DAY(HIREDATE) FROM EMPLOYEE;









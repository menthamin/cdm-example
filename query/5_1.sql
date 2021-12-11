/*
 * 5번 문제 1차 쿼리
 * 아래 조건에 모두 해당하는 환자수를 추출
 * a. 제 2형 당뇨병을 진단받은 환자 추출
 * b. 18세 이상
*/ 

WITH 
t2d AS (
	-- 조건 a : 제 2형 당뇨병 (Type 2 diabetes, T2D) 진단
	SELECT 
			person_id
		,	condition_start_date
	FROM de.condition_occurrence
	WHERE condition_concept_id IN (3191208, 36684827, 3194332, 3193274, 43531010
									, 4130162, 45766052, 45757474, 4099651, 4129519
									, 4063043, 4230254, 4193704, 4304377, 201826
									, 3194082, 3192767)
)
, person_age AS (
	-- 환자 나이 계산 / age() 함수 사용, 현재 시간(DBMS) 기준
	SELECT
			person_id
		,	birth_datetime
		,	EXTRACT(YEAR FROM age(now(), birth_datetime)) AS age_man
	FROM de.person
)
, t2d_man18_list AS (
SELECT 
		t2d.person_id
	,	t2d.condition_start_date
	,	pa.birth_datetime
	,	pa.age_man
FROM t2d t2d
LEFT JOIN person_age pa
ON t2d.person_id = pa.person_id
WHERE pa.age_man >= 18
)
SELECT 
		person_id  -- 환자 id
	,	condition_start_date -- 질병 진단일자
	,	age_man  -- 만 나이
FROM t2d_man18_list
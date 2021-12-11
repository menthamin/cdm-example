/* 1번 문제
 * a. 모든 환자에 대해 총 내원일수 추출
 * b. 총 내원일수의 최대값과 총 내원일수 최대값을 가지는 환자수 찾기
 */

-- a. 모든 환자에 대해 총 내원일수 추출
WITH 
person_visit AS (
	SELECT 	
			vo.person_id	
	--	,	vo.visit_start_date
	--	,	vo.visit_end_date
		,	SUM((vo.visit_end_date - vo.visit_start_date + 1)) AS tot_visit_date
	FROM de.visit_occurrence vo
	GROUP BY vo.person_id
	ORDER BY 1 DESC
)
SELECT
		person_id -- 환자 식별자
	,	tot_visit_date -- 환자별 총 내원일수
FROM person_visit;

-- b. 총 내원일수의 최대값과 최대값을 가지는 환자 수 찾기
WITH 
person_visit AS (
	SELECT 	
			vo.person_id	
		,	SUM((vo.visit_end_date - vo.visit_start_date + 1)) AS tot_visit_date
	FROM de.visit_occurrence vo
	GROUP BY vo.person_id
)
, max_visit_person AS (
	SELECT
			person_id
		,	tot_visit_date AS max_visit_date
	FROM person_visit
	WHERE tot_visit_date = (SELECT max(tot_visit_date) FROM person_visit)
)
SELECT
		max_visit_date  -- 총 내원일수의 최대값
	,	COUNT(DISTINCT person_id) AS person_cnt  -- 최대값을 가지는 환자수
FROM max_visit_person
GROUP BY max_visit_date;
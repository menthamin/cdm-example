/* 2번 문제
 * 
 * 진단 받은 상병 내역 중 첫글자는 a-e 로 시작하고 중간에 'heart'를 포함하는
 * 상병 이름을 중복없이 나열
 * 조건 : 문자 검색시 대소문자 구분 하지 않음 
 * 
 */

WITH
heart_list AS (
	SELECT 
			concept_id
		,	concept_name	
	FROM de.concept
	WHERE concept_name ~* '^[a-e](.)*(heart)+'
)
, map_concept AS (
	SELECT 
			co.condition_concept_id
		,	hl.concept_name
	FROM de.condition_occurrence co
	LEFT JOIN heart_list hl
	ON co.condition_concept_id = hl.concept_id
)
SELECT
	DISTINCT concept_name  -- 상병 이름 중복없이 나열
FROM map_concept
WHERE concept_name IS NOT NULL
ORDER BY 1;
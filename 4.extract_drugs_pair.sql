/* 
 * 4번 문제
 * 짝지어진 두번째 약의 처방 건수가 첫번째 약의 처방 건수보다 더 많은
 * 첫번째 약의 약품명을 처방건수 순으로 출력
 * 
 * 풀이 실패
 * 풀이 방법 :
 *  15개의 약에 대해 15C2 의 조합별 Pair 정리 후 정해진 조건에 맞는 약 출력 필요
 * 
 */

WITH
drug_list AS (
	SELECT
			distinct drug_concept_id
		,	concept_name
		,	COUNT(*) AS	cnt 
	FROM de.drug_exposure
	JOIN de.concept 
	ON drug_concept_id = concept_id
	WHERE concept_id IN (40213154, 19078106, 19009384, 40224172, 19127663
						, 1511248, 40169216, 1539463, 19126352, 1539411
						, 1332419, 40163924, 19030765, 19106768, 19075601)
	GROUP BY drug_concept_id, concept_name
	ORDER BY COUNT(*) DESC
)
-- 1. 15가지 약 번호와 약품명 : drugs
, drugs AS (SELECT drug_concept_id, concept_name FROM drug_list)
-- 2. 15가지 약별로 drugs_exposure에 저장된 처방건수
, prescription_count AS (SELECT drug_concept_id, cnt FROM drug_list)
, visit_drugs AS (
SELECT
		visit_occurrence_id
	,	COUNT(CASE WHEN drug_concept_id = '40213154' THEN 1 ELSE NULL END) AS "40213154"
	,	COUNT(CASE WHEN drug_concept_id = '19078106' THEN 1 ELSE NULL END) AS "19078106"
	,	COUNT(CASE WHEN drug_concept_id = '19009384' THEN 1 ELSE NULL END) AS "19009384"
	,	COUNT(CASE WHEN drug_concept_id = '40224172' THEN 1 ELSE NULL END) AS "40224172"
	,	COUNT(CASE WHEN drug_concept_id = '19127663' THEN 1 ELSE NULL END) AS "19127663"
	,	COUNT(CASE WHEN drug_concept_id = '1511248' THEN 1 ELSE NULL END) AS "1511248"
	,	COUNT(CASE WHEN drug_concept_id = '40169216' THEN 1 ELSE NULL END) AS "40169216"
	,	COUNT(CASE WHEN drug_concept_id = '1539463' THEN 1 ELSE NULL END) AS "1539463"
	,	COUNT(CASE WHEN drug_concept_id = '19126352' THEN 1 ELSE NULL END) AS "19126352"
	,	COUNT(CASE WHEN drug_concept_id = '1539411' THEN 1 ELSE NULL END) AS "1539411"
	,	COUNT(CASE WHEN drug_concept_id = '1332419' THEN 1 ELSE NULL END) AS "1332419"
	,	COUNT(CASE WHEN drug_concept_id = '40163924' THEN 1 ELSE NULL END) AS "40163924"
	,	COUNT(CASE WHEN drug_concept_id = '19030765' THEN 1 ELSE NULL END) AS "19030765"
	,	COUNT(CASE WHEN drug_concept_id = '19106768' THEN 1 ELSE NULL END) AS "19106768"
	,	COUNT(CASE WHEN drug_concept_id = '19075601' THEN 1 ELSE NULL END) AS "19075601"
FROM drug_exposure
WHERE drug_concept_id in (SELECT drug_concept_id FROM drugs)
GROUP BY visit_occurrence_id
ORDER BY 2 DESC
)
SELECT * FROM visit_drugs;
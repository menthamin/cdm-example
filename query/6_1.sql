/*
 * 6번 문제 1차 쿼리
 * 제 2형 당뇨병을 진단받은 환자의 의약품 처방 내역 추출
*/ 

WITH 
t2d AS (
	-- 조건 a : 제 2형 당뇨병 (Type 2 diabetes, T2D)을 진단 받은 경우 추출
	SELECT 
			person_id
		,	condition_start_date
	FROM de.condition_occurrence
	WHERE condition_concept_id IN (3191208, 36684827, 3194332, 3193274, 43531010
									, 4130162, 45766052, 45757474, 4099651, 4129519
									, 4063043, 4230254, 4193704, 4304377, 201826
									, 3194082, 3192767)
)
, drug_exposure_list AS (
	-- 제 2형 당뇨병 환자들이 digoxin, smvastatin, clopidogrel, naproxen을 처방받은 경우 추출
	SELECT 
			person_id
		,	drug_concept_id
		,	CASE WHEN drug_concept_id = 19018935 THEN 'digoxin'
				WHEN drug_concept_id IN (1539411, 1539463) THEN 'simvastatin'
				WHEN drug_concept_id = 19075601 THEN 'clopidogrel'
				WHEN drug_concept_id = 1115171 THEN 'naproxen'
			ELSE NULL END AS drug_name
		,	drug_exposure_start_date	
	FROM de.drug_exposure
	WHERE person_id IN (SELECT person_id FROM t2d)  -- 제 2형 당뇨병 필터
	AND drug_concept_id IN (19018935, 1539411, 1539463, 19075601, 1115171)  -- drug 필터
)
SELECT 
		person_id  -- 환자 id
	, 	drug_exposure_start_date  -- drug 처방일자
	,	STRING_AGG(DISTINCT drug_name, ', ' ORDER BY drug_name) AS drug_names  -- 처방일자에 처방받은 drug 리스트
FROM drug_exposure_list
GROUP BY person_id, drug_exposure_start_date
ORDER BY person_id, drug_exposure_start_date

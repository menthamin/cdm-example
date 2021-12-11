/* 3번 문제
 * 
 * 환자번호 '1891866' 환자가 처방받은 약의 종류별로 
 * 처음시작일, 마지막 종료일, 복용일을 구하고 복용일이 긴 순으로 정렬 및 테이블 생성
 * 
 * Output : problem_03_drug 테이블
 */

DROP TABLE walker102.problem_03_drug;
CREATE TABLE walker102.problem_03_drug AS
WITH
person_drug_info AS (
	SELECT 
			drug_concept_id  -- 약의 종류
		,	MIN(drug_exposure_start_date) AS start_date  -- 처방 시작일
		,	MAX(drug_exposure_end_date) AS end_date  -- 처방 종료일
	FROM de.drug_exposure
	WHERE person_id = '1891866'
	GROUP BY drug_concept_id
)
SELECT 
		drug_concept_id  -- 약의 종류
	,	start_date  -- 처음 시작일
	,	end_date  -- 마지막 종료일
	,	(end_date - start_date) + 1 AS tot_exposure_date  -- 복용일 (마지막-처음)+1 로 계산
FROM person_drug_info
ORDER BY tot_exposure_date DESC;
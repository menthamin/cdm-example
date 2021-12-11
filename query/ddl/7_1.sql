/*
 * 7번 문제
 * 
 * 테이블 생성 DDL 문
 * 내용 :
 *  테이블 및 시퀀스 drop
 *  0. 랜덤번호 부여를 위한 pseudo_encrypt() 함수 생성
 * 	1. person 테이블 생성
 * 	2. visit_occurrence 테이블 생성
 *	3. drug_exposure 테이블 생성
 *	4. condition_occurrence 테이블 생성
 *
 */

-- DROP 
DROP TABLE IF EXISTS walker102.condition_occurrence;
DROP TABLE IF EXISTS walker102.drug_exposure;
DROP TABLE IF EXISTS walker102.visit_occurrence;
DROP TABLE IF EXISTS walker102.person;
DROP SEQUENCE IF EXISTS person_id_seq;
DROP SEQUENCE IF EXISTS visit_occurrence_id_seq;
DROP SEQUENCE IF EXISTS drug_exposure_id_seq;
DROP SEQUENCE IF EXISTS condition_occurrence_id_seq;

-- 0. 랜덤번호 부여를 위한 pseudo_encrypt() 함수 생성
-- 출처 : https://coderedirect.com/questions/163648/pseudo-encrypt-function-in-plpgsql-that-takes-bigint
CREATE OR REPLACE FUNCTION pseudo_encrypt(VALUE bigint) returns bigint AS $$
DECLARE
l1 bigint;
l2 bigint;
r1 bigint;
r2 bigint;
i int:=0;
BEGIN
    l1:= (VALUE >> 32) & 4294967295::bigint;
    r1:= VALUE & 4294967295;
    WHILE i < 3 LOOP
        l2 := r1;
        r2 := l1 # ((((1366.0 * r1 + 150889) % 714025) / 714025.0) * 32767*32767)::int;
        l1 := l2;
        r1 := r2;
        i := i + 1;
    END LOOP;
RETURN ((l1::bigint << 32) + r1);
END;
$$ LANGUAGE plpgsql strict immutable;

-- 1. person 테이블 생성
CREATE SEQUENCE	IF NOT EXISTS person_id_seq;
CREATE TABLE IF NOT EXISTS walker102.person (
	person_id bigint NOT NULL DEFAULT pseudo_encrypt(nextval('person_id_seq')),
	year_of_birth int NOT NULL,
	month_of_birth int NULL,
	day_of_birth int NULL,
	death_date timestamp NULL,
	gender_value varchar(50) NULL,
	race_value varchar(50) NULL,
	ethnticity varchar(50) NULL,
	CONSTRAINT person_pk PRIMARY KEY (person_id)
);


-- 2. visit_occurrence 테이블 생성
CREATE SEQUENCE	IF NOT EXISTS visit_occurrence_id_seq;
CREATE TABLE IF NOT EXISTS walker102.visit_occurrence (
	visit_occurrence_id bigint NOT NULL DEFAULT pseudo_encrypt(nextval('visit_occurrence_id_seq')),
	person_id bigint NOT NULL,
	visit_start_date date NULL,
	care_site_nm text NULL,
	visit_type_value varchar(50) NULL,
	CONSTRAINT vo_pk PRIMARY KEY (visit_occurrence_id),
	CONSTRAINT vo_fk FOREIGN KEY (person_id) REFERENCES walker102.person(person_id)
);

-- 3. drug_exposure 테이블 생성
CREATE SEQUENCE	IF NOT EXISTS drug_exposure_id_seq;
CREATE TABLE IF NOT EXISTS walker102.drug_exposure (
	drug_exposure_id bigint NOT NULL DEFAULT pseudo_encrypt(nextval('drug_exposure_id_seq')),
	person_id bigint NOT NULL,
	drug_exposure_start_date date NOT NULL,
	drug_value TEXT NULL,
	route_value varchar(50) NULL,
	dose_value varchar(50) NULL,
	unit_value varchar(50) NULL,
	visit_occurrence_id bigint NULL,
	CONSTRAINT de_pk PRIMARY KEY (drug_exposure_id),
	CONSTRAINT de_fk1 FOREIGN KEY (person_id) REFERENCES walker102.person(person_id),
	CONSTRAINT de_fk2 FOREIGN KEY (visit_occurrence_id) REFERENCES walker102.visit_occurrence(visit_occurrence_id)
);

-- 4. condition_occurrence 테이블 생성
CREATE SEQUENCE	IF NOT EXISTS condition_occurrence_id_seq;
CREATE TABLE IF NOT EXISTS walker102.condition_occurrence (
	condition_occurrence_id bigint NOT NULL DEFAULT pseudo_encrypt(nextval('condition_occurrence_id_seq')),
	person_id bigint NOT NULL,
	condition_start_date date NOT NULL,
	condition_value TEXT NULL,
	visit_occurrence_id bigint NULL,
	CONSTRAINT co_pk PRIMARY KEY (condition_occurrence_id),
	CONSTRAINT co_fk FOREIGN KEY (visit_occurrence_id) REFERENCES walker102.visit_occurrence(visit_occurrence_id)
);
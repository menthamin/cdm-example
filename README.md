# cdm-example
- 코드 설명 :  sql, ipynb 파일에 주석
- 디렉터리 구조 및 파일 설명
```
main
│  1.extract_visit_date.sql         # 1번 쿼리 파일 / 클라이언트 프로그램에서 실행
│  2.extract_concept_name.sql       # 2번 쿼리 파일 / 클라이언트 프로그램에서 실행
│  3.extract_drug_exposure.sql      # 3번 쿼리 파일 / 클라이언트 프로그램에서 실행
│  4.extract_drugs_pair.sql         # 4번 쿼리 파일 / 클라이언트 프로그램에서 실행
│  5.extract_type2_diabetes.ipynb   # 5번 노트북 파일 / config/db_config.py 에 접속 정보 수정 필요
│  6.drug_pattern.ipynb             # 6번 노트북 파일 / config/db_config.py 에 접속 정보 수정 필요
│  7.note.ipynb                     # 7번 노트북 파일 / config/db_config.py 에 접속 정보 수정 필요
│  README.md
├─config
│  └─ db_config.py                  # db 접속 정보 / 수정 필요
└─query
    │  5_1.sql                      # 5번 노트북에서 읽어오는 쿼리 파일
    │  6_1.sql                      # 6번 노트북에서 읽어오는 쿼리 파일
    └─ddl
       └─  7_1.sql                  # 7번 테이블 생성 쿼리(함수, 시퀀스 포함)
```
- config/db_config.py 파일 : 접속정보 수정 필요
```
psql_config = {
    "host" : "",  # host 정보
    "dbname" : "",  # dbname 정보
    "user" : "",  # user 정보
    "password" : "",  ## password 정보
    "port" : 5432
}
```

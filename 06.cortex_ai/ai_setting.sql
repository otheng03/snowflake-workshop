use demo.magi_handson;
use warehouse compute_wh;

CREATE STAGE int_stg 
DIRECTORY = ( ENABLE = true ) ;

// Intelligence role 
CREATE DATABASE IF NOT EXISTS snowflake_intelligence;
GRANT USAGE ON DATABASE snowflake_intelligence TO ROLE accountadmin;

CREATE SCHEMA IF NOT EXISTS snowflake_intelligence.agents;
GRANT USAGE ON SCHEMA snowflake_intelligence.agents TO ROLE accountadmin;

GRANT CREATE AGENT ON SCHEMA snowflake_intelligence.agents TO ROLE accountadmin;

// API
GRANT DATABASE ROLE SNOWFLAKE.CORTEX_USER TO ROLE accountadmin;
GRANT USAGE ON CORTEX SEARCH SERVICE DEMO.MAGI_HANDSON.docs_search TO ROLE accountadmin;

ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'ANY_REGION';

-------------------------------------------------------- 

// 청킹 데이터 확인
ls @ext_stg/chunked/image_data_chunk.csv;

// 테이블 생성
create or replace TABLE IMAGE_DATA_CHUNK (
	RELATIVE_PATH VARCHAR,
	FILE_URL VARCHAR,
	CHUNK_INDEX NUMBER,
	CHUNK VARCHAR,
	CREATED_TIMESTAMP TIMESTAMP_NTZ(9)
);

// 청킹 데이터 적재 
copy into IMAGE_DATA_CHUNK
from @ext_stg/chunked/image_data_chunk.csv
FILE_FORMAT = (type=csv FIELD_OPTIONALLY_ENCLOSED_BY='"' PARSE_HEADER = TRUE)
MATCH_BY_COLUMN_NAME = case_insensitive;

select * from image_data_chunk limit 10;


------------------------ 
// cortex search API

SHOW CORTEX SEARCH SERVICES;

SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
      'DOCS_SEARCH',
      '{
         "query": "코스피",
         "columns": ["CHUNK", "FILE_URL"],
         "limit": 5
      }'
  )
)['results'] as results;

------------------------ 
// cortex search API

CREATE OR REPLACE CORTEX SEARCH SERVICE DEMO.MAGI_HANDSON.ETF_NAME_SEARCH
  ON ITEM_NM_KOR
  ATTRIBUTES ETF_ITEM_CD
  WAREHOUSE = COMPUTE_WH
  TARGET_LAG = '1 hour'
  EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
AS (
    SELECT ITEM_NM_KOR,
            ETF_ITEM_CD
      FROM DEMO.MAGI_HANDSON.SF_KOSCOM_ETFMST
);


select * FROM DEMO.MAGI_HANDSON.SF_KOSCOM_ETFMST limit 10;

SELECT PARSE_JSON(
  SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
      'ETF_NAME_SEARCH',
      '{
         "query": "선물인버스",
         "columns": ["ITEM_NM_KOR","ETF_ITEM_CD"],
         "limit": 10
      }'
  )
)['results'] as results;


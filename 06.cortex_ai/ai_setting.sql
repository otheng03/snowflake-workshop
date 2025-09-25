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



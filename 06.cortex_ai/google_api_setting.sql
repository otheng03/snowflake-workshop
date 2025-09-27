use demo.magi_handson;
use warehouse compute_wh;

CREATE OR REPLACE NETWORK RULE google_api_calls
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('www.googleapis.com');

// trial 계정에서 사용 불가
-- CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION api_access_integration
-- ALLOWED_NETWORK_RULES = (google_api_calls)
-- ENABLED = TRUE;

-- CREATE OR REPLACE PROCEDURE call_external_api(query VARCHAR)
-- RETURNS VARIANT
-- LANGUAGE PYTHON
-- RUNTIME_VERSION = '3.9'
-- PACKAGES = ('snowflake-snowpark-python', 'requests')
-- EXTERNAL_ACCESS_INTEGRATIONS = (api_access_integration)
-- HANDLER = 'call_api'
-- AS
-- $$
-- import requests
-- import json
-- from snowflake.snowpark.context import get_active_session

-- def call_api(session, query):

--     api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
--     cx_id = "21d0bf132cb034776"  # 여기에 자신의 CX ID를 입력하세요
--     url = f"https://www.googleapis.com/customsearch/v1?key={api_key}&cx={cx_id}&q={query}"

--     print("API 요청 URL:", url)

--     try:
--         # GET 요청 보내기
--         response = requests.get(url)

--         # 요청이 성공했는지 확인
--         response.raise_for_status()

--         # JSON 응답 파싱
--         search_results = response.json()

--         # 검색 결과 출력
--         if 'items' in search_results:
--             print("\n검색 결과:")
--             for item in search_results['items']:
--                 title = item.get('title', '제목 없음')
--                 link = item.get('link', '링크 없음')
--                 print(f"- 제목: {title}")
--                 print(f"  링크: {link}\n")
--         else:
--             print("검색 결과가 없습니다.")
--             print("API 응답:", json.dumps(search_results, indent=2, ensure_ascii=False))

--         return search_results;

--     except requests.exceptions.HTTPError as http_err:
--         print(f"HTTP 오류 발생: {http_err}")
--         print("응답 내용:", response.text)
--     except Exception as err:
--         print(f"기타 오류 발생: {err}")


-- $$;

-- CALL call_external_api('한국 통상 무역 협상 결과 찾아줘');




#!/bin/bash

# ===========================================
# Snowflake REST API - curl로 SQL 실행하기
# 설정값을 아래에서 수정하세요
# ===========================================

# 필수 설정값 - 여기를 수정하세요
ACCOUNT="SFSEAPAC-KR_DEMO28"           # 예: abc123.us-east-1
JWT_TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJTRlNFQVBBQy1LUl9ERU1PMjguQVBJX1VTRVIuU0hBMjU2OitJNGhZSElkZGRHMTNvYWRKY1BvWDZvLzcvSndPVUFPOWtJODJJalVTcGc9Iiwic3ViIjoiU0ZTRUFQQUMtS1JfREVNTzI4LkFQSV9VU0VSIiwiZXhwIjoxNzU4NzYwMzMyLCJpYXQiOjE3NTg3NTY3MzJ9.Su0eNzAhMcSQjI5qIS0v-M_QIopeqwvlDH52o2QxDtcC8aEQTOT5zQ7IUYMYYU4UCsg7rWVTz-4GWP6mBhhlqe1Ar8_3Q7ORmNV0aDqTvp93gV7WDs8CshHPwbNooTUm55wgKBbZQwHDw7Cg7ZgOof1qpVoPBwmbiny-jE5WRFTFZ7MRDFgamLgERunwzDdywZUXgwd3fJrp_piOPU1y7HuUe0vc0r7sR-awdgxwBlBakTmQ3TDjNpx9QzXemQCTBNWHLLS6_a5Bjdc8MTH0nA4bGakhCquzpXOlictXnNOyceupazPJCQnRYw7Rv4UJJZ49CnGN9igX6D-Y7ouLFA"
WAREHOUSE="COMPUTE_WH"             # 예: COMPUTE_WH
DATABASE="DEMO"               # 선택사항
SCHEMA="MAGI_HANDSON"                   # 선택사항 (보통 PUBLIC)

# API 엔드포인트
API_URL="https://${ACCOUNT}.snowflakecomputing.com/api/v2/statements"

# ===========================================
# SQL 실행 함수
# ===========================================
execute_sql() {
    local sql="$1"
    local warehouse="${2:-$WAREHOUSE}"
    local database="${3:-$DATABASE}"
    local schema="${4:-$SCHEMA}"
    
    echo "🚀 실행 중: $sql"
    echo "📍 웨어하우스: $warehouse"
    
    # JSON 데이터 구성
    local json_data="{
        \"statement\": \"$sql\",
        \"warehouse\": \"$warehouse\",
        \"timeout\": 60"
    
    if [ ! -z "$database" ]; then
        json_data="${json_data},\"database\": \"$database\""
    fi
    
    if [ ! -z "$schema" ]; then
        json_data="${json_data},\"schema\": \"$schema\""
    fi
    
    json_data="${json_data}}"
    
    # curl 실행
    curl -s -X POST "$API_URL" \
      -H "Authorization: Bearer $JWT_TOKEN" \
      -H "Content-Type: application/json" \
      -H "X-Snowflake-Authorization-Token-Type: KEYPAIR_JWT" \
      -d "$json_data" | jq '.'
    
    echo ""
}

# ===========================================
# 데이터만 추출하는 함수
# ===========================================
execute_sql_data_only() {
    local sql="$1"
    local warehouse="${2:-$WAREHOUSE}"
    
    echo "📊 데이터 추출: $sql"
    
    curl -s -X POST "$API_URL" \
      -H "Authorization: Bearer $JWT_TOKEN" \
      -H "Content-Type: application/json" \
      -H "X-Snowflake-Authorization-Token-Type: KEYPAIR_JWT" \
      -d "{
        \"statement\": \"$sql\",
        \"warehouse\": \"$warehouse\",
        \"timeout\": 60
      }" | jq '.data // "에러 발생"'
    
    echo ""
}

# ===========================================
# 설정 확인
# ===========================================
check_config() {
    echo "🔍 설정 확인:"
    echo "  계정: $ACCOUNT"
    echo "  웨어하우스: $WAREHOUSE" 
    echo "  데이터베이스: $DATABASE"
    echo "  스키마: $SCHEMA"
    echo "  토큰: ${JWT_TOKEN:0:20}..." 
    echo ""
    
    if [ -z "$JWT_TOKEN" ]; then
        echo "❌ JWT_TOKEN이 설정되지 않았습니다!"
        echo "💡 jwt_token_generator.py를 실행해서 토큰을 생성하세요:"
        echo "   python jwt_token_generator.py"
        echo ""
        exit 1
    fi
}

# ===========================================
# 메인 실행부
# ===========================================

echo "❄️ Snowflake REST API - curl 실행기"
echo "=" * 50

# 설정 확인
check_config

# 예제 쿼리들 실행
echo "1️⃣ 현재 시간과 사용자정보 조회"
execute_sql "SELECT CURRENT_TIMESTAMP() AS current_time, CURRENT_USER() AS user, CURRENT_ROLE() AS role"

echo "2️⃣ 데이터베이스 목록 (상위 5개)"
execute_sql_data_only "SHOW DATABASES LIMIT 5"

echo "3️⃣ 사용자 정의 쿼리 - 필요시 아래 수정하세요"
# 여기에 원하는 쿼리를 추가하세요
execute_sql "SELECT * FROM demo.magi_handson.market_info where base_dt='2025-07-23' and ITEM_NM_KOR='TIGER 코리아밸류업'"

echo "🎉 완료!"
echo ""
echo "💡 사용법:"
echo "  execute_sql \"SELECT * FROM my_table\""
echo "  execute_sql_data_only \"SELECT COUNT(*) FROM users\""


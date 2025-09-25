## 03. 데이터 엔드포인트 API

## 3-1. api_user 생성 
```sql
api_setting.sql 참조
```

## 3-2. keypair 생성
``` baxh
./generate_keypair.sh 
```

## 3-3. api_user 의 public key 업데이트 
api_setting.sql 참조

## 3-4. jwt 토큰생성
``` baxh
python jwt_token_generator.py
```

## 3-5. 쿼리실행요청
```bash
./snowflake_curl.sh 실행
```

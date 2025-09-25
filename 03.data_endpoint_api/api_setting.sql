
create or replace user api_user;
GRANT ROLE ACCOUNTADMIN TO USER API_USER;
alter user api_user set default_role=accountadmin;


// 새로운 공개키 등록
ALTER USER API_USER SET RSA_PUBLIC_KEY='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3VAQvOgNtOFpj0nafr1Flefur8AmGSAEZhwRgo9zrnu8HJfRKsetPv3hJne+J8OofW9TBvfa0hbRUQCJyM+UsHl74wewhM+hv7P7Hm31D4qRQ8/L7iOtT6LYt6aoWMdbpZKT9WI4E7gCAJprgmFwd/lv9vvtWRnD8VMpD2u4Hx5zC4AeZnzgKIRKOO7keRqs3LBG1nH8SKFUiENW1YeStxKjyqa745bM4QOxBiojyf5yDf+3m/usMpXzcmbP2f2APaSLMxnE94URMfCcLdGD35QHVVvAs08SWmUvHwV9vpdu44p3OL6wzMYg7TzAwrvoU1qWEqV5rJd7MmoV73qC8wIDAQAB';

// 등록 확인 
desc user API_USER;

SELECT * FROM demo.magi_handson.market_info where base_dt='2025-07-23' and ITEM_NM_KOR='TIGER 코리아밸류업';



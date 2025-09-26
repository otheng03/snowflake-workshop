
create or replace user api_user;
GRANT ROLE ACCOUNTADMIN TO USER API_USER;
alter user api_user set default_role=accountadmin;


// 새로운 공개키 등록
ALTER USER API_USER SET RSA_PUBLIC_KEY='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsPEPcyMrOs5za2V/VfiqP4k67Zrwo2xJfSmqxzPqBnqdNmL8YZEnFr/rAUI+31sLmruJ4TtuwhHMyJ4w2Yr8UcqgVRwM3o2y8wn/NwPCo/5GzUosEhmMLz6OPAE6p4NvZlFxUvybLWlTB49E9eaqJ4CuON6EZ9sAZUz5AdyBmL57ktJTQmEaiQBAjrVymRVTAgzHRv3Q1r+2cjrLUGbYF0w3T/RBYtK4h0hkwzaDe0ZmI1zB8BMNgkRJGsFjLqMiq+eKEZXLW5j20pkJ9G0Al2oZGuP1c4/Smd2YFkrutDSR4vj7jqWqxFtXhtrClZlQy7ATA54nFx9ocS52a0Gi1QIDAQAB';

// 등록 확인 
desc user API_USER;

SELECT * FROM demo.magi_handson.market_info where base_dt='2025-07-23' and ITEM_NM_KOR='TIGER 코리아밸류업';



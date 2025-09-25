
create or replace user api_user;
GRANT ROLE ACCOUNTADMIN TO USER API_USER;
alter user api_user set default_role=accountadmin;


// 새로운 공개키 등록
ALTER USER API_USER SET RSA_PUBLIC_KEY='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAs+BVabeP2ec7Hdpx3y1+lXS3+wKoOp7rVo5jLceg1KAjw8oYDJnjcPiucMZNHLFN+TmoIjtFZXuXkNVy3tIqeJpcc2IYFdxJg9v+PlEs7ZNzL+9GX1QgdagBhXgblPKa+jASa7D3xHq+kckp9vl2ARUCDGBVdwTSgognIrYiO7nq3CEMDi2Wk1E70k4ruKUrDu6Kk+IIsfvf7eMEEv8wdvbhpcVe0M1YNOLejjWv8vDuqqeE1p9mva66jgBPaBYoC9b4E8v0ZVBR1WqZFeWQaLtOYfRVHChomIRn0b8QbyBCUkZFs2Cx8UoffI87+o3FwlKPAhF9jZNAzvpfUOQFLwIDAQAB';

// 등록 확인 
desc user API_USER;

SELECT * FROM demo.magi_handson.market_info where base_dt='2025-07-23' and ITEM_NM_KOR='TIGER 코리아밸류업';



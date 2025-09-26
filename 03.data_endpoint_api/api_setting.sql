
create or replace user api_user;
GRANT ROLE ACCOUNTADMIN TO USER API_USER;
alter user api_user set default_role=accountadmin;


// 새로운 공개키 등록
ALTER USER API_USER SET RSA_PUBLIC_KEY='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmqH771d2B0ljRtohrXhQ6d80KZ4qHWNWx5e9Yfqe+YNizqG9gWvxv3zhNIyYuW2uNhzkAgGO6t/+UYml8/XHMxm6Iu4p2XRWwvT7MYA6shNSedNs/FArmsRlA9+TNSgMZ9ZxdrRtARkkm2aiUsoMp3JDWAcceL+hmkYkEQmpr+Rxi6aHDFCOKRmwcN27vOCtMvNGLRxJQCev9a+TOetmKXMPXzdXm8mntZ33sL32ScmLLJGVPhnZbelkj6bx3JHH5zhjEJrxpeT7TTxrp7T+Ao6yTbLFQGePu7Aq85bJRyfNPPoBMWt/ccnt2PPRuc8VPbmUuvqGifPe7JHvsXehcwIDAQAB';

// 등록 확인 
desc user API_USER;

SELECT * FROM demo.magi_handson.market_info where base_dt='2025-07-23' and ITEM_NM_KOR='TIGER 코리아밸류업';



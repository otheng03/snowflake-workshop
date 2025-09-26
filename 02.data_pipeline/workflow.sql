
use demo.magi_handson;
use warehouse compute_wh;

show tables;
-- SF_KOSCOM_ETFMST
-- SF_KOSCOM_ETF_JITRADE_DAILY
-- SF_KOSCOM_ETF_JONG_DAILY
-- SF_KOSCOM_ETF_MAST_DAILY


---------------- workflow 1

select * 
from SF_KOSCOM_ETF_MAST_DAILY daily
join SF_KOSCOM_ETFMST master
on daily.etf_item_cd = master.etf_item_cd;

// dynamic table  asset_info 생성
create or replace dynamic table asset_info
target_lag = '5 minutes'
warehouse = compute_wh
as
select 
BASE_DT,
master.ETF_ITEM_CD,
ITEM_NM_KOR,
BASE_IDX_NM,
AUM,
SSC_VARI,
SSC_VARI_SIM,
SSC_VARI_AMT,
SSC_QTY,
RDT_QTY,
NAV,
MCP_NM_KOR
from SF_KOSCOM_ETF_MAST_DAILY daily
join SF_KOSCOM_ETFMST master
on daily.etf_item_cd = master.etf_item_cd;

select * from asset_info;

// Q: 2025.09.18 기준 BM이 ‘코스피200’인 모든 ETF 종목들의 AUM 정보 확인
select * from asset_info 
where base_dt='2025-09-18' and base_idx_nm ilike '%코스피%200';

// Q: TIGER 미국나스닥100 종목의 날짜별 AUM 추이 확인
select item_nm_kor, base_dt, aum from asset_info 
where item_nm_kor ='TIGER 미국나스닥100'
order by base_dt;

// Q: BM이 ‘코스피200’인 모든 ETF 종목들의 날짜별 설정액 증감액 추이 확인
select base_idx_nm,item_nm_kor, base_dt, ssc_vari from asset_info 
where base_idx_nm ilike '%코스피%200'
order by base_dt;


---------------- workflow 2
// dynamic table trade_daily 생성
create or replace dynamic table trade_daily
target_lag = '1 minutes'
warehouse = compute_wh
refresh_mode=incremental
as
select
BASE_DT,
master.ETF_ITEM_CD,
ITEM_NM_KOR,
BASE_IDX_NM,
sum(BUY_AMT::number) as sum_buy_amt,
sum(SEL_AMT::number) as sum_sel_amt
from SF_KOSCOM_ETF_JITRADE_DAILY daily
join SF_KOSCOM_ETFMST master
on daily.etf_item_cd = master.etf_item_cd
group by 1,2,3,4
;

select * from trade_daily limit 10;

// dynamic table market_info 생성
create or replace dynamic table market_info
target_lag = '1 minutes'
warehouse = compute_wh
refresh_mode=incremental
as
select
trade_daily.BASE_DT,
trade_daily.ETF_ITEM_CD,
ITEM_NM_KOR,
BASE_IDX_NM,
MKCAP,
sum_BUY_AMT,
sum_SEL_AMT
from trade_daily 
join SF_KOSCOM_ETF_JONG_DAILY JONG_DAILY
on trade_daily.etf_item_cd = JONG_DAILY.etf_item_cd
and trade_daily.base_dt = JONG_DAILY.base_dt
;

// 화면 확인

// downstream table 의 refresh 를 따라간다. 
ALTER DYNAMIC TABLE trade_daily SET TARGET_LAG = DOWNSTREAM;

show dynamic tables;

// Q: TIGER 미국나스닥100 종목의 날짜별 순매수량 추이 정보 확인
select item_nm_kor, base_dt, sum_buy_amt, sum_sel_amt, (sum_buy_amt-sum_sel_amt) as net_amt from market_info
where item_nm_kor ='TIGER 미국나스닥100'
order by base_dt;

// Q: BM이 ‘코스피200’인 모든 ETF 종목들의 날짜별 매도금액 및 시가총액 변화 추이 확인
select base_idx_nm, base_dt, item_nm_kor, sum_sel_amt, mkcap from market_info
where base_idx_nm ilike '%코스피%200'
order by base_dt;

---------------------------------- 
// data 변경
select max(base_dt) from SF_KOSCOM_ETF_JITRADE_DAILY;

// TIGER 미국나스닥100 데이터 추가
insert into SF_KOSCOM_ETF_JITRADE_DAILY
values('2025-08-25','KR7133690008',6000,1076360,86041764600,175480,14020107350);

insert into SF_KOSCOM_ETF_JITRADE_DAILY
values('2025-08-26','KR7133690008',6000,1076360,86041764600,175480,14020107350);



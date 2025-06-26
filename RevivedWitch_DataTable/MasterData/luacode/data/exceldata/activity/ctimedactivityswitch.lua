-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/activity/ctimedactivityswitch.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ctimedactivityswitch = {}
ctimedactivityswitch.Data = {
[1001] = {id = 1001, activityLineId = 1, openTime = "2019-10-07 12:00:00", closeTime = "2019-11-11 18:00:00", scheduleLimit = 10002, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2001] = {id = 2001, activityLineId = 2, openTime = "2021-01-14 04:00:00", closeTime = "2021-09-06 04:00:00", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2002] = {id = 2002, activityLineId = 2, openTime = "2021-09-09 16:00:00", closeTime = "2021-11-08 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2003] = {id = 2003, activityLineId = 2, openTime = "2021-11-08 04:00:00", closeTime = "2022-01-07 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2004] = {id = 2004, activityLineId = 2, openTime = "2022-01-07 04:00:00", closeTime = "2022-03-08 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2005] = {id = 2005, activityLineId = 2, openTime = "2022-03-08 04:00:00", closeTime = "2022-05-07 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2006] = {id = 2006, activityLineId = 2, openTime = "2022-05-07 04:00:00", closeTime = "2022-07-06 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2007] = {id = 2007, activityLineId = 2, openTime = "2022-07-08 04:00:00", closeTime = "2022-09-06 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2008] = {id = 2008, activityLineId = 2, openTime = "2022-09-06 04:00:00", closeTime = "2022-11-05 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2009] = {id = 2009, activityLineId = 2, openTime = "2022-11-05 04:00:00", closeTime = "2023-01-04 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2010] = {id = 2010, activityLineId = 2, openTime = "2023-01-04 04:00:00", closeTime = "2023-03-05 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2011] = {id = 2011, activityLineId = 2, openTime = "2023-03-05 04:00:00", closeTime = "2023-05-04 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2012] = {id = 2012, activityLineId = 2, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[2013] = {id = 2013, activityLineId = 2, openTime = "2025-05-15 04:00:00", closeTime = "2025-07-14 04:00:00", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[3001] = {id = 3001, activityLineId = 3, openTime = "2021-03-23 10:00:00", closeTime = "2122-03-24 10:00:00", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4002] = {id = 4002, activityLineId = 4, openTime = "2021-07-22 04:00:00", closeTime = "2021-08-05 04:00:00", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4003] = {id = 4003, activityLineId = 4, openTime = "2021-08-05 04:00:00", closeTime = "2021-08-19 04:00:00", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4004] = {id = 4004, activityLineId = 4, openTime = "2021-08-19 04:00:00", closeTime = "2021-09-02 04:00:00", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4005] = {id = 4005, activityLineId = 4, openTime = "2021-09-02 04:00:00", closeTime = "2021-09-16 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4006] = {id = 4006, activityLineId = 4, openTime = "2021-09-16 04:00:00", closeTime = "2021-09-30 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4007] = {id = 4007, activityLineId = 4, openTime = "2021-09-30 04:00:00", closeTime = "2021-10-14 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4008] = {id = 4008, activityLineId = 4, openTime = "2021-10-14 04:00:00", closeTime = "2021-10-28 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4009] = {id = 4009, activityLineId = 4, openTime = "2021-10-28 04:00:00", closeTime = "2021-11-11 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4010] = {id = 4010, activityLineId = 4, openTime = "2021-11-11 04:00:00", closeTime = "2021-11-25 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4011] = {id = 4011, activityLineId = 4, openTime = "2021-11-25 04:00:00", closeTime = "2021-12-09 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4012] = {id = 4012, activityLineId = 4, openTime = "2021-12-09 04:00:00", closeTime = "2021-12-23 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4013] = {id = 4013, activityLineId = 4, openTime = "2021-12-23 04:00:00", closeTime = "2022-01-06 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4014] = {id = 4014, activityLineId = 4, openTime = "2022-01-06 04:00:00", closeTime = "2022-01-20 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4015] = {id = 4015, activityLineId = 4, openTime = "2022-01-20 04:00:00", closeTime = "2022-02-03 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4016] = {id = 4016, activityLineId = 4, openTime = "2022-02-03 04:00:00", closeTime = "2022-02-17 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[4017] = {id = 4017, activityLineId = 4, openTime = "2022-02-17 04:00:00", closeTime = "2022-03-03 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[5001] = {id = 5001, activityLineId = 5, openTime = "2020-12-04 12:00:00", closeTime = "2021-02-01 12:00:00", scheduleLimit = 10003, scheduleinterval = -1, parameter = "35001;1", onChannel = "110001;610001;610002", specialentry = -1}
, 
[6001] = {id = 6001, activityLineId = 6, openTime = "2022-06-24 04:00:00", closeTime = "2022-07-12 04:00:00", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[7001] = {id = 7001, activityLineId = 7, openTime = "2021-08-01 04:00:00", closeTime = "2021-08-26 04:00:00", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[7002] = {id = 7002, activityLineId = 7, openTime = "2021-10-01 04:00:00", closeTime = "2021-10-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[7003] = {id = 7003, activityLineId = 7, openTime = "2021-10-18 04:00:00", closeTime = "2021-12-30 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[7004] = {id = 7004, activityLineId = 7, openTime = "2021-12-18 04:00:00", closeTime = "2022-02-10 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[7007] = {id = 7007, activityLineId = 7, openTime = "2022-01-18 04:00:00", closeTime = "2022-03-03 03:59:59", scheduleLimit = 10003, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[7008] = {id = 7008, activityLineId = 7, openTime = "2022-04-28 03:59:59", closeTime = "2022-05-12 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[7010] = {id = 7010, activityLineId = 7, openTime = "2022-06-30 04:00:00", closeTime = "2022-07-21 03:59:59", scheduleLimit = 10003, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[7011] = {id = 7011, activityLineId = 7, openTime = "2022-07-28 04:00:00", closeTime = "2022-08-18 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[7012] = {id = 7012, activityLineId = 7, openTime = "2022-09-29 04:00:00", closeTime = "2022-10-13 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[7013] = {id = 7013, activityLineId = 7, openTime = "2022-10-27 04:00:00", closeTime = "2022-11-17 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[7015] = {id = 7015, activityLineId = 7, openTime = "2022-12-18 04:00:00", closeTime = "2023-02-02 03:59:59", scheduleLimit = 12025, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[7016] = {id = 7016, activityLineId = 7, openTime = "2024-03-21 04:00:00", closeTime = "2024-03-28 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[8001] = {id = 8001, activityLineId = 8, openTime = "2021-08-19 04:00:00", closeTime = "2021-09-18 04:00:00", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[8002] = {id = 8002, activityLineId = 8, openTime = "2021-08-19 04:00:00", closeTime = "2022-01-06 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[8003] = {id = 8003, activityLineId = 8, openTime = "2022-06-30 04:00:00", closeTime = "2022-07-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[8004] = {id = 8004, activityLineId = 8, openTime = "2022-08-11 04:00:00", closeTime = "2022-09-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[9001] = {id = 9001, activityLineId = 9, openTime = "2022-08-08 04:00:00", closeTime = "2022-10-13 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[10039] = {id = 10039, activityLineId = 10, openTime = "2025-05-15 04:00:00", closeTime = "2025-05-22 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10040] = {id = 10040, activityLineId = 10, openTime = "2025-05-29 04:00:00", closeTime = "2025-06-05 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10041] = {id = 10041, activityLineId = 10, openTime = "2025-06-12 04:00:00", closeTime = "2025-06-19 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10042] = {id = 10042, activityLineId = 10, openTime = "2025-06-26 04:00:00", closeTime = "2025-07-03 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10043] = {id = 10043, activityLineId = 10, openTime = "2025-07-10 04:00:00", closeTime = "2025-07-17 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10044] = {id = 10044, activityLineId = 10, openTime = "2025-07-24 04:00:00", closeTime = "2025-07-31 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10045] = {id = 10045, activityLineId = 10, openTime = "2025-08-07 04:00:00", closeTime = "2025-08-14 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10046] = {id = 10046, activityLineId = 10, openTime = "2025-08-21 04:00:00", closeTime = "2025-08-28 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10047] = {id = 10047, activityLineId = 10, openTime = "2025-09-04 04:00:00", closeTime = "2025-09-11 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[10048] = {id = 10048, activityLineId = 10, openTime = "2025-09-18 04:00:00", closeTime = "2025-09-25 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[11001] = {id = 11001, activityLineId = 11, openTime = "2021-10-01 04:01:00", closeTime = "2021-10-14 03:59:59", scheduleLimit = 10002, scheduleinterval = -1, parameter = "9001", onChannel = "", specialentry = -1}
, 
[11002] = {id = 11002, activityLineId = 11, openTime = "2021-09-16 04:00:00", closeTime = "2021-09-30 03:59:59", scheduleLimit = 10002, scheduleinterval = -1, parameter = "12001", onChannel = "", specialentry = -1}
, 
[11003] = {id = 11003, activityLineId = 11, openTime = "2021-06-24 04:00:00", closeTime = "2021-08-12 04:00:00", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[11004] = {id = 11004, activityLineId = 11, openTime = "2021-10-27 10:00:00", closeTime = "2021-11-11 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "16001", onChannel = "", specialentry = -1}
, 
[11005] = {id = 11005, activityLineId = 11, openTime = "2022-03-10 16:00:00", closeTime = "2022-03-17 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "29001", onChannel = "", specialentry = -1}
, 
[11006] = {id = 11006, activityLineId = 11, openTime = "2022-06-30 16:00:00", closeTime = "2022-07-14 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "40001", onChannel = "", specialentry = -1}
, 
[11007] = {id = 11007, activityLineId = 11, openTime = "2022-08-11 16:00:00", closeTime = "2022-08-25 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "40001", onChannel = "", specialentry = -1}
, 
[12001] = {id = 12001, activityLineId = 12, openTime = "2021-09-16 15:00:00", closeTime = "2021-09-30 15:00:00", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[12002] = {id = 12002, activityLineId = 12, openTime = "2022-04-11 04:00:00", closeTime = "2022-05-05 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[12003] = {id = 12003, activityLineId = 12, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[13039] = {id = 13039, activityLineId = 13, openTime = "2025-05-15 04:00:00", closeTime = "2025-05-29 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13040] = {id = 13040, activityLineId = 13, openTime = "2025-05-29 04:00:00", closeTime = "2025-06-12 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13041] = {id = 13041, activityLineId = 13, openTime = "2025-06-12 04:00:00", closeTime = "2025-06-26 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13042] = {id = 13042, activityLineId = 13, openTime = "2025-06-26 04:00:00", closeTime = "2025-07-10 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13043] = {id = 13043, activityLineId = 13, openTime = "2025-07-10 04:00:00", closeTime = "2025-07-24 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13044] = {id = 13044, activityLineId = 13, openTime = "2025-07-24 04:00:00", closeTime = "2025-08-07 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13045] = {id = 13045, activityLineId = 13, openTime = "2025-08-07 04:00:00", closeTime = "2025-08-21 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13046] = {id = 13046, activityLineId = 13, openTime = "2025-08-21 04:00:00", closeTime = "2025-09-04 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13047] = {id = 13047, activityLineId = 13, openTime = "2025-09-04 04:00:00", closeTime = "2025-09-18 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[13048] = {id = 13048, activityLineId = 13, openTime = "2025-09-18 04:00:00", closeTime = "2025-10-02 03:59:59", scheduleLimit = 10025, scheduleinterval = 43, parameter = "", onChannel = "", specialentry = -1}
, 
[15001] = {id = 15001, activityLineId = 15, openTime = "2021-09-26 04:00:00", closeTime = "2021-10-26 03:59:59", scheduleLimit = 0, scheduleinterval = 0, parameter = "", onChannel = "", specialentry = -1}
, 
[15002] = {id = 15002, activityLineId = 15, openTime = "2021-12-16 04:00:00", closeTime = "2022-01-06 03:59:59", scheduleLimit = 0, scheduleinterval = 0, parameter = "", onChannel = "", specialentry = -1}
, 
[15003] = {id = 15003, activityLineId = 15, openTime = "2022-01-27 04:00:00", closeTime = "2022-02-10 03:59:59", scheduleLimit = 0, scheduleinterval = 0, parameter = "", onChannel = "", specialentry = -1}
, 
[15005] = {id = 15005, activityLineId = 15, openTime = "2022-06-17 04:00:00", closeTime = "2022-07-14 03:59:59", scheduleLimit = 0, scheduleinterval = 0, parameter = "", onChannel = "", specialentry = -1}
, 
[16001] = {id = 16001, activityLineId = 16, openTime = "2021-10-01 04:00:00", closeTime = "2021-11-18 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[17001] = {id = 17001, activityLineId = 17, openTime = "2021-10-01 04:00:00", closeTime = "2021-11-11 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[18001] = {id = 18001, activityLineId = 18, openTime = "2021-11-03 04:00:00", closeTime = "2023-01-12 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[19001] = {id = 19001, activityLineId = 19, openTime = "2021-10-11 04:00:00", closeTime = "2022-11-17 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[20001] = {id = 20001, activityLineId = 20, openTime = "2021-11-25 15:00:00", closeTime = "2021-12-09 15:00:00", scheduleLimit = 12004, scheduleinterval = 6, parameter = "2021-12-08 04:00:00", onChannel = "", specialentry = -1}
, 
[21001] = {id = 21001, activityLineId = 21, openTime = "2021-12-14 04:00:00", closeTime = "2023-01-05 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[22001] = {id = 22001, activityLineId = 22, openTime = "2021-12-23 04:00:00", closeTime = "2023-01-05 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[23001] = {id = 23001, activityLineId = 23, openTime = "2023-01-05 04:00:00", closeTime = "2023-01-12 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[24001] = {id = 24001, activityLineId = 24, openTime = "2021-11-03 04:00:00", closeTime = "2023-01-12 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[25001] = {id = 25001, activityLineId = 25, openTime = "2023-01-05 18:10:00", closeTime = "2023-02-02 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[26001] = {id = 26001, activityLineId = 26, openTime = "2023-01-22 04:00:00", closeTime = "2023-01-29 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[27001] = {id = 27001, activityLineId = 27, openTime = "2022-02-10 16:00:00", closeTime = "2023-03-09 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[29001] = {id = 29001, activityLineId = 29, openTime = "2023-03-09 04:00:00", closeTime = "2023-03-16 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[30001] = {id = 30001, activityLineId = 30, openTime = "2023-01-05 18:10:00", closeTime = "2023-02-02 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[31001] = {id = 31001, activityLineId = 31, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[32001] = {id = 32001, activityLineId = 32, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[33001] = {id = 33001, activityLineId = 33, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[34001] = {id = 34001, activityLineId = 34, openTime = "2023-05-19 04:00:00", closeTime = "2023-06-09 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "2023-06-09 03:59:59", onChannel = "", specialentry = -1}
, 
[35001] = {id = 35001, activityLineId = 35, openTime = "2022-05-24 04:00:00", closeTime = "2022-06-16 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[36001] = {id = 36001, activityLineId = 36, openTime = "2022-08-04 04:00:00", closeTime = "2022-08-18 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[37001] = {id = 37001, activityLineId = 37, openTime = "2022-04-26 04:00:00", closeTime = "2022-05-19 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[37002] = {id = 37002, activityLineId = 37, openTime = "2022-07-01 04:00:00", closeTime = "2022-07-22 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[37003] = {id = 37003, activityLineId = 37, openTime = "2022-08-01 04:00:00", closeTime = "2022-08-22 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[38001] = {id = 38001, activityLineId = 38, openTime = "2022-06-13 04:00:00", closeTime = "2024-05-19 03:59:59", scheduleLimit = 13029, scheduleinterval = 38, parameter = "", onChannel = "", specialentry = -1}
, 
[39001] = {id = 39001, activityLineId = 39, openTime = "2022-05-26 04:00:00", closeTime = "2022-06-16 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39002] = {id = 39002, activityLineId = 39, openTime = "2022-06-16 04:00:00", closeTime = "2022-07-07 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39003] = {id = 39003, activityLineId = 39, openTime = "2022-07-08 04:00:00", closeTime = "2022-07-29 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39004] = {id = 39004, activityLineId = 39, openTime = "2022-07-29 04:00:00", closeTime = "2022-08-19 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39005] = {id = 39005, activityLineId = 39, openTime = "2022-08-19 04:00:00", closeTime = "2022-09-09 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39006] = {id = 39006, activityLineId = 39, openTime = "2022-09-09 04:00:00", closeTime = "2022-09-30 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39007] = {id = 39007, activityLineId = 39, openTime = "2022-09-30 04:00:00", closeTime = "2022-10-21 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39008] = {id = 39008, activityLineId = 39, openTime = "2022-10-21 04:00:00", closeTime = "2022-11-11 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39009] = {id = 39009, activityLineId = 39, openTime = "2022-11-11 04:00:00", closeTime = "2022-12-02 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39010] = {id = 39010, activityLineId = 39, openTime = "2022-12-02 04:00:00", closeTime = "2022-12-23 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39011] = {id = 39011, activityLineId = 39, openTime = "2022-12-23 04:00:00", closeTime = "2023-01-13 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39012] = {id = 39012, activityLineId = 39, openTime = "2023-01-13 04:00:00", closeTime = "2023-02-03 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39013] = {id = 39013, activityLineId = 39, openTime = "2023-02-03 04:00:00", closeTime = "2023-02-24 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39014] = {id = 39014, activityLineId = 39, openTime = "2023-02-24 04:00:00", closeTime = "2023-03-17 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39015] = {id = 39015, activityLineId = 39, openTime = "2023-03-17 04:00:00", closeTime = "2023-04-07 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39016] = {id = 39016, activityLineId = 39, openTime = "2023-04-07 04:00:00", closeTime = "2023-04-28 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39017] = {id = 39017, activityLineId = 39, openTime = "2023-04-28 04:00:00", closeTime = "2023-05-19 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39018] = {id = 39018, activityLineId = 39, openTime = "2023-05-19 04:00:00", closeTime = "2023-06-09 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39019] = {id = 39019, activityLineId = 39, openTime = "2023-06-09 04:00:00", closeTime = "2023-06-30 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[39020] = {id = 39020, activityLineId = 39, openTime = "2023-03-21 04:00:00", closeTime = "2023-03-28 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -2}
, 
[39021] = {id = 39021, activityLineId = 39, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -3}
, 
[40001] = {id = 40001, activityLineId = 40, openTime = "2022-08-18 04:00:00", closeTime = "2022-11-17 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[41001] = {id = 41001, activityLineId = 41, openTime = "2022-06-01 04:00:00", closeTime = "2035-07-19 03:59:59", scheduleLimit = 10011, scheduleinterval = 4, parameter = "", onChannel = "", specialentry = -1}
, 
[42001] = {id = 42001, activityLineId = 42, openTime = "2022-07-08 15:00:00", closeTime = "2022-07-17 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[43001] = {id = 43001, activityLineId = 43, openTime = "2022-06-06 04:00:00", closeTime = "2022-07-21 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[44001] = {id = 44001, activityLineId = 44, openTime = "2022-08-18 04:00:00", closeTime = "2022-11-10 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[45001] = {id = 45001, activityLineId = 45, openTime = "2021-06-19 04:00:00", closeTime = "2022-08-04 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[45002] = {id = 45002, activityLineId = 45, openTime = "2022-08-24 04:00:00", closeTime = "2022-12-08 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[46001] = {id = 46001, activityLineId = 46, openTime = "2022-08-08 15:00:00", closeTime = "2022-09-29 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "2022-09-22 04:00:00", onChannel = "", specialentry = -1}
, 
[47001] = {id = 47001, activityLineId = 47, openTime = "2022-08-04 04:00:00", closeTime = "2022-09-08 04:00:00", scheduleLimit = 12025, scheduleinterval = 17, parameter = "", onChannel = "", specialentry = -1}
, 
[50001] = {id = 50001, activityLineId = 50, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[51001] = {id = 51001, activityLineId = 51, openTime = "2023-01-11 04:00:00", closeTime = "2023-01-31 03:59:59", scheduleLimit = 10010, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[52001] = {id = 52001, activityLineId = 52, openTime = "2024-03-21 04:00:00", closeTime = "2024-03-28 03:59:59", scheduleLimit = 12025, scheduleinterval = 17, parameter = "240", onChannel = "", specialentry = -1}
, 
[53001] = {id = 53001, activityLineId = 53, openTime = "2024-03-21 04:00:00", closeTime = "2024-08-31 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -1}
, 
[54001] = {id = 54001, activityLineId = 54, openTime = "2025-05-15 04:00:00", closeTime = "2025-06-12 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -3}
, 
[54002] = {id = 54002, activityLineId = 54, openTime = "2025-06-14 04:00:00", closeTime = "2025-07-10 03:59:59", scheduleLimit = 12004, scheduleinterval = 6, parameter = "", onChannel = "", specialentry = -3}
, 
[801001] = {id = 801001, activityLineId = 801, openTime = "2021-08-19 04:00:00", closeTime = "2022-01-06 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[801002] = {id = 801002, activityLineId = 801, openTime = "2022-06-30 04:00:00", closeTime = "2022-07-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[801003] = {id = 801003, activityLineId = 801, openTime = "2022-08-11 04:00:00", closeTime = "2022-09-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[802001] = {id = 802001, activityLineId = 802, openTime = "2021-08-19 04:00:00", closeTime = "2022-01-06 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[802002] = {id = 802002, activityLineId = 802, openTime = "2022-06-30 04:00:00", closeTime = "2022-07-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[802003] = {id = 802003, activityLineId = 802, openTime = "2022-09-30 04:00:00", closeTime = "2022-10-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[802004] = {id = 802004, activityLineId = 802, openTime = "2023-01-17 04:00:00", closeTime = "2023-01-31 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[803001] = {id = 803001, activityLineId = 803, openTime = "2021-08-19 04:00:00", closeTime = "2022-01-06 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[803002] = {id = 803002, activityLineId = 803, openTime = "2022-06-30 04:00:00", closeTime = "2022-07-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[803003] = {id = 803003, activityLineId = 803, openTime = "2022-08-11 04:00:00", closeTime = "2022-09-14 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[804001] = {id = 804001, activityLineId = 804, openTime = "2021-08-19 04:00:00", closeTime = "2022-02-18 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[804002] = {id = 804002, activityLineId = 804, openTime = "2022-06-30 04:00:00", closeTime = "2022-08-25 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[804003] = {id = 804003, activityLineId = 804, openTime = "2022-09-30 04:00:00", closeTime = "2022-10-07 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[804004] = {id = 804004, activityLineId = 804, openTime = "2023-01-17 04:00:00", closeTime = "2023-02-21 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
, 
[805001] = {id = 805001, activityLineId = 805, openTime = "2023-01-17 04:00:00", closeTime = "2023-01-31 03:59:59", scheduleLimit = 10003, scheduleinterval = -1, parameter = "", onChannel = "", specialentry = -1}
}
ctimedactivityswitch.AllIds = {1001, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 3001, 4002, 4003, 4004, 4005, 4006, 4007, 4008, 4009, 4010, 4011, 4012, 4013, 4014, 4015, 4016, 4017, 5001, 6001, 7001, 7002, 7003, 7004, 7007, 7008, 7010, 7011, 7012, 7013, 7015, 7016, 8001, 8002, 8003, 8004, 9001, 10039, 10040, 10041, 10042, 10043, 10044, 10045, 10046, 10047, 10048, 11001, 11002, 11003, 11004, 11005, 11006, 11007, 12001, 12002, 12003, 13039, 13040, 13041, 13042, 13043, 13044, 13045, 13046, 13047, 13048, 15001, 15002, 15003, 15005, 16001, 17001, 18001, 19001, 20001, 21001, 22001, 23001, 24001, 25001, 26001, 27001, 29001, 30001, 31001, 32001, 33001, 34001, 35001, 36001, 37001, 37002, 37003, 38001, 39001, 39002, 39003, 39004, 39005, 39006, 39007, 39008, 39009, 39010, 39011, 39012, 39013, 39014, 39015, 39016, 39017, 39018, 39019, 39020, 39021, 40001, 41001, 42001, 43001, 44001, 45001, 45002, 46001, 47001, 50001, 51001, 52001, 53001, 54001, 54002, 801001, 801002, 801003, 802001, 802002, 802003, 802004, 803001, 803002, 803003, 804001, 804002, 804003, 804004, 805001}
return ctimedactivityswitch


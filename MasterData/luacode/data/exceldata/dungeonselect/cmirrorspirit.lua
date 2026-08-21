-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cmirrorspirit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cmirrorspirit = {}
cmirrorspirit.Data = {
[1] = {id = 1, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-04 12:00:00", missionend = "2022-08-05 03:59:59"}
, 
[2] = {id = 2, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-04 18:00:00", missionend = "2022-08-05 03:59:59"}
, 
[3] = {id = 3, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-05 12:00:00", missionend = "2022-08-06 03:59:59"}
, 
[4] = {id = 4, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-05 18:00:00", missionend = "2022-08-06 03:59:59"}
, 
[5] = {id = 5, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-06 12:00:00", missionend = "2022-08-07 03:59:59"}
, 
[6] = {id = 6, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-06 18:00:00", missionend = "2022-08-07 03:59:59"}
, 
[7] = {id = 7, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-07 12:00:00", missionend = "2022-08-08 03:59:59"}
, 
[8] = {id = 8, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-07 18:00:00", missionend = "2022-08-08 03:59:59"}
, 
[9] = {id = 9, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-08 12:00:00", missionend = "2022-08-09 03:59:59"}
, 
[10] = {id = 10, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-08 18:00:00", missionend = "2022-08-09 03:59:59"}
, 
[11] = {id = 11, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-09 12:00:00", missionend = "2022-08-10 03:59:59"}
, 
[12] = {id = 12, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-09 18:00:00", missionend = "2022-08-10 03:59:59"}
, 
[13] = {id = 13, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-10 12:00:00", missionend = "2022-08-11 03:59:59"}
, 
[14] = {id = 14, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-10 18:00:00", missionend = "2022-08-11 03:59:59"}
, 
[15] = {id = 15, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-11 12:00:00", missionend = "2022-08-12 03:59:59"}
, 
[16] = {id = 16, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-11 18:00:00", missionend = "2022-08-12 03:59:59"}
, 
[17] = {id = 17, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-12 12:00:00", missionend = "2022-08-13 03:59:59"}
, 
[18] = {id = 18, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-12 18:00:00", missionend = "2022-08-13 03:59:59"}
, 
[19] = {id = 19, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-13 12:00:00", missionend = "2022-08-14 03:59:59"}
, 
[20] = {id = 20, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-13 18:00:00", missionend = "2022-08-14 03:59:59"}
, 
[21] = {id = 21, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-14 12:00:00", missionend = "2022-08-15 03:59:59"}
, 
[22] = {id = 22, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-14 18:00:00", missionend = "2022-08-15 03:59:59"}
, 
[23] = {id = 23, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-15 12:00:00", missionend = "2022-08-16 03:59:59"}
, 
[24] = {id = 24, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-15 18:00:00", missionend = "2022-08-16 03:59:59"}
, 
[25] = {id = 25, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-16 12:00:00", missionend = "2022-08-17 03:59:59"}
, 
[26] = {id = 26, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-16 18:00:00", missionend = "2022-08-17 03:59:59"}
, 
[27] = {id = 27, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-17 12:00:00", missionend = "2022-08-18 03:59:59"}
, 
[28] = {id = 28, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-17 18:00:00", missionend = "2022-08-18 03:59:59"}
, 
[29] = {id = 29, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-18 12:00:00", missionend = "2022-08-19 03:59:59"}
, 
[30] = {id = 30, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-18 18:00:00", missionend = "2022-08-19 03:59:59"}
, 
[31] = {id = 31, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-19 12:00:00", missionend = "2022-08-20 03:59:59"}
, 
[32] = {id = 32, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-19 18:00:00", missionend = "2022-08-20 03:59:59"}
, 
[33] = {id = 33, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-20 12:00:00", missionend = "2022-08-21 03:59:59"}
, 
[34] = {id = 34, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-20 18:00:00", missionend = "2022-08-21 03:59:59"}
, 
[35] = {id = 35, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-21 12:00:00", missionend = "2022-08-22 03:59:59"}
, 
[36] = {id = 36, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-21 18:00:00", missionend = "2022-08-22 03:59:59"}
, 
[37] = {id = 37, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-22 12:00:00", missionend = "2022-08-23 03:59:59"}
, 
[38] = {id = 38, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-22 18:00:00", missionend = "2022-08-23 03:59:59"}
, 
[39] = {id = 39, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-23 12:00:00", missionend = "2022-08-24 03:59:59"}
, 
[40] = {id = 40, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-23 18:00:00", missionend = "2022-08-24 03:59:59"}
, 
[41] = {id = 41, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-24 12:00:00", missionend = "2022-08-25 03:59:59"}
, 
[42] = {id = 42, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-24 18:00:00", missionend = "2022-08-25 03:59:59"}
, 
[43] = {id = 43, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-25 12:00:00", missionend = "2022-08-26 03:59:59"}
, 
[44] = {id = 44, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-25 18:00:00", missionend = "2022-08-26 03:59:59"}
, 
[45] = {id = 45, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-26 12:00:00", missionend = "2022-08-27 03:59:59"}
, 
[46] = {id = 46, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-26 18:00:00", missionend = "2022-08-27 03:59:59"}
, 
[47] = {id = 47, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-27 12:00:00", missionend = "2022-08-28 03:59:59"}
, 
[48] = {id = 48, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-27 18:00:00", missionend = "2022-08-28 03:59:59"}
, 
[49] = {id = 49, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-28 12:00:00", missionend = "2022-08-29 03:59:59"}
, 
[50] = {id = 50, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-28 18:00:00", missionend = "2022-08-29 03:59:59"}
, 
[51] = {id = 51, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-29 12:00:00", missionend = "2022-08-30 03:59:59"}
, 
[52] = {id = 52, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-29 18:00:00", missionend = "2022-08-30 03:59:59"}
, 
[53] = {id = 53, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-30 12:00:00", missionend = "2022-08-31 03:59:59"}
, 
[54] = {id = 54, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-30 18:00:00", missionend = "2022-08-31 03:59:59"}
, 
[55] = {id = 55, eventid = 47001, type = 1, itemid = 35003, itemnum = 30, missionstart = "2022-08-31 12:00:00", missionend = "2022-09-01 03:59:59"}
, 
[56] = {id = 56, eventid = 47001, type = 2, itemid = 35003, itemnum = 30, missionstart = "2022-08-31 18:00:00", missionend = "2022-09-01 03:59:59"}
}
cmirrorspirit.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56}
return cmirrorspirit


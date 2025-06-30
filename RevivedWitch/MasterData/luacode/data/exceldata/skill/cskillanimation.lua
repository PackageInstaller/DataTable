-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/skill/cskillanimation.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cskillanimation = {}
cskillanimation.Data = {
[10001] = {id = 10001, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "5"}
, 
[10002] = {id = 10002, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[10003] = {id = 10003, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10004] = {id = 10004, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[10005] = {id = 10005, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "5"}
, 
[10006] = {id = 10006, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10007] = {id = 10007, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10008] = {id = 10008, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "13"}
, 
[10009] = {id = 10009, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[10010] = {id = 10010, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[10011] = {id = 10011, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10012] = {id = 10012, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10013] = {id = 10013, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10014] = {id = 10014, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10015] = {id = 10015, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "12"}
, 
[10016] = {id = 10016, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "4"}
, 
[10017] = {id = 10017, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10018] = {id = 10018, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "14"}
, 
[10019] = {id = 10019, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10020] = {id = 10020, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "4"}
, 
[10021] = {id = 10021, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "18"}
, 
[10022] = {id = 10022, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10023] = {id = 10023, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10024] = {id = 10024, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10025] = {id = 10025, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10026] = {id = 10026, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "4"}
, 
[10027] = {id = 10027, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "3"}
, 
[10028] = {id = 10028, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10029] = {id = 10029, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10030] = {id = 10030, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "3"}
, 
[10031] = {id = 10031, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10032] = {id = 10032, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "20"}
, 
[10033] = {id = 10033, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "15"}
, 
[10034] = {id = 10034, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10035] = {id = 10035, actionType = 1, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "4"}
, 
[10036] = {id = 10036, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10037] = {id = 10037, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10038] = {id = 10038, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10039] = {id = 10039, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10040] = {id = 10040, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10041] = {id = 10041, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10042] = {id = 10042, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "5"}
, 
[10043] = {id = 10043, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[10044] = {id = 10044, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "3"}
, 
[10045] = {id = 10045, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10046] = {id = 10046, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10047] = {id = 10047, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10048] = {id = 10048, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10049] = {id = 10049, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "20"}
, 
[10050] = {id = 10050, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10051] = {id = 10051, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "10"}
, 
[10052] = {id = 10052, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "19"}
, 
[10053] = {id = 10053, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10054] = {id = 10054, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "5"}
, 
[10055] = {id = 10055, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "21"}
, 
[10056] = {id = 10056, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10057] = {id = 10057, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "7"}
, 
[10058] = {id = 10058, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10059] = {id = 10059, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10060] = {id = 10060, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10061] = {id = 10061, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "7"}
, 
[10062] = {id = 10062, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[10063] = {id = 10063, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10064] = {id = 10064, actionType = 1, actionAtk = "AttackStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10065] = {id = 10065, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "8"}
, 
[10066] = {id = 10066, actionType = 1, actionAtk = "AttackStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10067] = {id = 10067, actionType = 1, actionAtk = "AttackStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10068] = {id = 10068, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "24"}
, 
[10069] = {id = 10069, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "12"}
, 
[10070] = {id = 10070, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10071] = {id = 10071, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10072] = {id = 10072, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "11"}
, 
[10073] = {id = 10073, actionType = 1, actionAtk = "AttackStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10074] = {id = 10074, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10075] = {id = 10075, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10076] = {id = 10076, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10078] = {id = 10078, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10079] = {id = 10079, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10080] = {id = 10080, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10081] = {id = 10081, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10082] = {id = 10082, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10083] = {id = 10083, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10084] = {id = 10084, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10085] = {id = 10085, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10086] = {id = 10086, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10088] = {id = 10088, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10089] = {id = 10089, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10090] = {id = 10090, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10091] = {id = 10091, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10092] = {id = 10092, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10093] = {id = 10093, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10094] = {id = 10094, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10095] = {id = 10095, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10097] = {id = 10097, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10098] = {id = 10098, actionType = 1, actionAtk = "AttackStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10099] = {id = 10099, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10100] = {id = 10100, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10101] = {id = 10101, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10102] = {id = 10102, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10103] = {id = 10103, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10104] = {id = 10104, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10105] = {id = 10105, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10106] = {id = 10106, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10107] = {id = 10107, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10109] = {id = 10109, actionType = 1, actionAtk = "AttackStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10111] = {id = 10111, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10112] = {id = 10112, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10113] = {id = 10113, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10115] = {id = 10115, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10116] = {id = 10116, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10117] = {id = 10117, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10118] = {id = 10118, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10119] = {id = 10119, actionType = 1, actionAtk = "AttackStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10120] = {id = 10120, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10121] = {id = 10121, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10122] = {id = 10122, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10123] = {id = 10123, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10124] = {id = 10124, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10126] = {id = 10126, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[10130] = {id = 10130, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[11055] = {id = 11055, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "21"}
, 
[14061] = {id = 14061, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "3"}
, 
[15061] = {id = 15061, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "12"}
, 
[15075] = {id = 15075, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[16061] = {id = 16061, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "12"}
, 
[16075] = {id = 16075, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[17061] = {id = 17061, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "12"}
, 
[17075] = {id = 17075, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[18022] = {id = 18022, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "3"}
, 
[18061] = {id = 18061, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "12"}
, 
[18075] = {id = 18075, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[19003] = {id = 19003, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[19016] = {id = 19016, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "4"}
, 
[19017] = {id = 19017, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "6"}
, 
[19022] = {id = 19022, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "11"}
, 
[19029] = {id = 19029, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[19051] = {id = 19051, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "10"}
, 
[19061] = {id = 19061, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "12"}
, 
[19067] = {id = 19067, actionType = 1, actionAtk = "Attack2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[19075] = {id = 19075, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[100108] = {id = 100108, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[100110] = {id = 100110, actionType = 1, actionAtk = "Attack", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6000101] = {id = 6000101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000102] = {id = 6000102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000103] = {id = 6000103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000104] = {id = 6000104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000105] = {id = 6000105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000201] = {id = 6000201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000202] = {id = 6000202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000203] = {id = 6000203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000204] = {id = 6000204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000205] = {id = 6000205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6000301] = {id = 6000301, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000302] = {id = 6000302, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000303] = {id = 6000303, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000304] = {id = 6000304, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000305] = {id = 6000305, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000401] = {id = 6000401, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6000402] = {id = 6000402, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6000403] = {id = 6000403, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6000404] = {id = 6000404, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6000405] = {id = 6000405, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6000501] = {id = 6000501, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000502] = {id = 6000502, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000503] = {id = 6000503, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000504] = {id = 6000504, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000505] = {id = 6000505, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6000601] = {id = 6000601, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "45"}
, 
[6000602] = {id = 6000602, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "60"}
, 
[6000603] = {id = 6000603, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "90"}
, 
[6000604] = {id = 6000604, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "72"}
, 
[6000605] = {id = 6000605, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "51"}
, 
[6001101] = {id = 6001101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6001102] = {id = 6001102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6001103] = {id = 6001103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6001104] = {id = 6001104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6001105] = {id = 6001105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6001106] = {id = 6001106, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6001107] = {id = 6001107, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6002101] = {id = 6002101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002102] = {id = 6002102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002103] = {id = 6002103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002104] = {id = 6002104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002105] = {id = 6002105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002201] = {id = 6002201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002202] = {id = 6002202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002203] = {id = 6002203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002204] = {id = 6002204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002205] = {id = 6002205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6002206] = {id = 6002206, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003101] = {id = 6003101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003102] = {id = 6003102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003103] = {id = 6003103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003104] = {id = 6003104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003105] = {id = 6003105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003201] = {id = 6003201, actionType = 1, actionAtk = "MagicSummon", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003202] = {id = 6003202, actionType = 1, actionAtk = "MagicSummon", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003203] = {id = 6003203, actionType = 1, actionAtk = "MagicSummon", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003204] = {id = 6003204, actionType = 1, actionAtk = "MagicSummon", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003205] = {id = 6003205, actionType = 1, actionAtk = "MagicSummon", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003301] = {id = 6003301, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003302] = {id = 6003302, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003303] = {id = 6003303, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003304] = {id = 6003304, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6003305] = {id = 6003305, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004101] = {id = 6004101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6004102] = {id = 6004102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6004103] = {id = 6004103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6004104] = {id = 6004104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6004105] = {id = 6004105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6004201] = {id = 6004201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "14"}
, 
[6004202] = {id = 6004202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "14"}
, 
[6004203] = {id = 6004203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "14"}
, 
[6004204] = {id = 6004204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "14"}
, 
[6004205] = {id = 6004205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "14"}
, 
[6004206] = {id = 6004206, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "14"}
, 
[6004301] = {id = 6004301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004302] = {id = 6004302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004303] = {id = 6004303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004304] = {id = 6004304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004305] = {id = 6004305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004401] = {id = 6004401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004402] = {id = 6004402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004403] = {id = 6004403, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004404] = {id = 6004404, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6004405] = {id = 6004405, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6005101] = {id = 6005101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005102] = {id = 6005102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005103] = {id = 6005103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005104] = {id = 6005104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005105] = {id = 6005105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005201] = {id = 6005201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005202] = {id = 6005202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005203] = {id = 6005203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005204] = {id = 6005204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6005205] = {id = 6005205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6006101] = {id = 6006101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6006102] = {id = 6006102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6006103] = {id = 6006103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6006104] = {id = 6006104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6006105] = {id = 6006105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6006201] = {id = 6006201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6006202] = {id = 6006202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6006203] = {id = 6006203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6006204] = {id = 6006204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6006205] = {id = 6006205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6007101] = {id = 6007101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "39"}
, 
[6007102] = {id = 6007102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "39"}
, 
[6007103] = {id = 6007103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "39"}
, 
[6007104] = {id = 6007104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "39"}
, 
[6007105] = {id = 6007105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "39"}
, 
[6007201] = {id = 6007201, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6007202] = {id = 6007202, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6007203] = {id = 6007203, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6007204] = {id = 6007204, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6007205] = {id = 6007205, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6008101] = {id = 6008101, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6008102] = {id = 6008102, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6008103] = {id = 6008103, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6008104] = {id = 6008104, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6008105] = {id = 6008105, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6008201] = {id = 6008201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6008202] = {id = 6008202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6008203] = {id = 6008203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6008204] = {id = 6008204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6008205] = {id = 6008205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6009101] = {id = 6009101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009102] = {id = 6009102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009103] = {id = 6009103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009104] = {id = 6009104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009105] = {id = 6009105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009201] = {id = 6009201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009202] = {id = 6009202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009203] = {id = 6009203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009204] = {id = 6009204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6009205] = {id = 6009205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6010101] = {id = 6010101, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "30"}
, 
[6010102] = {id = 6010102, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "30"}
, 
[6010103] = {id = 6010103, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "30"}
, 
[6010104] = {id = 6010104, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "30"}
, 
[6010105] = {id = 6010105, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "30"}
, 
[6010201] = {id = 6010201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6010202] = {id = 6010202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6010203] = {id = 6010203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6010204] = {id = 6010204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6010205] = {id = 6010205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "1"}
, 
[6011101] = {id = 6011101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "75"}
, 
[6011102] = {id = 6011102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "75"}
, 
[6011103] = {id = 6011103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "75"}
, 
[6011104] = {id = 6011104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "75"}
, 
[6011105] = {id = 6011105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "75"}
, 
[6011106] = {id = 6011106, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6011201] = {id = 6011201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6011202] = {id = 6011202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6011203] = {id = 6011203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6011204] = {id = 6011204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6011205] = {id = 6011205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "24"}
, 
[6012101] = {id = 6012101, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012102] = {id = 6012102, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012103] = {id = 6012103, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012104] = {id = 6012104, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012105] = {id = 6012105, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012201] = {id = 6012201, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012202] = {id = 6012202, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012203] = {id = 6012203, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012204] = {id = 6012204, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012205] = {id = 6012205, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012301] = {id = 6012301, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012302] = {id = 6012302, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012303] = {id = 6012303, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012304] = {id = 6012304, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012305] = {id = 6012305, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012401] = {id = 6012401, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012402] = {id = 6012402, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012403] = {id = 6012403, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012404] = {id = 6012404, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012405] = {id = 6012405, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012501] = {id = 6012501, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012502] = {id = 6012502, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012503] = {id = 6012503, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012504] = {id = 6012504, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012505] = {id = 6012505, actionType = 1, actionAtk = "Magic5", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "35"}
, 
[6012601] = {id = 6012601, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012602] = {id = 6012602, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012603] = {id = 6012603, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012604] = {id = 6012604, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6012605] = {id = 6012605, actionType = 1, actionAtk = "Magic6", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "32"}
, 
[6013101] = {id = 6013101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "56"}
, 
[6013102] = {id = 6013102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "56"}
, 
[6013103] = {id = 6013103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "56"}
, 
[6013104] = {id = 6013104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "56"}
, 
[6013105] = {id = 6013105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "56"}
, 
[6013201] = {id = 6013201, actionType = 2, actionAtk = "Magic3", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "15"}
, 
[6013202] = {id = 6013202, actionType = 2, actionAtk = "Magic3", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "15"}
, 
[6013203] = {id = 6013203, actionType = 2, actionAtk = "Magic3", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "15"}
, 
[6013204] = {id = 6013204, actionType = 2, actionAtk = "Magic3", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "15"}
, 
[6013205] = {id = 6013205, actionType = 2, actionAtk = "Magic3", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "15"}
, 
[6014101] = {id = 6014101, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "4"}
, 
[6014102] = {id = 6014102, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "4"}
, 
[6014103] = {id = 6014103, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "4"}
, 
[6014104] = {id = 6014104, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "4"}
, 
[6014105] = {id = 6014105, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "4"}
, 
[6014201] = {id = 6014201, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6014202] = {id = 6014202, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6014203] = {id = 6014203, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6014204] = {id = 6014204, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6014205] = {id = 6014205, actionType = 2, actionAtk = "SkillDisappear", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6014301] = {id = 6014301, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6014302] = {id = 6014302, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6014303] = {id = 6014303, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6014304] = {id = 6014304, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6014305] = {id = 6014305, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6014401] = {id = 6014401, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6014402] = {id = 6014402, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6014403] = {id = 6014403, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6014404] = {id = 6014404, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6014405] = {id = 6014405, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6015101] = {id = 6015101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6015102] = {id = 6015102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6015103] = {id = 6015103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6015104] = {id = 6015104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6015105] = {id = 6015105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "6"}
, 
[6015201] = {id = 6015201, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "10"}
, 
[6015202] = {id = 6015202, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "10"}
, 
[6015203] = {id = 6015203, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "10"}
, 
[6015204] = {id = 6015204, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "10"}
, 
[6015205] = {id = 6015205, actionType = 2, actionAtk = "Attack", skillStart = "AttackStart", skillLoop = "AttackLoop", skillEnd = "AttackEnd", loopTime = "10"}
, 
[6016101] = {id = 6016101, actionType = 1, actionAtk = "Magic3", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016102] = {id = 6016102, actionType = 1, actionAtk = "Magic3", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016103] = {id = 6016103, actionType = 1, actionAtk = "Magic3", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016104] = {id = 6016104, actionType = 1, actionAtk = "Magic3", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016105] = {id = 6016105, actionType = 1, actionAtk = "Magic3", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016201] = {id = 6016201, actionType = 1, actionAtk = "Magic4", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016202] = {id = 6016202, actionType = 1, actionAtk = "Magic4", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016203] = {id = 6016203, actionType = 1, actionAtk = "Magic4", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016204] = {id = 6016204, actionType = 1, actionAtk = "Magic4", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6016205] = {id = 6016205, actionType = 1, actionAtk = "Magic4", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6017101] = {id = 6017101, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017102] = {id = 6017102, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017103] = {id = 6017103, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017104] = {id = 6017104, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017105] = {id = 6017105, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017201] = {id = 6017201, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "82"}
, 
[6017202] = {id = 6017202, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "82"}
, 
[6017203] = {id = 6017203, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "82"}
, 
[6017204] = {id = 6017204, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "82"}
, 
[6017205] = {id = 6017205, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "82"}
, 
[6017301] = {id = 6017301, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017302] = {id = 6017302, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017303] = {id = 6017303, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017304] = {id = 6017304, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017305] = {id = 6017305, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6017401] = {id = 6017401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6017402] = {id = 6017402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6017403] = {id = 6017403, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6017404] = {id = 6017404, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6017405] = {id = 6017405, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6018101] = {id = 6018101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "11"}
, 
[6018102] = {id = 6018102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "11"}
, 
[6018103] = {id = 6018103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "11"}
, 
[6018104] = {id = 6018104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "11"}
, 
[6018105] = {id = 6018105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "11"}
, 
[6018201] = {id = 6018201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6018202] = {id = 6018202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6018203] = {id = 6018203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6018204] = {id = 6018204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6018205] = {id = 6018205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6019101] = {id = 6019101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019102] = {id = 6019102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019103] = {id = 6019103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019104] = {id = 6019104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019105] = {id = 6019105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019201] = {id = 6019201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019202] = {id = 6019202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019203] = {id = 6019203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019204] = {id = 6019204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6019205] = {id = 6019205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6020101] = {id = 6020101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6020102] = {id = 6020102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6020103] = {id = 6020103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6020104] = {id = 6020104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6020105] = {id = 6020105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "3"}
, 
[6020201] = {id = 6020201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6020202] = {id = 6020202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6020203] = {id = 6020203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6020204] = {id = 6020204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6020205] = {id = 6020205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6021101] = {id = 6021101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "48"}
, 
[6021102] = {id = 6021102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "48"}
, 
[6021103] = {id = 6021103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "48"}
, 
[6021104] = {id = 6021104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "48"}
, 
[6021105] = {id = 6021105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "48"}
, 
[6021201] = {id = 6021201, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6021202] = {id = 6021202, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6021203] = {id = 6021203, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6021204] = {id = 6021204, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6021205] = {id = 6021205, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6022101] = {id = 6022101, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "171"}
, 
[6022102] = {id = 6022102, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "171"}
, 
[6022103] = {id = 6022103, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "171"}
, 
[6022104] = {id = 6022104, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "171"}
, 
[6022105] = {id = 6022105, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "171"}
, 
[6022201] = {id = 6022201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6022202] = {id = 6022202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6022203] = {id = 6022203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6022204] = {id = 6022204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6022205] = {id = 6022205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6022301] = {id = 6022301, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6022401] = {id = 6022401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6022402] = {id = 6022402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6022403] = {id = 6022403, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6022404] = {id = 6022404, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6022405] = {id = 6022405, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023101] = {id = 6023101, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023102] = {id = 6023102, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023103] = {id = 6023103, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023104] = {id = 6023104, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023105] = {id = 6023105, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023201] = {id = 6023201, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023202] = {id = 6023202, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023203] = {id = 6023203, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023204] = {id = 6023204, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023205] = {id = 6023205, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023301] = {id = 6023301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023302] = {id = 6023302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023303] = {id = 6023303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023304] = {id = 6023304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023305] = {id = 6023305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023401] = {id = 6023401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023402] = {id = 6023402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023403] = {id = 6023403, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023404] = {id = 6023404, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6023405] = {id = 6023405, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6024101] = {id = 6024101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "22"}
, 
[6024102] = {id = 6024102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "22"}
, 
[6024103] = {id = 6024103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "22"}
, 
[6024104] = {id = 6024104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "22"}
, 
[6024105] = {id = 6024105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "22"}
, 
[6024201] = {id = 6024201, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024202] = {id = 6024202, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024203] = {id = 6024203, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024204] = {id = 6024204, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024205] = {id = 6024205, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024301] = {id = 6024301, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024302] = {id = 6024302, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024303] = {id = 6024303, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024304] = {id = 6024304, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024305] = {id = 6024305, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024401] = {id = 6024401, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024402] = {id = 6024402, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024403] = {id = 6024403, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024404] = {id = 6024404, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6024405] = {id = 6024405, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "50"}
, 
[6025101] = {id = 6025101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025102] = {id = 6025102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025103] = {id = 6025103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025104] = {id = 6025104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025105] = {id = 6025105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025201] = {id = 6025201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6025202] = {id = 6025202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6025203] = {id = 6025203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6025204] = {id = 6025204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6025205] = {id = 6025205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6025301] = {id = 6025301, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025302] = {id = 6025302, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025303] = {id = 6025303, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025304] = {id = 6025304, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025305] = {id = 6025305, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025401] = {id = 6025401, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025402] = {id = 6025402, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025403] = {id = 6025403, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025404] = {id = 6025404, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6025405] = {id = 6025405, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "31"}
, 
[6026101] = {id = 6026101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "33"}
, 
[6026102] = {id = 6026102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "33"}
, 
[6026103] = {id = 6026103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "33"}
, 
[6026104] = {id = 6026104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "33"}
, 
[6026105] = {id = 6026105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "33"}
, 
[6026201] = {id = 6026201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "37"}
, 
[6026202] = {id = 6026202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "37"}
, 
[6026203] = {id = 6026203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "37"}
, 
[6026204] = {id = 6026204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "37"}
, 
[6026205] = {id = 6026205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "37"}
, 
[6027101] = {id = 6027101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "29"}
, 
[6027102] = {id = 6027102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "29"}
, 
[6027103] = {id = 6027103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "29"}
, 
[6027104] = {id = 6027104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "29"}
, 
[6027105] = {id = 6027105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "29"}
, 
[6027201] = {id = 6027201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6027202] = {id = 6027202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6027203] = {id = 6027203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6027204] = {id = 6027204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6027205] = {id = 6027205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6028101] = {id = 6028101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6028102] = {id = 6028102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6028103] = {id = 6028103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6028104] = {id = 6028104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6028105] = {id = 6028105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6028201] = {id = 6028201, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "64"}
, 
[6028202] = {id = 6028202, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "64"}
, 
[6028203] = {id = 6028203, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "64"}
, 
[6028204] = {id = 6028204, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "64"}
, 
[6028205] = {id = 6028205, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "64"}
, 
[6029101] = {id = 6029101, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "4"}
, 
[6029102] = {id = 6029102, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "4"}
, 
[6029103] = {id = 6029103, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "4"}
, 
[6029104] = {id = 6029104, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "4"}
, 
[6029105] = {id = 6029105, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "4"}
, 
[6029201] = {id = 6029201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6029202] = {id = 6029202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6029203] = {id = 6029203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6029204] = {id = 6029204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6029205] = {id = 6029205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "40"}
, 
[6030101] = {id = 6030101, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030102] = {id = 6030102, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030103] = {id = 6030103, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030104] = {id = 6030104, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030105] = {id = 6030105, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030201] = {id = 6030201, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6030202] = {id = 6030202, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6030203] = {id = 6030203, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6030204] = {id = 6030204, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6030205] = {id = 6030205, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6030301] = {id = 6030301, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030302] = {id = 6030302, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030303] = {id = 6030303, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030304] = {id = 6030304, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030305] = {id = 6030305, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030401] = {id = 6030401, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030402] = {id = 6030402, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030403] = {id = 6030403, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030404] = {id = 6030404, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030405] = {id = 6030405, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030501] = {id = 6030501, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030502] = {id = 6030502, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030503] = {id = 6030503, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030504] = {id = 6030504, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030505] = {id = 6030505, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030601] = {id = 6030601, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030602] = {id = 6030602, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030603] = {id = 6030603, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030604] = {id = 6030604, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030605] = {id = 6030605, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6030701] = {id = 6030701, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030702] = {id = 6030702, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030703] = {id = 6030703, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030704] = {id = 6030704, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030705] = {id = 6030705, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030801] = {id = 6030801, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030802] = {id = 6030802, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030803] = {id = 6030803, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030804] = {id = 6030804, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6030805] = {id = 6030805, actionType = 2, actionAtk = "Magic", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "6"}
, 
[6032101] = {id = 6032101, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6032102] = {id = 6032102, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6032103] = {id = 6032103, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6032104] = {id = 6032104, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6032105] = {id = 6032105, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6032201] = {id = 6032201, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "13"}
, 
[6032202] = {id = 6032202, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "13"}
, 
[6032203] = {id = 6032203, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "13"}
, 
[6032204] = {id = 6032204, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "13"}
, 
[6032205] = {id = 6032205, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "13"}
, 
[6033101] = {id = 6033101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6033102] = {id = 6033102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6033103] = {id = 6033103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6033104] = {id = 6033104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6033105] = {id = 6033105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6033201] = {id = 6033201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "24"}
, 
[6033202] = {id = 6033202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "24"}
, 
[6033203] = {id = 6033203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "24"}
, 
[6033204] = {id = 6033204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "24"}
, 
[6033205] = {id = 6033205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "24"}
, 
[6034101] = {id = 6034101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6034102] = {id = 6034102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6034103] = {id = 6034103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6034104] = {id = 6034104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6034105] = {id = 6034105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6034201] = {id = 6034201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "59"}
, 
[6034202] = {id = 6034202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "59"}
, 
[6034203] = {id = 6034203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "59"}
, 
[6034204] = {id = 6034204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "59"}
, 
[6034205] = {id = 6034205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "59"}
, 
[6035101] = {id = 6035101, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6035102] = {id = 6035102, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6035103] = {id = 6035103, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6035104] = {id = 6035104, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6035105] = {id = 6035105, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6035201] = {id = 6035201, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6035202] = {id = 6035202, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6035203] = {id = 6035203, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6035204] = {id = 6035204, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6035205] = {id = 6035205, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6035301] = {id = 6035301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035302] = {id = 6035302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035303] = {id = 6035303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035304] = {id = 6035304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035305] = {id = 6035305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035401] = {id = 6035401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035402] = {id = 6035402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035403] = {id = 6035403, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035404] = {id = 6035404, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6035405] = {id = 6035405, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6036101] = {id = 6036101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "39"}
, 
[6036102] = {id = 6036102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "39"}
, 
[6036103] = {id = 6036103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "39"}
, 
[6036104] = {id = 6036104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "39"}
, 
[6036105] = {id = 6036105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "39"}
, 
[6036201] = {id = 6036201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6036202] = {id = 6036202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6036203] = {id = 6036203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6036204] = {id = 6036204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6036205] = {id = 6036205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "30"}
, 
[6038101] = {id = 6038101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038102] = {id = 6038102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038103] = {id = 6038103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038104] = {id = 6038104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038105] = {id = 6038105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038201] = {id = 6038201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038202] = {id = 6038202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038203] = {id = 6038203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038204] = {id = 6038204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038205] = {id = 6038205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038301] = {id = 6038301, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038302] = {id = 6038302, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038303] = {id = 6038303, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038304] = {id = 6038304, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038305] = {id = 6038305, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038401] = {id = 6038401, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038402] = {id = 6038402, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038403] = {id = 6038403, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038404] = {id = 6038404, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038405] = {id = 6038405, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038501] = {id = 6038501, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038502] = {id = 6038502, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038503] = {id = 6038503, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038504] = {id = 6038504, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038505] = {id = 6038505, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038601] = {id = 6038601, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038602] = {id = 6038602, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038603] = {id = 6038603, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038604] = {id = 6038604, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038605] = {id = 6038605, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038701] = {id = 6038701, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038702] = {id = 6038702, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038703] = {id = 6038703, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038704] = {id = 6038704, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038705] = {id = 6038705, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038801] = {id = 6038801, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038802] = {id = 6038802, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038803] = {id = 6038803, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038804] = {id = 6038804, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038805] = {id = 6038805, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6038901] = {id = 6038901, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038902] = {id = 6038902, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038903] = {id = 6038903, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038904] = {id = 6038904, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038905] = {id = 6038905, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6038906] = {id = 6038906, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039101] = {id = 6039101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039102] = {id = 6039102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039103] = {id = 6039103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039104] = {id = 6039104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039105] = {id = 6039105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039106] = {id = 6039106, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039111] = {id = 6039111, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039112] = {id = 6039112, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039113] = {id = 6039113, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039114] = {id = 6039114, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039115] = {id = 6039115, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039201] = {id = 6039201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039202] = {id = 6039202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039203] = {id = 6039203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039204] = {id = 6039204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039205] = {id = 6039205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039301] = {id = 6039301, actionType = 1, actionAtk = "Magic3Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039302] = {id = 6039302, actionType = 1, actionAtk = "Magic3Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039303] = {id = 6039303, actionType = 1, actionAtk = "Magic3Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039304] = {id = 6039304, actionType = 1, actionAtk = "Magic3Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6039305] = {id = 6039305, actionType = 1, actionAtk = "Magic3Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6041101] = {id = 6041101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6041102] = {id = 6041102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6041103] = {id = 6041103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6041104] = {id = 6041104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6041105] = {id = 6041105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6041201] = {id = 6041201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041202] = {id = 6041202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041203] = {id = 6041203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041204] = {id = 6041204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041205] = {id = 6041205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041301] = {id = 6041301, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041302] = {id = 6041302, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041303] = {id = 6041303, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041304] = {id = 6041304, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041305] = {id = 6041305, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041401] = {id = 6041401, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041402] = {id = 6041402, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041403] = {id = 6041403, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041404] = {id = 6041404, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6041405] = {id = 6041405, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "26"}
, 
[6042101] = {id = 6042101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6042102] = {id = 6042102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6042103] = {id = 6042103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6042104] = {id = 6042104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6042105] = {id = 6042105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6042201] = {id = 6042201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "97"}
, 
[6042202] = {id = 6042202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "97"}
, 
[6042203] = {id = 6042203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "97"}
, 
[6042204] = {id = 6042204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "97"}
, 
[6042205] = {id = 6042205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "97"}
, 
[6043101] = {id = 6043101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "90"}
, 
[6043102] = {id = 6043102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "90"}
, 
[6043103] = {id = 6043103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "90"}
, 
[6043104] = {id = 6043104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "90"}
, 
[6043105] = {id = 6043105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "90"}
, 
[6043201] = {id = 6043201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6043202] = {id = 6043202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6043203] = {id = 6043203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6043204] = {id = 6043204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6043205] = {id = 6043205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "26"}
, 
[6044101] = {id = 6044101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6044102] = {id = 6044102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6044103] = {id = 6044103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6044104] = {id = 6044104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6044105] = {id = 6044105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "19"}
, 
[6044201] = {id = 6044201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "19"}
, 
[6044202] = {id = 6044202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "19"}
, 
[6044203] = {id = 6044203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "19"}
, 
[6044204] = {id = 6044204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "19"}
, 
[6044205] = {id = 6044205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "19"}
, 
[6045101] = {id = 6045101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "48"}
, 
[6045102] = {id = 6045102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "48"}
, 
[6045103] = {id = 6045103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "48"}
, 
[6045104] = {id = 6045104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "48"}
, 
[6045105] = {id = 6045105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "48"}
, 
[6045201] = {id = 6045201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6045202] = {id = 6045202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6045203] = {id = 6045203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6045204] = {id = 6045204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6045205] = {id = 6045205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6047101] = {id = 6047101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6047102] = {id = 6047102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6047103] = {id = 6047103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6047104] = {id = 6047104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6047105] = {id = 6047105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6047201] = {id = 6047201, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "28"}
, 
[6047202] = {id = 6047202, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "28"}
, 
[6047203] = {id = 6047203, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "28"}
, 
[6047204] = {id = 6047204, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "28"}
, 
[6047205] = {id = 6047205, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "28"}
, 
[6048101] = {id = 6048101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6048102] = {id = 6048102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6048103] = {id = 6048103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6048104] = {id = 6048104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6048105] = {id = 6048105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "29"}
, 
[6048201] = {id = 6048201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6048202] = {id = 6048202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6048203] = {id = 6048203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6048204] = {id = 6048204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6048205] = {id = 6048205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6049101] = {id = 6049101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "44"}
, 
[6049102] = {id = 6049102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "44"}
, 
[6049103] = {id = 6049103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "44"}
, 
[6049104] = {id = 6049104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "44"}
, 
[6049105] = {id = 6049105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "44"}
, 
[6049201] = {id = 6049201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6049202] = {id = 6049202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6049203] = {id = 6049203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6049204] = {id = 6049204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6049205] = {id = 6049205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "32"}
, 
[6051101] = {id = 6051101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "15"}
, 
[6051102] = {id = 6051102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "15"}
, 
[6051103] = {id = 6051103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "15"}
, 
[6051104] = {id = 6051104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "15"}
, 
[6051105] = {id = 6051105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "15"}
, 
[6051201] = {id = 6051201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6051202] = {id = 6051202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6051203] = {id = 6051203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6051204] = {id = 6051204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6051205] = {id = 6051205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "12"}
, 
[6052101] = {id = 6052101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "17"}
, 
[6052102] = {id = 6052102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "17"}
, 
[6052103] = {id = 6052103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "17"}
, 
[6052104] = {id = 6052104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "17"}
, 
[6052105] = {id = 6052105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "17"}
, 
[6052201] = {id = 6052201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6052202] = {id = 6052202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6052203] = {id = 6052203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6052204] = {id = 6052204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6052205] = {id = 6052205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6053101] = {id = 6053101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "15"}
, 
[6053102] = {id = 6053102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6053103] = {id = 6053103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6053104] = {id = 6053104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6053105] = {id = 6053105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6053201] = {id = 6053201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6053202] = {id = 6053202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6053203] = {id = 6053203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6053204] = {id = 6053204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6053205] = {id = 6053205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "15"}
, 
[6054101] = {id = 6054101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6054102] = {id = 6054102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6054103] = {id = 6054103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6054104] = {id = 6054104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6054105] = {id = 6054105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "150"}
, 
[6054201] = {id = 6054201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6054202] = {id = 6054202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6054203] = {id = 6054203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6054204] = {id = 6054204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6054205] = {id = 6054205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6055101] = {id = 6055101, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "18"}
, 
[6055102] = {id = 6055102, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "18"}
, 
[6055103] = {id = 6055103, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "18"}
, 
[6055104] = {id = 6055104, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "18"}
, 
[6055105] = {id = 6055105, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "18"}
, 
[6055201] = {id = 6055201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "62"}
, 
[6055202] = {id = 6055202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "62"}
, 
[6055203] = {id = 6055203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "62"}
, 
[6055204] = {id = 6055204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "62"}
, 
[6055205] = {id = 6055205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "62"}
, 
[6055301] = {id = 6055301, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6055302] = {id = 6055302, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6055303] = {id = 6055303, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6055304] = {id = 6055304, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6055305] = {id = 6055305, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "18"}
, 
[6055401] = {id = 6055401, actionType = 2, actionAtk = "Magic", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "18"}
, 
[6055402] = {id = 6055402, actionType = 2, actionAtk = "Magic", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "18"}
, 
[6055403] = {id = 6055403, actionType = 2, actionAtk = "Magic", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "18"}
, 
[6055404] = {id = 6055404, actionType = 2, actionAtk = "Magic", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "18"}
, 
[6055405] = {id = 6055405, actionType = 2, actionAtk = "Magic", skillStart = "Magic3Start", skillLoop = "Magic3Loop", skillEnd = "Magic3End", loopTime = "18"}
, 
[6056101] = {id = 6056101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6056102] = {id = 6056102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6056103] = {id = 6056103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6056104] = {id = 6056104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6056105] = {id = 6056105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "20"}
, 
[6056201] = {id = 6056201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6056202] = {id = 6056202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6056203] = {id = 6056203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6056204] = {id = 6056204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6056205] = {id = 6056205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6057101] = {id = 6057101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "16"}
, 
[6057102] = {id = 6057102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "16"}
, 
[6057103] = {id = 6057103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "16"}
, 
[6057104] = {id = 6057104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "16"}
, 
[6057105] = {id = 6057105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "16"}
, 
[6057201] = {id = 6057201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6057202] = {id = 6057202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6057203] = {id = 6057203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6057204] = {id = 6057204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6057205] = {id = 6057205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6059101] = {id = 6059101, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6059102] = {id = 6059102, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6059103] = {id = 6059103, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6059104] = {id = 6059104, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6059105] = {id = 6059105, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[6059201] = {id = 6059201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059202] = {id = 6059202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059203] = {id = 6059203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059204] = {id = 6059204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059205] = {id = 6059205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059301] = {id = 6059301, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059302] = {id = 6059302, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059303] = {id = 6059303, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059304] = {id = 6059304, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6059305] = {id = 6059305, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "10"}
, 
[6060101] = {id = 6060101, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060102] = {id = 6060102, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060103] = {id = 6060103, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060104] = {id = 6060104, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060105] = {id = 6060105, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060201] = {id = 6060201, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060202] = {id = 6060202, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060203] = {id = 6060203, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060204] = {id = 6060204, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6060205] = {id = 6060205, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "13"}
, 
[6061101] = {id = 6061101, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061102] = {id = 6061102, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061103] = {id = 6061103, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061104] = {id = 6061104, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061105] = {id = 6061105, actionType = 2, actionAtk = "Attack", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061201] = {id = 6061201, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6061202] = {id = 6061202, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6061203] = {id = 6061203, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6061204] = {id = 6061204, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6061205] = {id = 6061205, actionType = 2, actionAtk = "Attack", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "20"}
, 
[6061301] = {id = 6061301, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061302] = {id = 6061302, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061303] = {id = 6061303, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061304] = {id = 6061304, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061305] = {id = 6061305, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "7"}
, 
[6061401] = {id = 6061401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6061402] = {id = 6061402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "1"}
, 
[6063101] = {id = 6063101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063102] = {id = 6063102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063103] = {id = 6063103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063104] = {id = 6063104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063105] = {id = 6063105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063201] = {id = 6063201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063202] = {id = 6063202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063203] = {id = 6063203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063204] = {id = 6063204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063205] = {id = 6063205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063301] = {id = 6063301, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063302] = {id = 6063302, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063303] = {id = 6063303, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063304] = {id = 6063304, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6063305] = {id = 6063305, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064101] = {id = 6064101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064102] = {id = 6064102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064103] = {id = 6064103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064104] = {id = 6064104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064105] = {id = 6064105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064201] = {id = 6064201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064202] = {id = 6064202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064203] = {id = 6064203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064204] = {id = 6064204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6064205] = {id = 6064205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6065101] = {id = 6065101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6065102] = {id = 6065102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6065103] = {id = 6065103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6065104] = {id = 6065104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6065105] = {id = 6065105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6065106] = {id = 6065106, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "5"}
, 
[6065201] = {id = 6065201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "25"}
, 
[6065202] = {id = 6065202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "25"}
, 
[6065203] = {id = 6065203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "25"}
, 
[6065204] = {id = 6065204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "25"}
, 
[6065205] = {id = 6065205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "25"}
, 
[6066101] = {id = 6066101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066102] = {id = 6066102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066103] = {id = 6066103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066104] = {id = 6066104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066105] = {id = 6066105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066201] = {id = 6066201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066202] = {id = 6066202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066203] = {id = 6066203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066204] = {id = 6066204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066205] = {id = 6066205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066301] = {id = 6066301, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066302] = {id = 6066302, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066303] = {id = 6066303, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066304] = {id = 6066304, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066305] = {id = 6066305, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066401] = {id = 6066401, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066402] = {id = 6066402, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066403] = {id = 6066403, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066404] = {id = 6066404, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6066405] = {id = 6066405, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6067101] = {id = 6067101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "23"}
, 
[6067102] = {id = 6067102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "23"}
, 
[6067103] = {id = 6067103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "23"}
, 
[6067104] = {id = 6067104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "23"}
, 
[6067105] = {id = 6067105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "23"}
, 
[6067201] = {id = 6067201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "46"}
, 
[6067202] = {id = 6067202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "46"}
, 
[6067203] = {id = 6067203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "46"}
, 
[6067204] = {id = 6067204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "46"}
, 
[6067205] = {id = 6067205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "46"}
, 
[6067301] = {id = 6067301, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6067302] = {id = 6067302, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6067303] = {id = 6067303, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6067304] = {id = 6067304, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6067305] = {id = 6067305, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "30"}
, 
[6068101] = {id = 6068101, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068102] = {id = 6068102, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068103] = {id = 6068103, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068104] = {id = 6068104, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068105] = {id = 6068105, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068201] = {id = 6068201, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "25"}
, 
[6068202] = {id = 6068202, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "25"}
, 
[6068203] = {id = 6068203, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "25"}
, 
[6068204] = {id = 6068204, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "25"}
, 
[6068205] = {id = 6068205, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "25"}
, 
[6068501] = {id = 6068501, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068502] = {id = 6068502, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068503] = {id = 6068503, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068504] = {id = 6068504, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068505] = {id = 6068505, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068601] = {id = 6068601, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068602] = {id = 6068602, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068603] = {id = 6068603, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068604] = {id = 6068604, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6068605] = {id = 6068605, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "40"}
, 
[6069101] = {id = 6069101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6069102] = {id = 6069102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6069103] = {id = 6069103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6069104] = {id = 6069104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6069105] = {id = 6069105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "30"}
, 
[6069201] = {id = 6069201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "40"}
, 
[6069202] = {id = 6069202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "40"}
, 
[6069203] = {id = 6069203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "40"}
, 
[6069204] = {id = 6069204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "40"}
, 
[6069205] = {id = 6069205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "40"}
, 
[6070101] = {id = 6070101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070102] = {id = 6070102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070103] = {id = 6070103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070104] = {id = 6070104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070105] = {id = 6070105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070201] = {id = 6070201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070202] = {id = 6070202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070203] = {id = 6070203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070204] = {id = 6070204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070205] = {id = 6070205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070301] = {id = 6070301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070302] = {id = 6070302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070303] = {id = 6070303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070304] = {id = 6070304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070305] = {id = 6070305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070401] = {id = 6070401, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070402] = {id = 6070402, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070403] = {id = 6070403, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070404] = {id = 6070404, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6070405] = {id = 6070405, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071101] = {id = 6071101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071102] = {id = 6071102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071103] = {id = 6071103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071104] = {id = 6071104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071105] = {id = 6071105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071201] = {id = 6071201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071202] = {id = 6071202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071203] = {id = 6071203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071204] = {id = 6071204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6071205] = {id = 6071205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6072101] = {id = 6072101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "21"}
, 
[6072102] = {id = 6072102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "21"}
, 
[6072103] = {id = 6072103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "21"}
, 
[6072104] = {id = 6072104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "21"}
, 
[6072105] = {id = 6072105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "21"}
, 
[6072201] = {id = 6072201, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "33"}
, 
[6072202] = {id = 6072202, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "33"}
, 
[6072203] = {id = 6072203, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "33"}
, 
[6072204] = {id = 6072204, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "33"}
, 
[6072205] = {id = 6072205, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "33"}
, 
[6072301] = {id = 6072301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6072302] = {id = 6072302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6072303] = {id = 6072303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6072304] = {id = 6072304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6072305] = {id = 6072305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073101] = {id = 6073101, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073102] = {id = 6073102, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073103] = {id = 6073103, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073104] = {id = 6073104, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073105] = {id = 6073105, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073201] = {id = 6073201, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073202] = {id = 6073202, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073203] = {id = 6073203, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073204] = {id = 6073204, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073205] = {id = 6073205, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073301] = {id = 6073301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073302] = {id = 6073302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073303] = {id = 6073303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073304] = {id = 6073304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073305] = {id = 6073305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6073401] = {id = 6073401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6074101] = {id = 6074101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "33"}
, 
[6074102] = {id = 6074102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "33"}
, 
[6074103] = {id = 6074103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "33"}
, 
[6074104] = {id = 6074104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "33"}
, 
[6074105] = {id = 6074105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "33"}
, 
[6074201] = {id = 6074201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "34"}
, 
[6074202] = {id = 6074202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "34"}
, 
[6074203] = {id = 6074203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "34"}
, 
[6074204] = {id = 6074204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "34"}
, 
[6074205] = {id = 6074205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = "34"}
, 
[6075101] = {id = 6075101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075102] = {id = 6075102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075103] = {id = 6075103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075104] = {id = 6075104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075105] = {id = 6075105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075201] = {id = 6075201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075202] = {id = 6075202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075203] = {id = 6075203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075204] = {id = 6075204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075205] = {id = 6075205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075301] = {id = 6075301, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075302] = {id = 6075302, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075303] = {id = 6075303, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075304] = {id = 6075304, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6075305] = {id = 6075305, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6076101] = {id = 6076101, actionType = 2, actionAtk = "", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6076102] = {id = 6076102, actionType = 2, actionAtk = "", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6076103] = {id = 6076103, actionType = 2, actionAtk = "", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6076104] = {id = 6076104, actionType = 2, actionAtk = "", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6076105] = {id = 6076105, actionType = 2, actionAtk = "", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[6076201] = {id = 6076201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6076202] = {id = 6076202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6076203] = {id = 6076203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6076204] = {id = 6076204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6076205] = {id = 6076205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078101] = {id = 6078101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078102] = {id = 6078102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078103] = {id = 6078103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078104] = {id = 6078104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078105] = {id = 6078105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078201] = {id = 6078201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078202] = {id = 6078202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078203] = {id = 6078203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078204] = {id = 6078204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6078205] = {id = 6078205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079101] = {id = 6079101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079102] = {id = 6079102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079103] = {id = 6079103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079104] = {id = 6079104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079105] = {id = 6079105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079201] = {id = 6079201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079202] = {id = 6079202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079203] = {id = 6079203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079204] = {id = 6079204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6079205] = {id = 6079205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080101] = {id = 6080101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080102] = {id = 6080102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080103] = {id = 6080103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080104] = {id = 6080104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080105] = {id = 6080105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080201] = {id = 6080201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080202] = {id = 6080202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080203] = {id = 6080203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080204] = {id = 6080204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6080205] = {id = 6080205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081101] = {id = 6081101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081102] = {id = 6081102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081103] = {id = 6081103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081104] = {id = 6081104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081105] = {id = 6081105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081201] = {id = 6081201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081202] = {id = 6081202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081203] = {id = 6081203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081204] = {id = 6081204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081205] = {id = 6081205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6081301] = {id = 6081301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082101] = {id = 6082101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082102] = {id = 6082102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082103] = {id = 6082103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082104] = {id = 6082104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082105] = {id = 6082105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082201] = {id = 6082201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082202] = {id = 6082202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082203] = {id = 6082203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082204] = {id = 6082204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082205] = {id = 6082205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082301] = {id = 6082301, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082302] = {id = 6082302, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082303] = {id = 6082303, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082304] = {id = 6082304, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6082305] = {id = 6082305, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083101] = {id = 6083101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083102] = {id = 6083102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083103] = {id = 6083103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083104] = {id = 6083104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083105] = {id = 6083105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083201] = {id = 6083201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083202] = {id = 6083202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083203] = {id = 6083203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083204] = {id = 6083204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083205] = {id = 6083205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083301] = {id = 6083301, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083302] = {id = 6083302, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083303] = {id = 6083303, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083304] = {id = 6083304, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6083305] = {id = 6083305, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084101] = {id = 6084101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084102] = {id = 6084102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084103] = {id = 6084103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084104] = {id = 6084104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084105] = {id = 6084105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084111] = {id = 6084111, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084112] = {id = 6084112, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084113] = {id = 6084113, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084201] = {id = 6084201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084202] = {id = 6084202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084203] = {id = 6084203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084204] = {id = 6084204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084205] = {id = 6084205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084211] = {id = 6084211, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084212] = {id = 6084212, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6084213] = {id = 6084213, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085101] = {id = 6085101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085102] = {id = 6085102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085103] = {id = 6085103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085104] = {id = 6085104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085105] = {id = 6085105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085111] = {id = 6085111, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085112] = {id = 6085112, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085113] = {id = 6085113, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085114] = {id = 6085114, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085115] = {id = 6085115, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085121] = {id = 6085121, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085201] = {id = 6085201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085202] = {id = 6085202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085203] = {id = 6085203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085204] = {id = 6085204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085205] = {id = 6085205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085211] = {id = 6085211, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085212] = {id = 6085212, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085213] = {id = 6085213, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085214] = {id = 6085214, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085215] = {id = 6085215, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6085221] = {id = 6085221, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086101] = {id = 6086101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086102] = {id = 6086102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086103] = {id = 6086103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086104] = {id = 6086104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086105] = {id = 6086105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086201] = {id = 6086201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086202] = {id = 6086202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086203] = {id = 6086203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086204] = {id = 6086204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6086205] = {id = 6086205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088101] = {id = 6088101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088102] = {id = 6088102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088103] = {id = 6088103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088104] = {id = 6088104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088105] = {id = 6088105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088111] = {id = 6088111, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088112] = {id = 6088112, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088113] = {id = 6088113, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088114] = {id = 6088114, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088115] = {id = 6088115, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088201] = {id = 6088201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088202] = {id = 6088202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088203] = {id = 6088203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088204] = {id = 6088204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088205] = {id = 6088205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6088211] = {id = 6088211, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089101] = {id = 6089101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089102] = {id = 6089102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089103] = {id = 6089103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089104] = {id = 6089104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089105] = {id = 6089105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089201] = {id = 6089201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089202] = {id = 6089202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089203] = {id = 6089203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089204] = {id = 6089204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6089205] = {id = 6089205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090101] = {id = 6090101, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090102] = {id = 6090102, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090103] = {id = 6090103, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090104] = {id = 6090104, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090105] = {id = 6090105, actionType = 1, actionAtk = "Magic", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090201] = {id = 6090201, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090202] = {id = 6090202, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090203] = {id = 6090203, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090204] = {id = 6090204, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6090205] = {id = 6090205, actionType = 1, actionAtk = "Magic2", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091101] = {id = 6091101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091102] = {id = 6091102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091103] = {id = 6091103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091104] = {id = 6091104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091105] = {id = 6091105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091201] = {id = 6091201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091202] = {id = 6091202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091203] = {id = 6091203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091204] = {id = 6091204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091205] = {id = 6091205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091301] = {id = 6091301, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091302] = {id = 6091302, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091303] = {id = 6091303, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091304] = {id = 6091304, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6091305] = {id = 6091305, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092101] = {id = 6092101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092102] = {id = 6092102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092103] = {id = 6092103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092104] = {id = 6092104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092105] = {id = 6092105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092201] = {id = 6092201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092202] = {id = 6092202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092203] = {id = 6092203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092204] = {id = 6092204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092205] = {id = 6092205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6092301] = {id = 6092301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093101] = {id = 6093101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093102] = {id = 6093102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093103] = {id = 6093103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093104] = {id = 6093104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093105] = {id = 6093105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093201] = {id = 6093201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093202] = {id = 6093202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093203] = {id = 6093203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093204] = {id = 6093204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093205] = {id = 6093205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6093206] = {id = 6093206, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094101] = {id = 6094101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094102] = {id = 6094102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094103] = {id = 6094103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094104] = {id = 6094104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094105] = {id = 6094105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094201] = {id = 6094201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094202] = {id = 6094202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094203] = {id = 6094203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094204] = {id = 6094204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6094205] = {id = 6094205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095101] = {id = 6095101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095102] = {id = 6095102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095103] = {id = 6095103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095104] = {id = 6095104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095105] = {id = 6095105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095201] = {id = 6095201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095202] = {id = 6095202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095203] = {id = 6095203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095204] = {id = 6095204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095205] = {id = 6095205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095301] = {id = 6095301, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095302] = {id = 6095302, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095303] = {id = 6095303, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095304] = {id = 6095304, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6095305] = {id = 6095305, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097101] = {id = 6097101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097102] = {id = 6097102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097103] = {id = 6097103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097104] = {id = 6097104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097105] = {id = 6097105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097201] = {id = 6097201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097202] = {id = 6097202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097203] = {id = 6097203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097204] = {id = 6097204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097205] = {id = 6097205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097301] = {id = 6097301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097302] = {id = 6097302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097303] = {id = 6097303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097304] = {id = 6097304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6097305] = {id = 6097305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098101] = {id = 6098101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098102] = {id = 6098102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098103] = {id = 6098103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098104] = {id = 6098104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098105] = {id = 6098105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098201] = {id = 6098201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098202] = {id = 6098202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098203] = {id = 6098203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098204] = {id = 6098204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098205] = {id = 6098205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6098211] = {id = 6098211, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099101] = {id = 6099101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099102] = {id = 6099102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099103] = {id = 6099103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099104] = {id = 6099104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099105] = {id = 6099105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099201] = {id = 6099201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099202] = {id = 6099202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099203] = {id = 6099203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099204] = {id = 6099204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6099205] = {id = 6099205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100101] = {id = 6100101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100102] = {id = 6100102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100103] = {id = 6100103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100104] = {id = 6100104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100105] = {id = 6100105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100201] = {id = 6100201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100202] = {id = 6100202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100203] = {id = 6100203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100204] = {id = 6100204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6100205] = {id = 6100205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101101] = {id = 6101101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101102] = {id = 6101102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101103] = {id = 6101103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101104] = {id = 6101104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101105] = {id = 6101105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101201] = {id = 6101201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101202] = {id = 6101202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101203] = {id = 6101203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101204] = {id = 6101204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101205] = {id = 6101205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101301] = {id = 6101301, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101302] = {id = 6101302, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101303] = {id = 6101303, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101304] = {id = 6101304, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6101305] = {id = 6101305, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102101] = {id = 6102101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102102] = {id = 6102102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102103] = {id = 6102103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102104] = {id = 6102104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102105] = {id = 6102105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102201] = {id = 6102201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102202] = {id = 6102202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102203] = {id = 6102203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102204] = {id = 6102204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102205] = {id = 6102205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102301] = {id = 6102301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102302] = {id = 6102302, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102303] = {id = 6102303, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102304] = {id = 6102304, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102305] = {id = 6102305, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102401] = {id = 6102401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102402] = {id = 6102402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102403] = {id = 6102403, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102404] = {id = 6102404, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6102405] = {id = 6102405, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103101] = {id = 6103101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103102] = {id = 6103102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103103] = {id = 6103103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103104] = {id = 6103104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103105] = {id = 6103105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103201] = {id = 6103201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103202] = {id = 6103202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103203] = {id = 6103203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103204] = {id = 6103204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6103205] = {id = 6103205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104101] = {id = 6104101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104102] = {id = 6104102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104103] = {id = 6104103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104104] = {id = 6104104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104105] = {id = 6104105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104201] = {id = 6104201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104202] = {id = 6104202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104203] = {id = 6104203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104204] = {id = 6104204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6104205] = {id = 6104205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105101] = {id = 6105101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105102] = {id = 6105102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105103] = {id = 6105103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105104] = {id = 6105104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105105] = {id = 6105105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105201] = {id = 6105201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105202] = {id = 6105202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105203] = {id = 6105203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105204] = {id = 6105204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6105205] = {id = 6105205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106101] = {id = 6106101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106102] = {id = 6106102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106103] = {id = 6106103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106104] = {id = 6106104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106105] = {id = 6106105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106201] = {id = 6106201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106202] = {id = 6106202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106203] = {id = 6106203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106204] = {id = 6106204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6106205] = {id = 6106205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107101] = {id = 6107101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107102] = {id = 6107102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107103] = {id = 6107103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107104] = {id = 6107104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107105] = {id = 6107105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107201] = {id = 6107201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107202] = {id = 6107202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107203] = {id = 6107203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107204] = {id = 6107204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6107205] = {id = 6107205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109101] = {id = 6109101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109102] = {id = 6109102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109103] = {id = 6109103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109104] = {id = 6109104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109105] = {id = 6109105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109201] = {id = 6109201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109202] = {id = 6109202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109203] = {id = 6109203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109204] = {id = 6109204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6109205] = {id = 6109205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111101] = {id = 6111101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111102] = {id = 6111102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111103] = {id = 6111103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111104] = {id = 6111104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111105] = {id = 6111105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111201] = {id = 6111201, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111202] = {id = 6111202, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111203] = {id = 6111203, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111204] = {id = 6111204, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6111205] = {id = 6111205, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112101] = {id = 6112101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112102] = {id = 6112102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112103] = {id = 6112103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112104] = {id = 6112104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112105] = {id = 6112105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112201] = {id = 6112201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112202] = {id = 6112202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112203] = {id = 6112203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112204] = {id = 6112204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6112205] = {id = 6112205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113101] = {id = 6113101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113102] = {id = 6113102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113103] = {id = 6113103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113104] = {id = 6113104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113105] = {id = 6113105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113201] = {id = 6113201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113202] = {id = 6113202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113203] = {id = 6113203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113204] = {id = 6113204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6113205] = {id = 6113205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115101] = {id = 6115101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115102] = {id = 6115102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115103] = {id = 6115103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115104] = {id = 6115104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115105] = {id = 6115105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115201] = {id = 6115201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115202] = {id = 6115202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115203] = {id = 6115203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115204] = {id = 6115204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115205] = {id = 6115205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6115211] = {id = 6115211, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116101] = {id = 6116101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116102] = {id = 6116102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116103] = {id = 6116103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116104] = {id = 6116104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116105] = {id = 6116105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116201] = {id = 6116201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116202] = {id = 6116202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116203] = {id = 6116203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116204] = {id = 6116204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6116205] = {id = 6116205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117101] = {id = 6117101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117102] = {id = 6117102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117103] = {id = 6117103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117104] = {id = 6117104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117105] = {id = 6117105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117201] = {id = 6117201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117202] = {id = 6117202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117203] = {id = 6117203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117204] = {id = 6117204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6117205] = {id = 6117205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118101] = {id = 6118101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118102] = {id = 6118102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118103] = {id = 6118103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118104] = {id = 6118104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118105] = {id = 6118105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118201] = {id = 6118201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118202] = {id = 6118202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118203] = {id = 6118203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118204] = {id = 6118204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6118205] = {id = 6118205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119101] = {id = 6119101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119102] = {id = 6119102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119103] = {id = 6119103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119104] = {id = 6119104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119105] = {id = 6119105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119201] = {id = 6119201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119202] = {id = 6119202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119203] = {id = 6119203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119204] = {id = 6119204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6119205] = {id = 6119205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120101] = {id = 6120101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120102] = {id = 6120102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120103] = {id = 6120103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120104] = {id = 6120104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120105] = {id = 6120105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120201] = {id = 6120201, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120202] = {id = 6120202, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120203] = {id = 6120203, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120204] = {id = 6120204, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6120205] = {id = 6120205, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121101] = {id = 6121101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121102] = {id = 6121102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121103] = {id = 6121103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121104] = {id = 6121104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121105] = {id = 6121105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121201] = {id = 6121201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121202] = {id = 6121202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121203] = {id = 6121203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121204] = {id = 6121204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6121205] = {id = 6121205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122101] = {id = 6122101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122102] = {id = 6122102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122103] = {id = 6122103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122104] = {id = 6122104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122105] = {id = 6122105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122201] = {id = 6122201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122202] = {id = 6122202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122203] = {id = 6122203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122204] = {id = 6122204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6122205] = {id = 6122205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123101] = {id = 6123101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123102] = {id = 6123102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123103] = {id = 6123103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123104] = {id = 6123104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123105] = {id = 6123105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123201] = {id = 6123201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123202] = {id = 6123202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123203] = {id = 6123203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123204] = {id = 6123204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6123205] = {id = 6123205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124101] = {id = 6124101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124102] = {id = 6124102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124103] = {id = 6124103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124104] = {id = 6124104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124105] = {id = 6124105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124201] = {id = 6124201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124202] = {id = 6124202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124203] = {id = 6124203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124204] = {id = 6124204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6124205] = {id = 6124205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126101] = {id = 6126101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126102] = {id = 6126102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126103] = {id = 6126103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126104] = {id = 6126104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126105] = {id = 6126105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126201] = {id = 6126201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126202] = {id = 6126202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126203] = {id = 6126203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126204] = {id = 6126204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6126205] = {id = 6126205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130101] = {id = 6130101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130102] = {id = 6130102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130103] = {id = 6130103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130104] = {id = 6130104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130105] = {id = 6130105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130201] = {id = 6130201, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130202] = {id = 6130202, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130203] = {id = 6130203, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130204] = {id = 6130204, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[6130205] = {id = 6130205, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108101] = {id = 60108101, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108102] = {id = 60108102, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108103] = {id = 60108103, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108104] = {id = 60108104, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108105] = {id = 60108105, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108201] = {id = 60108201, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108202] = {id = 60108202, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108203] = {id = 60108203, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108204] = {id = 60108204, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60108205] = {id = 60108205, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110101] = {id = 60110101, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110102] = {id = 60110102, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110103] = {id = 60110103, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110104] = {id = 60110104, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110105] = {id = 60110105, actionType = 1, actionAtk = "MagicStart", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110201] = {id = 60110201, actionType = 1, actionAtk = "Magic2Loop", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110202] = {id = 60110202, actionType = 1, actionAtk = "Magic2Loop", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110203] = {id = 60110203, actionType = 1, actionAtk = "Magic2Loop", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110204] = {id = 60110204, actionType = 1, actionAtk = "Magic2Loop", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60110205] = {id = 60110205, actionType = 1, actionAtk = "Magic2Loop", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60381001] = {id = 60381001, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381002] = {id = 60381002, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381003] = {id = 60381003, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381004] = {id = 60381004, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381005] = {id = 60381005, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381101] = {id = 60381101, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381102] = {id = 60381102, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381103] = {id = 60381103, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381104] = {id = 60381104, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381105] = {id = 60381105, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381201] = {id = 60381201, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381202] = {id = 60381202, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381203] = {id = 60381203, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381204] = {id = 60381204, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381205] = {id = 60381205, actionType = 2, actionAtk = "Magic", skillStart = "MagicStart", skillLoop = "MagicLoop", skillEnd = "MagicEnd", loopTime = "3"}
, 
[60381301] = {id = 60381301, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[60381302] = {id = 60381302, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[60381303] = {id = 60381303, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[60381304] = {id = 60381304, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[60381305] = {id = 60381305, actionType = 2, actionAtk = "Magic2", skillStart = "Magic2Start", skillLoop = "Magic2Loop", skillEnd = "Magic2End", loopTime = "10"}
, 
[60712201] = {id = 60712201, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60712202] = {id = 60712202, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60712203] = {id = 60712203, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60712204] = {id = 60712204, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60712205] = {id = 60712205, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60811201] = {id = 60811201, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60811202] = {id = 60811202, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60811203] = {id = 60811203, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60811204] = {id = 60811204, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60811205] = {id = 60811205, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812201] = {id = 60812201, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812202] = {id = 60812202, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812203] = {id = 60812203, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812204] = {id = 60812204, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812205] = {id = 60812205, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812401] = {id = 60812401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812402] = {id = 60812402, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812403] = {id = 60812403, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812404] = {id = 60812404, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[60812405] = {id = 60812405, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601081011] = {id = 601081011, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601081012] = {id = 601081012, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601081013] = {id = 601081013, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601081014] = {id = 601081014, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601081015] = {id = 601081015, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601081016] = {id = 601081016, actionType = 1, actionAtk = "Magic2Start", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601102011] = {id = 601102011, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601102021] = {id = 601102021, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601102022] = {id = 601102022, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601102023] = {id = 601102023, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601102024] = {id = 601102024, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[601102025] = {id = 601102025, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608910101] = {id = 608910101, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608910201] = {id = 608910201, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608910301] = {id = 608910301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608910401] = {id = 608910401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608910501] = {id = 608910501, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608920101] = {id = 608920101, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608920201] = {id = 608920201, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608920301] = {id = 608920301, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608920401] = {id = 608920401, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
, 
[608920501] = {id = 608920501, actionType = 0, actionAtk = "", skillStart = "", skillLoop = "", skillEnd = "", loopTime = ""}
}
cskillanimation.AllIds = {10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018, 10019, 10020, 10021, 10022, 10023, 10024, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 10042, 10043, 10044, 10045, 10046, 10047, 10048, 10049, 10050, 10051, 10052, 10053, 10054, 10055, 10056, 10057, 10058, 10059, 10060, 10061, 10062, 10063, 10064, 10065, 10066, 10067, 10068, 10069, 10070, 10071, 10072, 10073, 10074, 10075, 10076, 10078, 10079, 10080, 10081, 10082, 10083, 10084, 10085, 10086, 10088, 10089, 10090, 10091, 10092, 10093, 10094, 10095, 10097, 10098, 10099, 10100, 10101, 10102, 10103, 10104, 10105, 10106, 10107, 10109, 10111, 10112, 10113, 10115, 10116, 10117, 10118, 10119, 10120, 10121, 10122, 10123, 10124, 10126, 10130, 11055, 14061, 15061, 15075, 16061, 16075, 17061, 17075, 18022, 18061, 18075, 19003, 19016, 19017, 19022, 19029, 19051, 19061, 19067, 19075, 100108, 100110, 6000101, 6000102, 6000103, 6000104, 6000105, 6000201, 6000202, 6000203, 6000204, 6000205, 6000301, 6000302, 6000303, 6000304, 6000305, 6000401, 6000402, 6000403, 6000404, 6000405, 6000501, 6000502, 6000503, 6000504, 6000505, 6000601, 6000602, 6000603, 6000604, 6000605, 6001101, 6001102, 6001103, 6001104, 6001105, 6001106, 6001107, 6002101, 6002102, 6002103, 6002104, 6002105, 6002201, 6002202, 6002203, 6002204, 6002205, 6002206, 6003101, 6003102, 6003103, 6003104, 6003105, 6003201, 6003202, 6003203, 6003204, 6003205, 6003301, 6003302, 6003303, 6003304, 6003305, 6004101, 6004102, 6004103, 6004104, 6004105, 6004201, 6004202, 6004203, 6004204, 6004205, 6004206, 6004301, 6004302, 6004303, 6004304, 6004305, 6004401, 6004402, 6004403, 6004404, 6004405, 6005101, 6005102, 6005103, 6005104, 6005105, 6005201, 6005202, 6005203, 6005204, 6005205, 6006101, 6006102, 6006103, 6006104, 6006105, 6006201, 6006202, 6006203, 6006204, 6006205, 6007101, 6007102, 6007103, 6007104, 6007105, 6007201, 6007202, 6007203, 6007204, 6007205, 6008101, 6008102, 6008103, 6008104, 6008105, 6008201, 6008202, 6008203, 6008204, 6008205, 6009101, 6009102, 6009103, 6009104, 6009105, 6009201, 6009202, 6009203, 6009204, 6009205, 6010101, 6010102, 6010103, 6010104, 6010105, 6010201, 6010202, 6010203, 6010204, 6010205, 6011101, 6011102, 6011103, 6011104, 6011105, 6011106, 6011201, 6011202, 6011203, 6011204, 6011205, 6012101, 6012102, 6012103, 6012104, 6012105, 6012201, 6012202, 6012203, 6012204, 6012205, 6012301, 6012302, 6012303, 6012304, 6012305, 6012401, 6012402, 6012403, 6012404, 6012405, 6012501, 6012502, 6012503, 6012504, 6012505, 6012601, 6012602, 6012603, 6012604, 6012605, 6013101, 6013102, 6013103, 6013104, 6013105, 6013201, 6013202, 6013203, 6013204, 6013205, 6014101, 6014102, 6014103, 6014104, 6014105, 6014201, 6014202, 6014203, 6014204, 6014205, 6014301, 6014302, 6014303, 6014304, 6014305, 6014401, 6014402, 6014403, 6014404, 6014405, 6015101, 6015102, 6015103, 6015104, 6015105, 6015201, 6015202, 6015203, 6015204, 6015205, 6016101, 6016102, 6016103, 6016104, 6016105, 6016201, 6016202, 6016203, 6016204, 6016205, 6017101, 6017102, 6017103, 6017104, 6017105, 6017201, 6017202, 6017203, 6017204, 6017205, 6017301, 6017302, 6017303, 6017304, 6017305, 6017401, 6017402, 6017403, 6017404, 6017405, 6018101, 6018102, 6018103, 6018104, 6018105, 6018201, 6018202, 6018203, 6018204, 6018205, 6019101, 6019102, 6019103, 6019104, 6019105, 6019201, 6019202, 6019203, 6019204, 6019205, 6020101, 6020102, 6020103, 6020104, 6020105, 6020201, 6020202, 6020203, 6020204, 6020205, 6021101, 6021102, 6021103, 6021104, 6021105, 6021201, 6021202, 6021203, 6021204, 6021205, 6022101, 6022102, 6022103, 6022104, 6022105, 6022201, 6022202, 6022203, 6022204, 6022205, 6022301, 6022401, 6022402, 6022403, 6022404, 6022405, 6023101, 6023102, 6023103, 6023104, 6023105, 6023201, 6023202, 6023203, 6023204, 6023205, 6023301, 6023302, 6023303, 6023304, 6023305, 6023401, 6023402, 6023403, 6023404, 6023405, 6024101, 6024102, 6024103, 6024104, 6024105, 6024201, 6024202, 6024203, 6024204, 6024205, 6024301, 6024302, 6024303, 6024304, 6024305, 6024401, 6024402, 6024403, 6024404, 6024405, 6025101, 6025102, 6025103, 6025104, 6025105, 6025201, 6025202, 6025203, 6025204, 6025205, 6025301, 6025302, 6025303, 6025304, 6025305, 6025401, 6025402, 6025403, 6025404, 6025405, 6026101, 6026102, 6026103, 6026104, 6026105, 6026201, 6026202, 6026203, 6026204, 6026205, 6027101, 6027102, 6027103, 6027104, 6027105, 6027201, 6027202, 6027203, 6027204, 6027205, 6028101, 6028102, 6028103, 6028104, 6028105, 6028201, 6028202, 6028203, 6028204, 6028205, 6029101, 6029102, 6029103, 6029104, 6029105, 6029201, 6029202, 6029203, 6029204, 6029205, 6030101, 6030102, 6030103, 6030104, 6030105, 6030201, 6030202, 6030203, 6030204, 6030205, 6030301, 6030302, 6030303, 6030304, 6030305, 6030401, 6030402, 6030403, 6030404, 6030405, 6030501, 6030502, 6030503, 6030504, 6030505, 6030601, 6030602, 6030603, 6030604, 6030605, 6030701, 6030702, 6030703, 6030704, 6030705, 6030801, 6030802, 6030803, 6030804, 6030805, 6032101, 6032102, 6032103, 6032104, 6032105, 6032201, 6032202, 6032203, 6032204, 6032205, 6033101, 6033102, 6033103, 6033104, 6033105, 6033201, 6033202, 6033203, 6033204, 6033205, 6034101, 6034102, 6034103, 6034104, 6034105, 6034201, 6034202, 6034203, 6034204, 6034205, 6035101, 6035102, 6035103, 6035104, 6035105, 6035201, 6035202, 6035203, 6035204, 6035205, 6035301, 6035302, 6035303, 6035304, 6035305, 6035401, 6035402, 6035403, 6035404, 6035405, 6036101, 6036102, 6036103, 6036104, 6036105, 6036201, 6036202, 6036203, 6036204, 6036205, 6038101, 6038102, 6038103, 6038104, 6038105, 6038201, 6038202, 6038203, 6038204, 6038205, 6038301, 6038302, 6038303, 6038304, 6038305, 6038401, 6038402, 6038403, 6038404, 6038405, 6038501, 6038502, 6038503, 6038504, 6038505, 6038601, 6038602, 6038603, 6038604, 6038605, 6038701, 6038702, 6038703, 6038704, 6038705, 6038801, 6038802, 6038803, 6038804, 6038805, 6038901, 6038902, 6038903, 6038904, 6038905, 6038906, 6039101, 6039102, 6039103, 6039104, 6039105, 6039106, 6039111, 6039112, 6039113, 6039114, 6039115, 6039201, 6039202, 6039203, 6039204, 6039205, 6039301, 6039302, 6039303, 6039304, 6039305, 6041101, 6041102, 6041103, 6041104, 6041105, 6041201, 6041202, 6041203, 6041204, 6041205, 6041301, 6041302, 6041303, 6041304, 6041305, 6041401, 6041402, 6041403, 6041404, 6041405, 6042101, 6042102, 6042103, 6042104, 6042105, 6042201, 6042202, 6042203, 6042204, 6042205, 6043101, 6043102, 6043103, 6043104, 6043105, 6043201, 6043202, 6043203, 6043204, 6043205, 6044101, 6044102, 6044103, 6044104, 6044105, 6044201, 6044202, 6044203, 6044204, 6044205, 6045101, 6045102, 6045103, 6045104, 6045105, 6045201, 6045202, 6045203, 6045204, 6045205, 6047101, 6047102, 6047103, 6047104, 6047105, 6047201, 6047202, 6047203, 6047204, 6047205, 6048101, 6048102, 6048103, 6048104, 6048105, 6048201, 6048202, 6048203, 6048204, 6048205, 6049101, 6049102, 6049103, 6049104, 6049105, 6049201, 6049202, 6049203, 6049204, 6049205, 6051101, 6051102, 6051103, 6051104, 6051105, 6051201, 6051202, 6051203, 6051204, 6051205, 6052101, 6052102, 6052103, 6052104, 6052105, 6052201, 6052202, 6052203, 6052204, 6052205, 6053101, 6053102, 6053103, 6053104, 6053105, 6053201, 6053202, 6053203, 6053204, 6053205, 6054101, 6054102, 6054103, 6054104, 6054105, 6054201, 6054202, 6054203, 6054204, 6054205, 6055101, 6055102, 6055103, 6055104, 6055105, 6055201, 6055202, 6055203, 6055204, 6055205, 6055301, 6055302, 6055303, 6055304, 6055305, 6055401, 6055402, 6055403, 6055404, 6055405, 6056101, 6056102, 6056103, 6056104, 6056105, 6056201, 6056202, 6056203, 6056204, 6056205, 6057101, 6057102, 6057103, 6057104, 6057105, 6057201, 6057202, 6057203, 6057204, 6057205, 6059101, 6059102, 6059103, 6059104, 6059105, 6059201, 6059202, 6059203, 6059204, 6059205, 6059301, 6059302, 6059303, 6059304, 6059305, 6060101, 6060102, 6060103, 6060104, 6060105, 6060201, 6060202, 6060203, 6060204, 6060205, 6061101, 6061102, 6061103, 6061104, 6061105, 6061201, 6061202, 6061203, 6061204, 6061205, 6061301, 6061302, 6061303, 6061304, 6061305, 6061401, 6061402, 6063101, 6063102, 6063103, 6063104, 6063105, 6063201, 6063202, 6063203, 6063204, 6063205, 6063301, 6063302, 6063303, 6063304, 6063305, 6064101, 6064102, 6064103, 6064104, 6064105, 6064201, 6064202, 6064203, 6064204, 6064205, 6065101, 6065102, 6065103, 6065104, 6065105, 6065106, 6065201, 6065202, 6065203, 6065204, 6065205, 6066101, 6066102, 6066103, 6066104, 6066105, 6066201, 6066202, 6066203, 6066204, 6066205, 6066301, 6066302, 6066303, 6066304, 6066305, 6066401, 6066402, 6066403, 6066404, 6066405, 6067101, 6067102, 6067103, 6067104, 6067105, 6067201, 6067202, 6067203, 6067204, 6067205, 6067301, 6067302, 6067303, 6067304, 6067305, 6068101, 6068102, 6068103, 6068104, 6068105, 6068201, 6068202, 6068203, 6068204, 6068205, 6068501, 6068502, 6068503, 6068504, 6068505, 6068601, 6068602, 6068603, 6068604, 6068605, 6069101, 6069102, 6069103, 6069104, 6069105, 6069201, 6069202, 6069203, 6069204, 6069205, 6070101, 6070102, 6070103, 6070104, 6070105, 6070201, 6070202, 6070203, 6070204, 6070205, 6070301, 6070302, 6070303, 6070304, 6070305, 6070401, 6070402, 6070403, 6070404, 6070405, 6071101, 6071102, 6071103, 6071104, 6071105, 6071201, 6071202, 6071203, 6071204, 6071205, 6072101, 6072102, 6072103, 6072104, 6072105, 6072201, 6072202, 6072203, 6072204, 6072205, 6072301, 6072302, 6072303, 6072304, 6072305, 6073101, 6073102, 6073103, 6073104, 6073105, 6073201, 6073202, 6073203, 6073204, 6073205, 6073301, 6073302, 6073303, 6073304, 6073305, 6073401, 6074101, 6074102, 6074103, 6074104, 6074105, 6074201, 6074202, 6074203, 6074204, 6074205, 6075101, 6075102, 6075103, 6075104, 6075105, 6075201, 6075202, 6075203, 6075204, 6075205, 6075301, 6075302, 6075303, 6075304, 6075305, 6076101, 6076102, 6076103, 6076104, 6076105, 6076201, 6076202, 6076203, 6076204, 6076205, 6078101, 6078102, 6078103, 6078104, 6078105, 6078201, 6078202, 6078203, 6078204, 6078205, 6079101, 6079102, 6079103, 6079104, 6079105, 6079201, 6079202, 6079203, 6079204, 6079205, 6080101, 6080102, 6080103, 6080104, 6080105, 6080201, 6080202, 6080203, 6080204, 6080205, 6081101, 6081102, 6081103, 6081104, 6081105, 6081201, 6081202, 6081203, 6081204, 6081205, 6081301, 6082101, 6082102, 6082103, 6082104, 6082105, 6082201, 6082202, 6082203, 6082204, 6082205, 6082301, 6082302, 6082303, 6082304, 6082305, 6083101, 6083102, 6083103, 6083104, 6083105, 6083201, 6083202, 6083203, 6083204, 6083205, 6083301, 6083302, 6083303, 6083304, 6083305, 6084101, 6084102, 6084103, 6084104, 6084105, 6084111, 6084112, 6084113, 6084201, 6084202, 6084203, 6084204, 6084205, 6084211, 6084212, 6084213, 6085101, 6085102, 6085103, 6085104, 6085105, 6085111, 6085112, 6085113, 6085114, 6085115, 6085121, 6085201, 6085202, 6085203, 6085204, 6085205, 6085211, 6085212, 6085213, 6085214, 6085215, 6085221, 6086101, 6086102, 6086103, 6086104, 6086105, 6086201, 6086202, 6086203, 6086204, 6086205, 6088101, 6088102, 6088103, 6088104, 6088105, 6088111, 6088112, 6088113, 6088114, 6088115, 6088201, 6088202, 6088203, 6088204, 6088205, 6088211, 6089101, 6089102, 6089103, 6089104, 6089105, 6089201, 6089202, 6089203, 6089204, 6089205, 6090101, 6090102, 6090103, 6090104, 6090105, 6090201, 6090202, 6090203, 6090204, 6090205, 6091101, 6091102, 6091103, 6091104, 6091105, 6091201, 6091202, 6091203, 6091204, 6091205, 6091301, 6091302, 6091303, 6091304, 6091305, 6092101, 6092102, 6092103, 6092104, 6092105, 6092201, 6092202, 6092203, 6092204, 6092205, 6092301, 6093101, 6093102, 6093103, 6093104, 6093105, 6093201, 6093202, 6093203, 6093204, 6093205, 6093206, 6094101, 6094102, 6094103, 6094104, 6094105, 6094201, 6094202, 6094203, 6094204, 6094205, 6095101, 6095102, 6095103, 6095104, 6095105, 6095201, 6095202, 6095203, 6095204, 6095205, 6095301, 6095302, 6095303, 6095304, 6095305, 6097101, 6097102, 6097103, 6097104, 6097105, 6097201, 6097202, 6097203, 6097204, 6097205, 6097301, 6097302, 6097303, 6097304, 6097305, 6098101, 6098102, 6098103, 6098104, 6098105, 6098201, 6098202, 6098203, 6098204, 6098205, 6098211, 6099101, 6099102, 6099103, 6099104, 6099105, 6099201, 6099202, 6099203, 6099204, 6099205, 6100101, 6100102, 6100103, 6100104, 6100105, 6100201, 6100202, 6100203, 6100204, 6100205, 6101101, 6101102, 6101103, 6101104, 6101105, 6101201, 6101202, 6101203, 6101204, 6101205, 6101301, 6101302, 6101303, 6101304, 6101305, 6102101, 6102102, 6102103, 6102104, 6102105, 6102201, 6102202, 6102203, 6102204, 6102205, 6102301, 6102302, 6102303, 6102304, 6102305, 6102401, 6102402, 6102403, 6102404, 6102405, 6103101, 6103102, 6103103, 6103104, 6103105, 6103201, 6103202, 6103203, 6103204, 6103205, 6104101, 6104102, 6104103, 6104104, 6104105, 6104201, 6104202, 6104203, 6104204, 6104205, 6105101, 6105102, 6105103, 6105104, 6105105, 6105201, 6105202, 6105203, 6105204, 6105205, 6106101, 6106102, 6106103, 6106104, 6106105, 6106201, 6106202, 6106203, 6106204, 6106205, 6107101, 6107102, 6107103, 6107104, 6107105, 6107201, 6107202, 6107203, 6107204, 6107205, 6109101, 6109102, 6109103, 6109104, 6109105, 6109201, 6109202, 6109203, 6109204, 6109205, 6111101, 6111102, 6111103, 6111104, 6111105, 6111201, 6111202, 6111203, 6111204, 6111205, 6112101, 6112102, 6112103, 6112104, 6112105, 6112201, 6112202, 6112203, 6112204, 6112205, 6113101, 6113102, 6113103, 6113104, 6113105, 6113201, 6113202, 6113203, 6113204, 6113205, 6115101, 6115102, 6115103, 6115104, 6115105, 6115201, 6115202, 6115203, 6115204, 6115205, 6115211, 6116101, 6116102, 6116103, 6116104, 6116105, 6116201, 6116202, 6116203, 6116204, 6116205, 6117101, 6117102, 6117103, 6117104, 6117105, 6117201, 6117202, 6117203, 6117204, 6117205, 6118101, 6118102, 6118103, 6118104, 6118105, 6118201, 6118202, 6118203, 6118204, 6118205, 6119101, 6119102, 6119103, 6119104, 6119105, 6119201, 6119202, 6119203, 6119204, 6119205, 6120101, 6120102, 6120103, 6120104, 6120105, 6120201, 6120202, 6120203, 6120204, 6120205, 6121101, 6121102, 6121103, 6121104, 6121105, 6121201, 6121202, 6121203, 6121204, 6121205, 6122101, 6122102, 6122103, 6122104, 6122105, 6122201, 6122202, 6122203, 6122204, 6122205, 6123101, 6123102, 6123103, 6123104, 6123105, 6123201, 6123202, 6123203, 6123204, 6123205, 6124101, 6124102, 6124103, 6124104, 6124105, 6124201, 6124202, 6124203, 6124204, 6124205, 6126101, 6126102, 6126103, 6126104, 6126105, 6126201, 6126202, 6126203, 6126204, 6126205, 6130101, 6130102, 6130103, 6130104, 6130105, 6130201, 6130202, 6130203, 6130204, 6130205, 60108101, 60108102, 60108103, 60108104, 60108105, 60108201, 60108202, 60108203, 60108204, 60108205, 60110101, 60110102, 60110103, 60110104, 60110105, 60110201, 60110202, 60110203, 60110204, 60110205, 60381001, 60381002, 60381003, 60381004, 60381005, 60381101, 60381102, 60381103, 60381104, 60381105, 60381201, 60381202, 60381203, 60381204, 60381205, 60381301, 60381302, 60381303, 60381304, 60381305, 60712201, 60712202, 60712203, 60712204, 60712205, 60811201, 60811202, 60811203, 60811204, 60811205, 60812201, 60812202, 60812203, 60812204, 60812205, 60812401, 60812402, 60812403, 60812404, 60812405, 601081011, 601081012, 601081013, 601081014, 601081015, 601081016, 601102011, 601102021, 601102022, 601102023, 601102024, 601102025, 608910101, 608910201, 608910301, 608910401, 608910501, 608920101, 608920201, 608920301, 608920401, 608920501}
return cskillanimation


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonbattle/cmonsterchasingroute.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cmonsterchasingroute = {}
cmonsterchasingroute.Data = {
[1001] = {id = 1001, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,2,7,7", chaseTimes = 3}
, 
[1003] = {id = 1003, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "8,14,5,5", chaseTimes = 3}
, 
[1004] = {id = 1004, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "15,29,5,5", chaseTimes = 3}
, 
[1006] = {id = 1006, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,3,7,6", chaseTimes = 3}
, 
[1007] = {id = 1007, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "2,11,5,5", chaseTimes = 3}
, 
[1008] = {id = 1008, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,12,5,5", chaseTimes = 3}
, 
[1009] = {id = 1009, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,11,5,7", chaseTimes = 3}
, 
[1010] = {id = 1010, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,2,7,7", chaseTimes = 3}
, 
[1011] = {id = 1011, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,20,5,5", chaseTimes = 3}
, 
[1012] = {id = 1012, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "28,24,5,5", chaseTimes = 3}
, 
[1013] = {id = 1013, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "26,5,7,7", chaseTimes = 3}
, 
[1014] = {id = 1014, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,21,9,5", chaseTimes = 3}
, 
[1015] = {id = 1015, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "28,20,7,7", chaseTimes = 3}
, 
[1016] = {id = 1016, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,20,5,6", chaseTimes = 3}
, 
[1017] = {id = 1017, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "28,27,7,7", chaseTimes = 3}
, 
[1018] = {id = 1018, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,18,5,7", chaseTimes = 3}
, 
[1019] = {id = 1019, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "1,6,5,5", chaseTimes = 3}
, 
[1020] = {id = 1020, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,14,5,5", chaseTimes = 3}
, 
[1021] = {id = 1021, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,4,5,5", chaseTimes = 3}
, 
[1022] = {id = 1022, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,28,5,5", chaseTimes = 3}
, 
[1023] = {id = 1023, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,23,5,9", chaseTimes = 3}
, 
[1024] = {id = 1024, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "25,16,5,5", chaseTimes = 3}
, 
[1025] = {id = 1025, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,17,5,9", chaseTimes = 3}
, 
[1026] = {id = 1026, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,11,3,5", chaseTimes = 3}
, 
[1027] = {id = 1027, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,10,5,5", chaseTimes = 3}
, 
[1028] = {id = 1028, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,9,5,5", chaseTimes = 3}
, 
[1029] = {id = 1029, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,23,5,5", chaseTimes = 3}
, 
[1030] = {id = 1030, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,22,5,5", chaseTimes = 3}
, 
[1031] = {id = 1031, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,23,5,5", chaseTimes = 3}
, 
[1032] = {id = 1032, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,13,5,5", chaseTimes = 3}
, 
[1033] = {id = 1033, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "22,16,5,5", chaseTimes = 3}
, 
[1034] = {id = 1034, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,19,5,5", chaseTimes = 3}
, 
[1035] = {id = 1035, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,5,5,5", chaseTimes = 3}
, 
[1036] = {id = 1036, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,22,4,5", chaseTimes = 3}
, 
[1037] = {id = 1037, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "30,14,5,5", chaseTimes = 3}
, 
[1038] = {id = 1038, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,6,5,5", chaseTimes = 3}
, 
[1039] = {id = 1039, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,15,5,5", chaseTimes = 3}
, 
[1040] = {id = 1040, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "21,16,5,5", chaseTimes = 3}
, 
[1041] = {id = 1041, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,7,5,5", chaseTimes = 3}
, 
[1042] = {id = 1042, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.2", maxChasingArea = "8,15,5,5", chaseTimes = 3}
, 
[1043] = {id = 1043, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.2", maxChasingArea = "26,12,5,5", chaseTimes = 3}
, 
[1044] = {id = 1044, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.2", maxChasingArea = "18,6,5,5", chaseTimes = 3}
, 
[1045] = {id = 1045, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,9,5,5", chaseTimes = 3}
, 
[1046] = {id = 1046, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,6,5,5", chaseTimes = 3}
, 
[1047] = {id = 1047, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,11,5,5", chaseTimes = 3}
, 
[1048] = {id = 1048, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "11,16,5,5", chaseTimes = 3}
, 
[1049] = {id = 1049, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,3,5,5", chaseTimes = 3}
, 
[1050] = {id = 1050, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,10,5,5", chaseTimes = 3}
, 
[1051] = {id = 1051, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "10,1,5,5", chaseTimes = 3}
, 
[1052] = {id = 1052, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,9,5,5", chaseTimes = 3}
, 
[1053] = {id = 1053, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,13,5,5", chaseTimes = 3}
, 
[1054] = {id = 1054, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,19,5,5", chaseTimes = 3}
, 
[1055] = {id = 1055, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,26,5,5", chaseTimes = 3}
, 
[1056] = {id = 1056, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,5,5,5", chaseTimes = 3}
, 
[1057] = {id = 1057, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,10,5,5", chaseTimes = 3}
, 
[1058] = {id = 1058, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,6,5,5", chaseTimes = 3}
, 
[1059] = {id = 1059, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "34,7,5,5", chaseTimes = 3}
, 
[1060] = {id = 1060, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,4,3,5", chaseTimes = 3}
, 
[1061] = {id = 1061, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,3,5,5", chaseTimes = 3}
, 
[1062] = {id = 1062, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "21,8,5,5", chaseTimes = 3}
, 
[1063] = {id = 1063, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,9,5,5", chaseTimes = 3}
, 
[1064] = {id = 1064, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,16,5,5", chaseTimes = 3}
, 
[1065] = {id = 1065, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,5,5,5", chaseTimes = 3}
, 
[1066] = {id = 1066, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,29,5,5", chaseTimes = 3}
, 
[1067] = {id = 1067, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,27,5,5", chaseTimes = 3}
, 
[1068] = {id = 1068, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,21,5,5", chaseTimes = 3}
, 
[1069] = {id = 1069, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "28,22,5,5", chaseTimes = 3}
, 
[1070] = {id = 1070, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,2,5,5", chaseTimes = 3}
, 
[1071] = {id = 1071, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,23,5,5", chaseTimes = 3}
, 
[1072] = {id = 1072, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,23,5,5", chaseTimes = 3}
, 
[1073] = {id = 1073, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "25,5,5,5", chaseTimes = 3}
, 
[1074] = {id = 1074, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,20,7,6", chaseTimes = 3}
, 
[1075] = {id = 1075, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,11,4,5", chaseTimes = 3}
, 
[1076] = {id = 1076, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,11,7,7", chaseTimes = 3}
, 
[1077] = {id = 1077, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,30,6,4", chaseTimes = 3}
, 
[1078] = {id = 1078, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,8,9,6", chaseTimes = 3}
, 
[1079] = {id = 1079, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,5,5,6", chaseTimes = 3}
, 
[1080] = {id = 1080, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,18,5,5", chaseTimes = 3}
, 
[1081] = {id = 1081, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,12,5,5", chaseTimes = 3}
, 
[1082] = {id = 1082, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,22,5,5", chaseTimes = 3}
, 
[1083] = {id = 1083, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,14,5,5", chaseTimes = 3}
, 
[1084] = {id = 1084, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,11,5,5", chaseTimes = 3}
, 
[1085] = {id = 1085, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "28,12,5,5", chaseTimes = 3}
, 
[1086] = {id = 1086, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,18,5,5", chaseTimes = 3}
, 
[1087] = {id = 1087, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,9,5,5", chaseTimes = 3}
, 
[1088] = {id = 1088, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,9,5,5", chaseTimes = 3}
, 
[1089] = {id = 1089, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "25,7,5,5", chaseTimes = 3}
, 
[1090] = {id = 1090, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,14,5,5", chaseTimes = 3}
, 
[1091] = {id = 1091, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,27,5,5", chaseTimes = 3}
, 
[1092] = {id = 1092, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,24,6,4", chaseTimes = 3}
, 
[1093] = {id = 1093, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,11,5,5", chaseTimes = 3}
, 
[1094] = {id = 1094, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,2,5,6", chaseTimes = 3}
, 
[1095] = {id = 1095, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "31,20,5,6", chaseTimes = 3}
, 
[1096] = {id = 1096, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,7,5,5", chaseTimes = 3}
, 
[1097] = {id = 1097, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,4,5,5", chaseTimes = 3}
, 
[1098] = {id = 1098, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,18,6,8", chaseTimes = 3}
, 
[1099] = {id = 1099, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,5,5,5", chaseTimes = 3}
, 
[1100] = {id = 1100, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,6,5,5", chaseTimes = 3}
, 
[1101] = {id = 1101, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,16,5,5", chaseTimes = 3}
, 
[1102] = {id = 1102, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,23,5,5", chaseTimes = 3}
, 
[1103] = {id = 1103, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,8,5,5", chaseTimes = 3}
, 
[1104] = {id = 1104, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,19,5,5", chaseTimes = 3}
, 
[1105] = {id = 1105, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,9,4,5", chaseTimes = 3}
, 
[1106] = {id = 1106, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,10,4,7", chaseTimes = 3}
, 
[1107] = {id = 1107, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,7,4,5", chaseTimes = 3}
, 
[1108] = {id = 1108, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "26,15,5,4", chaseTimes = 3}
, 
[1109] = {id = 1109, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,13,5,5", chaseTimes = 3}
, 
[1110] = {id = 1110, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,2,5,5", chaseTimes = 3}
, 
[1111] = {id = 1111, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,17,5,5", chaseTimes = 3}
, 
[1112] = {id = 1112, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,32,5,5", chaseTimes = 3}
, 
[1113] = {id = 1113, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,21,5,5", chaseTimes = 3}
, 
[1114] = {id = 1114, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,11,5,5", chaseTimes = 3}
, 
[1115] = {id = 1115, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,12,5,5", chaseTimes = 3}
, 
[1116] = {id = 1116, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "1,7,5,5", chaseTimes = 3}
, 
[1117] = {id = 1117, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,6,5,5", chaseTimes = 3}
, 
[1118] = {id = 1118, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,13,5,5", chaseTimes = 3}
, 
[1119] = {id = 1119, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,2,5,5", chaseTimes = 3}
, 
[1120] = {id = 1120, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,24,5,5", chaseTimes = 3}
, 
[1121] = {id = 1121, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,14,5,5", chaseTimes = 3}
, 
[1122] = {id = 1122, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,7,5,5", chaseTimes = 3}
, 
[1123] = {id = 1123, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,8,5,5", chaseTimes = 3}
, 
[1124] = {id = 1124, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,5,5,4", chaseTimes = 3}
, 
[1125] = {id = 1125, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,10,5,5", chaseTimes = 3}
, 
[1126] = {id = 1126, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,13,5,5", chaseTimes = 3}
, 
[1127] = {id = 1127, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,2,5,5", chaseTimes = 3}
, 
[1128] = {id = 1128, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "1,16,7,5", chaseTimes = 3}
, 
[1129] = {id = 1129, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,2,8,6", chaseTimes = 3}
, 
[1130] = {id = 1130, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,17,5,5", chaseTimes = 3}
, 
[1131] = {id = 1131, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,15,5,5", chaseTimes = 3}
, 
[1132] = {id = 1132, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,18,5,5", chaseTimes = 3}
, 
[1133] = {id = 1133, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,7,5,5", chaseTimes = 3}
, 
[1134] = {id = 1134, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,4,5,5", chaseTimes = 3}
, 
[1135] = {id = 1135, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "9,24,5,5", chaseTimes = 3}
, 
[1136] = {id = 1136, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,7,5,5", chaseTimes = 3}
, 
[1137] = {id = 1137, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,13,5,5", chaseTimes = 3}
, 
[1138] = {id = 1138, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,24,5,5", chaseTimes = 3}
, 
[1139] = {id = 1139, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,5,5,5", chaseTimes = 3}
, 
[1140] = {id = 1140, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,17,5,5", chaseTimes = 3}
, 
[1141] = {id = 1141, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,6,5,5", chaseTimes = 3}
, 
[1142] = {id = 1142, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,14,5,5", chaseTimes = 3}
, 
[1143] = {id = 1143, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,25,5,5", chaseTimes = 3}
, 
[1144] = {id = 1144, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,20,5,5", chaseTimes = 3}
, 
[1145] = {id = 1145, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,9,5,5", chaseTimes = 3}
, 
[1146] = {id = 1146, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,9,5,5", chaseTimes = 3}
, 
[1147] = {id = 1147, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,2,5,5", chaseTimes = 3}
, 
[1148] = {id = 1148, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,20,5,5", chaseTimes = 3}
, 
[1149] = {id = 1149, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,13,5,5", chaseTimes = 3}
, 
[1150] = {id = 1150, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,17,5,5", chaseTimes = 3}
, 
[1151] = {id = 1151, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,3,5,5", chaseTimes = 3}
, 
[1152] = {id = 1152, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,5,3,3", chaseTimes = 3}
, 
[1153] = {id = 1153, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,10,3,5", chaseTimes = 3}
, 
[1154] = {id = 1154, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "27,7,5,3", chaseTimes = 3}
, 
[1155] = {id = 1155, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,18,5,5", chaseTimes = 3}
, 
[1156] = {id = 1156, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,8,5,5", chaseTimes = 3}
, 
[1157] = {id = 1157, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,5,5,5", chaseTimes = 3}
, 
[1158] = {id = 1158, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,22,5,5", chaseTimes = 3}
, 
[1159] = {id = 1159, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,15,5,5", chaseTimes = 3}
, 
[1160] = {id = 1160, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,6,5,5", chaseTimes = 3}
, 
[1161] = {id = 1161, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,21,4,4", chaseTimes = 3}
, 
[1162] = {id = 1162, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,20,4,4", chaseTimes = 3}
, 
[1163] = {id = 1163, direction = 3, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,9,3,4", chaseTimes = 3}
, 
[1164] = {id = 1164, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,20,5,5", chaseTimes = 3}
, 
[1165] = {id = 1165, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,4,5,5", chaseTimes = 3}
, 
[1166] = {id = 1166, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,18,5,5", chaseTimes = 3}
, 
[1167] = {id = 1167, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,11,5,5", chaseTimes = 3}
, 
[1168] = {id = 1168, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,6,5,5", chaseTimes = 3}
, 
[1169] = {id = 1169, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,15,5,5", chaseTimes = 3}
, 
[1170] = {id = 1170, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,7,5,5", chaseTimes = 3}
, 
[1173] = {id = 1173, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,15,5,5", chaseTimes = 3}
, 
[1174] = {id = 1174, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,18,5,5", chaseTimes = 3}
, 
[1175] = {id = 1175, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,9,5,5", chaseTimes = 3}
, 
[1176] = {id = 1176, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,2,5,5", chaseTimes = 3}
, 
[1177] = {id = 1177, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,2,5,5", chaseTimes = 3}
, 
[1178] = {id = 1178, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,10,5,5", chaseTimes = 3}
, 
[1179] = {id = 1179, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,10,5,5", chaseTimes = 3}
, 
[1180] = {id = 1180, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,10,5,5", chaseTimes = 3}
, 
[1181] = {id = 1181, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,7,5,5", chaseTimes = 3}
, 
[1182] = {id = 1182, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,18,5,5", chaseTimes = 3}
, 
[1183] = {id = 1183, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,9,5,5", chaseTimes = 3}
, 
[1184] = {id = 1184, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,11,5,5", chaseTimes = 3}
, 
[1185] = {id = 1185, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,7,5,5", chaseTimes = 3}
, 
[1186] = {id = 1186, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "1,9,5,5", chaseTimes = 3}
, 
[1187] = {id = 1187, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,14,5,4", chaseTimes = 3}
, 
[1188] = {id = 1188, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,19,5,5", chaseTimes = 3}
, 
[1189] = {id = 1189, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,9,5,5", chaseTimes = 3}
, 
[1190] = {id = 1190, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,26,5,5", chaseTimes = 3}
, 
[1191] = {id = 1191, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,20,5,5", chaseTimes = 3}
, 
[1192] = {id = 1192, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,7,5,5", chaseTimes = 3}
, 
[1193] = {id = 1193, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,17,5,5", chaseTimes = 3}
, 
[1194] = {id = 1194, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,22,5,5", chaseTimes = 3}
, 
[1195] = {id = 1195, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,24,5,5", chaseTimes = 3}
, 
[1196] = {id = 1196, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,16,5,5", chaseTimes = 3}
, 
[1197] = {id = 1197, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,10,5,5", chaseTimes = 3}
, 
[1198] = {id = 1198, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,16,5,5", chaseTimes = 3}
, 
[1199] = {id = 1199, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,7,5,5", chaseTimes = 3}
, 
[1200] = {id = 1200, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,12,5,5", chaseTimes = 3}
, 
[1201] = {id = 1201, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,10,5,5", chaseTimes = 3}
, 
[1202] = {id = 1202, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,11,5,5", chaseTimes = 3}
, 
[1203] = {id = 1203, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "37,14,5,5", chaseTimes = 3}
, 
[1204] = {id = 1204, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "30,27,5,5", chaseTimes = 3}
, 
[1206] = {id = 1206, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,10,5,5", chaseTimes = 3}
, 
[1207] = {id = 1207, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,29,5,5", chaseTimes = 3}
, 
[1208] = {id = 1208, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,7,5,5", chaseTimes = 3}
, 
[1209] = {id = 1209, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,8,5,5", chaseTimes = 3}
, 
[1210] = {id = 1210, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,18,5,5", chaseTimes = 3}
, 
[1211] = {id = 1211, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,22,5,5", chaseTimes = 3}
, 
[1212] = {id = 1212, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,6,5,5", chaseTimes = 3}
, 
[1213] = {id = 1213, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,9,5,5", chaseTimes = 3}
, 
[1214] = {id = 1214, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,23,5,5", chaseTimes = 3}
, 
[1215] = {id = 1215, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,22,5,5", chaseTimes = 3}
, 
[1216] = {id = 1216, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,11,5,5", chaseTimes = 3}
, 
[1217] = {id = 1217, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,10,5,5", chaseTimes = 3}
, 
[1218] = {id = 1218, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,27,5,5", chaseTimes = 3}
, 
[1219] = {id = 1219, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,24,5,5", chaseTimes = 3}
, 
[1220] = {id = 1220, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,7,5,5", chaseTimes = 3}
, 
[1221] = {id = 1221, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,8,5,5", chaseTimes = 3}
, 
[1222] = {id = 1222, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,6,5,5", chaseTimes = 3}
, 
[1223] = {id = 1223, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,16,5,5", chaseTimes = 3}
, 
[1224] = {id = 1224, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,25,5,5", chaseTimes = 3}
, 
[1225] = {id = 1225, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,14,5,5", chaseTimes = 3}
, 
[1226] = {id = 1226, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,19,5,5", chaseTimes = 3}
, 
[1227] = {id = 1227, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,7,5,5", chaseTimes = 3}
, 
[1228] = {id = 1228, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,14,5,5", chaseTimes = 3}
, 
[1229] = {id = 1229, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,23,5,5", chaseTimes = 3}
, 
[1230] = {id = 1230, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,21,5,5", chaseTimes = 3}
, 
[1231] = {id = 1231, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,6,5,5", chaseTimes = 3}
, 
[1232] = {id = 1232, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,18,5,5", chaseTimes = 3}
, 
[1233] = {id = 1233, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,6,5,5", chaseTimes = 3}
, 
[1234] = {id = 1234, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,9,5,5", chaseTimes = 3}
, 
[1235] = {id = 1235, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,25,5,5", chaseTimes = 3}
, 
[1236] = {id = 1236, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,7,5,5", chaseTimes = 3}
, 
[1237] = {id = 1237, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,11,5,5", chaseTimes = 3}
, 
[1238] = {id = 1238, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,20,5,5", chaseTimes = 3}
, 
[1239] = {id = 1239, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,7,5,5", chaseTimes = 3}
, 
[1240] = {id = 1240, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,22,5,5", chaseTimes = 3}
, 
[1241] = {id = 1241, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "7,22,5,5", chaseTimes = 3}
, 
[1242] = {id = 1242, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.6", chasingRadius = "1.2", maxChasingArea = "13,12,5,5", chaseTimes = 3}
, 
[1243] = {id = 1243, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,7,5,5", chaseTimes = 3}
, 
[1244] = {id = 1244, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,26,5,5", chaseTimes = 3}
, 
[1245] = {id = 1245, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,10,5,5", chaseTimes = 3}
, 
[1246] = {id = 1246, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,20,5,5", chaseTimes = 3}
, 
[1247] = {id = 1247, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,17,5,5", chaseTimes = 3}
, 
[1248] = {id = 1248, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,8,5,5", chaseTimes = 3}
, 
[1249] = {id = 1249, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,3,5,5", chaseTimes = 3}
, 
[1250] = {id = 1250, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,13,5,5", chaseTimes = 3}
, 
[1251] = {id = 1251, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,16,5,5", chaseTimes = 3}
, 
[1253] = {id = 1253, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,9,5,5", chaseTimes = 3}
, 
[1254] = {id = 1254, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,14,5,5", chaseTimes = 3}
, 
[1255] = {id = 1255, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,14,5,5", chaseTimes = 3}
, 
[1256] = {id = 1256, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,7,5,5", chaseTimes = 3}
, 
[1257] = {id = 1257, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,20,5,5", chaseTimes = 3}
, 
[1258] = {id = 1258, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,19,5,5", chaseTimes = 3}
, 
[1259] = {id = 1259, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,8,11,6", chaseTimes = 3}
, 
[1260] = {id = 1260, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,24,3,3", chaseTimes = 3}
, 
[1261] = {id = 1261, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,24,3,3", chaseTimes = 3}
, 
[1262] = {id = 1262, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,15,3,2", chaseTimes = 3}
, 
[1263] = {id = 1263, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,20,5,5", chaseTimes = 3}
, 
[1264] = {id = 1264, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,5,5,5", chaseTimes = 3}
, 
[1265] = {id = 1265, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,19,5,5", chaseTimes = 3}
, 
[1266] = {id = 1266, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,10,5,5", chaseTimes = 3}
, 
[1267] = {id = 1267, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "34,9,5,5", chaseTimes = 3}
, 
[1268] = {id = 1268, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,27,5,5", chaseTimes = 3}
, 
[1269] = {id = 1269, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,12,5,5", chaseTimes = 3}
, 
[1271] = {id = 1271, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,20,5,5", chaseTimes = 3}
, 
[1272] = {id = 1272, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,8,5,5", chaseTimes = 3}
, 
[1273] = {id = 1273, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,17,5,5", chaseTimes = 3}
, 
[1274] = {id = 1274, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,16,5,5", chaseTimes = 3}
, 
[1275] = {id = 1275, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,8,5,5", chaseTimes = 3}
, 
[1276] = {id = 1276, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,14,5,5", chaseTimes = 3}
, 
[1277] = {id = 1277, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,7,5,5", chaseTimes = 3}
, 
[1278] = {id = 1278, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,22,5,5", chaseTimes = 3}
, 
[1279] = {id = 1279, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,19,5,5", chaseTimes = 3}
, 
[1280] = {id = 1280, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,9,5,5", chaseTimes = 3}
, 
[1281] = {id = 1281, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,22,5,5", chaseTimes = 3}
, 
[1282] = {id = 1282, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,29,5,5", chaseTimes = 3}
, 
[1283] = {id = 1283, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "25,20,5,5", chaseTimes = 3}
, 
[1284] = {id = 1284, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,11,5,5", chaseTimes = 3}
, 
[1285] = {id = 1285, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "21,19,5,5", chaseTimes = 3}
, 
[1286] = {id = 1286, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,22,5,5", chaseTimes = 3}
, 
[1287] = {id = 1287, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,25,5,5", chaseTimes = 3}
, 
[1288] = {id = 1288, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,13,5,5", chaseTimes = 3}
, 
[1289] = {id = 1289, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,21,5,5", chaseTimes = 3}
, 
[1290] = {id = 1290, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,25,5,5", chaseTimes = 3}
, 
[1291] = {id = 1291, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,13,5,5", chaseTimes = 3}
, 
[1292] = {id = 1292, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "29,21,5,5", chaseTimes = 3}
, 
[1293] = {id = 1293, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,6,5,5", chaseTimes = 3}
, 
[1294] = {id = 1294, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,23,5,5", chaseTimes = 3}
, 
[1295] = {id = 1295, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,7,5,5", chaseTimes = 3}
, 
[1296] = {id = 1296, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "28,8,5,5", chaseTimes = 3}
, 
[1297] = {id = 1297, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,19,5,5", chaseTimes = 3}
, 
[1298] = {id = 1298, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,16,5,5", chaseTimes = 3}
, 
[1299] = {id = 1299, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,19,5,5", chaseTimes = 3}
, 
[1300] = {id = 1300, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "24,8,5,5", chaseTimes = 3}
, 
[1301] = {id = 1301, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,27,5,5", chaseTimes = 3}
, 
[1302] = {id = 1302, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "26,10,5,5", chaseTimes = 3}
, 
[1303] = {id = 1303, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,12,5,5", chaseTimes = 3}
, 
[1304] = {id = 1304, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,30,5,5", chaseTimes = 3}
, 
[1305] = {id = 1305, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,17,5,5", chaseTimes = 3}
, 
[1306] = {id = 1306, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,7,5,5", chaseTimes = 3}
, 
[1307] = {id = 1307, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,19,5,5", chaseTimes = 3}
, 
[1308] = {id = 1308, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,11,5,5", chaseTimes = 3}
, 
[1309] = {id = 1309, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,20,5,5", chaseTimes = 3}
, 
[1310] = {id = 1310, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,7,5,5", chaseTimes = 3}
, 
[1311] = {id = 1311, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,6,5,5", chaseTimes = 3}
, 
[1312] = {id = 1312, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,13,5,5", chaseTimes = 3}
, 
[1313] = {id = 1313, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,23,5,5", chaseTimes = 3}
, 
[1314] = {id = 1314, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,9,5,5", chaseTimes = 3}
, 
[1315] = {id = 1315, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,15,5,5", chaseTimes = 3}
, 
[1316] = {id = 1316, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "27,22,5,5", chaseTimes = 3}
, 
[1317] = {id = 1317, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,13,4,4", chaseTimes = 3}
, 
[1318] = {id = 1318, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,10,4,4", chaseTimes = 3}
, 
[1319] = {id = 1319, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,4,5,3", chaseTimes = 3}
, 
[1320] = {id = 1320, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,28,3,5", chaseTimes = 3}
, 
[1321] = {id = 1321, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,12,4,5", chaseTimes = 3}
, 
[1322] = {id = 1322, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.2", chasingRadius = "1.6", maxChasingArea = "8,4,6,3", chaseTimes = 3}
, 
[1323] = {id = 1323, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,5,5,4", chaseTimes = 3}
, 
[1324] = {id = 1324, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,15,4,6", chaseTimes = 3}
, 
[1325] = {id = 1325, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "25,19,2,5", chaseTimes = 3}
, 
[1326] = {id = 1326, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "4,15,3,2", chaseTimes = 3}
, 
[1327] = {id = 1327, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,9,4,4", chaseTimes = 3}
, 
[1328] = {id = 1328, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,23,3,4", chaseTimes = 3}
, 
[1329] = {id = 1329, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "22,13,5,5", chaseTimes = 3}
, 
[1330] = {id = 1330, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "25,23,4,5", chaseTimes = 3}
, 
[1331] = {id = 1331, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,15,6,5", chaseTimes = 3}
, 
[1332] = {id = 1332, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.2", chasingRadius = "1.6", maxChasingArea = "6,22,4,5", chaseTimes = 3}
, 
[1333] = {id = 1333, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.2", chasingRadius = "1.6", maxChasingArea = "13,15,4,4", chaseTimes = 3}
, 
[1334] = {id = 1334, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.2", chasingRadius = "1.6", maxChasingArea = "21,14,5,6", chaseTimes = 3}
, 
[1335] = {id = 1335, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,25,5,5", chaseTimes = 3}
, 
[1336] = {id = 1336, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,16,5,5", chaseTimes = 3}
, 
[1337] = {id = 1337, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,15,3,3", chaseTimes = 3}
, 
[1338] = {id = 1338, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "17,18,4,3", chaseTimes = 3}
, 
[1339] = {id = 1339, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "27,18,4,4", chaseTimes = 3}
, 
[1340] = {id = 1340, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,21,6,5", chaseTimes = 3}
, 
[1341] = {id = 1341, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,16,4,3", chaseTimes = 3}
, 
[1342] = {id = 1342, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "33,14,3,6", chaseTimes = 3}
, 
[1343] = {id = 1343, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.2", chasingRadius = "1.6", maxChasingArea = "13,21,3,5", chaseTimes = 3}
, 
[1344] = {id = 1344, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.2", chasingRadius = "1.6", maxChasingArea = "23,9,3,5", chaseTimes = 3}
, 
[1345] = {id = 1345, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.2", chasingRadius = "1.6", maxChasingArea = "6,9,3,4", chaseTimes = 3}
, 
[1346] = {id = 1346, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.6", chasingRadius = "1.6", maxChasingArea = "30,16,5,5", chaseTimes = 3}
, 
[1347] = {id = 1347, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,19,5,3", chaseTimes = 3}
, 
[1348] = {id = 1348, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,9,4,3", chaseTimes = 3}
, 
[1349] = {id = 1349, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,14,3,4", chaseTimes = 3}
, 
[1350] = {id = 1350, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,17,5,4", chaseTimes = 3}
, 
[1351] = {id = 1351, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,6,4,5", chaseTimes = 3}
, 
[1352] = {id = 1352, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,11,5,4", chaseTimes = 3}
, 
[1353] = {id = 1353, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,30,6,3", chaseTimes = 3}
, 
[1354] = {id = 1354, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "1.4", chasingRadius = "1.6", maxChasingArea = "17,19,3,4", chaseTimes = 3}
, 
[1355] = {id = 1355, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,23,3,3", chaseTimes = 3}
, 
[1356] = {id = 1356, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,14,5,5", chaseTimes = 3}
, 
[1357] = {id = 1357, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,6,3,3", chaseTimes = 3}
, 
[1358] = {id = 1358, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,24,4,3", chaseTimes = 3}
, 
[1359] = {id = 1359, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,15,3,5", chaseTimes = 3}
, 
[1360] = {id = 1360, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,5,4,3", chaseTimes = 3}
, 
[1361] = {id = 1361, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,18,3,5", chaseTimes = 3}
, 
[1362] = {id = 1362, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "18,16,3,3", chaseTimes = 3}
, 
[1363] = {id = 1363, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,5,5,3", chaseTimes = 3}
, 
[1364] = {id = 1364, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,18,5,3", chaseTimes = 3}
, 
[1365] = {id = 1365, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,9,5,3", chaseTimes = 3}
, 
[1366] = {id = 1366, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "15,8,3,4", chaseTimes = 3}
, 
[1367] = {id = 1367, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "2,18,5,4", chaseTimes = 3}
, 
[1368] = {id = 1368, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "10,22,3,5", chaseTimes = 3}
, 
[1369] = {id = 1369, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,9,3,5", chaseTimes = 3}
, 
[1370] = {id = 1370, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,15,3,5", chaseTimes = 3}
, 
[1371] = {id = 1371, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,19,6,3", chaseTimes = 3}
, 
[1372] = {id = 1372, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,10,4,6", chaseTimes = 3}
, 
[1373] = {id = 1373, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,13,3,6", chaseTimes = 3}
, 
[1374] = {id = 1374, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,16,5,3", chaseTimes = 3}
, 
[1375] = {id = 1375, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,11,4,4", chaseTimes = 3}
, 
[1376] = {id = 1376, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "3,14,4,3", chaseTimes = 3}
, 
[1377] = {id = 1377, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "13,11,3,5", chaseTimes = 3}
, 
[1378] = {id = 1378, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,12,3,4", chaseTimes = 3}
, 
[1379] = {id = 1379, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,15,4,4", chaseTimes = 3}
, 
[1380] = {id = 1380, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,12,3,3", chaseTimes = 3}
, 
[1381] = {id = 1381, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "7,15,4,3", chaseTimes = 3}
, 
[1382] = {id = 1382, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,16,4,3", chaseTimes = 3}
, 
[1383] = {id = 1383, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "19,11,3,5", chaseTimes = 3}
, 
[1384] = {id = 1384, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,27,4,4", chaseTimes = 3}
, 
[1385] = {id = 1385, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "11,14,4,5", chaseTimes = 3}
, 
[1386] = {id = 1386, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,22,3,4", chaseTimes = 3}
, 
[1387] = {id = 1387, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "26,7,4,6", chaseTimes = 3}
, 
[1388] = {id = 1388, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,19,4,4", chaseTimes = 3}
, 
[1389] = {id = 1389, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "5,9,4,4", chaseTimes = 3}
, 
[1390] = {id = 1390, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "8,14,3,6", chaseTimes = 3}
, 
[1391] = {id = 1391, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "14,31,5,3", chaseTimes = 3}
, 
[1392] = {id = 1392, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "16,13,3,5", chaseTimes = 3}
, 
[1393] = {id = 1393, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "6,31,4,4", chaseTimes = 3}
, 
[1394] = {id = 1394, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "9,21,3,3", chaseTimes = 3}
, 
[1395] = {id = 1395, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "20,21,3,3", chaseTimes = 3}
, 
[1396] = {id = 1396, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "23,13,3,5", chaseTimes = 3}
, 
[1397] = {id = 1397, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "12,10,4,3", chaseTimes = 3}
, 
[1398] = {id = 1398, direction = 0, chasingSpeed = "1.6", returnSpeed = "1.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.6", maxChasingArea = "28,19,3,2", chaseTimes = 3}
, 
[6001] = {id = 6001, direction = 0, chasingSpeed = "0.8", returnSpeed = "0.6", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "7,3,4,4", chaseTimes = 3}
, 
[6002] = {id = 6002, direction = 0, chasingSpeed = "1.6", returnSpeed = "0.6", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "11,4,3,3", chaseTimes = 3}
, 
[6003] = {id = 6003, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.2", maxChasingArea = "10,12,8,3", chaseTimes = 3}
, 
[6004] = {id = 6004, direction = 0, chasingSpeed = "1.8", returnSpeed = "0.6", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "7,1,3,7", chaseTimes = 3}
, 
[6006] = {id = 6006, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "2,6,6,4", chaseTimes = 3}
, 
[6007] = {id = 6007, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "11,5,5,3", chaseTimes = 3}
, 
[6008] = {id = 6008, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "10,12,8,5", chaseTimes = 3}
, 
[6009] = {id = 6009, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "9,9,3,2", chaseTimes = 3}
, 
[6012] = {id = 6012, direction = 0, chasingSpeed = "1", returnSpeed = "0.6", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "9,12,3,3", chaseTimes = 3}
, 
[6014] = {id = 6014, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "7,3,4,4", chaseTimes = 3}
, 
[6015] = {id = 6015, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "11,4,3,3", chaseTimes = 3}
, 
[6016] = {id = 6016, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1.2", maxChasingArea = "10,12,8,3", chaseTimes = 3}
, 
[6017] = {id = 6017, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "7,10,2,4", chaseTimes = 3}
, 
[6019] = {id = 6019, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "2,6,6,4", chaseTimes = 3}
, 
[6020] = {id = 6020, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "11,5,5,3", chaseTimes = 3}
, 
[6021] = {id = 6021, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "10,12,8,5", chaseTimes = 3}
, 
[6022] = {id = 6022, direction = 0, chasingSpeed = "1", returnSpeed = "0.8", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "9,9,3,2", chaseTimes = 3}
, 
[6025] = {id = 6025, direction = 0, chasingSpeed = "1", returnSpeed = "0.6", returnDelay = 500, triggerRadius = "0.8", chasingRadius = "1", maxChasingArea = "9,12,3,3", chaseTimes = 3}
}
cmonsterchasingroute.AllIds = {1001, 1003, 1004, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 1173, 1174, 1175, 1176, 1177, 1178, 1179, 1180, 1181, 1182, 1183, 1184, 1185, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193, 1194, 1195, 1196, 1197, 1198, 1199, 1200, 1201, 1202, 1203, 1204, 1206, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1221, 1222, 1223, 1224, 1225, 1226, 1227, 1228, 1229, 1230, 1231, 1232, 1233, 1234, 1235, 1236, 1237, 1238, 1239, 1240, 1241, 1242, 1243, 1244, 1245, 1246, 1247, 1248, 1249, 1250, 1251, 1253, 1254, 1255, 1256, 1257, 1258, 1259, 1260, 1261, 1262, 1263, 1264, 1265, 1266, 1267, 1268, 1269, 1271, 1272, 1273, 1274, 1275, 1276, 1277, 1278, 1279, 1280, 1281, 1282, 1283, 1284, 1285, 1286, 1287, 1288, 1289, 1290, 1291, 1292, 1293, 1294, 1295, 1296, 1297, 1298, 1299, 1300, 1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333, 1334, 1335, 1336, 1337, 1338, 1339, 1340, 1341, 1342, 1343, 1344, 1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355, 1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377, 1378, 1379, 1380, 1381, 1382, 1383, 1384, 1385, 1386, 1387, 1388, 1389, 1390, 1391, 1392, 1393, 1394, 1395, 1396, 1397, 1398, 6001, 6002, 6003, 6004, 6006, 6007, 6008, 6009, 6012, 6014, 6015, 6016, 6017, 6019, 6020, 6021, 6022, 6025}
return cmonsterchasingroute


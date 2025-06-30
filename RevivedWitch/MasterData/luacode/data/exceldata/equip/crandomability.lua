-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/equip/crandomability.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local crandomability = {}
crandomability.Data = {
[1001] = {id = 1001, rank = 1, type = 1, skillID = 0, attrID = 131, attrRange = "10101;10102"}
, 
[1002] = {id = 1002, rank = 2, type = 1, skillID = 0, attrID = 131, attrRange = "10103;10104"}
, 
[1003] = {id = 1003, rank = 3, type = 1, skillID = 0, attrID = 131, attrRange = "10105;10106"}
, 
[1004] = {id = 1004, rank = 4, type = 1, skillID = 0, attrID = 131, attrRange = "10107;10108"}
, 
[1005] = {id = 1005, rank = 5, type = 1, skillID = 0, attrID = 131, attrRange = "10109;10110"}
, 
[1006] = {id = 1006, rank = 6, type = 1, skillID = 0, attrID = 131, attrRange = "10111;10112"}
, 
[1007] = {id = 1007, rank = 7, type = 1, skillID = 0, attrID = 131, attrRange = "10113;10114"}
, 
[1011] = {id = 1011, rank = 1, type = 1, skillID = 0, attrID = 141, attrRange = "10201;10202"}
, 
[1012] = {id = 1012, rank = 2, type = 1, skillID = 0, attrID = 141, attrRange = "10203;10204"}
, 
[1013] = {id = 1013, rank = 3, type = 1, skillID = 0, attrID = 141, attrRange = "10205;10206"}
, 
[1014] = {id = 1014, rank = 4, type = 1, skillID = 0, attrID = 141, attrRange = "10207;10208"}
, 
[1015] = {id = 1015, rank = 5, type = 1, skillID = 0, attrID = 141, attrRange = "10209;10210"}
, 
[1016] = {id = 1016, rank = 6, type = 1, skillID = 0, attrID = 141, attrRange = "10211;10212"}
, 
[1017] = {id = 1017, rank = 7, type = 1, skillID = 0, attrID = 141, attrRange = "10213;10214"}
, 
[1021] = {id = 1021, rank = 1, type = 1, skillID = 0, attrID = 31, attrRange = "10301;10302"}
, 
[1022] = {id = 1022, rank = 2, type = 1, skillID = 0, attrID = 31, attrRange = "10303;10304"}
, 
[1023] = {id = 1023, rank = 3, type = 1, skillID = 0, attrID = 31, attrRange = "10305;10306"}
, 
[1024] = {id = 1024, rank = 4, type = 1, skillID = 0, attrID = 31, attrRange = "10307;10308"}
, 
[1025] = {id = 1025, rank = 5, type = 1, skillID = 0, attrID = 31, attrRange = "10309;10310"}
, 
[1026] = {id = 1026, rank = 6, type = 1, skillID = 0, attrID = 31, attrRange = "10311;10312"}
, 
[1027] = {id = 1027, rank = 7, type = 1, skillID = 0, attrID = 31, attrRange = "10313;10314"}
, 
[1031] = {id = 1031, rank = 1, type = 1, skillID = 0, attrID = 551, attrRange = "10401;10402"}
, 
[1032] = {id = 1032, rank = 2, type = 1, skillID = 0, attrID = 551, attrRange = "10403;10404"}
, 
[1033] = {id = 1033, rank = 3, type = 1, skillID = 0, attrID = 551, attrRange = "10405;10406"}
, 
[1034] = {id = 1034, rank = 4, type = 1, skillID = 0, attrID = 551, attrRange = "10407;10408"}
, 
[1035] = {id = 1035, rank = 5, type = 1, skillID = 0, attrID = 551, attrRange = "10409;10410"}
, 
[1036] = {id = 1036, rank = 6, type = 1, skillID = 0, attrID = 551, attrRange = "10411;10412"}
, 
[1037] = {id = 1037, rank = 7, type = 1, skillID = 0, attrID = 551, attrRange = "10413;10414"}
, 
[1051] = {id = 1051, rank = 1, type = 1, skillID = 0, attrID = 91, attrRange = "10601;10602"}
, 
[1052] = {id = 1052, rank = 2, type = 1, skillID = 0, attrID = 91, attrRange = "10603;10604"}
, 
[1053] = {id = 1053, rank = 3, type = 1, skillID = 0, attrID = 91, attrRange = "10605;10606"}
, 
[1054] = {id = 1054, rank = 4, type = 1, skillID = 0, attrID = 91, attrRange = "10607;10608"}
, 
[1055] = {id = 1055, rank = 5, type = 1, skillID = 0, attrID = 91, attrRange = "10609;10610"}
, 
[1056] = {id = 1056, rank = 6, type = 1, skillID = 0, attrID = 91, attrRange = "10611;10612"}
, 
[1057] = {id = 1057, rank = 7, type = 1, skillID = 0, attrID = 91, attrRange = "10613;10614"}
, 
[1061] = {id = 1061, rank = 1, type = 1, skillID = 0, attrID = 111, attrRange = "10701;10702"}
, 
[1062] = {id = 1062, rank = 2, type = 1, skillID = 0, attrID = 111, attrRange = "10703;10704"}
, 
[1063] = {id = 1063, rank = 3, type = 1, skillID = 0, attrID = 111, attrRange = "10705;10706"}
, 
[1064] = {id = 1064, rank = 4, type = 1, skillID = 0, attrID = 111, attrRange = "10707;10708"}
, 
[1065] = {id = 1065, rank = 5, type = 1, skillID = 0, attrID = 111, attrRange = "10709;10710"}
, 
[1066] = {id = 1066, rank = 6, type = 1, skillID = 0, attrID = 111, attrRange = "10711;10712"}
, 
[1067] = {id = 1067, rank = 7, type = 1, skillID = 0, attrID = 111, attrRange = "10713;10714"}
, 
[1071] = {id = 1071, rank = 1, type = 1, skillID = 0, attrID = 531, attrRange = "10801;10802"}
, 
[1072] = {id = 1072, rank = 2, type = 1, skillID = 0, attrID = 531, attrRange = "10803;10804"}
, 
[1073] = {id = 1073, rank = 3, type = 1, skillID = 0, attrID = 531, attrRange = "10805;10806"}
, 
[1074] = {id = 1074, rank = 4, type = 1, skillID = 0, attrID = 531, attrRange = "10807;10808"}
, 
[1075] = {id = 1075, rank = 5, type = 1, skillID = 0, attrID = 531, attrRange = "10809;10810"}
, 
[1076] = {id = 1076, rank = 6, type = 1, skillID = 0, attrID = 531, attrRange = "10811;10812"}
, 
[1077] = {id = 1077, rank = 7, type = 1, skillID = 0, attrID = 531, attrRange = "10813;10814"}
, 
[1081] = {id = 1081, rank = 1, type = 1, skillID = 0, attrID = 61, attrRange = "10901;10902"}
, 
[1082] = {id = 1082, rank = 2, type = 1, skillID = 0, attrID = 61, attrRange = "10903;10904"}
, 
[1083] = {id = 1083, rank = 3, type = 1, skillID = 0, attrID = 61, attrRange = "10905;10906"}
, 
[1084] = {id = 1084, rank = 4, type = 1, skillID = 0, attrID = 61, attrRange = "10907;10908"}
, 
[1085] = {id = 1085, rank = 5, type = 1, skillID = 0, attrID = 61, attrRange = "10909;10910"}
, 
[1086] = {id = 1086, rank = 6, type = 1, skillID = 0, attrID = 61, attrRange = "10911;10912"}
, 
[1087] = {id = 1087, rank = 7, type = 1, skillID = 0, attrID = 61, attrRange = "10913;10914"}
, 
[1091] = {id = 1091, rank = 1, type = 1, skillID = 0, attrID = 571, attrRange = "11001;11002"}
, 
[1092] = {id = 1092, rank = 2, type = 1, skillID = 0, attrID = 571, attrRange = "11003;11004"}
, 
[1093] = {id = 1093, rank = 3, type = 1, skillID = 0, attrID = 571, attrRange = "11005;11006"}
, 
[1094] = {id = 1094, rank = 4, type = 1, skillID = 0, attrID = 571, attrRange = "11007;11008"}
, 
[1095] = {id = 1095, rank = 5, type = 1, skillID = 0, attrID = 571, attrRange = "11009;11010"}
, 
[1096] = {id = 1096, rank = 6, type = 1, skillID = 0, attrID = 571, attrRange = "11011;11012"}
, 
[1097] = {id = 1097, rank = 7, type = 1, skillID = 0, attrID = 571, attrRange = "11013;11014"}
, 
[1101] = {id = 1101, rank = 1, type = 1, skillID = 0, attrID = 51, attrRange = "11101;11102"}
, 
[1102] = {id = 1102, rank = 2, type = 1, skillID = 0, attrID = 51, attrRange = "11103;11104"}
, 
[1103] = {id = 1103, rank = 3, type = 1, skillID = 0, attrID = 51, attrRange = "11105;11106"}
, 
[1104] = {id = 1104, rank = 4, type = 1, skillID = 0, attrID = 51, attrRange = "11107;11108"}
, 
[1105] = {id = 1105, rank = 5, type = 1, skillID = 0, attrID = 51, attrRange = "11109;11110"}
, 
[1106] = {id = 1106, rank = 6, type = 1, skillID = 0, attrID = 51, attrRange = "11111;11112"}
, 
[1107] = {id = 1107, rank = 7, type = 1, skillID = 0, attrID = 51, attrRange = "11113;11114"}
, 
[1111] = {id = 1111, rank = 1, type = 1, skillID = 0, attrID = 561, attrRange = "11201;11202"}
, 
[1112] = {id = 1112, rank = 2, type = 1, skillID = 0, attrID = 561, attrRange = "11203;11204"}
, 
[1113] = {id = 1113, rank = 3, type = 1, skillID = 0, attrID = 561, attrRange = "11205;11206"}
, 
[1114] = {id = 1114, rank = 4, type = 1, skillID = 0, attrID = 561, attrRange = "11207;11208"}
, 
[1115] = {id = 1115, rank = 5, type = 1, skillID = 0, attrID = 561, attrRange = "11209;11210"}
, 
[1116] = {id = 1116, rank = 6, type = 1, skillID = 0, attrID = 561, attrRange = "11211;11212"}
, 
[1117] = {id = 1117, rank = 7, type = 1, skillID = 0, attrID = 561, attrRange = "11213;11214"}
, 
[1121] = {id = 1121, rank = 1, type = 1, skillID = 0, attrID = 21, attrRange = "11301;11302"}
, 
[1122] = {id = 1122, rank = 2, type = 1, skillID = 0, attrID = 21, attrRange = "11303;11304"}
, 
[1123] = {id = 1123, rank = 3, type = 1, skillID = 0, attrID = 21, attrRange = "11305;11306"}
, 
[1124] = {id = 1124, rank = 4, type = 1, skillID = 0, attrID = 21, attrRange = "11307;11308"}
, 
[1125] = {id = 1125, rank = 5, type = 1, skillID = 0, attrID = 21, attrRange = "11309;11310"}
, 
[1126] = {id = 1126, rank = 6, type = 1, skillID = 0, attrID = 21, attrRange = "11311;11312"}
, 
[1127] = {id = 1127, rank = 7, type = 1, skillID = 0, attrID = 21, attrRange = "11313;11314"}
, 
[1131] = {id = 1131, rank = 1, type = 1, skillID = 0, attrID = 581, attrRange = "11401;11402"}
, 
[1132] = {id = 1132, rank = 2, type = 1, skillID = 0, attrID = 581, attrRange = "11403;11404"}
, 
[1133] = {id = 1133, rank = 3, type = 1, skillID = 0, attrID = 581, attrRange = "11405;11406"}
, 
[1134] = {id = 1134, rank = 4, type = 1, skillID = 0, attrID = 581, attrRange = "11407;11408"}
, 
[1135] = {id = 1135, rank = 5, type = 1, skillID = 0, attrID = 581, attrRange = "11409;11410"}
, 
[1136] = {id = 1136, rank = 6, type = 1, skillID = 0, attrID = 581, attrRange = "11411;11412"}
, 
[1137] = {id = 1137, rank = 7, type = 1, skillID = 0, attrID = 581, attrRange = "11413;11414"}
, 
[1141] = {id = 1141, rank = 1, type = 1, skillID = 0, attrID = 121, attrRange = "11501;11502"}
, 
[1142] = {id = 1142, rank = 2, type = 1, skillID = 0, attrID = 121, attrRange = "11503;11504"}
, 
[1143] = {id = 1143, rank = 3, type = 1, skillID = 0, attrID = 121, attrRange = "11505;11506"}
, 
[1144] = {id = 1144, rank = 4, type = 1, skillID = 0, attrID = 121, attrRange = "11507;11508"}
, 
[1145] = {id = 1145, rank = 5, type = 1, skillID = 0, attrID = 121, attrRange = "11509;11510"}
, 
[1146] = {id = 1146, rank = 6, type = 1, skillID = 0, attrID = 121, attrRange = "11511;11512"}
, 
[1147] = {id = 1147, rank = 7, type = 1, skillID = 0, attrID = 121, attrRange = "11513;11514"}
, 
[1151] = {id = 1151, rank = 1, type = 1, skillID = 0, attrID = 101, attrRange = "11601;11602"}
, 
[1152] = {id = 1152, rank = 2, type = 1, skillID = 0, attrID = 101, attrRange = "11603;11604"}
, 
[1153] = {id = 1153, rank = 3, type = 1, skillID = 0, attrID = 101, attrRange = "11605;11606"}
, 
[1154] = {id = 1154, rank = 4, type = 1, skillID = 0, attrID = 101, attrRange = "11607;11608"}
, 
[1155] = {id = 1155, rank = 5, type = 1, skillID = 0, attrID = 101, attrRange = "11609;11610"}
, 
[1156] = {id = 1156, rank = 6, type = 1, skillID = 0, attrID = 101, attrRange = "11611;11612"}
, 
[1157] = {id = 1157, rank = 7, type = 1, skillID = 0, attrID = 101, attrRange = "11613;11614"}
, 
[20001] = {id = 20001, rank = 0, type = 2, skillID = 20039, attrID = 0, attrRange = ""}
, 
[20002] = {id = 20002, rank = 0, type = 2, skillID = 20040, attrID = 0, attrRange = ""}
, 
[20003] = {id = 20003, rank = 0, type = 2, skillID = 20041, attrID = 0, attrRange = ""}
, 
[20004] = {id = 20004, rank = 0, type = 2, skillID = 20042, attrID = 0, attrRange = ""}
, 
[20005] = {id = 20005, rank = 0, type = 2, skillID = 20043, attrID = 0, attrRange = ""}
, 
[20006] = {id = 20006, rank = 0, type = 2, skillID = 20044, attrID = 0, attrRange = ""}
, 
[20007] = {id = 20007, rank = 0, type = 2, skillID = 20045, attrID = 0, attrRange = ""}
, 
[20008] = {id = 20008, rank = 0, type = 2, skillID = 20046, attrID = 0, attrRange = ""}
, 
[20009] = {id = 20009, rank = 0, type = 2, skillID = 20047, attrID = 0, attrRange = ""}
, 
[20010] = {id = 20010, rank = 0, type = 2, skillID = 20048, attrID = 0, attrRange = ""}
, 
[20011] = {id = 20011, rank = 0, type = 2, skillID = 20049, attrID = 0, attrRange = ""}
, 
[20012] = {id = 20012, rank = 0, type = 2, skillID = 20050, attrID = 0, attrRange = ""}
, 
[20013] = {id = 20013, rank = 0, type = 2, skillID = 20051, attrID = 0, attrRange = ""}
, 
[20014] = {id = 20014, rank = 0, type = 2, skillID = 20052, attrID = 0, attrRange = ""}
, 
[20015] = {id = 20015, rank = 0, type = 2, skillID = 20055, attrID = 0, attrRange = ""}
, 
[20016] = {id = 20016, rank = 0, type = 2, skillID = 20056, attrID = 0, attrRange = ""}
, 
[20017] = {id = 20017, rank = 0, type = 2, skillID = 20038, attrID = 0, attrRange = ""}
, 
[20018] = {id = 20018, rank = 0, type = 2, skillID = 20058, attrID = 0, attrRange = ""}
, 
[20019] = {id = 20019, rank = 0, type = 2, skillID = 20059, attrID = 0, attrRange = ""}
, 
[20020] = {id = 20020, rank = 0, type = 2, skillID = 20060, attrID = 0, attrRange = ""}
, 
[20021] = {id = 20021, rank = 0, type = 2, skillID = 20061, attrID = 0, attrRange = ""}
, 
[20022] = {id = 20022, rank = 0, type = 2, skillID = 20062, attrID = 0, attrRange = ""}
, 
[20023] = {id = 20023, rank = 0, type = 2, skillID = 20063, attrID = 0, attrRange = ""}
, 
[20024] = {id = 20024, rank = 0, type = 2, skillID = 20064, attrID = 0, attrRange = ""}
, 
[20025] = {id = 20025, rank = 0, type = 2, skillID = 20065, attrID = 0, attrRange = ""}
, 
[20026] = {id = 20026, rank = 0, type = 2, skillID = 20066, attrID = 0, attrRange = ""}
, 
[20027] = {id = 20027, rank = 0, type = 2, skillID = 20075, attrID = 0, attrRange = ""}
, 
[20028] = {id = 20028, rank = 0, type = 2, skillID = 20076, attrID = 0, attrRange = ""}
, 
[20029] = {id = 20029, rank = 0, type = 2, skillID = 20077, attrID = 0, attrRange = ""}
, 
[20030] = {id = 20030, rank = 0, type = 2, skillID = 20078, attrID = 0, attrRange = ""}
, 
[20031] = {id = 20031, rank = 0, type = 2, skillID = 20079, attrID = 0, attrRange = ""}
, 
[20032] = {id = 20032, rank = 0, type = 2, skillID = 20009, attrID = 0, attrRange = ""}
}
crandomability.AllIds = {1001, 1002, 1003, 1004, 1005, 1006, 1007, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010, 20011, 20012, 20013, 20014, 20015, 20016, 20017, 20018, 20019, 20020, 20021, 20022, 20023, 20024, 20025, 20026, 20027, 20028, 20029, 20030, 20031, 20032}
return crandomability


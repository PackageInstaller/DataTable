-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/battle/cbattleinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cbattleinfo = {}
cbattleinfo.Data = {
[1120] = {id = 1120, bgm = 3, transferID = 1, bossID = 10016, bossIDSecond = 0, 
enemyPositions = {"0", "10016@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[1122] = {id = 1122, bgm = 32, transferID = 4, bossID = 20003, bossIDSecond = 0, 
enemyPositions = {"0", "20003@100", "0", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1123] = {id = 1123, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "29009@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1124] = {id = 1124, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "29010@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1126] = {id = 1126, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"29012@100", "29012@100", "29012@100", "29012@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1127] = {id = 1127, bgm = 61, transferID = 4, bossID = 20007, bossIDSecond = 0, 
enemyPositions = {"0", "20007@100", "0", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1128] = {id = 1128, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "29002@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1129] = {id = 1129, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "29003@100", "0", "29012@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1130] = {id = 1130, bgm = 32, transferID = 4, bossID = 20003, bossIDSecond = 0, 
enemyPositions = {"0", "20003@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1131] = {id = 1131, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"20055@100", "20055@100", "20055@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1134] = {id = 1134, bgm = 32, transferID = 1, bossID = 20014, bossIDSecond = 0, 
enemyPositions = {"0", "20014@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1135] = {id = 1135, bgm = 32, transferID = 1, bossID = 20015, bossIDSecond = 0, 
enemyPositions = {"0", "20015@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1183] = {id = 1183, bgm = 32, transferID = 1, bossID = 10015, bossIDSecond = 0, 
enemyPositions = {"0", "10015@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1184] = {id = 1184, bgm = 3, transferID = 1, bossID = 20055, bossIDSecond = 0, 
enemyPositions = {"0", "20055@100", "0", "0"}
, result = 0, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1186] = {id = 1186, bgm = 32, transferID = 2, bossID = 20056, bossIDSecond = 0, 
enemyPositions = {"0", "20057@100", "0", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1187] = {id = 1187, bgm = 32, transferID = 3, bossID = 20057, bossIDSecond = 0, 
enemyPositions = {"0", "20057@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1189] = {id = 1189, bgm = 133, transferID = 1, bossID = 20001, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20001@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1191] = {id = 1191, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20131@100", "0", "20130@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1294] = {id = 1294, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20187@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1295] = {id = 1295, bgm = 452, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20161@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1297] = {id = 1297, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20160@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1300] = {id = 1300, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20167@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1301] = {id = 1301, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "20168@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1307] = {id = 1307, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20174@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1312] = {id = 1312, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"29006@100", "29005@100", "29006@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1313] = {id = 1313, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"29006@100", "29008@100", "29006@100", "29008@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1314] = {id = 1314, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"29004@100", "0", "29004@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1315] = {id = 1315, bgm = 454, transferID = 1, bossID = 20182, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20182@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1316] = {id = 1316, bgm = 32, transferID = 1, bossID = 20180, bossIDSecond = 0, 
enemyPositions = {"20185@100", "0", "0", "20180@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1317] = {id = 1317, bgm = 32, transferID = 1, bossID = 20181, bossIDSecond = 0, 
enemyPositions = {"20186@100", "0", "0", "20181@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1345] = {id = 1345, bgm = 32, transferID = 1, bossID = 20202, bossIDSecond = 0, 
enemyPositions = {"0", "20202@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1346] = {id = 1346, bgm = 32, transferID = 1, bossID = 20203, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20203@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1347] = {id = 1347, bgm = 1220, transferID = 1, bossID = 20204, bossIDSecond = 0, 
enemyPositions = {"0", "20204@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1348] = {id = 1348, bgm = 32, transferID = 1, bossID = 20205, bossIDSecond = 0, 
enemyPositions = {"0", "20205@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1349] = {id = 1349, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20206@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1350] = {id = 1350, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"20208@100", "0", "20207@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1351] = {id = 1351, bgm = 452, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "20209@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1352] = {id = 1352, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"20212@100", "0", "20212@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1353] = {id = 1353, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"20213@100", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1354] = {id = 1354, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20215@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1355] = {id = 1355, bgm = 631, transferID = 1, bossID = 20216, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20216@100", "0"}
, result = 0, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1356] = {id = 1356, bgm = 754, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20220@100", "0"}
, result = 0, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1357] = {id = 1357, bgm = 755, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20218@100", "0"}
, result = 0, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1361] = {id = 1361, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20209@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[1362] = {id = 1362, bgm = 992, transferID = 1, bossID = 20229, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20229@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1363] = {id = 1363, bgm = 1220, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20242@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1364] = {id = 1364, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "20237@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1365] = {id = 1365, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20238@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1366] = {id = 1366, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20239@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1367] = {id = 1367, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "20240@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1368] = {id = 1368, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "20241@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1369] = {id = 1369, bgm = 1222, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20230@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1370] = {id = 1370, bgm = 32, transferID = 1, bossID = 20228, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20228@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1371] = {id = 1371, bgm = 997, transferID = 1, bossID = 20231, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20231@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1372] = {id = 1372, bgm = 992, transferID = 1, bossID = 20243, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20243@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1373] = {id = 1373, bgm = 32, transferID = 1, bossID = 20228, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20228@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1374] = {id = 1374, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "20241@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1375] = {id = 1375, bgm = 32, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "20241@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1376] = {id = 1376, bgm = 1222, transferID = 1, bossID = 20220, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20230@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1377] = {id = 1377, bgm = 32, transferID = 1, bossID = 20228, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20228@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1378] = {id = 1378, bgm = 997, transferID = 1, bossID = 20231, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20231@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1379] = {id = 1379, bgm = 992, transferID = 1, bossID = 20243, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20243@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1380] = {id = 1380, bgm = 32, transferID = 1, bossID = 20228, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20228@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[1381] = {id = 1381, bgm = 32, transferID = 1, bossID = 20244, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20244@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2001] = {id = 2001, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30001@100", "30002@100", "30002@100", "30002@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2002] = {id = 2002, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30002@100", "30002@100", "30002@100", "30002@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2003] = {id = 2003, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30003@100", "30003@100", "30003@100", "30003@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2004] = {id = 2004, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30004@100", "0", "30004@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2005] = {id = 2005, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30005@100", "30005@100", "30005@100", "30005@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2006] = {id = 2006, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30004@100", "0", "30006@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2007] = {id = 2007, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30006@100", "0", "30006@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2008] = {id = 2008, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30010@100", "30010@100", "30010@100", "30010@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2009] = {id = 2009, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30009@100", "0", "30009@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2010] = {id = 2010, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30007@100", "0", "30007@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2011] = {id = 2011, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30007@100", "0", "30009@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2012] = {id = 2012, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30011@100", "30011@100", "30011@100", "30011@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2013] = {id = 2013, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30012@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2014] = {id = 2014, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30013@100", "0", "30013@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2015] = {id = 2015, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30012@100", "0", "30013@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2016] = {id = 2016, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30014@100", "0", "30014@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2017] = {id = 2017, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30015@100", "0", "30015@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2018] = {id = 2018, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30016@100", "0", "30014@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2019] = {id = 2019, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30017@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2020] = {id = 2020, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30018@100", "0", "30047@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2021] = {id = 2021, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30019@100", "30019@100", "30019@100", "30019@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2022] = {id = 2022, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30019@100", "30019@100", "0", "30020@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2023] = {id = 2023, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30021@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2024] = {id = 2024, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30022@100", "0", "30022@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2025] = {id = 2025, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30023@100", "0", "30022@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2026] = {id = 2026, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30024@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2027] = {id = 2027, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30024@100", "0", "30023@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2028] = {id = 2028, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30025@100", "30025@100", "30025@100", "30025@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2029] = {id = 2029, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30027@100", "0", "30026@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2030] = {id = 2030, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30025@100", "30025@100", "0", "30026@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2031] = {id = 2031, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30028@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2032] = {id = 2032, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30029@100", "0", "30029@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2033] = {id = 2033, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30030@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2034] = {id = 2034, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30031@100", "0", "30029@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2035] = {id = 2035, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30032@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2036] = {id = 2036, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30033@100", "0", "30033@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2037] = {id = 2037, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30035@100", "0", "30034@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2038] = {id = 2038, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30033@100", "0", "30033@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2039] = {id = 2039, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30035@100", "0", "30036@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2040] = {id = 2040, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30037@100", "0", "30037@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2041] = {id = 2041, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30037@100", "0", "30038@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2042] = {id = 2042, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30039@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2043] = {id = 2043, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30040@100", "0", "30040@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2044] = {id = 2044, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30040@100", "0", "30042@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2201] = {id = 2201, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30201@100", "0", "30248@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2202] = {id = 2202, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30202@100", "30202@100", "30202@100", "30202@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2203] = {id = 2203, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30203@100", "30203@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2204] = {id = 2204, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30204@100", "30204@100", "30204@100", "30204@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2205] = {id = 2205, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30205@100", "0", "30249@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2206] = {id = 2206, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30206@100", "0", "30206@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2207] = {id = 2207, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30207@100", "30207@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2208] = {id = 2208, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30208@100", "30208@100", "30208@100", "30208@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2209] = {id = 2209, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30208@100", "30207@100", "30208@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2210] = {id = 2210, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30209@100", "0", "30209@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2211] = {id = 2211, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30210@100", "30210@100", "30210@100", "30210@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2212] = {id = 2212, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30211@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2213] = {id = 2213, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30212@100", "30212@100", "30212@100", "30212@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2214] = {id = 2214, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30213@100", "0", "30250@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2215] = {id = 2215, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30214@100", "0", "30214@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2216] = {id = 2216, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30215@100", "0", "30215@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2217] = {id = 2217, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30216@100", "30216@100", "30216@100", "30216@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2218] = {id = 2218, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30217@100", "0", "30251@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2219] = {id = 2219, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30218@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2220] = {id = 2220, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30219@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2221] = {id = 2221, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30220@100", "30220@100", "30220@100", "30220@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2222] = {id = 2222, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30220@100", "30220@100", "0", "30221@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2223] = {id = 2223, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30220@100", "30220@100", "0", "30222@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2224] = {id = 2224, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30220@100", "30220@100", "30220@100", "30220@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2225] = {id = 2225, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30224@100", "0", "30224@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2226] = {id = 2226, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30223@100", "30223@100", "0", "30224@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2227] = {id = 2227, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30225@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2228] = {id = 2228, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30226@100", "0", "30226@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2229] = {id = 2229, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30227@100", "0", "30227@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2230] = {id = 2230, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30228@100", "0", "30228@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2231] = {id = 2231, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30229@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2232] = {id = 2232, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30230@100", "0", "30230@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2233] = {id = 2233, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30231@100", "0", "30230@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2234] = {id = 2234, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30232@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2235] = {id = 2235, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30233@100", "0", "30233@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2236] = {id = 2236, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30234@100", "0", "30234@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2237] = {id = 2237, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30234@100", "0", "30233@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2238] = {id = 2238, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30235@100", "0", "30235@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2239] = {id = 2239, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30236@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2240] = {id = 2240, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30237@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2241] = {id = 2241, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30238@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2242] = {id = 2242, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30239@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2243] = {id = 2243, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30240@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2244] = {id = 2244, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30241@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2245] = {id = 2245, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30242@100", "0", "30243@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2246] = {id = 2246, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30242@100", "0", "30243@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2247] = {id = 2247, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30243@100", "0", "30244@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2248] = {id = 2248, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30245@100", "0", "30246@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2249] = {id = 2249, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30245@100", "0", "30247@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2401] = {id = 2401, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30401@100", "0", "30402@33;30417@33;30418@34", "30402@33;30417@33;30418@34"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2402] = {id = 2402, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30403@100", "0", "30403@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2403] = {id = 2403, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30404@100", "30404@100", "30404@100", "30404@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2404] = {id = 2404, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30404@100", "30404@100", "30404@100", "30404@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2405] = {id = 2405, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30403@100", "0", "30405@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2406] = {id = 2406, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30406@100", "0", "30406@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2407] = {id = 2407, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30406@100", "0", "30406@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2408] = {id = 2408, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30410@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2409] = {id = 2409, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30408@100", "0", "30408@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2410] = {id = 2410, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30409@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2411] = {id = 2411, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30410@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2412] = {id = 2412, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30409@100", "0", "30409@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2413] = {id = 2413, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30411@100", "30411@100", "30411@100", "30411@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2414] = {id = 2414, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30412@100", "0", "30409@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2415] = {id = 2415, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30413@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2416] = {id = 2416, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30414@100", "0", "30415@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2417] = {id = 2417, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30414@100", "0", "30414@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2418] = {id = 2418, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30414@100", "0", "30414@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2419] = {id = 2419, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30416@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2420] = {id = 2420, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30419@100", "30419@100", "30419@100", "30419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2421] = {id = 2421, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30420@100", "0", "30420@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2422] = {id = 2422, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30421@100", "30421@100", "30421@100", "30421@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2423] = {id = 2423, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30422@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2424] = {id = 2424, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30423@100", "0", "30423@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2425] = {id = 2425, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30424@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2426] = {id = 2426, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30425@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2427] = {id = 2427, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30444@100", "30426@100", "30444@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2428] = {id = 2428, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30427@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2429] = {id = 2429, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30427@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2430] = {id = 2430, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30428@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2431] = {id = 2431, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30429@100", "30428@100", "30429@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2432] = {id = 2432, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30430@100", "0", "30430@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2433] = {id = 2433, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30431@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2434] = {id = 2434, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30432@100", "0", "30430@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2435] = {id = 2435, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30630@100", "30630@100", "30630@100", "30630@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2436] = {id = 2436, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30631@100", "30631@100", "30631@100", "30631@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2437] = {id = 2437, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30632@100", "0", "30632@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2438] = {id = 2438, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30633@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2439] = {id = 2439, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30634@100", "30634@100", "30634@100", "30634@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2440] = {id = 2440, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "30635@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2441] = {id = 2441, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30636@100", "0", "30636@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2442] = {id = 2442, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30637@100", "0", "30637@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2443] = {id = 2443, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30638@100", "0", "30638@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2444] = {id = 2444, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "30639@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2445] = {id = 2445, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30640@100", "0", "30640@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2446] = {id = 2446, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30641@100", "0", "30641@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2447] = {id = 2447, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30642@100", "0", "30642@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2448] = {id = 2448, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30643@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2449] = {id = 2449, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30644@100", "0", "30644@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2450] = {id = 2450, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30645@100", "0", "30645@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2451] = {id = 2451, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30646@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2601] = {id = 2601, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30434@100", "30434@100", "30434@100", "30434@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2602] = {id = 2602, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30434@100", "30434@100", "30434@100", "30434@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2603] = {id = 2603, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30435@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2604] = {id = 2604, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30436@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2605] = {id = 2605, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30436@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2606] = {id = 2606, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30438@100", "30437@100", "30438@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2607] = {id = 2607, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30439@100", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2608] = {id = 2608, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30440@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2609] = {id = 2609, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30440@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2610] = {id = 2610, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30441@100", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2611] = {id = 2611, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30442@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2612] = {id = 2612, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30442@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2613] = {id = 2613, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30443@100", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2614] = {id = 2614, bgm = 573, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30443@100", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2701] = {id = 2701, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30501@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2702] = {id = 2702, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30502@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2703] = {id = 2703, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30503@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2704] = {id = 2704, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30505@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2705] = {id = 2705, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30506@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2706] = {id = 2706, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30507@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2707] = {id = 2707, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30508@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2708] = {id = 2708, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30509@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2709] = {id = 2709, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30510@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2710] = {id = 2710, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30511@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2711] = {id = 2711, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30512@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2712] = {id = 2712, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30513@100", "0", "30514@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2713] = {id = 2713, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30515@100", "0", "30516@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2714] = {id = 2714, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30517@100", "0", "30518@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2715] = {id = 2715, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30519@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2716] = {id = 2716, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30520@100", "0", "30521@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2717] = {id = 2717, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30522@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2718] = {id = 2718, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30523@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2719] = {id = 2719, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30524@100", "0", "30525@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2720] = {id = 2720, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30526@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2721] = {id = 2721, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30527@100", "0", "30528@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2722] = {id = 2722, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30529@100", "0", "30530@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2723] = {id = 2723, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30532@100", "0", "30531@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2724] = {id = 2724, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30534@100", "0", "30533@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2725] = {id = 2725, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30535@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2726] = {id = 2726, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30536@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2727] = {id = 2727, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30537@100", "0", "30538@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2728] = {id = 2728, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30537@100", "0", "30538@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2729] = {id = 2729, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30540@100", "30541@100", "30539@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2730] = {id = 2730, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30542@100", "0", "30543@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2731] = {id = 2731, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30546@100", "30548@100", "30547@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2732] = {id = 2732, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30551@100", "0", "30549@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2733] = {id = 2733, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30550@100", "0", "30552@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2734] = {id = 2734, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30553@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2735] = {id = 2735, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30554@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2736] = {id = 2736, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30555@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2737] = {id = 2737, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30556@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2738] = {id = 2738, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30557@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2739] = {id = 2739, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30559@100", "0", "30558@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2740] = {id = 2740, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30560@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2741] = {id = 2741, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30562@100", "0", "30561@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2742] = {id = 2742, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30564@100", "0", "30563@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2743] = {id = 2743, bgm = 571, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30565@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2801] = {id = 2801, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30566@100", "30566@100", "30566@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2802] = {id = 2802, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30568@100", "30567@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2803] = {id = 2803, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30569@100", "30569@100", "30569@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2804] = {id = 2804, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30570@100", "30570@100", "30570@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2805] = {id = 2805, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30572@100", "30571@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2806] = {id = 2806, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30573@100", "0", "30574@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2807] = {id = 2807, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30575@100", "0", "30575@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2808] = {id = 2808, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30576@100", "0", "30576@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2809] = {id = 2809, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30577@100", "30577@100", "30578@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2810] = {id = 2810, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30579@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2811] = {id = 2811, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30580@100", "30580@100", "30580@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2812] = {id = 2812, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30581@100", "30581@100", "30581@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2813] = {id = 2813, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30582@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2814] = {id = 2814, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30583@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2815] = {id = 2815, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30584@100", "30584@100", "30584@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2816] = {id = 2816, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30585@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2817] = {id = 2817, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30586@100", "30586@100", "30586@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2818] = {id = 2818, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30587@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2819] = {id = 2819, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30588@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2820] = {id = 2820, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30589@100", "0", "30590@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2821] = {id = 2821, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30589@100", "0", "30590@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2822] = {id = 2822, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30589@100", "0", "30591@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2823] = {id = 2823, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30589@100", "30589@100", "30592@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2824] = {id = 2824, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30594@100", "30594@100", "30594@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2825] = {id = 2825, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30595@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2826] = {id = 2826, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30596@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2827] = {id = 2827, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30597@100", "30597@100", "30597@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2828] = {id = 2828, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30598@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2829] = {id = 2829, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30599@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2830] = {id = 2830, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30600@100", "0", "30600@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2831] = {id = 2831, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30601@100", "0", "30601@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2832] = {id = 2832, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30602@100", "30602@100", "0", "30603@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2833] = {id = 2833, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30604@100", "0", "30605@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2834] = {id = 2834, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30606@100", "0", "30607@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2835] = {id = 2835, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30608@100", "0", "30608@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2836] = {id = 2836, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30609@100", "0", "30609@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2837] = {id = 2837, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30610@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2838] = {id = 2838, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30611@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2839] = {id = 2839, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30613@100", "0", "30612@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2840] = {id = 2840, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30614@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2841] = {id = 2841, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30616@100", "0", "30615@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2842] = {id = 2842, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30618@100", "0", "30617@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2843] = {id = 2843, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30620@100", "0", "30619@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2844] = {id = 2844, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30621@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2845] = {id = 2845, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30622@100", "30622@100", "0", "30622@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2846] = {id = 2846, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30623@100", "30623@100", "0", "30623@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2847] = {id = 2847, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30624@100", "0", "30624@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2848] = {id = 2848, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30625@100", "0", "30625@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2849] = {id = 2849, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30626@100", "0", "30626@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2850] = {id = 2850, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30627@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2851] = {id = 2851, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30626@100", "0", "30626@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2852] = {id = 2852, bgm = 1221, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30627@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[2901] = {id = 2901, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30647@100", "0", "30647@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2902] = {id = 2902, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30648@100", "30648@100", "30648@100", "30648@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2903] = {id = 2903, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30649@100", "30649@100", "30648@100", "30648@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2904] = {id = 2904, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30647@100", "0", "30647@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2905] = {id = 2905, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30649@100", "30649@100", "30649@100", "30649@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2906] = {id = 2906, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30649@100", "30649@100", "30648@100", "30648@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2907] = {id = 2907, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30650@100", "30650@100", "30650@100", "30650@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2908] = {id = 2908, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30650@100", "30650@100", "30650@100", "30650@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2909] = {id = 2909, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30650@100", "30650@100", "30650@100", "30650@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2910] = {id = 2910, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30652@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2911] = {id = 2911, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30651@100", "30651@100", "30651@100", "30651@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2912] = {id = 2912, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30651@100", "30651@100", "30651@100", "30651@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2913] = {id = 2913, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30651@100", "30651@100", "30651@100", "30651@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2914] = {id = 2914, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30653@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2915] = {id = 2915, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30654@100", "30654@100", "30655@100", "30655@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2916] = {id = 2916, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30654@100", "30654@100", "30655@100", "30655@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2917] = {id = 2917, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30658@100", "0", "30659@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2918] = {id = 2918, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30656@100", "0", "30656@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2919] = {id = 2919, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30656@100", "0", "30656@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2920] = {id = 2920, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30657@100", "0", "30657@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2921] = {id = 2921, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30660@100", "0", "30660@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2922] = {id = 2922, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30660@100", "0", "30660@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2923] = {id = 2923, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30661@100", "0", "30661@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2924] = {id = 2924, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30661@100", "0", "30661@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2925] = {id = 2925, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30661@100", "0", "30661@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2926] = {id = 2926, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30662@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2927] = {id = 2927, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30663@100", "0", "30663@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2928] = {id = 2928, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30664@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2929] = {id = 2929, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30663@100", "0", "30663@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2930] = {id = 2930, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30664@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2931] = {id = 2931, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30665@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2932] = {id = 2932, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30666@100", "0", "30668@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2933] = {id = 2933, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30666@100", "0", "30667@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2934] = {id = 2934, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30669@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2935] = {id = 2935, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30666@100", "0", "30668@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2936] = {id = 2936, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30666@100", "0", "30667@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2937] = {id = 2937, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30667@100", "0", "30668@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2938] = {id = 2938, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20247@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2939] = {id = 2939, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30674@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2940] = {id = 2940, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30672@100", "0", "30673@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2941] = {id = 2941, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30671@100", "0", "30672@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2942] = {id = 2942, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30671@100", "0", "30673@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2943] = {id = 2943, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30675@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2944] = {id = 2944, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30674@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2945] = {id = 2945, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30677@100", "0", "30678@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2946] = {id = 2946, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30677@100", "0", "30679@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2947] = {id = 2947, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30680@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2948] = {id = 2948, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20246@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2949] = {id = 2949, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30677@100", "30678@100", "30679@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2950] = {id = 2950, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"30677@100", "30678@100", "30679@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2951] = {id = 2951, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30680@100", "0", "30678@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2952] = {id = 2952, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "30685@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2953] = {id = 2953, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "30682@100", "0", "30681@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[2954] = {id = 2954, bgm = 3, transferID = 1, bossID = 20245, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20244@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6001] = {id = 6001, bgm = 3, transferID = 1, bossID = 60001, bossIDSecond = 0, 
enemyPositions = {"0", "60001@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6002] = {id = 6002, bgm = 3, transferID = 1, bossID = 60002, bossIDSecond = 0, 
enemyPositions = {"0", "60002@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6003] = {id = 6003, bgm = 3, transferID = 1, bossID = 60003, bossIDSecond = 0, 
enemyPositions = {"0", "60003@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6004] = {id = 6004, bgm = 3, transferID = 1, bossID = 60004, bossIDSecond = 0, 
enemyPositions = {"0", "60004@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6005] = {id = 6005, bgm = 3, transferID = 1, bossID = 60005, bossIDSecond = 0, 
enemyPositions = {"0", "60005@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6006] = {id = 6006, bgm = 3, transferID = 1, bossID = 60006, bossIDSecond = 0, 
enemyPositions = {"0", "60006@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6007] = {id = 6007, bgm = 3, transferID = 1, bossID = 60007, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60007@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6008] = {id = 6008, bgm = 3, transferID = 1, bossID = 60008, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60008@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6009] = {id = 6009, bgm = 3, transferID = 1, bossID = 60009, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60009@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6010] = {id = 6010, bgm = 3, transferID = 1, bossID = 60007, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60036@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6011] = {id = 6011, bgm = 3, transferID = 1, bossID = 60008, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60037@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6012] = {id = 6012, bgm = 3, transferID = 1, bossID = 60009, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60038@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6013] = {id = 6013, bgm = 3, transferID = 1, bossID = 60010, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60010@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6014] = {id = 6014, bgm = 3, transferID = 1, bossID = 60011, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60011@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6015] = {id = 6015, bgm = 3, transferID = 1, bossID = 60012, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60012@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6016] = {id = 6016, bgm = 3, transferID = 1, bossID = 60010, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60039@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6017] = {id = 6017, bgm = 3, transferID = 1, bossID = 60011, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60040@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6018] = {id = 6018, bgm = 3, transferID = 1, bossID = 60012, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60041@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6019] = {id = 6019, bgm = 3, transferID = 1, bossID = 60013, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60013@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6020] = {id = 6020, bgm = 3, transferID = 1, bossID = 60014, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60014@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6021] = {id = 6021, bgm = 3, transferID = 1, bossID = 60015, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60015@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6022] = {id = 6022, bgm = 3, transferID = 1, bossID = 60013, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60042@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6023] = {id = 6023, bgm = 3, transferID = 1, bossID = 60014, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60043@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6024] = {id = 6024, bgm = 3, transferID = 1, bossID = 60015, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60044@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6025] = {id = 6025, bgm = 3, transferID = 1, bossID = 60016, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60016@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6026] = {id = 6026, bgm = 3, transferID = 1, bossID = 60017, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60017@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6027] = {id = 6027, bgm = 3, transferID = 1, bossID = 60018, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60018@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6028] = {id = 6028, bgm = 3, transferID = 1, bossID = 60019, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60019@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6029] = {id = 6029, bgm = 3, transferID = 1, bossID = 60016, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60020@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6030] = {id = 6030, bgm = 3, transferID = 1, bossID = 60017, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60021@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6031] = {id = 6031, bgm = 3, transferID = 1, bossID = 60018, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60022@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6032] = {id = 6032, bgm = 3, transferID = 1, bossID = 60019, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60023@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6033] = {id = 6033, bgm = 3, transferID = 1, bossID = 60024, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60024@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6034] = {id = 6034, bgm = 3, transferID = 1, bossID = 60025, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60025@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6035] = {id = 6035, bgm = 3, transferID = 1, bossID = 60026, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60026@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6036] = {id = 6036, bgm = 3, transferID = 1, bossID = 60027, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60027@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6037] = {id = 6037, bgm = 3, transferID = 1, bossID = 60028, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60028@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6038] = {id = 6038, bgm = 3, transferID = 1, bossID = 60029, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60029@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6039] = {id = 6039, bgm = 3, transferID = 1, bossID = 60030, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60030@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6040] = {id = 6040, bgm = 3, transferID = 1, bossID = 60031, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60031@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6041] = {id = 6041, bgm = 3, transferID = 1, bossID = 60032, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60032@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6042] = {id = 6042, bgm = 3, transferID = 1, bossID = 60033, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60033@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6043] = {id = 6043, bgm = 3, transferID = 1, bossID = 60034, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60034@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6044] = {id = 6044, bgm = 3, transferID = 1, bossID = 60035, bossIDSecond = 0, 
enemyPositions = {"0", "0", "60035@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6055] = {id = 6055, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62001@100", "0", "62001@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6056] = {id = 6056, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62003@100", "0", "62003@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6057] = {id = 6057, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62004@100", "0", "62004@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6058] = {id = 6058, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62002@100", "0", "62002@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6059] = {id = 6059, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62003@100", "0", "62003@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6060] = {id = 6060, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62006@100", "0", "62008@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6061] = {id = 6061, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62007@100", "0", "62007@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6062] = {id = 6062, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62006@100", "0", "62007@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6063] = {id = 6063, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62008@100", "0", "62008@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6064] = {id = 6064, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62009@100", "0", "62009@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6065] = {id = 6065, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62012@100", "0", "62012@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6066] = {id = 6066, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62013@100", "0", "62013@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6067] = {id = 6067, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62014@100", "0", "62014@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6068] = {id = 6068, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62015@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6069] = {id = 6069, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62013@100", "0", "62014@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6070] = {id = 6070, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62005@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6071] = {id = 6071, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62018@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6072] = {id = 6072, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62010@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6073] = {id = 6073, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62011@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6074] = {id = 6074, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62019@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6075] = {id = 6075, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62016@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6076] = {id = 6076, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62017@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6077] = {id = 6077, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62020@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6078] = {id = 6078, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62021@100", "0", "62021@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6079] = {id = 6079, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62023@100", "0", "62023@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6080] = {id = 6080, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62024@100", "0", "62024@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6081] = {id = 6081, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62022@100", "0", "62022@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6082] = {id = 6082, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62023@100", "0", "62023@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6083] = {id = 6083, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62026@100", "0", "62028@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6084] = {id = 6084, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62027@100", "0", "62027@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6085] = {id = 6085, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62026@100", "0", "62027@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6086] = {id = 6086, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62028@100", "0", "62028@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6087] = {id = 6087, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62029@100", "0", "62029@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6088] = {id = 6088, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62032@100", "0", "62032@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6089] = {id = 6089, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62033@100", "0", "62033@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6090] = {id = 6090, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62034@100", "0", "62034@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6091] = {id = 6091, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62035@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6092] = {id = 6092, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62033@100", "0", "62034@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6093] = {id = 6093, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62025@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6094] = {id = 6094, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62038@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6095] = {id = 6095, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62030@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6096] = {id = 6096, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62031@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6097] = {id = 6097, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62039@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6098] = {id = 6098, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62036@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6099] = {id = 6099, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62037@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6100] = {id = 6100, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62040@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6101] = {id = 6101, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62041@100", "0", "62041@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6102] = {id = 6102, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62043@100", "0", "62043@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6103] = {id = 6103, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62044@100", "0", "62044@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6104] = {id = 6104, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62042@100", "0", "62042@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6105] = {id = 6105, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62043@100", "0", "62043@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6106] = {id = 6106, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62046@100", "0", "62048@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6107] = {id = 6107, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62047@100", "0", "62047@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6108] = {id = 6108, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62046@100", "0", "62047@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6109] = {id = 6109, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62048@100", "0", "62048@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6110] = {id = 6110, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62049@100", "0", "62049@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6111] = {id = 6111, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62052@100", "0", "62052@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6112] = {id = 6112, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62053@100", "0", "62053@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6113] = {id = 6113, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62054@100", "0", "62054@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6114] = {id = 6114, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62055@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6115] = {id = 6115, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62053@100", "0", "62054@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6116] = {id = 6116, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62045@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6117] = {id = 6117, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62058@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6118] = {id = 6118, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62050@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6119] = {id = 6119, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62051@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6120] = {id = 6120, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62059@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6121] = {id = 6121, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62056@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6122] = {id = 6122, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62057@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6123] = {id = 6123, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62060@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6124] = {id = 6124, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62061@100", "0", "62061@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6125] = {id = 6125, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62063@100", "0", "62063@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6126] = {id = 6126, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62064@100", "0", "62064@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6127] = {id = 6127, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62062@100", "0", "62062@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6128] = {id = 6128, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62063@100", "0", "62063@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6129] = {id = 6129, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62066@100", "0", "62068@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6130] = {id = 6130, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62067@100", "0", "62067@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6131] = {id = 6131, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62066@100", "0", "62067@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6132] = {id = 6132, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62068@100", "0", "62068@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6133] = {id = 6133, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62069@100", "0", "62069@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6134] = {id = 6134, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62072@100", "0", "62072@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6135] = {id = 6135, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62073@100", "0", "62073@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6136] = {id = 6136, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62074@100", "0", "62074@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6137] = {id = 6137, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62075@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6138] = {id = 6138, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62073@100", "0", "62074@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6139] = {id = 6139, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62065@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6140] = {id = 6140, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62078@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6141] = {id = 6141, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62070@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6142] = {id = 6142, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62071@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6143] = {id = 6143, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62079@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6144] = {id = 6144, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62076@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6145] = {id = 6145, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62077@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6146] = {id = 6146, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62080@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6147] = {id = 6147, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62081@100", "0", "62081@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6148] = {id = 6148, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62083@100", "0", "62083@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6149] = {id = 6149, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62084@100", "0", "62084@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6150] = {id = 6150, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62082@100", "0", "62082@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6151] = {id = 6151, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62083@100", "0", "62083@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6152] = {id = 6152, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62086@100", "0", "62088@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6153] = {id = 6153, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62087@100", "0", "62087@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6154] = {id = 6154, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62086@100", "0", "62087@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6155] = {id = 6155, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62088@100", "0", "62088@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6156] = {id = 6156, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62089@100", "0", "62089@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6157] = {id = 6157, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62092@100", "0", "62092@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6158] = {id = 6158, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62093@100", "0", "62093@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6159] = {id = 6159, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62094@100", "0", "62094@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6160] = {id = 6160, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62095@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6161] = {id = 6161, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62093@100", "0", "62094@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6162] = {id = 6162, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62105@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6163] = {id = 6163, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62098@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6164] = {id = 6164, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62090@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6165] = {id = 6165, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62091@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6166] = {id = 6166, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62099@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6167] = {id = 6167, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62096@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6168] = {id = 6168, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62097@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6169] = {id = 6169, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62100@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6170] = {id = 6170, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62101@100", "0", "62101@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6171] = {id = 6171, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62103@100", "0", "62103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6172] = {id = 6172, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62104@100", "0", "62104@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6173] = {id = 6173, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62102@100", "0", "62102@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6174] = {id = 6174, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62103@100", "0", "62103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6175] = {id = 6175, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62106@100", "0", "62108@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6176] = {id = 6176, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62107@100", "0", "62107@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6177] = {id = 6177, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62106@100", "0", "62107@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6178] = {id = 6178, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62108@100", "0", "62108@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6179] = {id = 6179, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62109@100", "0", "62109@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6180] = {id = 6180, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62112@100", "0", "62112@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6181] = {id = 6181, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62113@100", "0", "62113@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6182] = {id = 6182, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62114@100", "0", "62114@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6183] = {id = 6183, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62115@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6184] = {id = 6184, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62113@100", "0", "62114@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6185] = {id = 6185, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62105@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6186] = {id = 6186, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62118@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6187] = {id = 6187, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62110@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6188] = {id = 6188, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62111@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6189] = {id = 6189, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62119@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6190] = {id = 6190, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62116@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6191] = {id = 6191, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62117@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6192] = {id = 6192, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62120@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6193] = {id = 6193, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62121@100", "0", "62121@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6194] = {id = 6194, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62123@100", "0", "62123@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6195] = {id = 6195, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62124@100", "0", "62124@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6196] = {id = 6196, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62122@100", "0", "62122@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6197] = {id = 6197, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62123@100", "0", "62123@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6198] = {id = 6198, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62126@100", "0", "62128@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6199] = {id = 6199, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62127@100", "0", "62127@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6200] = {id = 6200, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62126@100", "0", "62127@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6201] = {id = 6201, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62128@100", "0", "62128@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6202] = {id = 6202, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62129@100", "0", "62129@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6203] = {id = 6203, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62132@100", "0", "62132@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6204] = {id = 6204, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62133@100", "0", "62133@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6205] = {id = 6205, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62134@100", "0", "62134@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6206] = {id = 6206, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62135@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6207] = {id = 6207, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62133@100", "0", "62134@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6208] = {id = 6208, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62125@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6209] = {id = 6209, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62138@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6210] = {id = 6210, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62130@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6211] = {id = 6211, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62131@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6212] = {id = 6212, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62139@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6213] = {id = 6213, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62136@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6214] = {id = 6214, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62137@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6215] = {id = 6215, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62140@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6216] = {id = 6216, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62141@100", "0", "62141@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6217] = {id = 6217, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62143@100", "0", "62143@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6218] = {id = 6218, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62144@100", "0", "62144@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6219] = {id = 6219, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62142@100", "0", "62142@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6220] = {id = 6220, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62143@100", "0", "62143@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6221] = {id = 6221, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62146@100", "0", "62148@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6222] = {id = 6222, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62147@100", "0", "62147@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6223] = {id = 6223, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62146@100", "0", "62147@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6224] = {id = 6224, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62148@100", "0", "62148@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6225] = {id = 6225, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62149@100", "0", "62149@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6226] = {id = 6226, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62152@100", "0", "62152@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6227] = {id = 6227, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62153@100", "0", "62153@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6228] = {id = 6228, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62154@100", "0", "62154@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6229] = {id = 6229, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62155@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6230] = {id = 6230, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62153@100", "0", "62154@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6231] = {id = 6231, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62145@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6232] = {id = 6232, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62158@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6233] = {id = 6233, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62150@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6234] = {id = 6234, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62151@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6235] = {id = 6235, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62159@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6236] = {id = 6236, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62156@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6237] = {id = 6237, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62157@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6238] = {id = 6238, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62160@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6239] = {id = 6239, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62161@100", "0", "62161@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6240] = {id = 6240, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62163@100", "0", "62163@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6241] = {id = 6241, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62164@100", "0", "62164@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6242] = {id = 6242, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62162@100", "0", "62162@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6243] = {id = 6243, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62163@100", "0", "62163@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6244] = {id = 6244, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62166@100", "0", "62168@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6245] = {id = 6245, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62167@100", "0", "62167@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6246] = {id = 6246, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62166@100", "0", "62167@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6247] = {id = 6247, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62168@100", "0", "62168@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6248] = {id = 6248, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62169@100", "0", "62169@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6249] = {id = 6249, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62172@100", "0", "62172@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6250] = {id = 6250, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62173@100", "0", "62173@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6251] = {id = 6251, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62174@100", "0", "62174@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6252] = {id = 6252, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62175@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6253] = {id = 6253, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62173@100", "0", "62174@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6254] = {id = 6254, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62165@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6255] = {id = 6255, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62178@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6256] = {id = 6256, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62170@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6257] = {id = 6257, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62171@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6258] = {id = 6258, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62179@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6259] = {id = 6259, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62176@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6260] = {id = 6260, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62177@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6261] = {id = 6261, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62180@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6262] = {id = 6262, bgm = 32, transferID = 3, bossID = 63001, bossIDSecond = 0, 
enemyPositions = {"0", "63001@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6263] = {id = 6263, bgm = 60, transferID = 4, bossID = 63002, bossIDSecond = 0, 
enemyPositions = {"0", "63002@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6264] = {id = 6264, bgm = 32, transferID = 1, bossID = 63003, bossIDSecond = 0, 
enemyPositions = {"0", "63003@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6265] = {id = 6265, bgm = 133, transferID = 1, bossID = 63004, bossIDSecond = 0, 
enemyPositions = {"0", "0", "63004@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6267] = {id = 6267, bgm = 32, transferID = 1, bossID = 63006, bossIDSecond = 0, 
enemyPositions = {"0", "63006@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6269] = {id = 6269, bgm = 452, transferID = 1, bossID = 63008, bossIDSecond = 0, 
enemyPositions = {"0", "63008@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6270] = {id = 6270, bgm = 754, transferID = 1, bossID = 63011, bossIDSecond = 0, 
enemyPositions = {"0", "0", "63011@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6271] = {id = 6271, bgm = 997, transferID = 1, bossID = 63010, bossIDSecond = 0, 
enemyPositions = {"0", "0", "63012@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6272] = {id = 6272, bgm = 3, transferID = 1, bossID = 63016, bossIDSecond = 0, 
enemyPositions = {"0", "0", "63016@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6273] = {id = 6273, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "64001@100", "0", "64001@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6274] = {id = 6274, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "64002@100", "0", "64002@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6275] = {id = 6275, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "64004@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6276] = {id = 6276, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "64003@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6277] = {id = 6277, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"64005@100", "64005@100", "64005@100", "64005@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6278] = {id = 6278, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"64006@100", "0", "64006@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6279] = {id = 6279, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"64007@100", "0", "64007@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6280] = {id = 6280, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"64008@100", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6281] = {id = 6281, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62103@100", "0", "62103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6282] = {id = 6282, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62103@100", "0", "62103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6283] = {id = 6283, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62103@100", "0", "62103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6284] = {id = 6284, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62103@100", "0", "62103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6285] = {id = 6285, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"62103@100", "0", "62103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6286] = {id = 6286, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62181@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6287] = {id = 6287, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62182@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6288] = {id = 6288, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62183@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6289] = {id = 6289, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62184@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6290] = {id = 6290, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62185@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6291] = {id = 6291, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62186@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6292] = {id = 6292, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62187@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6293] = {id = 6293, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62188@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6294] = {id = 6294, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62189@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6295] = {id = 6295, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62190@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6296] = {id = 6296, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62191@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6297] = {id = 6297, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62192@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6298] = {id = 6298, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62193@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6299] = {id = 6299, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62194@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6300] = {id = 6300, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62195@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6301] = {id = 6301, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62196@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6302] = {id = 6302, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62197@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6303] = {id = 6303, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62198@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6304] = {id = 6304, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62199@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6305] = {id = 6305, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62200@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6306] = {id = 6306, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62201@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6307] = {id = 6307, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62202@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6308] = {id = 6308, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62203@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6309] = {id = 6309, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62204@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6310] = {id = 6310, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62205@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6311] = {id = 6311, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62206@100", "62206@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6312] = {id = 6312, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62207@100", "62207@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6313] = {id = 6313, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62208@100", "62208@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6314] = {id = 6314, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62209@100", "62209@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6315] = {id = 6315, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62210@100", "62210@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6316] = {id = 6316, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62211@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6317] = {id = 6317, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62212@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6318] = {id = 6318, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62213@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6319] = {id = 6319, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62214@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6320] = {id = 6320, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62215@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6321] = {id = 6321, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62217@100", "0", "62216@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6322] = {id = 6322, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62219@100", "0", "62218@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6323] = {id = 6323, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62221@100", "0", "62220@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6324] = {id = 6324, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62223@100", "0", "62222@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6325] = {id = 6325, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62225@100", "0", "62224@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6326] = {id = 6326, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62226@100", "62226@100", "62226@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6327] = {id = 6327, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62227@100", "62227@100", "62227@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6328] = {id = 6328, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62228@100", "62228@100", "62228@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6329] = {id = 6329, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62229@100", "62229@100", "62229@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6330] = {id = 6330, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62230@100", "62230@200", "62230@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6331] = {id = 6331, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62231@100", "0", "62231@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6332] = {id = 6332, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62232@100", "0", "62232@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6333] = {id = 6333, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62233@100", "0", "62233@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6334] = {id = 6334, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62234@100", "0", "62234@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6335] = {id = 6335, bgm = 253, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62235@100", "0", "62235@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[6336] = {id = 6336, bgm = 3, transferID = 1, bossID = 62236, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62236@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6337] = {id = 6337, bgm = 3, transferID = 1, bossID = 62237, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62237@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6338] = {id = 6338, bgm = 3, transferID = 1, bossID = 62238, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62238@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6339] = {id = 6339, bgm = 3, transferID = 1, bossID = 62239, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62239@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6340] = {id = 6340, bgm = 3, transferID = 1, bossID = 62240, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62240@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6341] = {id = 6341, bgm = 3, transferID = 1, bossID = 62241, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62241@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6342] = {id = 6342, bgm = 3, transferID = 1, bossID = 62242, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62242@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6343] = {id = 6343, bgm = 3, transferID = 1, bossID = 62243, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62243@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6344] = {id = 6344, bgm = 3, transferID = 1, bossID = 62244, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62244@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6345] = {id = 6345, bgm = 3, transferID = 1, bossID = 62245, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62245@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6346] = {id = 6346, bgm = 3, transferID = 1, bossID = 62246, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62246@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6347] = {id = 6347, bgm = 3, transferID = 1, bossID = 62247, bossIDSecond = 0, 
enemyPositions = {"0", "0", "62247@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[6348] = {id = 6348, bgm = 997, transferID = 1, bossID = 63010, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66057@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6349] = {id = 6349, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6350] = {id = 6350, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6351] = {id = 6351, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6352] = {id = 6352, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6353] = {id = 6353, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6354] = {id = 6354, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6355] = {id = 6355, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6356] = {id = 6356, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6357] = {id = 6357, bgm = 3, transferID = 1, bossID = 66203, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66203@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6358] = {id = 6358, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6359] = {id = 6359, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6360] = {id = 6360, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6361] = {id = 6361, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6362] = {id = 6362, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6363] = {id = 6363, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6364] = {id = 6364, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6365] = {id = 6365, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6366] = {id = 6366, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6367] = {id = 6367, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6368] = {id = 6368, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6369] = {id = 6369, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6370] = {id = 6370, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6371] = {id = 6371, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6372] = {id = 6372, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6373] = {id = 6373, bgm = 32, transferID = 1, bossID = 66211, bossIDSecond = 0, 
enemyPositions = {"66213@100", "66211@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6374] = {id = 6374, bgm = 32, transferID = 1, bossID = 66210, bossIDSecond = 0, 
enemyPositions = {"66213@100", "66210@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6375] = {id = 6375, bgm = 32, transferID = 1, bossID = 66212, bossIDSecond = 0, 
enemyPositions = {"66213@100", "0", "66212@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6376] = {id = 6376, bgm = 32, transferID = 1, bossID = 66209, bossIDSecond = 0, 
enemyPositions = {"66213@100", "66209@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6377] = {id = 6377, bgm = 32, transferID = 1, bossID = 66210, bossIDSecond = 0, 
enemyPositions = {"66213@100", "66210@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6378] = {id = 6378, bgm = 32, transferID = 1, bossID = 66212, bossIDSecond = 0, 
enemyPositions = {"66213@100", "0", "66212@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6379] = {id = 6379, bgm = 32, transferID = 1, bossID = 66209, bossIDSecond = 0, 
enemyPositions = {"66213@100", "66209@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6380] = {id = 6380, bgm = 32, transferID = 1, bossID = 66209, bossIDSecond = 0, 
enemyPositions = {"66213@100", "66209@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6381] = {id = 6381, bgm = 3, transferID = 1, bossID = 66203, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66203@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6382] = {id = 6382, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6383] = {id = 6383, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6384] = {id = 6384, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6385] = {id = 6385, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6386] = {id = 6386, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6387] = {id = 6387, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6388] = {id = 6388, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6389] = {id = 6389, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6390] = {id = 6390, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6391] = {id = 6391, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6392] = {id = 6392, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6393] = {id = 6393, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6394] = {id = 6394, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6395] = {id = 6395, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6396] = {id = 6396, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6397] = {id = 6397, bgm = 3, transferID = 1, bossID = 66203, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66203@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6398] = {id = 6398, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6399] = {id = 6399, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6400] = {id = 6400, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6401] = {id = 6401, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6402] = {id = 6402, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6403] = {id = 6403, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6404] = {id = 6404, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6405] = {id = 6405, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66396@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6406] = {id = 6406, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6407] = {id = 6407, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6408] = {id = 6408, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6409] = {id = 6409, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6410] = {id = 6410, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6411] = {id = 6411, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6412] = {id = 6412, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6413] = {id = 6413, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6414] = {id = 6414, bgm = 3, transferID = 1, bossID = 66203, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66203@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6415] = {id = 6415, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6416] = {id = 6416, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6417] = {id = 6417, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6418] = {id = 6418, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6419] = {id = 6419, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6420] = {id = 6420, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6421] = {id = 6421, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6422] = {id = 6422, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6423] = {id = 6423, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6424] = {id = 6424, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6425] = {id = 6425, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6426] = {id = 6426, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6427] = {id = 6427, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6428] = {id = 6428, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6429] = {id = 6429, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6430] = {id = 6430, bgm = 3, transferID = 1, bossID = 66203, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66203@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6431] = {id = 6431, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6432] = {id = 6432, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6433] = {id = 6433, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6434] = {id = 6434, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6435] = {id = 6435, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6436] = {id = 6436, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6437] = {id = 6437, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6438] = {id = 6438, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6439] = {id = 6439, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6440] = {id = 6440, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6441] = {id = 6441, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6442] = {id = 6442, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6443] = {id = 6443, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6444] = {id = 6444, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6445] = {id = 6445, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6446] = {id = 6446, bgm = 3, transferID = 1, bossID = 66203, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66203@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6447] = {id = 6447, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6448] = {id = 6448, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6449] = {id = 6449, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6450] = {id = 6450, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6451] = {id = 6451, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6452] = {id = 6452, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6453] = {id = 6453, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6454] = {id = 6454, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6455] = {id = 6455, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6456] = {id = 6456, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6457] = {id = 6457, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6458] = {id = 6458, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6459] = {id = 6459, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6460] = {id = 6460, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6461] = {id = 6461, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6462] = {id = 6462, bgm = 3, transferID = 1, bossID = 66203, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66203@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6463] = {id = 6463, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6464] = {id = 6464, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6465] = {id = 6465, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6466] = {id = 6466, bgm = 32, transferID = 1, bossID = 66204, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66204@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6467] = {id = 6467, bgm = 32, transferID = 1, bossID = 66205, bossIDSecond = 0, 
enemyPositions = {"66208@100", "0", "0", "66205@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6468] = {id = 6468, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6469] = {id = 6469, bgm = 32, transferID = 1, bossID = 66207, bossIDSecond = 0, 
enemyPositions = {"66208@100", "66206@100", "0", "66207@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6470] = {id = 6470, bgm = 3, transferID = 1, bossID = 66060, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "66060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6471] = {id = 6471, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6472] = {id = 6472, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6473] = {id = 6473, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6474] = {id = 6474, bgm = 32, transferID = 1, bossID = 66062, bossIDSecond = 0, 
enemyPositions = {"66065@100", "66061@100", "0", "66062@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6475] = {id = 6475, bgm = 32, transferID = 1, bossID = 66063, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66063@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6476] = {id = 6476, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6477] = {id = 6477, bgm = 32, transferID = 1, bossID = 66064, bossIDSecond = 0, 
enemyPositions = {"66065@100", "0", "0", "66064@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6478] = {id = 6478, bgm = 133, transferID = 1, bossID = 66432, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66432@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6479] = {id = 6479, bgm = 133, transferID = 1, bossID = 66433, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66433@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6480] = {id = 6480, bgm = 133, transferID = 1, bossID = 66434, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66434@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6481] = {id = 6481, bgm = 133, transferID = 1, bossID = 66435, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66435@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6482] = {id = 6482, bgm = 133, transferID = 1, bossID = 66436, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66436@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6483] = {id = 6483, bgm = 133, transferID = 1, bossID = 66437, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66437@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6484] = {id = 6484, bgm = 133, transferID = 1, bossID = 66438, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66438@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6485] = {id = 6485, bgm = 133, transferID = 1, bossID = 66439, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66439@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6486] = {id = 6486, bgm = 133, transferID = 1, bossID = 66440, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66440@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6487] = {id = 6487, bgm = 133, transferID = 1, bossID = 66441, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66441@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6488] = {id = 6488, bgm = 133, transferID = 1, bossID = 66442, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66442@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6489] = {id = 6489, bgm = 133, transferID = 1, bossID = 66443, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66443@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6490] = {id = 6490, bgm = 133, transferID = 1, bossID = 66444, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66444@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6491] = {id = 6491, bgm = 133, transferID = 1, bossID = 66445, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66445@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6492] = {id = 6492, bgm = 133, transferID = 1, bossID = 66446, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66446@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6493] = {id = 6493, bgm = 133, transferID = 1, bossID = 66447, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66447@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6494] = {id = 6494, bgm = 133, transferID = 1, bossID = 66448, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66448@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6495] = {id = 6495, bgm = 133, transferID = 1, bossID = 66449, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66449@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6497] = {id = 6497, bgm = 32, transferID = 1, bossID = 66450, bossIDSecond = 0, 
enemyPositions = {"0", "66450@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6498] = {id = 6498, bgm = 32, transferID = 1, bossID = 66451, bossIDSecond = 0, 
enemyPositions = {"0", "66451@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6499] = {id = 6499, bgm = 32, transferID = 1, bossID = 66452, bossIDSecond = 0, 
enemyPositions = {"0", "66452@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6500] = {id = 6500, bgm = 32, transferID = 1, bossID = 66453, bossIDSecond = 0, 
enemyPositions = {"0", "66453@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6501] = {id = 6501, bgm = 32, transferID = 1, bossID = 66454, bossIDSecond = 0, 
enemyPositions = {"0", "66454@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6502] = {id = 6502, bgm = 32, transferID = 1, bossID = 66455, bossIDSecond = 0, 
enemyPositions = {"0", "66455@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6503] = {id = 6503, bgm = 32, transferID = 1, bossID = 66456, bossIDSecond = 0, 
enemyPositions = {"0", "66456@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6504] = {id = 6504, bgm = 32, transferID = 1, bossID = 66457, bossIDSecond = 0, 
enemyPositions = {"0", "66457@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6505] = {id = 6505, bgm = 32, transferID = 1, bossID = 66458, bossIDSecond = 0, 
enemyPositions = {"0", "66458@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6506] = {id = 6506, bgm = 32, transferID = 1, bossID = 66459, bossIDSecond = 0, 
enemyPositions = {"0", "66459@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6507] = {id = 6507, bgm = 32, transferID = 1, bossID = 66460, bossIDSecond = 0, 
enemyPositions = {"0", "66460@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6508] = {id = 6508, bgm = 32, transferID = 1, bossID = 66461, bossIDSecond = 0, 
enemyPositions = {"0", "66461@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6509] = {id = 6509, bgm = 32, transferID = 1, bossID = 66462, bossIDSecond = 0, 
enemyPositions = {"0", "66462@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6510] = {id = 6510, bgm = 32, transferID = 1, bossID = 66463, bossIDSecond = 0, 
enemyPositions = {"0", "66463@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6511] = {id = 6511, bgm = 32, transferID = 1, bossID = 66464, bossIDSecond = 0, 
enemyPositions = {"0", "66464@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6512] = {id = 6512, bgm = 32, transferID = 1, bossID = 66465, bossIDSecond = 0, 
enemyPositions = {"0", "66465@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6513] = {id = 6513, bgm = 32, transferID = 1, bossID = 66466, bossIDSecond = 0, 
enemyPositions = {"0", "66466@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6514] = {id = 6514, bgm = 32, transferID = 1, bossID = 66467, bossIDSecond = 0, 
enemyPositions = {"0", "66467@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6515] = {id = 6515, bgm = 60, transferID = 4, bossID = 66468, bossIDSecond = 0, 
enemyPositions = {"0", "66468@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6516] = {id = 6516, bgm = 60, transferID = 4, bossID = 66469, bossIDSecond = 0, 
enemyPositions = {"0", "66469@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6517] = {id = 6517, bgm = 60, transferID = 4, bossID = 66470, bossIDSecond = 0, 
enemyPositions = {"0", "66470@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6518] = {id = 6518, bgm = 60, transferID = 4, bossID = 66471, bossIDSecond = 0, 
enemyPositions = {"0", "66471@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6519] = {id = 6519, bgm = 60, transferID = 4, bossID = 66472, bossIDSecond = 0, 
enemyPositions = {"0", "66472@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6520] = {id = 6520, bgm = 60, transferID = 4, bossID = 66473, bossIDSecond = 0, 
enemyPositions = {"0", "66473@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6521] = {id = 6521, bgm = 60, transferID = 4, bossID = 66474, bossIDSecond = 0, 
enemyPositions = {"0", "66474@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6522] = {id = 6522, bgm = 60, transferID = 4, bossID = 66475, bossIDSecond = 0, 
enemyPositions = {"0", "66475@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6523] = {id = 6523, bgm = 60, transferID = 4, bossID = 66476, bossIDSecond = 0, 
enemyPositions = {"0", "66476@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6524] = {id = 6524, bgm = 60, transferID = 4, bossID = 66477, bossIDSecond = 0, 
enemyPositions = {"0", "66477@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6525] = {id = 6525, bgm = 60, transferID = 4, bossID = 66478, bossIDSecond = 0, 
enemyPositions = {"0", "66478@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6526] = {id = 6526, bgm = 60, transferID = 4, bossID = 66479, bossIDSecond = 0, 
enemyPositions = {"0", "66479@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6527] = {id = 6527, bgm = 60, transferID = 4, bossID = 66480, bossIDSecond = 0, 
enemyPositions = {"0", "66480@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6528] = {id = 6528, bgm = 60, transferID = 4, bossID = 66481, bossIDSecond = 0, 
enemyPositions = {"0", "66481@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6529] = {id = 6529, bgm = 60, transferID = 4, bossID = 66482, bossIDSecond = 0, 
enemyPositions = {"0", "66482@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6530] = {id = 6530, bgm = 60, transferID = 4, bossID = 66483, bossIDSecond = 0, 
enemyPositions = {"0", "66483@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6531] = {id = 6531, bgm = 60, transferID = 4, bossID = 66484, bossIDSecond = 0, 
enemyPositions = {"0", "66484@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6532] = {id = 6532, bgm = 60, transferID = 4, bossID = 66485, bossIDSecond = 0, 
enemyPositions = {"0", "66485@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6533] = {id = 6533, bgm = 32, transferID = 3, bossID = 66486, bossIDSecond = 0, 
enemyPositions = {"0", "66486@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6534] = {id = 6534, bgm = 32, transferID = 3, bossID = 66487, bossIDSecond = 0, 
enemyPositions = {"0", "66487@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6535] = {id = 6535, bgm = 32, transferID = 3, bossID = 66488, bossIDSecond = 0, 
enemyPositions = {"0", "66488@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6536] = {id = 6536, bgm = 32, transferID = 3, bossID = 66489, bossIDSecond = 0, 
enemyPositions = {"0", "66489@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6537] = {id = 6537, bgm = 32, transferID = 3, bossID = 66490, bossIDSecond = 0, 
enemyPositions = {"0", "66490@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6538] = {id = 6538, bgm = 32, transferID = 3, bossID = 66491, bossIDSecond = 0, 
enemyPositions = {"0", "66491@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6539] = {id = 6539, bgm = 32, transferID = 3, bossID = 66492, bossIDSecond = 0, 
enemyPositions = {"0", "66492@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6540] = {id = 6540, bgm = 32, transferID = 3, bossID = 66493, bossIDSecond = 0, 
enemyPositions = {"0", "66493@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6541] = {id = 6541, bgm = 32, transferID = 3, bossID = 66494, bossIDSecond = 0, 
enemyPositions = {"0", "66494@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6542] = {id = 6542, bgm = 32, transferID = 3, bossID = 66495, bossIDSecond = 0, 
enemyPositions = {"0", "66495@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6543] = {id = 6543, bgm = 32, transferID = 3, bossID = 66496, bossIDSecond = 0, 
enemyPositions = {"0", "66496@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6544] = {id = 6544, bgm = 32, transferID = 3, bossID = 66497, bossIDSecond = 0, 
enemyPositions = {"0", "66497@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6545] = {id = 6545, bgm = 32, transferID = 3, bossID = 66498, bossIDSecond = 0, 
enemyPositions = {"0", "66498@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6546] = {id = 6546, bgm = 32, transferID = 3, bossID = 66499, bossIDSecond = 0, 
enemyPositions = {"0", "66499@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6547] = {id = 6547, bgm = 32, transferID = 3, bossID = 66500, bossIDSecond = 0, 
enemyPositions = {"0", "66500@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6548] = {id = 6548, bgm = 32, transferID = 3, bossID = 66501, bossIDSecond = 0, 
enemyPositions = {"0", "66501@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6549] = {id = 6549, bgm = 32, transferID = 3, bossID = 66502, bossIDSecond = 0, 
enemyPositions = {"0", "66502@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6550] = {id = 6550, bgm = 32, transferID = 3, bossID = 66503, bossIDSecond = 0, 
enemyPositions = {"0", "66503@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6551] = {id = 6551, bgm = 32, transferID = 1, bossID = 66504, bossIDSecond = 0, 
enemyPositions = {"0", "66504@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6552] = {id = 6552, bgm = 32, transferID = 1, bossID = 66505, bossIDSecond = 0, 
enemyPositions = {"0", "66505@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6553] = {id = 6553, bgm = 32, transferID = 1, bossID = 66506, bossIDSecond = 0, 
enemyPositions = {"0", "66506@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6554] = {id = 6554, bgm = 32, transferID = 1, bossID = 66507, bossIDSecond = 0, 
enemyPositions = {"0", "66507@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6555] = {id = 6555, bgm = 32, transferID = 1, bossID = 66508, bossIDSecond = 0, 
enemyPositions = {"0", "66508@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6556] = {id = 6556, bgm = 32, transferID = 1, bossID = 66509, bossIDSecond = 0, 
enemyPositions = {"0", "66509@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6557] = {id = 6557, bgm = 32, transferID = 1, bossID = 66510, bossIDSecond = 0, 
enemyPositions = {"0", "66510@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6558] = {id = 6558, bgm = 32, transferID = 1, bossID = 66511, bossIDSecond = 0, 
enemyPositions = {"0", "66511@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6559] = {id = 6559, bgm = 32, transferID = 1, bossID = 66512, bossIDSecond = 0, 
enemyPositions = {"0", "66512@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6560] = {id = 6560, bgm = 32, transferID = 1, bossID = 66513, bossIDSecond = 0, 
enemyPositions = {"0", "66513@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6561] = {id = 6561, bgm = 32, transferID = 1, bossID = 66514, bossIDSecond = 0, 
enemyPositions = {"0", "66514@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6562] = {id = 6562, bgm = 32, transferID = 1, bossID = 66515, bossIDSecond = 0, 
enemyPositions = {"0", "66515@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6563] = {id = 6563, bgm = 32, transferID = 1, bossID = 66516, bossIDSecond = 0, 
enemyPositions = {"0", "66516@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6564] = {id = 6564, bgm = 32, transferID = 1, bossID = 66517, bossIDSecond = 0, 
enemyPositions = {"0", "66517@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6565] = {id = 6565, bgm = 32, transferID = 1, bossID = 66518, bossIDSecond = 0, 
enemyPositions = {"0", "66518@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6566] = {id = 6566, bgm = 32, transferID = 1, bossID = 66519, bossIDSecond = 0, 
enemyPositions = {"0", "66519@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6567] = {id = 6567, bgm = 32, transferID = 1, bossID = 66520, bossIDSecond = 0, 
enemyPositions = {"0", "66520@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6568] = {id = 6568, bgm = 32, transferID = 1, bossID = 66521, bossIDSecond = 0, 
enemyPositions = {"0", "66521@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6569] = {id = 6569, bgm = 452, transferID = 1, bossID = 66522, bossIDSecond = 0, 
enemyPositions = {"0", "66522@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6570] = {id = 6570, bgm = 452, transferID = 1, bossID = 66523, bossIDSecond = 0, 
enemyPositions = {"0", "66523@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6571] = {id = 6571, bgm = 452, transferID = 1, bossID = 66524, bossIDSecond = 0, 
enemyPositions = {"0", "66524@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6572] = {id = 6572, bgm = 452, transferID = 1, bossID = 66525, bossIDSecond = 0, 
enemyPositions = {"0", "66525@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6573] = {id = 6573, bgm = 452, transferID = 1, bossID = 66526, bossIDSecond = 0, 
enemyPositions = {"0", "66526@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6574] = {id = 6574, bgm = 452, transferID = 1, bossID = 66527, bossIDSecond = 0, 
enemyPositions = {"0", "66527@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6575] = {id = 6575, bgm = 452, transferID = 1, bossID = 66528, bossIDSecond = 0, 
enemyPositions = {"0", "66528@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6576] = {id = 6576, bgm = 452, transferID = 1, bossID = 66529, bossIDSecond = 0, 
enemyPositions = {"0", "66529@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6577] = {id = 6577, bgm = 452, transferID = 1, bossID = 66530, bossIDSecond = 0, 
enemyPositions = {"0", "66530@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6578] = {id = 6578, bgm = 452, transferID = 1, bossID = 66531, bossIDSecond = 0, 
enemyPositions = {"0", "66531@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6579] = {id = 6579, bgm = 452, transferID = 1, bossID = 66532, bossIDSecond = 0, 
enemyPositions = {"0", "66532@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6580] = {id = 6580, bgm = 452, transferID = 1, bossID = 66533, bossIDSecond = 0, 
enemyPositions = {"0", "66533@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6581] = {id = 6581, bgm = 452, transferID = 1, bossID = 66534, bossIDSecond = 0, 
enemyPositions = {"0", "66534@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6582] = {id = 6582, bgm = 452, transferID = 1, bossID = 66535, bossIDSecond = 0, 
enemyPositions = {"0", "66535@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6583] = {id = 6583, bgm = 452, transferID = 1, bossID = 66536, bossIDSecond = 0, 
enemyPositions = {"0", "66536@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6584] = {id = 6584, bgm = 452, transferID = 1, bossID = 66537, bossIDSecond = 0, 
enemyPositions = {"0", "66537@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6585] = {id = 6585, bgm = 452, transferID = 1, bossID = 66538, bossIDSecond = 0, 
enemyPositions = {"0", "66538@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6586] = {id = 6586, bgm = 452, transferID = 1, bossID = 66539, bossIDSecond = 0, 
enemyPositions = {"0", "66539@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6587] = {id = 6587, bgm = 754, transferID = 1, bossID = 66540, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66540@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6588] = {id = 6588, bgm = 754, transferID = 1, bossID = 66541, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66541@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6589] = {id = 6589, bgm = 754, transferID = 1, bossID = 66542, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66542@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6590] = {id = 6590, bgm = 754, transferID = 1, bossID = 66543, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66543@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6591] = {id = 6591, bgm = 754, transferID = 1, bossID = 66544, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66544@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6592] = {id = 6592, bgm = 754, transferID = 1, bossID = 66545, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66545@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6593] = {id = 6593, bgm = 754, transferID = 1, bossID = 66546, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66546@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6594] = {id = 6594, bgm = 754, transferID = 1, bossID = 66547, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66547@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6595] = {id = 6595, bgm = 754, transferID = 1, bossID = 66548, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66548@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6596] = {id = 6596, bgm = 754, transferID = 1, bossID = 66549, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66549@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6597] = {id = 6597, bgm = 754, transferID = 1, bossID = 66550, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66550@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6598] = {id = 6598, bgm = 754, transferID = 1, bossID = 66551, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66551@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6599] = {id = 6599, bgm = 754, transferID = 1, bossID = 66552, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66552@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6600] = {id = 6600, bgm = 754, transferID = 1, bossID = 66553, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66553@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6601] = {id = 6601, bgm = 754, transferID = 1, bossID = 66554, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66554@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6602] = {id = 6602, bgm = 754, transferID = 1, bossID = 66555, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66555@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6603] = {id = 6603, bgm = 754, transferID = 1, bossID = 66556, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66556@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6604] = {id = 6604, bgm = 754, transferID = 1, bossID = 66557, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66557@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6605] = {id = 6605, bgm = 997, transferID = 1, bossID = 66576, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66576@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6606] = {id = 6606, bgm = 997, transferID = 1, bossID = 66577, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66577@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6607] = {id = 6607, bgm = 997, transferID = 1, bossID = 66578, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66578@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6608] = {id = 6608, bgm = 997, transferID = 1, bossID = 66579, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66579@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6609] = {id = 6609, bgm = 997, transferID = 1, bossID = 66580, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66580@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6610] = {id = 6610, bgm = 997, transferID = 1, bossID = 66581, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66581@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6611] = {id = 6611, bgm = 997, transferID = 1, bossID = 66582, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66582@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6612] = {id = 6612, bgm = 997, transferID = 1, bossID = 66583, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66583@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6613] = {id = 6613, bgm = 997, transferID = 1, bossID = 66584, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66584@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6614] = {id = 6614, bgm = 997, transferID = 1, bossID = 66585, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66585@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6615] = {id = 6615, bgm = 997, transferID = 1, bossID = 66586, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66586@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6616] = {id = 6616, bgm = 997, transferID = 1, bossID = 66587, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66587@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6617] = {id = 6617, bgm = 997, transferID = 1, bossID = 66588, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66588@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6618] = {id = 6618, bgm = 997, transferID = 1, bossID = 66589, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66589@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6619] = {id = 6619, bgm = 997, transferID = 1, bossID = 66590, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66590@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6620] = {id = 6620, bgm = 997, transferID = 1, bossID = 66591, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66591@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6621] = {id = 6621, bgm = 997, transferID = 1, bossID = 66592, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66592@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6622] = {id = 6622, bgm = 997, transferID = 1, bossID = 66593, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66593@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6623] = {id = 6623, bgm = 133, transferID = 1, bossID = 67169, bossIDSecond = 0, 
enemyPositions = {"0", "67169@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6624] = {id = 6624, bgm = 32, transferID = 1, bossID = 67170, bossIDSecond = 0, 
enemyPositions = {"0", "67170@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6625] = {id = 6625, bgm = 60, transferID = 1, bossID = 67171, bossIDSecond = 0, 
enemyPositions = {"0", "67171@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6626] = {id = 6626, bgm = 32, transferID = 1, bossID = 67172, bossIDSecond = 0, 
enemyPositions = {"0", "67172@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6627] = {id = 6627, bgm = 32, transferID = 1, bossID = 67173, bossIDSecond = 0, 
enemyPositions = {"0", "67173@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[6628] = {id = 6628, bgm = 452, transferID = 1, bossID = 67174, bossIDSecond = 0, 
enemyPositions = {"0", "67174@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[7001] = {id = 7001, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65004@100", "0", "65004@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7002] = {id = 7002, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65004@100", "65004@100", "65004@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7003] = {id = 7003, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65001@100", "65001@100", "65001@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7004] = {id = 7004, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65005@100", "65005@100", "65005@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7005] = {id = 7005, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "65006@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7006] = {id = 7006, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65002@100", "65002@100", "65002@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7007] = {id = 7007, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65002@100", "65002@100", "65002@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7008] = {id = 7008, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65002@100", "65002@100", "65002@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7009] = {id = 7009, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65003@100", "65003@100", "65003@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7010] = {id = 7010, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "65007@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7011] = {id = 7011, bgm = 454, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "65008@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[7012] = {id = 7012, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65003@100", "65003@100", "65003@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7013] = {id = 7013, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"65003@100", "65003@100", "65003@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7014] = {id = 7014, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66214@100", "0", "66214@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7015] = {id = 7015, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66215@100", "66215@100", "66215@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7016] = {id = 7016, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66216@100", "66216@100", "66216@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7017] = {id = 7017, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66217@100", "0", "66217@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7018] = {id = 7018, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66219@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7019] = {id = 7019, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66214@100", "0", "66214@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7020] = {id = 7020, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66215@100", "66215@100", "66215@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7021] = {id = 7021, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66216@100", "66216@100", "66216@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7022] = {id = 7022, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66218@100", "0", "66218@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7023] = {id = 7023, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66220@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7024] = {id = 7024, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66217@100", "0", "66217@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7025] = {id = 7025, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66218@100", "0", "66218@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[7026] = {id = 7026, bgm = 454, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66221@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[7027] = {id = 7027, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66220@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8001] = {id = 8001, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80001@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8002] = {id = 8002, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80002@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8003] = {id = 8003, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80003@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8004] = {id = 8004, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80004@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8005] = {id = 8005, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80005@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8006] = {id = 8006, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80006@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8007] = {id = 8007, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80007@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8008] = {id = 8008, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80008@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8009] = {id = 8009, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80009@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8010] = {id = 8010, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80010@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8011] = {id = 8011, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80011@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8012] = {id = 8012, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80012@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8013] = {id = 8013, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80013@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8014] = {id = 8014, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80014@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8015] = {id = 8015, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80015@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8016] = {id = 8016, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80016@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8017] = {id = 8017, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80017@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8018] = {id = 8018, bgm = 454, transferID = 1, bossID = 80018, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80018@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8019] = {id = 8019, bgm = 32, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80019@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8020] = {id = 8020, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80022@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8021] = {id = 8021, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80023@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8022] = {id = 8022, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "62211@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8023] = {id = 8023, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80025@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8024] = {id = 8024, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80026@100", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8025] = {id = 8025, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80027@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8026] = {id = 8026, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80028@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8027] = {id = 8027, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80029@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8028] = {id = 8028, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80030@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8029] = {id = 8029, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80031@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8030] = {id = 8030, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80032@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8031] = {id = 8031, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80033@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8032] = {id = 8032, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80034@100", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8033] = {id = 8033, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80035@100", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8034] = {id = 8034, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80036@100", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8035] = {id = 8035, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80037@100", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8036] = {id = 8036, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80043@100", "80038@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8037] = {id = 8037, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80039@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8038] = {id = 8038, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80040@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8039] = {id = 8039, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80041@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8040] = {id = 8040, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80042@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8041] = {id = 8041, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80045@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8042] = {id = 8042, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80046@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8043] = {id = 8043, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "20230@100"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8044] = {id = 8044, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80047@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8045] = {id = 8045, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80048@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8046] = {id = 8046, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80049@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8047] = {id = 8047, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80050@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8048] = {id = 8048, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"20234@100", "20235@100", "20236@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8049] = {id = 8049, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80051@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8050] = {id = 8050, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80052@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8051] = {id = 8051, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20231@100", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8052] = {id = 8052, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80053@100", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8053] = {id = 8053, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "20233", "0"}
, result = 0, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[8054] = {id = 8054, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80054@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8055] = {id = 8055, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80055@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8056] = {id = 8056, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80056@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8057] = {id = 8057, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80057@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8058] = {id = 8058, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80058@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8059] = {id = 8059, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80059@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8060] = {id = 8060, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80060@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8061] = {id = 8061, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80061@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8062] = {id = 8062, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80062@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8063] = {id = 8063, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80063@100", "80063@100", "80063@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8064] = {id = 8064, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80064@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8065] = {id = 8065, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80065@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8066] = {id = 8066, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80066@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8067] = {id = 8067, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80067@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8068] = {id = 8068, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "80068@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8069] = {id = 8069, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80069@100", "80069@100", "80069@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8070] = {id = 8070, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80072@100", "80072@100", "80072@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8071] = {id = 8071, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80063@100", "80063@100", "80063@100", "80073@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8072] = {id = 8072, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80063@100", "80063@100", "80063@100", "80074@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8073] = {id = 8073, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80063@100", "80063@100", "80063@100", "80075@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8074] = {id = 8074, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80063@100", "80063@100", "80063@100", "80076@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8075] = {id = 8075, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80063@100", "80063@100", "80065@100", "80077@100"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8076] = {id = 8076, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80079@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8077] = {id = 8077, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80080@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8078] = {id = 8078, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80081@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8079] = {id = 8079, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80082@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8080] = {id = 8080, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80083@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8081] = {id = 8081, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80084@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8082] = {id = 8082, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80085@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8083] = {id = 8083, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80086@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8084] = {id = 8084, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80087@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8085] = {id = 8085, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80088@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8086] = {id = 8086, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80089@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8087] = {id = 8087, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80091@100", "80092@100", "80093@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8088] = {id = 8088, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"80091@100", "0", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8089] = {id = 8089, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80092@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8090] = {id = 8090, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80093@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8091] = {id = 8091, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80090@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8092] = {id = 8092, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80094@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8093] = {id = 8093, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80095@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8094] = {id = 8094, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80096@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8095] = {id = 8095, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "80097@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8096] = {id = 8096, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80097@100", "80096@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8097] = {id = 8097, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80098@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8098] = {id = 8098, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80099@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8099] = {id = 8099, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80100@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8100] = {id = 8100, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80102@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8101] = {id = 8101, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67001@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8102] = {id = 8102, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80103@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8103] = {id = 8103, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80104@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8104] = {id = 8104, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80105@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[8105] = {id = 8105, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"20055@100", "20055@100", "20055@100", "0"}
, result = 0, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[8106] = {id = 8106, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "80106@100", "0", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[9001] = {id = 9001, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[9002] = {id = 9002, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[9003] = {id = 9003, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[9004] = {id = 9004, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[9495] = {id = 9495, bgm = 133, transferID = 1, bossID = 66449, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66449@100", "0"}
, result = 1, auto = 1, enemyMessage = 0, defeatResult = 0}
, 
[10001] = {id = 10001, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66001@100", "66001@100", "66001@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10002] = {id = 10002, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66002@100", "66002@100", "66002@100", "66019@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10003] = {id = 10003, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66004@100", "66004@100", "66004@100", "66020@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10004] = {id = 10004, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66006@100", "66006@100", "66006@100", "66021@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10005] = {id = 10005, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66010@100", "66010@100", "66010@100", "66022@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10006] = {id = 10006, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66012@100", "66012@100", "66012@100", "66023@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10007] = {id = 10007, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66015@100", "66015@100", "66024@100", "66026@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10008] = {id = 10008, bgm = 1254, transferID = 1, bossID = 66027, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66027@100"}
, result = 1, auto = 1, enemyMessage = 1, defeatResult = 0}
, 
[10009] = {id = 10009, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66029@100", "66029@100", "66029@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10010] = {id = 10010, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66030@100", "66030@100", "66030@100", "66049@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10011] = {id = 10011, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66032@100", "66032@100", "66032@100", "66050@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10012] = {id = 10012, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66034@100", "66034@100", "66034@100", "66051@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10013] = {id = 10013, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66038@100", "66038@100", "66038@100", "66052@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10014] = {id = 10014, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66040@100", "66040@100", "66040@100", "66053@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10015] = {id = 10015, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66043@100", "66043@100", "66054@100", "66047@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10016] = {id = 10016, bgm = 1254, transferID = 1, bossID = 66055, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66055@100"}
, result = 1, auto = 1, enemyMessage = 1, defeatResult = 0}
, 
[10017] = {id = 10017, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66066@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10018] = {id = 10018, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66067@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10019] = {id = 10019, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66068@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10020] = {id = 10020, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66069@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10021] = {id = 10021, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66070@100", "0", "66071@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10022] = {id = 10022, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66072@100", "0", "66073@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10023] = {id = 10023, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66074@100", "0", "66075@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10024] = {id = 10024, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66076@100", "0", "66077@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10025] = {id = 10025, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66078@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10026] = {id = 10026, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66079@100", "0", "66080@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10027] = {id = 10027, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66081@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10028] = {id = 10028, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66082@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10029] = {id = 10029, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66083@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10030] = {id = 10030, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66084@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10031] = {id = 10031, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66085@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10032] = {id = 10032, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66087@100", "0", "66086@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10033] = {id = 10033, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66088@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10034] = {id = 10034, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66089@100", "0", "66090@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10035] = {id = 10035, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66091@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10036] = {id = 10036, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66092@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10037] = {id = 10037, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66093@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10038] = {id = 10038, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66094@100", "0", "66095@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10039] = {id = 10039, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66096@100", "0", "66097@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10040] = {id = 10040, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66098@100", "66098@100", "66099@100", "66099@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10041] = {id = 10041, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66100@100", "66100@100", "66101@100", "66101@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10042] = {id = 10042, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66102@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10043] = {id = 10043, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10044] = {id = 10044, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66107@100", "66104@100", "0", "66105@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10045] = {id = 10045, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66111@100", "66108@100", "0", "66109@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10046] = {id = 10046, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66112@100", "0", "66113@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10047] = {id = 10047, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66114@100", "0", "66115@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10048] = {id = 10048, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66116@100", "66116@100", "66117@100", "66117@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10049] = {id = 10049, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66118@100", "66118@100", "66119@100", "66119@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10050] = {id = 10050, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66120@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10051] = {id = 10051, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66121@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10052] = {id = 10052, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66125@100", "66122@100", "0", "66123@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10053] = {id = 10053, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66129@100", "66126@100", "0", "66127@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10054] = {id = 10054, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66130@100", "0", "66131@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10055] = {id = 10055, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66132@100", "0", "66133@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10056] = {id = 10056, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66134@100", "66134@100", "66135@100", "66135@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10057] = {id = 10057, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66136@100", "66136@100", "66137@100", "66137@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10058] = {id = 10058, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66138@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10059] = {id = 10059, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66139@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10060] = {id = 10060, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66143@100", "66140@100", "0", "66141@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10061] = {id = 10061, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66147@100", "66144@100", "0", "66145@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10062] = {id = 10062, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66148@100", "0", "66148@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10063] = {id = 10063, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66149@100", "0", "66149@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10064] = {id = 10064, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66150@100", "66150@100", "66150@100", "66150@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10065] = {id = 10065, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66151@100", "66151@100", "66151@100", "66151@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10066] = {id = 10066, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66152@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10067] = {id = 10067, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66153@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10068] = {id = 10068, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66156@100", "66154@100", "0", "66154@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10069] = {id = 10069, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66159@100", "66157@100", "0", "66157@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10070] = {id = 10070, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66160@100", "0", "66160@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10071] = {id = 10071, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66161@100", "0", "66161@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10072] = {id = 10072, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66162@100", "66162@100", "66162@100", "66162@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10073] = {id = 10073, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66163@100", "66163@100", "66163@100", "66163@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10074] = {id = 10074, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66164@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10075] = {id = 10075, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66165@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10076] = {id = 10076, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66168@100", "66166@100", "0", "66166@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10077] = {id = 10077, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66171@100", "66169@100", "0", "66169@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10078] = {id = 10078, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66172@100", "0", "66172@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10079] = {id = 10079, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66173@100", "0", "66173@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10080] = {id = 10080, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66174@100", "66174@100", "66174@100", "66174@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10081] = {id = 10081, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66175@100", "66175@100", "66175@100", "66175@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10082] = {id = 10082, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66176@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10083] = {id = 10083, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66177@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10084] = {id = 10084, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66180@100", "66178@100", "0", "66178@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10085] = {id = 10085, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66183@100", "66181@100", "0", "66181@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10086] = {id = 10086, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66184@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10087] = {id = 10087, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66185@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10088] = {id = 10088, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66186@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10089] = {id = 10089, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66187@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10090] = {id = 10090, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66190@100", "0", "0", "66188@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10091] = {id = 10091, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66193@100", "0", "0", "66191@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10092] = {id = 10092, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66196@100", "0", "0", "66194@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10093] = {id = 10093, bgm = 1327, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66199@100", "0", "0", "66197@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10094] = {id = 10094, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66200@100", "66200@100", "66200@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10095] = {id = 10095, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66201@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10096] = {id = 10096, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66202@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10097] = {id = 10097, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66254@100", "0", "66254@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10098] = {id = 10098, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66256@100", "0", "66256@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10099] = {id = 10099, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66258@100", "0", "66258@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10100] = {id = 10100, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66259@100", "66259@100", "66260@100", "66260@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10101] = {id = 10101, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66262@100", "0", "66262@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10102] = {id = 10102, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66264@100", "0", "66264@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10103] = {id = 10103, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66266@100", "0", "66268@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10104] = {id = 10104, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66268@100", "66268@100", "0", "66268@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10105] = {id = 10105, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66270@100", "66270@100", "0", "66272@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10106] = {id = 10106, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66273@100", "0", "66273@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10107] = {id = 10107, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66274@100", "66274@100", "66274@100", "66276@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10108] = {id = 10108, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66275@100", "66275@100", "66277@100", "66277@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10109] = {id = 10109, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66278@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10110] = {id = 10110, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66280@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10111] = {id = 10111, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66282@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10112] = {id = 10112, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66285@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10113] = {id = 10113, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66286@100", "0", "66287@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10114] = {id = 10114, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66288@100", "0", "66289@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10115] = {id = 10115, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66290@100", "0", "66291@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10116] = {id = 10116, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66292@100", "0", "66293@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10117] = {id = 10117, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66294@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10118] = {id = 10118, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66297@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10119] = {id = 10119, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66298@100", "0", "66299@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10120] = {id = 10120, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66300@100", "0", "66301@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10121] = {id = 10121, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66303@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10122] = {id = 10122, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66304@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10123] = {id = 10123, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66306@100", "0", "66306@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10124] = {id = 10124, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66308@100", "0", "66309@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10125] = {id = 10125, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66310@100", "0", "66310@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10126] = {id = 10126, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66312@100", "0", "66312@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10127] = {id = 10127, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66313@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10128] = {id = 10128, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66314@100", "0", "66315@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10129] = {id = 10129, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66318@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10130] = {id = 10130, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66320@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10131] = {id = 10131, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66322@100", "0", "66323@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10132] = {id = 10132, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66324@100", "0", "66325@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10133] = {id = 10133, bgm = 1359, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66402@100", "0", "0", "66398@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 1}
, 
[10134] = {id = 10134, bgm = 1359, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66402@100", "0", "0", "66399@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 1}
, 
[10135] = {id = 10135, bgm = 1359, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66402@100", "0", "0", "66400@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 1}
, 
[10136] = {id = 10136, bgm = 1360, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66402@100", "0", "0", "66401@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 1}
, 
[10137] = {id = 10137, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66222@100", "0", "66222@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10138] = {id = 10138, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66224@100", "0", "66225@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10139] = {id = 10139, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66226@100", "0", "66227@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10140] = {id = 10140, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66228@100", "0", "66229@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10141] = {id = 10141, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66230@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10142] = {id = 10142, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66231@100", "0", "66232@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10143] = {id = 10143, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66233@100", "0", "66234@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10144] = {id = 10144, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66235@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10145] = {id = 10145, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66236@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10146] = {id = 10146, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66237@100", "0", "66238@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10147] = {id = 10147, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66239@100", "0", "66240@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10148] = {id = 10148, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66241@100", "0", "66242@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10149] = {id = 10149, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66244@100", "0", "66243@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10150] = {id = 10150, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66246@100", "0", "66245@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10151] = {id = 10151, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66247@100", "0", "66248@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10152] = {id = 10152, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66250@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10153] = {id = 10153, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66251@100", "0", "66252@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10154] = {id = 10154, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66253@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10155] = {id = 10155, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66326@100", "0", "66327@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10156] = {id = 10156, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66328@100", "0", "66329@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10157] = {id = 10157, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66330@100", "0", "66331@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10158] = {id = 10158, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66332@100", "0", "66333@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10159] = {id = 10159, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66334@100", "0", "66335@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10160] = {id = 10160, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66336@100", "0", "66337@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10161] = {id = 10161, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66338@100", "0", "66339@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10162] = {id = 10162, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66340@100", "0", "66341@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10163] = {id = 10163, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66342@100", "0", "66344@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10164] = {id = 10164, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66344@100", "0", "66345@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10165] = {id = 10165, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66346@100", "0", "66347@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10166] = {id = 10166, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66348@100", "0", "66349@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10167] = {id = 10167, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66350@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10168] = {id = 10168, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66352@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10169] = {id = 10169, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66349@100", "0", "66354@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10170] = {id = 10170, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66355@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10171] = {id = 10171, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66356@100", "0", "66357@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10172] = {id = 10172, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66359@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10173] = {id = 10173, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66363@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10174] = {id = 10174, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66365@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10175] = {id = 10175, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66366@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10176] = {id = 10176, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66369@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10177] = {id = 10177, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66370@100", "0", "66371@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10178] = {id = 10178, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66372@100", "0", "66373@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10179] = {id = 10179, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66374@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10180] = {id = 10180, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66376@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10181] = {id = 10181, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66377@100", "0", "66379@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10182] = {id = 10182, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66380@100", "0", "66381@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10183] = {id = 10183, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66382@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10184] = {id = 10184, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66384@100", "0", "66385@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10185] = {id = 10185, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66386@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10186] = {id = 10186, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66387@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10187] = {id = 10187, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66388@100", "0", "66390@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10188] = {id = 10188, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66393@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10189] = {id = 10189, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66394@100", "0", "66395@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10190] = {id = 10190, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66397@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10191] = {id = 10191, bgm = 1357, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66396@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10192] = {id = 10192, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66405@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10193] = {id = 10193, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66406@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10194] = {id = 10194, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66407@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10195] = {id = 10195, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66408@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10196] = {id = 10196, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66409@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10197] = {id = 10197, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66410@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10198] = {id = 10198, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66411@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10199] = {id = 10199, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66412@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10200] = {id = 10200, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10201] = {id = 10201, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10202] = {id = 10202, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10203] = {id = 10203, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10204] = {id = 10204, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10205] = {id = 10205, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10206] = {id = 10206, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10207] = {id = 10207, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10208] = {id = 10208, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10209] = {id = 10209, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10210] = {id = 10210, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10211] = {id = 10211, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10212] = {id = 10212, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10213] = {id = 10213, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10214] = {id = 10214, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10215] = {id = 10215, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10216] = {id = 10216, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10217] = {id = 10217, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10218] = {id = 10218, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10219] = {id = 10219, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10220] = {id = 10220, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10221] = {id = 10221, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10222] = {id = 10222, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10223] = {id = 10223, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10224] = {id = 10224, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10225] = {id = 10225, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10226] = {id = 10226, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10227] = {id = 10227, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10228] = {id = 10228, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10229] = {id = 10229, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10230] = {id = 10230, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[10231] = {id = 10231, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11001] = {id = 11001, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67011@100", "67012@100", "67012@100", "67012@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11002] = {id = 11002, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67013@100", "67013@100", "67013@100", "67013@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11003] = {id = 11003, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67014@100", "0", "67014@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11004] = {id = 11004, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67015@100", "0", "67015@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11005] = {id = 11005, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67016@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11006] = {id = 11006, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67017@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11007] = {id = 11007, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67018@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11008] = {id = 11008, bgm = 134, transferID = 1, bossID = 67001, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67001@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11009] = {id = 11009, bgm = 134, transferID = 1, bossID = 67003, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67003@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11011] = {id = 11011, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67021@100", "67022@100", "67022@100", "67022@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11012] = {id = 11012, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67023@100", "67023@100", "67023@100", "67023@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11013] = {id = 11013, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67024@100", "0", "67024@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11014] = {id = 11014, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67025@100", "0", "67025@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11015] = {id = 11015, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67026@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11016] = {id = 11016, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67027@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11017] = {id = 11017, bgm = 134, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67028@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11018] = {id = 11018, bgm = 134, transferID = 1, bossID = 67002, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67002@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11019] = {id = 11019, bgm = 134, transferID = 1, bossID = 67004, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67004@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11101] = {id = 11101, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66001@100", "66001@100", "66001@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11102] = {id = 11102, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66002@100", "66002@100", "66002@100", "66019@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11103] = {id = 11103, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66004@100", "66004@100", "66004@100", "66020@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11104] = {id = 11104, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66006@100", "66006@100", "66006@100", "66021@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11105] = {id = 11105, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66010@100", "66010@100", "66010@100", "66022@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11106] = {id = 11106, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66012@100", "66012@100", "66012@100", "66023@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11107] = {id = 11107, bgm = 1256, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66015@100", "66015@100", "66024@100", "66026@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11108] = {id = 11108, bgm = 1254, transferID = 1, bossID = 66027, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "66027@100"}
, result = 1, auto = 1, enemyMessage = 1, defeatResult = 0}
, 
[11109] = {id = 11109, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66029@100", "66029@100", "66029@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11110] = {id = 11110, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66030@100", "66030@100", "66030@100", "66049@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11111] = {id = 11111, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66032@100", "66032@100", "66032@100", "66050@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11112] = {id = 11112, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66034@100", "66034@100", "66034@100", "66051@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11113] = {id = 11113, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66038@100", "66038@100", "66038@100", "66052@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11114] = {id = 11114, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66040@100", "66040@100", "66040@100", "66053@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11115] = {id = 11115, bgm = 1257, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"66043@100", "66043@100", "66054@100", "66047@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11116] = {id = 11116, bgm = 1254, transferID = 1, bossID = 67083, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "67083@100"}
, result = 1, auto = 1, enemyMessage = 1, defeatResult = 0}
, 
[11117] = {id = 11117, bgm = 1254, transferID = 1, bossID = 67085, bossIDSecond = 0, 
enemyPositions = {"0", "0", "0", "67085@100"}
, result = 1, auto = 1, enemyMessage = 1, defeatResult = 0}
, 
[11118] = {id = 11118, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67138@100", "67138@100", "67139@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11119] = {id = 11119, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67140@100", "67141@100", "0"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11120] = {id = 11120, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67142@100", "0", "67142@100", "67143@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11121] = {id = 11121, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67144@100", "0", "67145@100", "67145@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11122] = {id = 11122, bgm = 1327, transferID = 1, bossID = 67146, bossIDSecond = 0, 
enemyPositions = {"67147@100", "0", "0", "67146@100"}
, result = 1, auto = 0, enemyMessage = 1, defeatResult = 0}
, 
[11123] = {id = 11123, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67100@100", "67100@100", "67100@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11124] = {id = 11124, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67102@100", "67101@100", "67101@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11125] = {id = 11125, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67103@100", "67103@100", "67103@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11126] = {id = 11126, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67104@100", "0", "67148@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11127] = {id = 11127, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67106@100", "67106@100", "0", "67105@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11128] = {id = 11128, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67107@100", "0", "67107@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11129] = {id = 11129, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67108@100", "0", "67108@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11130] = {id = 11130, bgm = 1327, transferID = 1, bossID = 67109, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67109@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11131] = {id = 11131, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67120@100", "67120@100", "67121@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11132] = {id = 11132, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67122@100", "67123@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11133] = {id = 11133, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67124@100", "0", "67149@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11134] = {id = 11134, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67125@100", "0", "67125@100", "67126@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11135] = {id = 11135, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67127@100", "0", "67128@100", "67128@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11136] = {id = 11136, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67129@100", "67129@100", "67130@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11137] = {id = 11137, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67131@100", "67132@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11138] = {id = 11138, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "67133@100", "0", "67150@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11139] = {id = 11139, bgm = 1325, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67134@100", "0", "67134@100", "67135@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11140] = {id = 11140, bgm = 1327, transferID = 1, bossID = 67136, bossIDSecond = 0, 
enemyPositions = {"67137@100", "0", "0", "67136@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11141] = {id = 11141, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67151@100", "67151@100", "67151@100", "67151@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11142] = {id = 11142, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67152@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11143] = {id = 11143, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67153@100", "67153@100", "67153@100", "67153@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11144] = {id = 11144, bgm = 3, transferID = 1, bossID = 67154, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67154@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11145] = {id = 11145, bgm = 3, transferID = 1, bossID = 67155, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67155@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11146] = {id = 11146, bgm = 3, transferID = 1, bossID = 67156, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67156@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11147] = {id = 11147, bgm = 3, transferID = 1, bossID = 67157, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67157@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11148] = {id = 11148, bgm = 3, transferID = 1, bossID = 67158, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67158@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11149] = {id = 11149, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67159@100", "67159@100", "67159@100", "67159@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11150] = {id = 11150, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67160@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11151] = {id = 11151, bgm = 3, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"67161@100", "67161@100", "67161@100", "67161@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11152] = {id = 11152, bgm = 3, transferID = 1, bossID = 67162, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67162@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11153] = {id = 11153, bgm = 3, transferID = 1, bossID = 67163, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67163@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11154] = {id = 11154, bgm = 3, transferID = 1, bossID = 67164, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67164@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11155] = {id = 11155, bgm = 3, transferID = 1, bossID = 67165, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67165@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11156] = {id = 11156, bgm = 3, transferID = 1, bossID = 67166, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67166@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11157] = {id = 11157, bgm = 3, transferID = 1, bossID = 67167, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67167@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11158] = {id = 11158, bgm = 3, transferID = 1, bossID = 67168, bossIDSecond = 0, 
enemyPositions = {"0", "0", "67168@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11159] = {id = 11159, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66405@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11160] = {id = 11160, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66406@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11161] = {id = 11161, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66407@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11162] = {id = 11162, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66408@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11163] = {id = 11163, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66409@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11164] = {id = 11164, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66410@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11165] = {id = 11165, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66411@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11166] = {id = 11166, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66412@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11167] = {id = 11167, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11168] = {id = 11168, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11169] = {id = 11169, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11170] = {id = 11170, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11171] = {id = 11171, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11172] = {id = 11172, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11173] = {id = 11173, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11174] = {id = 11174, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11175] = {id = 11175, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11176] = {id = 11176, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11177] = {id = 11177, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11178] = {id = 11178, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11179] = {id = 11179, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11180] = {id = 11180, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11181] = {id = 11181, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11182] = {id = 11182, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11183] = {id = 11183, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11184] = {id = 11184, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11185] = {id = 11185, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11186] = {id = 11186, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11187] = {id = 11187, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11188] = {id = 11188, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11189] = {id = 11189, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11190] = {id = 11190, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11191] = {id = 11191, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11192] = {id = 11192, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11193] = {id = 11193, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11194] = {id = 11194, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11195] = {id = 11195, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "0", "66413@100", "0"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11196] = {id = 11196, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66414@100", "0", "66418@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11197] = {id = 11197, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66423@100", "0", "66419@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
, 
[11198] = {id = 11198, bgm = 1362, transferID = 1, bossID = 0, bossIDSecond = 0, 
enemyPositions = {"0", "66420@100", "0", "66428@100"}
, result = 1, auto = 0, enemyMessage = 0, defeatResult = 0}
}
cbattleinfo.AllIds = {1120, 1122, 1123, 1124, 1126, 1127, 1128, 1129, 1130, 1131, 1134, 1135, 1183, 1184, 1186, 1187, 1189, 1191, 1294, 1295, 1297, 1300, 1301, 1307, 1312, 1313, 1314, 1315, 1316, 1317, 1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355, 1356, 1357, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377, 1378, 1379, 1380, 1381, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2201, 2202, 2203, 2204, 2205, 2206, 2207, 2208, 2209, 2210, 2211, 2212, 2213, 2214, 2215, 2216, 2217, 2218, 2219, 2220, 2221, 2222, 2223, 2224, 2225, 2226, 2227, 2228, 2229, 2230, 2231, 2232, 2233, 2234, 2235, 2236, 2237, 2238, 2239, 2240, 2241, 2242, 2243, 2244, 2245, 2246, 2247, 2248, 2249, 2401, 2402, 2403, 2404, 2405, 2406, 2407, 2408, 2409, 2410, 2411, 2412, 2413, 2414, 2415, 2416, 2417, 2418, 2419, 2420, 2421, 2422, 2423, 2424, 2425, 2426, 2427, 2428, 2429, 2430, 2431, 2432, 2433, 2434, 2435, 2436, 2437, 2438, 2439, 2440, 2441, 2442, 2443, 2444, 2445, 2446, 2447, 2448, 2449, 2450, 2451, 2601, 2602, 2603, 2604, 2605, 2606, 2607, 2608, 2609, 2610, 2611, 2612, 2613, 2614, 2701, 2702, 2703, 2704, 2705, 2706, 2707, 2708, 2709, 2710, 2711, 2712, 2713, 2714, 2715, 2716, 2717, 2718, 2719, 2720, 2721, 2722, 2723, 2724, 2725, 2726, 2727, 2728, 2729, 2730, 2731, 2732, 2733, 2734, 2735, 2736, 2737, 2738, 2739, 2740, 2741, 2742, 2743, 2801, 2802, 2803, 2804, 2805, 2806, 2807, 2808, 2809, 2810, 2811, 2812, 2813, 2814, 2815, 2816, 2817, 2818, 2819, 2820, 2821, 2822, 2823, 2824, 2825, 2826, 2827, 2828, 2829, 2830, 2831, 2832, 2833, 2834, 2835, 2836, 2837, 2838, 2839, 2840, 2841, 2842, 2843, 2844, 2845, 2846, 2847, 2848, 2849, 2850, 2851, 2852, 2901, 2902, 2903, 2904, 2905, 2906, 2907, 2908, 2909, 2910, 2911, 2912, 2913, 2914, 2915, 2916, 2917, 2918, 2919, 2920, 2921, 2922, 2923, 2924, 2925, 2926, 2927, 2928, 2929, 2930, 2931, 2932, 2933, 2934, 2935, 2936, 2937, 2938, 2939, 2940, 2941, 2942, 2943, 2944, 2945, 2946, 2947, 2948, 2949, 2950, 2951, 2952, 2953, 2954, 6001, 6002, 6003, 6004, 6005, 6006, 6007, 6008, 6009, 6010, 6011, 6012, 6013, 6014, 6015, 6016, 6017, 6018, 6019, 6020, 6021, 6022, 6023, 6024, 6025, 6026, 6027, 6028, 6029, 6030, 6031, 6032, 6033, 6034, 6035, 6036, 6037, 6038, 6039, 6040, 6041, 6042, 6043, 6044, 6055, 6056, 6057, 6058, 6059, 6060, 6061, 6062, 6063, 6064, 6065, 6066, 6067, 6068, 6069, 6070, 6071, 6072, 6073, 6074, 6075, 6076, 6077, 6078, 6079, 6080, 6081, 6082, 6083, 6084, 6085, 6086, 6087, 6088, 6089, 6090, 6091, 6092, 6093, 6094, 6095, 6096, 6097, 6098, 6099, 6100, 6101, 6102, 6103, 6104, 6105, 6106, 6107, 6108, 6109, 6110, 6111, 6112, 6113, 6114, 6115, 6116, 6117, 6118, 6119, 6120, 6121, 6122, 6123, 6124, 6125, 6126, 6127, 6128, 6129, 6130, 6131, 6132, 6133, 6134, 6135, 6136, 6137, 6138, 6139, 6140, 6141, 6142, 6143, 6144, 6145, 6146, 6147, 6148, 6149, 6150, 6151, 6152, 6153, 6154, 6155, 6156, 6157, 6158, 6159, 6160, 6161, 6162, 6163, 6164, 6165, 6166, 6167, 6168, 6169, 6170, 6171, 6172, 6173, 6174, 6175, 6176, 6177, 6178, 6179, 6180, 6181, 6182, 6183, 6184, 6185, 6186, 6187, 6188, 6189, 6190, 6191, 6192, 6193, 6194, 6195, 6196, 6197, 6198, 6199, 6200, 6201, 6202, 6203, 6204, 6205, 6206, 6207, 6208, 6209, 6210, 6211, 6212, 6213, 6214, 6215, 6216, 6217, 6218, 6219, 6220, 6221, 6222, 6223, 6224, 6225, 6226, 6227, 6228, 6229, 6230, 6231, 6232, 6233, 6234, 6235, 6236, 6237, 6238, 6239, 6240, 6241, 6242, 6243, 6244, 6245, 6246, 6247, 6248, 6249, 6250, 6251, 6252, 6253, 6254, 6255, 6256, 6257, 6258, 6259, 6260, 6261, 6262, 6263, 6264, 6265, 6267, 6269, 6270, 6271, 6272, 6273, 6274, 6275, 6276, 6277, 6278, 6279, 6280, 6281, 6282, 6283, 6284, 6285, 6286, 6287, 6288, 6289, 6290, 6291, 6292, 6293, 6294, 6295, 6296, 6297, 6298, 6299, 6300, 6301, 6302, 6303, 6304, 6305, 6306, 6307, 6308, 6309, 6310, 6311, 6312, 6313, 6314, 6315, 6316, 6317, 6318, 6319, 6320, 6321, 6322, 6323, 6324, 6325, 6326, 6327, 6328, 6329, 6330, 6331, 6332, 6333, 6334, 6335, 6336, 6337, 6338, 6339, 6340, 6341, 6342, 6343, 6344, 6345, 6346, 6347, 6348, 6349, 6350, 6351, 6352, 6353, 6354, 6355, 6356, 6357, 6358, 6359, 6360, 6361, 6362, 6363, 6364, 6365, 6366, 6367, 6368, 6369, 6370, 6371, 6372, 6373, 6374, 6375, 6376, 6377, 6378, 6379, 6380, 6381, 6382, 6383, 6384, 6385, 6386, 6387, 6388, 6389, 6390, 6391, 6392, 6393, 6394, 6395, 6396, 6397, 6398, 6399, 6400, 6401, 6402, 6403, 6404, 6405, 6406, 6407, 6408, 6409, 6410, 6411, 6412, 6413, 6414, 6415, 6416, 6417, 6418, 6419, 6420, 6421, 6422, 6423, 6424, 6425, 6426, 6427, 6428, 6429, 6430, 6431, 6432, 6433, 6434, 6435, 6436, 6437, 6438, 6439, 6440, 6441, 6442, 6443, 6444, 6445, 6446, 6447, 6448, 6449, 6450, 6451, 6452, 6453, 6454, 6455, 6456, 6457, 6458, 6459, 6460, 6461, 6462, 6463, 6464, 6465, 6466, 6467, 6468, 6469, 6470, 6471, 6472, 6473, 6474, 6475, 6476, 6477, 6478, 6479, 6480, 6481, 6482, 6483, 6484, 6485, 6486, 6487, 6488, 6489, 6490, 6491, 6492, 6493, 6494, 6495, 6497, 6498, 6499, 6500, 6501, 6502, 6503, 6504, 6505, 6506, 6507, 6508, 6509, 6510, 6511, 6512, 6513, 6514, 6515, 6516, 6517, 6518, 6519, 6520, 6521, 6522, 6523, 6524, 6525, 6526, 6527, 6528, 6529, 6530, 6531, 6532, 6533, 6534, 6535, 6536, 6537, 6538, 6539, 6540, 6541, 6542, 6543, 6544, 6545, 6546, 6547, 6548, 6549, 6550, 6551, 6552, 6553, 6554, 6555, 6556, 6557, 6558, 6559, 6560, 6561, 6562, 6563, 6564, 6565, 6566, 6567, 6568, 6569, 6570, 6571, 6572, 6573, 6574, 6575, 6576, 6577, 6578, 6579, 6580, 6581, 6582, 6583, 6584, 6585, 6586, 6587, 6588, 6589, 6590, 6591, 6592, 6593, 6594, 6595, 6596, 6597, 6598, 6599, 6600, 6601, 6602, 6603, 6604, 6605, 6606, 6607, 6608, 6609, 6610, 6611, 6612, 6613, 6614, 6615, 6616, 6617, 6618, 6619, 6620, 6621, 6622, 6623, 6624, 6625, 6626, 6627, 6628, 7001, 7002, 7003, 7004, 7005, 7006, 7007, 7008, 7009, 7010, 7011, 7012, 7013, 7014, 7015, 7016, 7017, 7018, 7019, 7020, 7021, 7022, 7023, 7024, 7025, 7026, 7027, 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010, 8011, 8012, 8013, 8014, 8015, 8016, 8017, 8018, 8019, 8020, 8021, 8022, 8023, 8024, 8025, 8026, 8027, 8028, 8029, 8030, 8031, 8032, 8033, 8034, 8035, 8036, 8037, 8038, 8039, 8040, 8041, 8042, 8043, 8044, 8045, 8046, 8047, 8048, 8049, 8050, 8051, 8052, 8053, 8054, 8055, 8056, 8057, 8058, 8059, 8060, 8061, 8062, 8063, 8064, 8065, 8066, 8067, 8068, 8069, 8070, 8071, 8072, 8073, 8074, 8075, 8076, 8077, 8078, 8079, 8080, 8081, 8082, 8083, 8084, 8085, 8086, 8087, 8088, 8089, 8090, 8091, 8092, 8093, 8094, 8095, 8096, 8097, 8098, 8099, 8100, 8101, 8102, 8103, 8104, 8105, 8106, 9001, 9002, 9003, 9004, 9495, 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018, 10019, 10020, 10021, 10022, 10023, 10024, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 10042, 10043, 10044, 10045, 10046, 10047, 10048, 10049, 10050, 10051, 10052, 10053, 10054, 10055, 10056, 10057, 10058, 10059, 10060, 10061, 10062, 10063, 10064, 10065, 10066, 10067, 10068, 10069, 10070, 10071, 10072, 10073, 10074, 10075, 10076, 10077, 10078, 10079, 10080, 10081, 10082, 10083, 10084, 10085, 10086, 10087, 10088, 10089, 10090, 10091, 10092, 10093, 10094, 10095, 10096, 10097, 10098, 10099, 10100, 10101, 10102, 10103, 10104, 10105, 10106, 10107, 10108, 10109, 10110, 10111, 10112, 10113, 10114, 10115, 10116, 10117, 10118, 10119, 10120, 10121, 10122, 10123, 10124, 10125, 10126, 10127, 10128, 10129, 10130, 10131, 10132, 10133, 10134, 10135, 10136, 10137, 10138, 10139, 10140, 10141, 10142, 10143, 10144, 10145, 10146, 10147, 10148, 10149, 10150, 10151, 10152, 10153, 10154, 10155, 10156, 10157, 10158, 10159, 10160, 10161, 10162, 10163, 10164, 10165, 10166, 10167, 10168, 10169, 10170, 10171, 10172, 10173, 10174, 10175, 10176, 10177, 10178, 10179, 10180, 10181, 10182, 10183, 10184, 10185, 10186, 10187, 10188, 10189, 10190, 10191, 10192, 10193, 10194, 10195, 10196, 10197, 10198, 10199, 10200, 10201, 10202, 10203, 10204, 10205, 10206, 10207, 10208, 10209, 10210, 10211, 10212, 10213, 10214, 10215, 10216, 10217, 10218, 10219, 10220, 10221, 10222, 10223, 10224, 10225, 10226, 10227, 10228, 10229, 10230, 10231, 11001, 11002, 11003, 11004, 11005, 11006, 11007, 11008, 11009, 11011, 11012, 11013, 11014, 11015, 11016, 11017, 11018, 11019, 11101, 11102, 11103, 11104, 11105, 11106, 11107, 11108, 11109, 11110, 11111, 11112, 11113, 11114, 11115, 11116, 11117, 11118, 11119, 11120, 11121, 11122, 11123, 11124, 11125, 11126, 11127, 11128, 11129, 11130, 11131, 11132, 11133, 11134, 11135, 11136, 11137, 11138, 11139, 11140, 11141, 11142, 11143, 11144, 11145, 11146, 11147, 11148, 11149, 11150, 11151, 11152, 11153, 11154, 11155, 11156, 11157, 11158, 11159, 11160, 11161, 11162, 11163, 11164, 11165, 11166, 11167, 11168, 11169, 11170, 11171, 11172, 11173, 11174, 11175, 11176, 11177, 11178, 11179, 11180, 11181, 11182, 11183, 11184, 11185, 11186, 11187, 11188, 11189, 11190, 11191, 11192, 11193, 11194, 11195, 11196, 11197, 11198}
return cbattleinfo


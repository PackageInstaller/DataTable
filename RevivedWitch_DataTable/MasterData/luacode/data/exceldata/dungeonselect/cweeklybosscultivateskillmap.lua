-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cweeklybosscultivateskillmap.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cweeklybosscultivateskillmap = {}
cweeklybosscultivateskillmap.Data = {
[1001] = {id = 1001, mapID = 1, nodePosition = "1;1", frontNode = "-1", conflictedNode = 1002, buffID = 70021, buffNameID = 1901601, buffIconID = 12605, littleIconID = 10133, buffDescriptionID = 1901610, unlockConsumptionTimes = 3}
, 
[1002] = {id = 1002, mapID = 1, nodePosition = "1;3", frontNode = "-1", conflictedNode = 1001, buffID = 70022, buffNameID = 1901603, buffIconID = 14759, littleIconID = 10136, buffDescriptionID = 1901611, unlockConsumptionTimes = 3}
, 
[1003] = {id = 1003, mapID = 1, nodePosition = "2;2", frontNode = "1001;1002", conflictedNode = 0, buffID = 70001, buffNameID = 1901598, buffIconID = 12600, littleIconID = 10139, buffDescriptionID = 1901607, unlockConsumptionTimes = 2}
, 
[1004] = {id = 1004, mapID = 1, nodePosition = "3;1", frontNode = "1003", conflictedNode = 1005, buffID = 70061, buffNameID = 1901599, buffIconID = 14761, littleIconID = 12624, buffDescriptionID = 1901616, unlockConsumptionTimes = 3}
, 
[1005] = {id = 1005, mapID = 1, nodePosition = "3;3", frontNode = "1003", conflictedNode = 1004, buffID = 70062, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12623, buffDescriptionID = 1901617, unlockConsumptionTimes = 3}
, 
[1006] = {id = 1006, mapID = 1, nodePosition = "4;2", frontNode = "1004;1005", conflictedNode = 0, buffID = 70041, buffNameID = 1901600, buffIconID = 14764, littleIconID = 12624, buffDescriptionID = 1901613, unlockConsumptionTimes = 2}
, 
[1007] = {id = 1007, mapID = 1, nodePosition = "5;1", frontNode = "1006", conflictedNode = 1008, buffID = 70101, buffNameID = 1901602, buffIconID = 12601, littleIconID = -1, buffDescriptionID = 1901621, unlockConsumptionTimes = 3}
, 
[1008] = {id = 1008, mapID = 1, nodePosition = "5;3", frontNode = "1006", conflictedNode = 1007, buffID = 70102, buffNameID = 1901602, buffIconID = 14761, littleIconID = -1, buffDescriptionID = 1901622, unlockConsumptionTimes = 3}
, 
[2001] = {id = 2001, mapID = 2, nodePosition = "1;1", frontNode = "-1", conflictedNode = 2002, buffID = 70211, buffNameID = 1901602, buffIconID = 14761, littleIconID = 10136, buffDescriptionID = 1901660, unlockConsumptionTimes = 3}
, 
[2002] = {id = 2002, mapID = 2, nodePosition = "1;3", frontNode = "-1", conflictedNode = 2001, buffID = 70212, buffNameID = 1901603, buffIconID = 14760, littleIconID = 10134, buffDescriptionID = 1901661, unlockConsumptionTimes = 3}
, 
[2003] = {id = 2003, mapID = 2, nodePosition = "2;2", frontNode = "2001;2002", conflictedNode = 0, buffID = 70002, buffNameID = 1901599, buffIconID = 14761, littleIconID = 10135, buffDescriptionID = 1901608, unlockConsumptionTimes = 2}
, 
[2004] = {id = 2004, mapID = 2, nodePosition = "3;1", frontNode = "2003", conflictedNode = 2005, buffID = 70061, buffNameID = 1901599, buffIconID = 14761, littleIconID = 12624, buffDescriptionID = 1901616, unlockConsumptionTimes = 3}
, 
[2005] = {id = 2005, mapID = 2, nodePosition = "3;3", frontNode = "2003", conflictedNode = 2004, buffID = 70213, buffNameID = 1901603, buffIconID = 12601, littleIconID = 12624, buffDescriptionID = 1901662, unlockConsumptionTimes = 3}
, 
[2006] = {id = 2006, mapID = 2, nodePosition = "4;2", frontNode = "2004;2005", conflictedNode = 0, buffID = 70041, buffNameID = 1901606, buffIconID = 14764, littleIconID = 12624, buffDescriptionID = 1901613, unlockConsumptionTimes = 2}
, 
[2007] = {id = 2007, mapID = 2, nodePosition = "5;1", frontNode = "2006", conflictedNode = 2008, buffID = 70214, buffNameID = 1901605, buffIconID = 12604, littleIconID = -1, buffDescriptionID = 1901663, unlockConsumptionTimes = 3}
, 
[2008] = {id = 2008, mapID = 2, nodePosition = "5;3", frontNode = "2006", conflictedNode = 2007, buffID = 70102, buffNameID = 1901602, buffIconID = 14761, littleIconID = -1, buffDescriptionID = 1901622, unlockConsumptionTimes = 3}
, 
[3001] = {id = 3001, mapID = 3, nodePosition = "1;1", frontNode = "-1", conflictedNode = 3002, buffID = 70021, buffNameID = 1901601, buffIconID = 12605, littleIconID = 10133, buffDescriptionID = 1901610, unlockConsumptionTimes = 3}
, 
[3002] = {id = 3002, mapID = 3, nodePosition = "1;3", frontNode = "-1", conflictedNode = 3001, buffID = 70023, buffNameID = 1901602, buffIconID = 12601, littleIconID = 10138, buffDescriptionID = 1901612, unlockConsumptionTimes = 3}
, 
[3003] = {id = 3003, mapID = 3, nodePosition = "2;2", frontNode = "3001;3002", conflictedNode = 0, buffID = 70003, buffNameID = 1901600, buffIconID = 14762, littleIconID = 10134, buffDescriptionID = 1901609, unlockConsumptionTimes = 2}
, 
[3004] = {id = 3004, mapID = 3, nodePosition = "3;1", frontNode = "3003", conflictedNode = 3005, buffID = 70061, buffNameID = 1901599, buffIconID = 14761, littleIconID = 12624, buffDescriptionID = 1901616, unlockConsumptionTimes = 3}
, 
[3005] = {id = 3005, mapID = 3, nodePosition = "3;3", frontNode = "3003", conflictedNode = 3004, buffID = 70063, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12625, buffDescriptionID = 1901618, unlockConsumptionTimes = 3}
, 
[3006] = {id = 3006, mapID = 3, nodePosition = "4;2", frontNode = "3004;3005", conflictedNode = 0, buffID = 70043, buffNameID = 1901606, buffIconID = 14763, littleIconID = 12625, buffDescriptionID = 1901615, unlockConsumptionTimes = 2}
, 
[3007] = {id = 3007, mapID = 3, nodePosition = "5;1", frontNode = "3006", conflictedNode = 3008, buffID = 70101, buffNameID = 1901602, buffIconID = 12601, littleIconID = -1, buffDescriptionID = 1901621, unlockConsumptionTimes = 3}
, 
[3008] = {id = 3008, mapID = 3, nodePosition = "5;3", frontNode = "3006", conflictedNode = 3007, buffID = 70102, buffNameID = 1901602, buffIconID = 14761, littleIconID = -1, buffDescriptionID = 1901622, unlockConsumptionTimes = 3}
, 
[4001] = {id = 4001, mapID = 4, nodePosition = "1;1", frontNode = "-1", conflictedNode = 4002, buffID = 70201, buffNameID = 1901601, buffIconID = 12605, littleIconID = 10133, buffDescriptionID = 1901657, unlockConsumptionTimes = 3}
, 
[4002] = {id = 4002, mapID = 4, nodePosition = "1;3", frontNode = "-1", conflictedNode = 4001, buffID = 70023, buffNameID = 1901602, buffIconID = 12601, littleIconID = 10138, buffDescriptionID = 1901612, unlockConsumptionTimes = 3}
, 
[4003] = {id = 4003, mapID = 4, nodePosition = "2;2", frontNode = "4001;4002", conflictedNode = 0, buffID = 70001, buffNameID = 1901598, buffIconID = 12600, littleIconID = 10139, buffDescriptionID = 1901607, unlockConsumptionTimes = 2}
, 
[4004] = {id = 4004, mapID = 4, nodePosition = "3;1", frontNode = "4003", conflictedNode = 4005, buffID = 70062, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12623, buffDescriptionID = 1901617, unlockConsumptionTimes = 3}
, 
[4005] = {id = 4005, mapID = 4, nodePosition = "3;3", frontNode = "4003", conflictedNode = 4004, buffID = 70063, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12625, buffDescriptionID = 1901618, unlockConsumptionTimes = 3}
, 
[4006] = {id = 4006, mapID = 4, nodePosition = "4;2", frontNode = "4004;4005", conflictedNode = 0, buffID = 70202, buffNameID = 1901598, buffIconID = 12600, littleIconID = -1, buffDescriptionID = 1901658, unlockConsumptionTimes = 2}
, 
[4007] = {id = 4007, mapID = 4, nodePosition = "5;1", frontNode = "4006", conflictedNode = 4008, buffID = 70101, buffNameID = 1901602, buffIconID = 12601, littleIconID = -1, buffDescriptionID = 1901621, unlockConsumptionTimes = 3}
, 
[4008] = {id = 4008, mapID = 4, nodePosition = "5;3", frontNode = "4006", conflictedNode = 4007, buffID = 70203, buffNameID = 1901601, buffIconID = 12605, littleIconID = -1, buffDescriptionID = 1901659, unlockConsumptionTimes = 3}
, 
[5001] = {id = 5001, mapID = 5, nodePosition = "1;1", frontNode = "-1", conflictedNode = 5002, buffID = 70022, buffNameID = 1901603, buffIconID = 14760, littleIconID = 10136, buffDescriptionID = 1901611, unlockConsumptionTimes = 3}
, 
[5002] = {id = 5002, mapID = 5, nodePosition = "1;3", frontNode = "-1", conflictedNode = 5001, buffID = 70023, buffNameID = 1901602, buffIconID = 12601, littleIconID = 10138, buffDescriptionID = 1901612, unlockConsumptionTimes = 3}
, 
[5003] = {id = 5003, mapID = 5, nodePosition = "2;2", frontNode = "5001;5002", conflictedNode = 0, buffID = 70002, buffNameID = 1901599, buffIconID = 14761, littleIconID = 10135, buffDescriptionID = 1901608, unlockConsumptionTimes = 2}
, 
[5004] = {id = 5004, mapID = 5, nodePosition = "3;1", frontNode = "5003", conflictedNode = 5005, buffID = 70062, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12623, buffDescriptionID = 1901617, unlockConsumptionTimes = 3}
, 
[5005] = {id = 5005, mapID = 5, nodePosition = "3;3", frontNode = "5003", conflictedNode = 5004, buffID = 70063, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12625, buffDescriptionID = 1901618, unlockConsumptionTimes = 3}
, 
[5006] = {id = 5006, mapID = 5, nodePosition = "4;2", frontNode = "5004;5005", conflictedNode = 0, buffID = 70042, buffNameID = 1901598, buffIconID = 12600, littleIconID = 12623, buffDescriptionID = 1901614, unlockConsumptionTimes = 2}
, 
[5007] = {id = 5007, mapID = 5, nodePosition = "5;1", frontNode = "5006", conflictedNode = 5008, buffID = 70101, buffNameID = 1901602, buffIconID = 12601, littleIconID = -1, buffDescriptionID = 1901621, unlockConsumptionTimes = 3}
, 
[5008] = {id = 5008, mapID = 5, nodePosition = "5;3", frontNode = "5006", conflictedNode = 5007, buffID = 70102, buffNameID = 1901602, buffIconID = 14761, littleIconID = -1, buffDescriptionID = 1901622, unlockConsumptionTimes = 3}
, 
[6001] = {id = 6001, mapID = 6, nodePosition = "1;1", frontNode = "-1", conflictedNode = 6002, buffID = 70211, buffNameID = 1901602, buffIconID = 14761, littleIconID = 10136, buffDescriptionID = 1901660, unlockConsumptionTimes = 3}
, 
[6002] = {id = 6002, mapID = 6, nodePosition = "1;3", frontNode = "-1", conflictedNode = 6001, buffID = 70212, buffNameID = 1901603, buffIconID = 14760, littleIconID = 10134, buffDescriptionID = 1901661, unlockConsumptionTimes = 3}
, 
[6003] = {id = 6003, mapID = 6, nodePosition = "2;2", frontNode = "6001;6002", conflictedNode = 0, buffID = 70002, buffNameID = 1901599, buffIconID = 14761, littleIconID = 10135, buffDescriptionID = 1901608, unlockConsumptionTimes = 2}
, 
[6004] = {id = 6004, mapID = 6, nodePosition = "3;1", frontNode = "6003", conflictedNode = 6005, buffID = 70061, buffNameID = 1901599, buffIconID = 14761, littleIconID = 12624, buffDescriptionID = 1901616, unlockConsumptionTimes = 3}
, 
[6005] = {id = 6005, mapID = 6, nodePosition = "3;3", frontNode = "6003", conflictedNode = 6004, buffID = 70213, buffNameID = 1901603, buffIconID = 12601, littleIconID = 12624, buffDescriptionID = 1901662, unlockConsumptionTimes = 3}
, 
[6006] = {id = 6006, mapID = 6, nodePosition = "4;2", frontNode = "6004;6005", conflictedNode = 0, buffID = 70041, buffNameID = 1901606, buffIconID = 14764, littleIconID = 12624, buffDescriptionID = 1901613, unlockConsumptionTimes = 2}
, 
[6007] = {id = 6007, mapID = 6, nodePosition = "5;1", frontNode = "6006", conflictedNode = 6008, buffID = 70214, buffNameID = 1901605, buffIconID = 12604, littleIconID = -1, buffDescriptionID = 1901663, unlockConsumptionTimes = 3}
, 
[6008] = {id = 6008, mapID = 6, nodePosition = "5;3", frontNode = "6006", conflictedNode = 6007, buffID = 70102, buffNameID = 1901602, buffIconID = 14761, littleIconID = -1, buffDescriptionID = 1901622, unlockConsumptionTimes = 3}
, 
[7001] = {id = 7001, mapID = 7, nodePosition = "1;1", frontNode = "-1", conflictedNode = 7002, buffID = 70021, buffNameID = 1901601, buffIconID = 12605, littleIconID = 10133, buffDescriptionID = 1901610, unlockConsumptionTimes = 3}
, 
[7002] = {id = 7002, mapID = 7, nodePosition = "1;3", frontNode = "-1", conflictedNode = 7001, buffID = 70022, buffNameID = 1901603, buffIconID = 14759, littleIconID = 10136, buffDescriptionID = 1901611, unlockConsumptionTimes = 3}
, 
[7003] = {id = 7003, mapID = 7, nodePosition = "2;2", frontNode = "7001;7002", conflictedNode = 0, buffID = 70001, buffNameID = 1901598, buffIconID = 12600, littleIconID = 10139, buffDescriptionID = 1901607, unlockConsumptionTimes = 2}
, 
[7004] = {id = 7004, mapID = 7, nodePosition = "3;1", frontNode = "7003", conflictedNode = 7005, buffID = 70061, buffNameID = 1901599, buffIconID = 14761, littleIconID = 12624, buffDescriptionID = 1901616, unlockConsumptionTimes = 3}
, 
[7005] = {id = 7005, mapID = 7, nodePosition = "3;3", frontNode = "7003", conflictedNode = 7004, buffID = 70062, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12623, buffDescriptionID = 1901617, unlockConsumptionTimes = 3}
, 
[7006] = {id = 7006, mapID = 7, nodePosition = "4;2", frontNode = "7004;7005", conflictedNode = 0, buffID = 70041, buffNameID = 1901600, buffIconID = 14764, littleIconID = 12624, buffDescriptionID = 1901613, unlockConsumptionTimes = 2}
, 
[7007] = {id = 7007, mapID = 7, nodePosition = "5;1", frontNode = "7006", conflictedNode = 7008, buffID = 70101, buffNameID = 1901602, buffIconID = 12601, littleIconID = -1, buffDescriptionID = 1901621, unlockConsumptionTimes = 3}
, 
[7008] = {id = 7008, mapID = 7, nodePosition = "5;3", frontNode = "7006", conflictedNode = 7007, buffID = 70102, buffNameID = 1901602, buffIconID = 14761, littleIconID = -1, buffDescriptionID = 1901622, unlockConsumptionTimes = 3}
, 
[8001] = {id = 8001, mapID = 8, nodePosition = "1;1", frontNode = "-1", conflictedNode = 8002, buffID = 70201, buffNameID = 1901601, buffIconID = 12605, littleIconID = 10133, buffDescriptionID = 1901657, unlockConsumptionTimes = 3}
, 
[8002] = {id = 8002, mapID = 8, nodePosition = "1;3", frontNode = "-1", conflictedNode = 8001, buffID = 70023, buffNameID = 1901602, buffIconID = 12601, littleIconID = 10138, buffDescriptionID = 1901612, unlockConsumptionTimes = 3}
, 
[8003] = {id = 8003, mapID = 8, nodePosition = "2;2", frontNode = "8001;8002", conflictedNode = 0, buffID = 70001, buffNameID = 1901598, buffIconID = 12600, littleIconID = 10139, buffDescriptionID = 1901607, unlockConsumptionTimes = 2}
, 
[8004] = {id = 8004, mapID = 8, nodePosition = "3;1", frontNode = "8003", conflictedNode = 8005, buffID = 70062, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12623, buffDescriptionID = 1901617, unlockConsumptionTimes = 3}
, 
[8005] = {id = 8005, mapID = 8, nodePosition = "3;3", frontNode = "8003", conflictedNode = 8004, buffID = 70063, buffNameID = 1901599, buffIconID = 12601, littleIconID = 12625, buffDescriptionID = 1901618, unlockConsumptionTimes = 3}
, 
[8006] = {id = 8006, mapID = 8, nodePosition = "4;2", frontNode = "8004;8005", conflictedNode = 0, buffID = 70202, buffNameID = 1901598, buffIconID = 12600, littleIconID = -1, buffDescriptionID = 1901658, unlockConsumptionTimes = 2}
, 
[8007] = {id = 8007, mapID = 8, nodePosition = "5;1", frontNode = "8006", conflictedNode = 8008, buffID = 70101, buffNameID = 1901602, buffIconID = 12601, littleIconID = -1, buffDescriptionID = 1901621, unlockConsumptionTimes = 3}
, 
[8008] = {id = 8008, mapID = 8, nodePosition = "5;3", frontNode = "8006", conflictedNode = 8007, buffID = 70203, buffNameID = 1901601, buffIconID = 12605, littleIconID = -1, buffDescriptionID = 1901659, unlockConsumptionTimes = 3}
}
cweeklybosscultivateskillmap.AllIds = {1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, 4001, 4002, 4003, 4004, 4005, 4006, 4007, 4008, 5001, 5002, 5003, 5004, 5005, 5006, 5007, 5008, 6001, 6002, 6003, 6004, 6005, 6006, 6007, 6008, 7001, 7002, 7003, 7004, 7005, 7006, 7007, 7008, 8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008}
return cweeklybosscultivateskillmap


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/scene/cscenejump.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cscenejump = {}
cscenejump.Data = {
[10001] = {id = 10001, jumpType = 1, 
nextNode = {10002}
, enterID = "2,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"21,1,1,2"}
, 
aimSceneID = {10002}
, 
aimPosition = {"3,10"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10002] = {id = 10002, jumpType = 1, 
nextNode = {10003}
, enterID = "3,10", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"27,2,1,2"}
, 
aimSceneID = {10003}
, 
aimPosition = {"9,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10003] = {id = 10003, jumpType = 2, 
nextNode = {10004}
, enterID = "9,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"9,1,2,1"}
, 
aimSceneID = {10004}
, 
aimPosition = {"16,46"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10004] = {id = 10004, jumpType = 1, 
nextNode = {10005}
, enterID = "16,46", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"45,2,1,2"}
, 
aimSceneID = {10005}
, 
aimPosition = {"4,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10005] = {id = 10005, jumpType = 2, 
nextNode = {10007}
, enterID = "4,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"40,0,3,1"}
, 
aimSceneID = {10007}
, 
aimPosition = {"3,13"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10007] = {id = 10007, jumpType = 1, 
nextNode = {10009}
, enterID = "3,13", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"30,13,2,1"}
, 
aimSceneID = {10009}
, 
aimPosition = {"4,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10009] = {id = 10009, jumpType = 1, 
nextNode = {10010}
, enterID = "4,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"14,3,3,1"}
, 
aimSceneID = {10010}
, 
aimPosition = {"4,20"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10010] = {id = 10010, jumpType = 2, 
nextNode = {10011}
, enterID = "4,20", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"21,5,2,1"}
, 
aimSceneID = {10011}
, 
aimPosition = {"20,37"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10011] = {id = 10011, jumpType = 2, 
nextNode = {12002}
, enterID = "20,37", enterDirection = "0", 
exitID = {1, 2}
, 
exitSituation = {"20,5,1,1", "11,21,2,1"}
, 
aimSceneID = {12002, 10012}
, 
aimPosition = {"5,37", "13,25"}
, 
direction = {0, 0}
, 
isShowInMap = {0, 0}
}
, 
[10012] = {id = 10012, jumpType = 1, 
nextNode = {10013}
, enterID = "13,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"29,3,3,1"}
, 
aimSceneID = {10013}
, 
aimPosition = {"5,23"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10013] = {id = 10013, jumpType = 2, 
nextNode = {10014}
, enterID = "5,23", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,8,3,1"}
, 
aimSceneID = {10014}
, 
aimPosition = {"9,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10014] = {id = 10014, jumpType = 1, 
nextNode = {10015}
, enterID = "9,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,3,3,1"}
, 
aimSceneID = {10015}
, 
aimPosition = {"4,20"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10015] = {id = 10015, jumpType = 2, 
nextNode = {10016}
, enterID = "4,20", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,2,3,1"}
, 
aimSceneID = {10016}
, 
aimPosition = {"15,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10016] = {id = 10016, jumpType = 1, 
nextNode = {10017}
, enterID = "15,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"11,2,3,1"}
, 
aimSceneID = {10017}
, 
aimPosition = {"4,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10017] = {id = 10017, jumpType = 2, 
nextNode = {10018}
, enterID = "4,24", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"3,3,3,1"}
, 
aimSceneID = {10018}
, 
aimPosition = {"11,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10018] = {id = 10018, jumpType = 1, 
nextNode = {10019}
, enterID = "11,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"9,1,5,1"}
, 
aimSceneID = {10019}
, 
aimPosition = {"5,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10019] = {id = 10019, jumpType = 2, 
nextNode = {10020}
, enterID = "5,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"4,2,3,1"}
, 
aimSceneID = {10020}
, 
aimPosition = {"5,22"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10020] = {id = 10020, jumpType = 2, 
nextNode = {10021}
, enterID = "5,22", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"10,2,5,1"}
, 
aimSceneID = {10021}
, 
aimPosition = {"16,40"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10021] = {id = 10021, jumpType = 0, 
nextNode = {13001}
, enterID = "16,40", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"3,3,1,1"}
, 
aimSceneID = {13001}
, 
aimPosition = {"16,17"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[10022] = {id = 10022, jumpType = 1, 
nextNode = {10023}
, enterID = "4,22", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,3,2,1"}
, 
aimSceneID = {10023}
, 
aimPosition = {"12,19"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10023] = {id = 10023, jumpType = 2, 
nextNode = {10024}
, enterID = "12,19", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"12,2,2,1"}
, 
aimSceneID = {10024}
, 
aimPosition = {"10,20"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10024] = {id = 10024, jumpType = 1, 
nextNode = {10025}
, enterID = "10,20", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,2,2,1"}
, 
aimSceneID = {10025}
, 
aimPosition = {"10,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10025] = {id = 10025, jumpType = 2, 
nextNode = {10026}
, enterID = "10,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"14,2,2,1"}
, 
aimSceneID = {10026}
, 
aimPosition = {"5,18"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10026] = {id = 10026, jumpType = 1, 
nextNode = {10027}
, enterID = "5,18", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,2,2,1"}
, 
aimSceneID = {10027}
, 
aimPosition = {"11,22"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10027] = {id = 10027, jumpType = 2, 
nextNode = {10028}
, enterID = "11,22", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"11,2,2,1"}
, 
aimSceneID = {10028}
, 
aimPosition = {"4,18"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10028] = {id = 10028, jumpType = 1, 
nextNode = {10029}
, enterID = "4,18", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,2,2,1"}
, 
aimSceneID = {10029}
, 
aimPosition = {"11,21"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10029] = {id = 10029, jumpType = 2, 
nextNode = {10030}
, enterID = "11,21", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"11,1,2,1"}
, 
aimSceneID = {10030}
, 
aimPosition = {"6,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10030] = {id = 10030, jumpType = 2, 
nextNode = {10031}
, enterID = "6,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,1,2,1"}
, 
aimSceneID = {10031}
, 
aimPosition = {"13,37"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10031] = {id = 10031, jumpType = 0, 
nextNode = {}
, enterID = "13,37", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"1,1,1,1"}
, 
aimSceneID = {14001}
, 
aimPosition = {"5,16"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[10032] = {id = 10032, jumpType = 1, 
nextNode = {10033}
, enterID = "9,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,1,2,1"}
, 
aimSceneID = {10033}
, 
aimPosition = {"9,23"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10033] = {id = 10033, jumpType = 2, 
nextNode = {10034}
, enterID = "9,23", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"12,1,2,1"}
, 
aimSceneID = {10034}
, 
aimPosition = {"14,22"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10034] = {id = 10034, jumpType = 1, 
nextNode = {10035}
, enterID = "14,22", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"7,2,2,1"}
, 
aimSceneID = {10035}
, 
aimPosition = {"4,20"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10035] = {id = 10035, jumpType = 2, 
nextNode = {10036}
, enterID = "4,20", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,8,2,1"}
, 
aimSceneID = {10036}
, 
aimPosition = {"5,20"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10036] = {id = 10036, jumpType = 1, 
nextNode = {10037}
, enterID = "5,20", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,2,2,1"}
, 
aimSceneID = {10037}
, 
aimPosition = {"13,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10037] = {id = 10037, jumpType = 2, 
nextNode = {10038}
, enterID = "13,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"4,4,2,1"}
, 
aimSceneID = {10038}
, 
aimPosition = {"4,16"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10038] = {id = 10038, jumpType = 1, 
nextNode = {10039}
, enterID = "4,16", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"17,1,2,1"}
, 
aimSceneID = {10039}
, 
aimPosition = {"6,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10039] = {id = 10039, jumpType = 2, 
nextNode = {10040}
, enterID = "6,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"5,1,2,1"}
, 
aimSceneID = {10040}
, 
aimPosition = {"11,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10040] = {id = 10040, jumpType = 2, 
nextNode = {10041}
, enterID = "11,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"7,2,2,1"}
, 
aimSceneID = {10041}
, 
aimPosition = {"13,38"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[10041] = {id = 10041, jumpType = 2, 
nextNode = {}
, enterID = "13,38", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[11000] = {id = 11000, jumpType = 0, 
nextNode = {20006}
, enterID = "17,59", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,0,1,1"}
, 
aimSceneID = {20006}
, 
aimPosition = {"0,0"}
, 
direction = {6}
, 
isShowInMap = {1}
}
, 
[11003] = {id = 11003, jumpType = 1, 
nextNode = {}
, enterID = "10,7", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[11004] = {id = 11004, jumpType = 1, 
nextNode = {}
, enterID = "18,8", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[11005] = {id = 11005, jumpType = 1, 
nextNode = {13101}
, enterID = "10,7", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"1,1,1,1"}
, 
aimSceneID = {13101}
, 
aimPosition = {"5,5"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[12001] = {id = 12001, jumpType = 0, 
nextNode = {}
, enterID = "2,33", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[12002] = {id = 12002, jumpType = 1, 
nextNode = {12003}
, enterID = "5,37", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"29,1,2,1"}
, 
aimSceneID = {12003}
, 
aimPosition = {"14,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12003] = {id = 12003, jumpType = 2, 
nextNode = {12004}
, enterID = "14,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"39,2,3,1"}
, 
aimSceneID = {12004}
, 
aimPosition = {"6,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12004] = {id = 12004, jumpType = 1, 
nextNode = {12005}
, enterID = "6,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"32,2,3,1"}
, 
aimSceneID = {12005}
, 
aimPosition = {"24,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12005] = {id = 12005, jumpType = 2, 
nextNode = {12006}
, enterID = "24,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"12,4,2,1"}
, 
aimSceneID = {12006}
, 
aimPosition = {"3,3"}
, 
direction = {4}
, 
isShowInMap = {1}
}
, 
[12006] = {id = 12006, jumpType = 1, 
nextNode = {12007}
, enterID = "3,3", enterDirection = "4", 
exitID = {1}
, 
exitSituation = {"21,2,3,1"}
, 
aimSceneID = {12007}
, 
aimPosition = {"5,35"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12007] = {id = 12007, jumpType = 2, 
nextNode = {12008}
, enterID = "5,35", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"32,8,3,1"}
, 
aimSceneID = {12008}
, 
aimPosition = {"5,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12008] = {id = 12008, jumpType = 1, 
nextNode = {12009}
, enterID = "5,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"31,2,3,1"}
, 
aimSceneID = {12009}
, 
aimPosition = {"4,13"}
, 
direction = {4}
, 
isShowInMap = {1}
}
, 
[12009] = {id = 12009, jumpType = 2, 
nextNode = {12010}
, enterID = "4,13", enterDirection = "4", 
exitID = {1}
, 
exitSituation = {"18,5,3,1"}
, 
aimSceneID = {12010}
, 
aimPosition = {"3,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12010] = {id = 12010, jumpType = 1, 
nextNode = {12011}
, enterID = "3,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"13,11,3,1"}
, 
aimSceneID = {12011}
, 
aimPosition = {"9,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12011] = {id = 12011, jumpType = 2, 
nextNode = {12012}
, enterID = "9,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"21,2,3,1"}
, 
aimSceneID = {12012}
, 
aimPosition = {"2,21"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12012] = {id = 12012, jumpType = 1, 
nextNode = {12013}
, enterID = "2,21", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"26,6,1,1"}
, 
aimSceneID = {12013}
, 
aimPosition = {"3,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12013] = {id = 12013, jumpType = 2, 
nextNode = {12014}
, enterID = "3,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,2,3,1"}
, 
aimSceneID = {12014}
, 
aimPosition = {"3,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12014] = {id = 12014, jumpType = 1, 
nextNode = {12015}
, enterID = "3,24", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,2,3,1"}
, 
aimSceneID = {12015}
, 
aimPosition = {"3,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12015] = {id = 12015, jumpType = 2, 
nextNode = {12016}
, enterID = "3,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,4,3,1"}
, 
aimSceneID = {12016}
, 
aimPosition = {"7,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12016] = {id = 12016, jumpType = 1, 
nextNode = {12017}
, enterID = "7,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,0,3,1"}
, 
aimSceneID = {12017}
, 
aimPosition = {"2,3"}
, 
direction = {2}
, 
isShowInMap = {1}
}
, 
[12017] = {id = 12017, jumpType = 2, 
nextNode = {12018}
, enterID = "2,3", enterDirection = "2", 
exitID = {1}
, 
exitSituation = {"24,3,1,3"}
, 
aimSceneID = {12018}
, 
aimPosition = {"3,3"}
, 
direction = {4}
, 
isShowInMap = {1}
}
, 
[12018] = {id = 12018, jumpType = 1, 
nextNode = {12019}
, enterID = "3,3", enterDirection = "4", 
exitID = {1}
, 
exitSituation = {"3,27,1,3"}
, 
aimSceneID = {12019}
, 
aimPosition = {"3,28"}
, 
direction = {2}
, 
isShowInMap = {1}
}
, 
[12019] = {id = 12019, jumpType = 2, 
nextNode = {12020}
, enterID = "3,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,13,3,1"}
, 
aimSceneID = {12020}
, 
aimPosition = {"5,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12020] = {id = 12020, jumpType = 1, 
nextNode = {12021}
, enterID = "5,24", enterDirection = "4", 
exitID = {1}
, 
exitSituation = {"38,3,1,3"}
, 
aimSceneID = {12021}
, 
aimPosition = {"3,16"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12021] = {id = 12021, jumpType = 2, 
nextNode = {12022}
, enterID = "3,16", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,4,3,1"}
, 
aimSceneID = {12022}
, 
aimPosition = {"3,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12022] = {id = 12022, jumpType = 1, 
nextNode = {12023}
, enterID = "3,24", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"31,3,3,1"}
, 
aimSceneID = {12023}
, 
aimPosition = {"5,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12023] = {id = 12023, jumpType = 2, 
nextNode = {12024}
, enterID = "5,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,3,4,1"}
, 
aimSceneID = {12024}
, 
aimPosition = {"2,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12024] = {id = 12024, jumpType = 2, 
nextNode = {12025}
, enterID = "2,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"30,3,5,1"}
, 
aimSceneID = {12025}
, 
aimPosition = {"2,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[12025] = {id = 12025, jumpType = 0, 
nextNode = {20008}
, enterID = "2,32", enterDirection = "0", 
exitID = {1, 2}
, 
exitSituation = {"1,1,1,1", "0,0,0,0"}
, 
aimSceneID = {20008, 30007}
, 
aimPosition = {"0,0", "0,0"}
, 
direction = {0, 0}
, 
isShowInMap = {0, 0}
}
, 
[13001] = {id = 13001, jumpType = 1, 
nextNode = {13002}
, enterID = "16,17", enterDirection = "0", 
exitID = {1, 2, 3, 4, 5}
, 
exitSituation = {"40,2,2,1", "1,1,1,1", "2,1,1,1", "3,1,1,1", "4,1,1,1"}
, 
aimSceneID = {13002, 13101, 13102, 13103, 13104}
, 
aimPosition = {"5,28", "10,11", "10,10", "10,10", "10,10"}
, 
direction = {0, 0, 0, 0, 0}
, 
isShowInMap = {1, 0, 0, 0, 0}
}
, 
[13002] = {id = 13002, jumpType = 2, 
nextNode = {13003}
, enterID = "5,28", enterDirection = "0", 
exitID = {1, 2}
, 
exitSituation = {"22,2,2,1", "0,0,1,1"}
, 
aimSceneID = {13003, 13101}
, 
aimPosition = {"31,33", "5,5"}
, 
direction = {0, 0}
, 
isShowInMap = {1, 0}
}
, 
[13003] = {id = 13003, jumpType = 1, 
nextNode = {13004}
, enterID = "31,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,3,3,1"}
, 
aimSceneID = {13004}
, 
aimPosition = {"27,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13004] = {id = 13004, jumpType = 2, 
nextNode = {13005}
, enterID = "27,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"26,3,3,1"}
, 
aimSceneID = {13005}
, 
aimPosition = {"4,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13005] = {id = 13005, jumpType = 1, 
nextNode = {13006}
, enterID = "4,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,4,2,1"}
, 
aimSceneID = {13006}
, 
aimPosition = {"3,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13006] = {id = 13006, jumpType = 2, 
nextNode = {13007}
, enterID = "3,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"29,3,3,1"}
, 
aimSceneID = {13007}
, 
aimPosition = {"7,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13007] = {id = 13007, jumpType = 1, 
nextNode = {13008}
, enterID = "7,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,5,3,1"}
, 
aimSceneID = {13008}
, 
aimPosition = {"5,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13008] = {id = 13008, jumpType = 2, 
nextNode = {13009}
, enterID = "5,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"29,1,2,1"}
, 
aimSceneID = {13009}
, 
aimPosition = {"19,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13009] = {id = 13009, jumpType = 1, 
nextNode = {13010}
, enterID = "19,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"14,5,3,1"}
, 
aimSceneID = {13010}
, 
aimPosition = {"11,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13010] = {id = 13010, jumpType = 2, 
nextNode = {13011}
, enterID = "11,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"32,15,3,1"}
, 
aimSceneID = {13011}
, 
aimPosition = {"3,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13011] = {id = 13011, jumpType = 1, 
nextNode = {13012}
, enterID = "3,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,1,3,1"}
, 
aimSceneID = {13012}
, 
aimPosition = {"20,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13012] = {id = 13012, jumpType = 2, 
nextNode = {13013}
, enterID = "20,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"4,2,3,1"}
, 
aimSceneID = {13013}
, 
aimPosition = {"9,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13013] = {id = 13013, jumpType = 1, 
nextNode = {13014}
, enterID = "9,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,4,3,1"}
, 
aimSceneID = {13014}
, 
aimPosition = {"6,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13014] = {id = 13014, jumpType = 2, 
nextNode = {13015}
, enterID = "6,24", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,5,3,1"}
, 
aimSceneID = {13015}
, 
aimPosition = {"6,15"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13015] = {id = 13015, jumpType = 1, 
nextNode = {13016}
, enterID = "6,15", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"28,2,3,1"}
, 
aimSceneID = {13016}
, 
aimPosition = {"12,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13016] = {id = 13016, jumpType = 2, 
nextNode = {13017}
, enterID = "12,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"17,2,3,1"}
, 
aimSceneID = {13017}
, 
aimPosition = {"24,37"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13017] = {id = 13017, jumpType = 1, 
nextNode = {13018}
, enterID = "24,37", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,5,3,1"}
, 
aimSceneID = {13018}
, 
aimPosition = {"8,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13018] = {id = 13018, jumpType = 2, 
nextNode = {13019}
, enterID = "8,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,2,3,1"}
, 
aimSceneID = {13019}
, 
aimPosition = {"7,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13019] = {id = 13019, jumpType = 1, 
nextNode = {13020}
, enterID = "7,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,1,3,1"}
, 
aimSceneID = {13020}
, 
aimPosition = {"25,17"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13020] = {id = 13020, jumpType = 2, 
nextNode = {13021}
, enterID = "25,17", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,1,3,1"}
, 
aimSceneID = {13021}
, 
aimPosition = {"21,36"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13021] = {id = 13021, jumpType = 1, 
nextNode = {13022}
, enterID = "21,36", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,5,3,1"}
, 
aimSceneID = {13022}
, 
aimPosition = {"16,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13022] = {id = 13022, jumpType = 2, 
nextNode = {13023}
, enterID = "16,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,2,3,1"}
, 
aimSceneID = {13023}
, 
aimPosition = {"13,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13023] = {id = 13023, jumpType = 1, 
nextNode = {13024}
, enterID = "13,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"4,1,3,1"}
, 
aimSceneID = {13024}
, 
aimPosition = {"10,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13024] = {id = 13024, jumpType = 2, 
nextNode = {13025}
, enterID = "10,24", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,10,3,1"}
, 
aimSceneID = {13025}
, 
aimPosition = {"21,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13025] = {id = 13025, jumpType = 1, 
nextNode = {13026}
, enterID = "21,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"10,1,3,1"}
, 
aimSceneID = {13026}
, 
aimPosition = {"4,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13026] = {id = 13026, jumpType = 2, 
nextNode = {13027}
, enterID = "4,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,6,3,1"}
, 
aimSceneID = {13027}
, 
aimPosition = {"11,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13027] = {id = 13027, jumpType = 1, 
nextNode = {13028}
, enterID = "11,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,3,3,1"}
, 
aimSceneID = {13028}
, 
aimPosition = {"4,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13028] = {id = 13028, jumpType = 2, 
nextNode = {13029}
, enterID = "4,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"18,3,3,1"}
, 
aimSceneID = {13029}
, 
aimPosition = {"4,22"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13029] = {id = 13029, jumpType = 1, 
nextNode = {13030}
, enterID = "4,22", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"13,3,3,1"}
, 
aimSceneID = {13030}
, 
aimPosition = {"10,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13030] = {id = 13030, jumpType = 2, 
nextNode = {13031}
, enterID = "10,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"10,4,1,1"}
, 
aimSceneID = {13031}
, 
aimPosition = {"3,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13031] = {id = 13031, jumpType = 1, 
nextNode = {13032}
, enterID = "3,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"18,2,3,1"}
, 
aimSceneID = {13032}
, 
aimPosition = {"5,45"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13032] = {id = 13032, jumpType = 2, 
nextNode = {13033}
, enterID = "5,45", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,2,1,1"}
, 
aimSceneID = {13033}
, 
aimPosition = {"4,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13033] = {id = 13033, jumpType = 1, 
nextNode = {13034}
, enterID = "4,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"5,3,3,1"}
, 
aimSceneID = {13034}
, 
aimPosition = {"5,36"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13034] = {id = 13034, jumpType = 2, 
nextNode = {13035}
, enterID = "5,36", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,3,1,1"}
, 
aimSceneID = {13035}
, 
aimPosition = {"14,56"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[13035] = {id = 13035, jumpType = 0, 
nextNode = {10022}
, enterID = "14,56", enterDirection = "0", 
exitID = {1, 2}
, 
exitSituation = {"0,0,1,1", "0,0,1,1"}
, 
aimSceneID = {10022, 13035}
, 
aimPosition = {"4,22", "12,13"}
, 
direction = {0, 0}
, 
isShowInMap = {0, 0}
}
, 
[13101] = {id = 13101, jumpType = 0, 
nextNode = {13001}
, enterID = "5,5", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"1,1,1,1"}
, 
aimSceneID = {13001}
, 
aimPosition = {"25,37"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[13102] = {id = 13102, jumpType = 0, 
nextNode = {13001}
, enterID = "10,10", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"1,1,1,1"}
, 
aimSceneID = {13001}
, 
aimPosition = {"4,37"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[13103] = {id = 13103, jumpType = 0, 
nextNode = {13001}
, enterID = "10,10", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"1,1,1,1"}
, 
aimSceneID = {13001}
, 
aimPosition = {"24,29"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[13104] = {id = 13104, jumpType = 0, 
nextNode = {13001}
, enterID = "10,10", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"1,1,1,1"}
, 
aimSceneID = {13001}
, 
aimPosition = {"41,36"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[14001] = {id = 14001, jumpType = 1, 
nextNode = {14002}
, enterID = "5,16", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"40,13,3,1"}
, 
aimSceneID = {14002}
, 
aimPosition = {"8,36"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14002] = {id = 14002, jumpType = 2, 
nextNode = {14003}
, enterID = "8,36", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"35,24,3,1"}
, 
aimSceneID = {14003}
, 
aimPosition = {"7,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14003] = {id = 14003, jumpType = 1, 
nextNode = {14004}
, enterID = "7,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,5,3,1"}
, 
aimSceneID = {14004}
, 
aimPosition = {"27,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14004] = {id = 14004, jumpType = 2, 
nextNode = {14005}
, enterID = "27,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"26,3,3,1"}
, 
aimSceneID = {14005}
, 
aimPosition = {"4,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14005] = {id = 14005, jumpType = 1, 
nextNode = {14006}
, enterID = "4,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"21,4,3,1"}
, 
aimSceneID = {14006}
, 
aimPosition = {"3,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14006] = {id = 14006, jumpType = 2, 
nextNode = {14007}
, enterID = "3,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"29,3,3,1"}
, 
aimSceneID = {14007}
, 
aimPosition = {"21,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14007] = {id = 14007, jumpType = 1, 
nextNode = {14008}
, enterID = "21,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"34,7,3,1"}
, 
aimSceneID = {14008}
, 
aimPosition = {"11,42"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14008] = {id = 14008, jumpType = 2, 
nextNode = {14009}
, enterID = "11,42", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"12,3,3,1"}
, 
aimSceneID = {14009}
, 
aimPosition = {"18,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14009] = {id = 14009, jumpType = 1, 
nextNode = {14010}
, enterID = "18,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,2,3,1"}
, 
aimSceneID = {14010}
, 
aimPosition = {"16,38"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14010] = {id = 14010, jumpType = 2, 
nextNode = {14011}
, enterID = "16,38", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"14,3,3,1"}
, 
aimSceneID = {14011}
, 
aimPosition = {"3,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14011] = {id = 14011, jumpType = 1, 
nextNode = {14012}
, enterID = "3,24", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,1,3,1"}
, 
aimSceneID = {14012}
, 
aimPosition = {"11,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14012] = {id = 14012, jumpType = 2, 
nextNode = {14013}
, enterID = "11,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,4,3,1"}
, 
aimSceneID = {14013}
, 
aimPosition = {"6,23"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14013] = {id = 14013, jumpType = 1, 
nextNode = {14014}
, enterID = "6,23", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,5,3,1"}
, 
aimSceneID = {14014}
, 
aimPosition = {"3,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14014] = {id = 14014, jumpType = 2, 
nextNode = {14015}
, enterID = "3,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"28,1,3,1"}
, 
aimSceneID = {14015}
, 
aimPosition = {"5,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14015] = {id = 14015, jumpType = 1, 
nextNode = {14016}
, enterID = "5,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,1,3,1"}
, 
aimSceneID = {14016}
, 
aimPosition = {"3,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14016] = {id = 14016, jumpType = 2, 
nextNode = {14017}
, enterID = "3,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,2,3,1"}
, 
aimSceneID = {14017}
, 
aimPosition = {"3,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14017] = {id = 14017, jumpType = 1, 
nextNode = {14018}
, enterID = "3,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"13,3,3,1"}
, 
aimSceneID = {14018}
, 
aimPosition = {"9,21"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14018] = {id = 14018, jumpType = 2, 
nextNode = {14019}
, enterID = "9,21", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,2,3,1"}
, 
aimSceneID = {14019}
, 
aimPosition = {"21,35"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14019] = {id = 14019, jumpType = 1, 
nextNode = {14020}
, enterID = "21,35", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,5,3,1"}
, 
aimSceneID = {14020}
, 
aimPosition = {"16,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14020] = {id = 14020, jumpType = 2, 
nextNode = {14021}
, enterID = "16,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,2,3,1"}
, 
aimSceneID = {14021}
, 
aimPosition = {"15,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14021] = {id = 14021, jumpType = 1, 
nextNode = {14022}
, enterID = "15,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,3,3,1"}
, 
aimSceneID = {14022}
, 
aimPosition = {"4,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14022] = {id = 14022, jumpType = 2, 
nextNode = {14023}
, enterID = "4,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,6,3,1"}
, 
aimSceneID = {14023}
, 
aimPosition = {"11,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14023] = {id = 14023, jumpType = 1, 
nextNode = {14024}
, enterID = "11,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,3,3,1"}
, 
aimSceneID = {14024}
, 
aimPosition = {"12,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14024] = {id = 14024, jumpType = 2, 
nextNode = {14025}
, enterID = "12,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,3,3,1"}
, 
aimSceneID = {14025}
, 
aimPosition = {"10,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14025] = {id = 14025, jumpType = 1, 
nextNode = {14026}
, enterID = "10,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"9,4,3,1"}
, 
aimSceneID = {14026}
, 
aimPosition = {"4,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14026] = {id = 14026, jumpType = 2, 
nextNode = {14027}
, enterID = "4,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,3,3,1"}
, 
aimSceneID = {14027}
, 
aimPosition = {"5,45"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14027] = {id = 14027, jumpType = 1, 
nextNode = {14028}
, enterID = "5,45", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"18,2,4,1"}
, 
aimSceneID = {14028}
, 
aimPosition = {"14,55"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14028] = {id = 14028, jumpType = 0, 
nextNode = {14029}
, enterID = "14,55", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"1,1,1,1"}
, 
aimSceneID = {14029}
, 
aimPosition = {"18,34"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[14029] = {id = 14029, jumpType = 1, 
nextNode = {14030}
, enterID = "18,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,3,3,1"}
, 
aimSceneID = {14030}
, 
aimPosition = {"5,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14030] = {id = 14030, jumpType = 2, 
nextNode = {14031}
, enterID = "5,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"4,4,3,1"}
, 
aimSceneID = {14031}
, 
aimPosition = {"6,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14031] = {id = 14031, jumpType = 1, 
nextNode = {14032}
, enterID = "6,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,3,3,1"}
, 
aimSceneID = {14032}
, 
aimPosition = {"27,23"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14032] = {id = 14032, jumpType = 2, 
nextNode = {14033}
, enterID = "27,23", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"17,7,3,1"}
, 
aimSceneID = {14033}
, 
aimPosition = {"23,24"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14033] = {id = 14033, jumpType = 1, 
nextNode = {14034}
, enterID = "23,24", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,5,3,1"}
, 
aimSceneID = {14034}
, 
aimPosition = {"24,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14034] = {id = 14034, jumpType = 2, 
nextNode = {14035}
, enterID = "24,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"5,8,3,1"}
, 
aimSceneID = {14035}
, 
aimPosition = {"17,37"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14035] = {id = 14035, jumpType = 0, 
nextNode = {14036}
, enterID = "17,37", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"6,3,1,1"}
, 
aimSceneID = {14036}
, 
aimPosition = {"10,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14036] = {id = 14036, jumpType = 1, 
nextNode = {14037}
, enterID = "10,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"9,4,3,1"}
, 
aimSceneID = {14037}
, 
aimPosition = {"5,45"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14037] = {id = 14037, jumpType = 2, 
nextNode = {14038}
, enterID = "5,45", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"18,2,4,1"}
, 
aimSceneID = {14038}
, 
aimPosition = {"17,37"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[14038] = {id = 14038, jumpType = 0, 
nextNode = {}
, enterID = "17,37", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"0,0,1,1"}
, 
aimSceneID = {10032}
, 
aimPosition = {"9,27"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[15001] = {id = 15001, jumpType = 1, 
nextNode = {15002}
, enterID = "12,45", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,1,3,2"}
, 
aimSceneID = {15002}
, 
aimPosition = {"7,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15002] = {id = 15002, jumpType = 2, 
nextNode = {15003}
, enterID = "7,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,4,5,2"}
, 
aimSceneID = {15003}
, 
aimPosition = {"16,36"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15003] = {id = 15003, jumpType = 1, 
nextNode = {15004}
, enterID = "16,36", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"17,2,5,2"}
, 
aimSceneID = {15004}
, 
aimPosition = {"7,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15004] = {id = 15004, jumpType = 2, 
nextNode = {15005}
, enterID = "7,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"27,1,4,2"}
, 
aimSceneID = {15005}
, 
aimPosition = {"15,39"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15005] = {id = 15005, jumpType = 1, 
nextNode = {15006}
, enterID = "15,39", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,5,4,1"}
, 
aimSceneID = {15006}
, 
aimPosition = {"9,35"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15006] = {id = 15006, jumpType = 2, 
nextNode = {15007}
, enterID = "9,35", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,4,2,1"}
, 
aimSceneID = {15007}
, 
aimPosition = {"16,39"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15007] = {id = 15007, jumpType = 1, 
nextNode = {15008}
, enterID = "16,39", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,5,3,1"}
, 
aimSceneID = {15008}
, 
aimPosition = {"16,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15008] = {id = 15008, jumpType = 2, 
nextNode = {15009}
, enterID = "16,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,2,3,1"}
, 
aimSceneID = {15009}
, 
aimPosition = {"10,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15009] = {id = 15009, jumpType = 1, 
nextNode = {15011}
, enterID = "10,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,1,3,2"}
, 
aimSceneID = {30012}
, 
aimPosition = {"0,0"}
, 
direction = {2}
, 
isShowInMap = {1}
}
, 
[15011] = {id = 15011, jumpType = 2, 
nextNode = {15012}
, enterID = "13,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"11,2,4,2"}
, 
aimSceneID = {15012}
, 
aimPosition = {"21,42"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15012] = {id = 15012, jumpType = 1, 
nextNode = {15013}
, enterID = "21,42", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,2,3,2"}
, 
aimSceneID = {15013}
, 
aimPosition = {"18,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15013] = {id = 15013, jumpType = 2, 
nextNode = {15014}
, enterID = "18,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"14,3,4,2"}
, 
aimSceneID = {15014}
, 
aimPosition = {"14,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15014] = {id = 15014, jumpType = 1, 
nextNode = {15015}
, enterID = "14,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"34,3,2,2"}
, 
aimSceneID = {15015}
, 
aimPosition = {"7,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15015] = {id = 15015, jumpType = 2, 
nextNode = {15016}
, enterID = "7,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,3,4,2"}
, 
aimSceneID = {15016}
, 
aimPosition = {"8,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15016] = {id = 15016, jumpType = 1, 
nextNode = {15017}
, enterID = "8,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"30,1,4,2"}
, 
aimSceneID = {15017}
, 
aimPosition = {"14,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15017] = {id = 15017, jumpType = 2, 
nextNode = {15018}
, enterID = "14,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"32,3,3,2"}
, 
aimSceneID = {15018}
, 
aimPosition = {"14,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15018] = {id = 15018, jumpType = 1, 
nextNode = {15019}
, enterID = "14,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,1,3,2"}
, 
aimSceneID = {15019}
, 
aimPosition = {"9,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15019] = {id = 15019, jumpType = 2, 
nextNode = {15020}
, enterID = "9,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"28,2,3,2"}
, 
aimSceneID = {15020}
, 
aimPosition = {"15,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15020] = {id = 15020, jumpType = 1, 
nextNode = {15021}
, enterID = "15,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,4,3,2"}
, 
aimSceneID = {15021}
, 
aimPosition = {"9,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15021] = {id = 15021, jumpType = 2, 
nextNode = {15022}
, enterID = "9,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"31,3,3,2"}
, 
aimSceneID = {15022}
, 
aimPosition = {"23,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15022] = {id = 15022, jumpType = 1, 
nextNode = {15023}
, enterID = "23,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"26,1,4,1"}
, 
aimSceneID = {15023}
, 
aimPosition = {"11,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15023] = {id = 15023, jumpType = 2, 
nextNode = {15024}
, enterID = "11,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"32,3,4,2"}
, 
aimSceneID = {15024}
, 
aimPosition = {"23,36"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15024] = {id = 15024, jumpType = 1, 
nextNode = {15025}
, enterID = "23,36", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"35,2,3,2"}
, 
aimSceneID = {15025}
, 
aimPosition = {"12,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15025] = {id = 15025, jumpType = 2, 
nextNode = {15026}
, enterID = "12,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,3,4,2"}
, 
aimSceneID = {15026}
, 
aimPosition = {"18,35"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15026] = {id = 15026, jumpType = 1, 
nextNode = {15027}
, enterID = "18,35", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"14,4,4,2"}
, 
aimSceneID = {15027}
, 
aimPosition = {"5,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15027] = {id = 15027, jumpType = 2, 
nextNode = {15028}
, enterID = "5,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,3,3,2"}
, 
aimSceneID = {15028}
, 
aimPosition = {"14,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15028] = {id = 15028, jumpType = 1, 
nextNode = {15029}
, enterID = "14,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,6,3,2"}
, 
aimSceneID = {15029}
, 
aimPosition = {"12,36"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15029] = {id = 15029, jumpType = 2, 
nextNode = {15030}
, enterID = "12,36", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"28,2,3,2"}
, 
aimSceneID = {15030}
, 
aimPosition = {"22,40"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15030] = {id = 15030, jumpType = 1, 
nextNode = {15031}
, enterID = "22,40", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"16,2,4,2"}
, 
aimSceneID = {15031}
, 
aimPosition = {"17,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15031] = {id = 15031, jumpType = 2, 
nextNode = {15032}
, enterID = "17,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,3,3,2"}
, 
aimSceneID = {15032}
, 
aimPosition = {"15,37"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15032] = {id = 15032, jumpType = 1, 
nextNode = {15033}
, enterID = "15,37", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"14,3,3,2"}
, 
aimSceneID = {15033}
, 
aimPosition = {"24,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15033] = {id = 15033, jumpType = 1, 
nextNode = {15034}
, enterID = "24,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,3,3,2"}
, 
aimSceneID = {15034}
, 
aimPosition = {"19,38"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15034] = {id = 15034, jumpType = 2, 
nextNode = {15035}
, enterID = "19,38", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"18,2,3,2"}
, 
aimSceneID = {15035}
, 
aimPosition = {"10,21"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[15035] = {id = 15035, jumpType = 2, 
nextNode = {}
, enterID = "10,21", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {}
, 
aimSceneID = {16001}
, 
aimPosition = {"7,26"}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[16001] = {id = 16001, jumpType = 1, 
nextNode = {16002}
, enterID = "7,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,5,3,1"}
, 
aimSceneID = {16002}
, 
aimPosition = {"10,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16002] = {id = 16002, jumpType = 2, 
nextNode = {16003}
, enterID = "10,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,3,3,1"}
, 
aimSceneID = {16003}
, 
aimPosition = {"11,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16003] = {id = 16003, jumpType = 1, 
nextNode = {16004}
, enterID = "11,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,3,3,1"}
, 
aimSceneID = {16004}
, 
aimPosition = {"10,25"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16004] = {id = 16004, jumpType = 2, 
nextNode = {16005}
, enterID = "10,25", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"10,1,2,1"}
, 
aimSceneID = {16005}
, 
aimPosition = {"13,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16005] = {id = 16005, jumpType = 1, 
nextNode = {16006}
, enterID = "13,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,3,4,1"}
, 
aimSceneID = {16006}
, 
aimPosition = {"13,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16006] = {id = 16006, jumpType = 2, 
nextNode = {16007}
, enterID = "13,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"12,1,3,1"}
, 
aimSceneID = {16007}
, 
aimPosition = {"11,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16007] = {id = 16007, jumpType = 1, 
nextNode = {16008}
, enterID = "11,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,4,3,1"}
, 
aimSceneID = {16008}
, 
aimPosition = {"19,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16008] = {id = 16008, jumpType = 2, 
nextNode = {16009}
, enterID = "19,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"27,1,2,1"}
, 
aimSceneID = {16009}
, 
aimPosition = {"7,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16009] = {id = 16009, jumpType = 1, 
nextNode = {16010}
, enterID = "7,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,4,4,1"}
, 
aimSceneID = {16010}
, 
aimPosition = {"7,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16010] = {id = 16010, jumpType = 2, 
nextNode = {16011}
, enterID = "7,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,3,2,1"}
, 
aimSceneID = {16011}
, 
aimPosition = {"7,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16011] = {id = 16011, jumpType = 1, 
nextNode = {16012}
, enterID = "7,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"22,2,2,1"}
, 
aimSceneID = {16012}
, 
aimPosition = {"9,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16012] = {id = 16012, jumpType = 2, 
nextNode = {16013}
, enterID = "9,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"28,5,2,1"}
, 
aimSceneID = {16013}
, 
aimPosition = {"13,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16013] = {id = 16013, jumpType = 1, 
nextNode = {16014}
, enterID = "13,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"33,2,2,1"}
, 
aimSceneID = {16014}
, 
aimPosition = {"13,32"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16014] = {id = 16014, jumpType = 2, 
nextNode = {16015}
, enterID = "13,32", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,1,2,1"}
, 
aimSceneID = {16015}
, 
aimPosition = {"9,39"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16015] = {id = 16015, jumpType = 1, 
nextNode = {16016}
, enterID = "9,39", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"17,2,2,1"}
, 
aimSceneID = {16016}
, 
aimPosition = {"6,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16016] = {id = 16016, jumpType = 2, 
nextNode = {16017}
, enterID = "6,30", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"33,4,2,1"}
, 
aimSceneID = {16017}
, 
aimPosition = {"7,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16017] = {id = 16017, jumpType = 1, 
nextNode = {16018}
, enterID = "7,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,2,2,1"}
, 
aimSceneID = {16018}
, 
aimPosition = {"13,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16018] = {id = 16018, jumpType = 2, 
nextNode = {16019}
, enterID = "13,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,1,2,1"}
, 
aimSceneID = {16019}
, 
aimPosition = {"15,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16019] = {id = 16019, jumpType = 1, 
nextNode = {16020}
, enterID = "15,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,2,2,1"}
, 
aimSceneID = {16020}
, 
aimPosition = {"13,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16020] = {id = 16020, jumpType = 2, 
nextNode = {16021}
, enterID = "13,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"13,1,2,1"}
, 
aimSceneID = {16021}
, 
aimPosition = {"5,29"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16021] = {id = 16021, jumpType = 1, 
nextNode = {16022}
, enterID = "5,29", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,1,2,1"}
, 
aimSceneID = {16022}
, 
aimPosition = {"11,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16022] = {id = 16022, jumpType = 2, 
nextNode = {16023}
, enterID = "11,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"10,1,1,1"}
, 
aimSceneID = {16023}
, 
aimPosition = {"10,23"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16023] = {id = 16023, jumpType = 1, 
nextNode = {16024}
, enterID = "10,23", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"10,1,2,1"}
, 
aimSceneID = {16024}
, 
aimPosition = {"5,27"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16024] = {id = 16024, jumpType = 2, 
nextNode = {16025}
, enterID = "5,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"23,1,2,1"}
, 
aimSceneID = {16025}
, 
aimPosition = {"6,28"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16025] = {id = 16025, jumpType = 1, 
nextNode = {16026}
, enterID = "6,28", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,1,4,1"}
, 
aimSceneID = {16026}
, 
aimPosition = {"7,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16026] = {id = 16026, jumpType = 2, 
nextNode = {16027}
, enterID = "7,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,7,4,1"}
, 
aimSceneID = {16027}
, 
aimPosition = {"4,20"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16027] = {id = 16027, jumpType = 1, 
nextNode = {16028}
, enterID = "4,20", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,3,3,1"}
, 
aimSceneID = {16028}
, 
aimPosition = {"5,20"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16028] = {id = 16028, jumpType = 2, 
nextNode = {16029}
, enterID = "5,20", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,1,4,1"}
, 
aimSceneID = {16029}
, 
aimPosition = {"6,18"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16029] = {id = 16029, jumpType = 1, 
nextNode = {16030}
, enterID = "6,18", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"19,2,3,1"}
, 
aimSceneID = {16030}
, 
aimPosition = {"12,33"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16030] = {id = 16030, jumpType = 2, 
nextNode = {16031}
, enterID = "12,33", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"11,1,3,1"}
, 
aimSceneID = {16031}
, 
aimPosition = {"7,34"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16031] = {id = 16031, jumpType = 1, 
nextNode = {16032}
, enterID = "7,34", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"25,1,2,1"}
, 
aimSceneID = {16032}
, 
aimPosition = {"7,26"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16032] = {id = 16032, jumpType = 2, 
nextNode = {16033}
, enterID = "7,26", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"20,2,2,1"}
, 
aimSceneID = {16033}
, 
aimPosition = {"6,31"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16033] = {id = 16033, jumpType = 1, 
nextNode = {16034}
, enterID = "6,31", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"24,2,2,1"}
, 
aimSceneID = {16034}
, 
aimPosition = {"7,38"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16034] = {id = 16034, jumpType = 2, 
nextNode = {16035}
, enterID = "7,38", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,2,2,1"}
, 
aimSceneID = {16035}
, 
aimPosition = {"24,51"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[16035] = {id = 16035, jumpType = 2, 
nextNode = {}
, enterID = "24,51", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[20009] = {id = 20009, jumpType = 0, 
nextNode = {30003}
, enterID = "0,0", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {}
, 
aimSceneID = {30003}
, 
aimPosition = {"0,0"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[30003] = {id = 30003, jumpType = 0, 
nextNode = {12002}
, enterID = "0,0", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {}
, 
aimSceneID = {12002}
, 
aimPosition = {"5,37"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[30006] = {id = 30006, jumpType = 1, 
nextNode = {}
, enterID = "14,27", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"5,4,4,1"}
, 
aimSceneID = {15001}
, 
aimPosition = {"12,45"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[30012] = {id = 30012, jumpType = 0, 
nextNode = {15011}
, enterID = "0,0", enterDirection = "2", 
exitID = {1}
, 
exitSituation = {"0,0,1,1"}
, 
aimSceneID = {15011}
, 
aimPosition = {"13,30"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[40001] = {id = 40001, jumpType = 0, 
nextNode = {}
, enterID = "9,19", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40002] = {id = 40002, jumpType = 0, 
nextNode = {}
, enterID = "4,19", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40003] = {id = 40003, jumpType = 0, 
nextNode = {}
, enterID = "4,27", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40004] = {id = 40004, jumpType = 0, 
nextNode = {}
, enterID = "8,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40005] = {id = 40005, jumpType = 0, 
nextNode = {}
, enterID = "4,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40006] = {id = 40006, jumpType = 0, 
nextNode = {}
, enterID = "9,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40007] = {id = 40007, jumpType = 0, 
nextNode = {}
, enterID = "14,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40101] = {id = 40101, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40102] = {id = 40102, jumpType = 0, 
nextNode = {}
, enterID = "4,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40103] = {id = 40103, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40111] = {id = 40111, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40112] = {id = 40112, jumpType = 0, 
nextNode = {}
, enterID = "4,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40113] = {id = 40113, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40121] = {id = 40121, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40122] = {id = 40122, jumpType = 0, 
nextNode = {}
, enterID = "4,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40123] = {id = 40123, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40201] = {id = 40201, jumpType = 0, 
nextNode = {}
, enterID = "4,19", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40202] = {id = 40202, jumpType = 0, 
nextNode = {}
, enterID = "3,17", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40203] = {id = 40203, jumpType = 0, 
nextNode = {}
, enterID = "4,20", enterDirection = "4", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40204] = {id = 40204, jumpType = 0, 
nextNode = {}
, enterID = "5,24", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40301] = {id = 40301, jumpType = 0, 
nextNode = {}
, enterID = "3,11", enterDirection = "4", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40302] = {id = 40302, jumpType = 0, 
nextNode = {}
, enterID = "4,25", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40303] = {id = 40303, jumpType = 0, 
nextNode = {}
, enterID = "4,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40304] = {id = 40304, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40311] = {id = 40311, jumpType = 0, 
nextNode = {}
, enterID = "3,11", enterDirection = "4", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40312] = {id = 40312, jumpType = 0, 
nextNode = {}
, enterID = "4,25", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40313] = {id = 40313, jumpType = 0, 
nextNode = {}
, enterID = "4,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40314] = {id = 40314, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40321] = {id = 40321, jumpType = 0, 
nextNode = {}
, enterID = "3,11", enterDirection = "4", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40322] = {id = 40322, jumpType = 0, 
nextNode = {}
, enterID = "4,25", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40323] = {id = 40323, jumpType = 0, 
nextNode = {}
, enterID = "4,22", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[40324] = {id = 40324, jumpType = 0, 
nextNode = {}
, enterID = "4,21", enterDirection = "0", 
exitID = {}
, 
exitSituation = {}
, 
aimSceneID = {}
, 
aimPosition = {}
, 
direction = {}
, 
isShowInMap = {}
}
, 
[60001] = {id = 60001, jumpType = 2, 
nextNode = {}
, enterID = "4,6", enterDirection = "3", 
exitID = {1}
, 
exitSituation = {"8,13,1,1"}
, 
aimSceneID = {60002}
, 
aimPosition = {"3,7"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[60002] = {id = 60002, jumpType = 2, 
nextNode = {}
, enterID = "3,7", enterDirection = "2", 
exitID = {1}
, 
exitSituation = {"12,18,1,1"}
, 
aimSceneID = {60003}
, 
aimPosition = {"4,6"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[60003] = {id = 60003, jumpType = 2, 
nextNode = {}
, enterID = "4,6", enterDirection = "2", 
exitID = {1}
, 
exitSituation = {"8,13,1,1"}
, 
aimSceneID = {60004}
, 
aimPosition = {"3,19"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[60004] = {id = 60004, jumpType = 2, 
nextNode = {}
, enterID = "3,19", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"4,3,1,1"}
, 
aimSceneID = {60005}
, 
aimPosition = {"12,5"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[60005] = {id = 60005, jumpType = 2, 
nextNode = {}
, enterID = "12,5", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"13,1,1,1"}
, 
aimSceneID = {60006}
, 
aimPosition = {"12,2"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[60006] = {id = 60006, jumpType = 2, 
nextNode = {}
, enterID = "12,2", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"13,1,1,1"}
, 
aimSceneID = {30001}
, 
aimPosition = {"0,0"}
, 
direction = {0}
, 
isShowInMap = {0}
}
, 
[60007] = {id = 60007, jumpType = 2, 
nextNode = {}
, enterID = "3,15", enterDirection = "5", 
exitID = {1}
, 
exitSituation = {"14,1,3,1"}
, 
aimSceneID = {60008}
, 
aimPosition = {"3,3"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[60008] = {id = 60008, jumpType = 2, 
nextNode = {}
, enterID = "3,3", enterDirection = "4", 
exitID = {1}
, 
exitSituation = {"15,2,3,1"}
, 
aimSceneID = {60009}
, 
aimPosition = {"3,3"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[60009] = {id = 60009, jumpType = 2, 
nextNode = {}
, enterID = "3,3", enterDirection = "4", 
exitID = {1}
, 
exitSituation = {"14,15,3,1"}
, 
aimSceneID = {60010}
, 
aimPosition = {"4,9"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[60010] = {id = 60010, jumpType = 2, 
nextNode = {}
, enterID = "4,9", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"15,1,3,1"}
, 
aimSceneID = {60011}
, 
aimPosition = {"5,15"}
, 
direction = {0}
, 
isShowInMap = {1}
}
, 
[60011] = {id = 60011, jumpType = 2, 
nextNode = {}
, enterID = "5,15", enterDirection = "0", 
exitID = {1}
, 
exitSituation = {"0,0,1,1"}
, 
aimSceneID = {30001}
, 
aimPosition = {"0,0"}
, 
direction = {0}
, 
isShowInMap = {1}
}
}
cscenejump.AllIds = {10001, 10002, 10003, 10004, 10005, 10007, 10009, 10010, 10011, 10012, 10013, 10014, 10015, 10016, 10017, 10018, 10019, 10020, 10021, 10022, 10023, 10024, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10035, 10036, 10037, 10038, 10039, 10040, 10041, 11000, 11003, 11004, 11005, 12001, 12002, 12003, 12004, 12005, 12006, 12007, 12008, 12009, 12010, 12011, 12012, 12013, 12014, 12015, 12016, 12017, 12018, 12019, 12020, 12021, 12022, 12023, 12024, 12025, 13001, 13002, 13003, 13004, 13005, 13006, 13007, 13008, 13009, 13010, 13011, 13012, 13013, 13014, 13015, 13016, 13017, 13018, 13019, 13020, 13021, 13022, 13023, 13024, 13025, 13026, 13027, 13028, 13029, 13030, 13031, 13032, 13033, 13034, 13035, 13101, 13102, 13103, 13104, 14001, 14002, 14003, 14004, 14005, 14006, 14007, 14008, 14009, 14010, 14011, 14012, 14013, 14014, 14015, 14016, 14017, 14018, 14019, 14020, 14021, 14022, 14023, 14024, 14025, 14026, 14027, 14028, 14029, 14030, 14031, 14032, 14033, 14034, 14035, 14036, 14037, 14038, 15001, 15002, 15003, 15004, 15005, 15006, 15007, 15008, 15009, 15011, 15012, 15013, 15014, 15015, 15016, 15017, 15018, 15019, 15020, 15021, 15022, 15023, 15024, 15025, 15026, 15027, 15028, 15029, 15030, 15031, 15032, 15033, 15034, 15035, 16001, 16002, 16003, 16004, 16005, 16006, 16007, 16008, 16009, 16010, 16011, 16012, 16013, 16014, 16015, 16016, 16017, 16018, 16019, 16020, 16021, 16022, 16023, 16024, 16025, 16026, 16027, 16028, 16029, 16030, 16031, 16032, 16033, 16034, 16035, 20009, 30003, 30006, 30012, 40001, 40002, 40003, 40004, 40005, 40006, 40007, 40101, 40102, 40103, 40111, 40112, 40113, 40121, 40122, 40123, 40201, 40202, 40203, 40204, 40301, 40302, 40303, 40304, 40311, 40312, 40313, 40314, 40321, 40322, 40323, 40324, 60001, 60002, 60003, 60004, 60005, 60006, 60007, 60008, 60009, 60010, 60011}
return cscenejump


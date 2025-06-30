-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/buff/cbuffsummon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cbuffsummon = {}
cbuffsummon.Data = {
[20414] = {id = 20414, summonType = 1, summonId = 90006, bornPoint = "-2", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20478] = {id = 20478, summonType = 1, summonId = 90005, bornPoint = "0", buffDeletedAfterDeathOrNot = "1", birthSkill = "6022401"}
, 
[20577] = {id = 20577, summonType = 1, summonId = 20222, bornPoint = "33", buffDeletedAfterDeathOrNot = "1", birthSkill = "201375"}
, 
[20603] = {id = 20603, summonType = 1, summonId = 90005, bornPoint = "0", buffDeletedAfterDeathOrNot = "1", birthSkill = "6022402"}
, 
[20604] = {id = 20604, summonType = 1, summonId = 90005, bornPoint = "0", buffDeletedAfterDeathOrNot = "1", birthSkill = "6022403"}
, 
[20605] = {id = 20605, summonType = 1, summonId = 90005, bornPoint = "0", buffDeletedAfterDeathOrNot = "1", birthSkill = "6022404"}
, 
[20606] = {id = 20606, summonType = 1, summonId = 90005, bornPoint = "0", buffDeletedAfterDeathOrNot = "1", birthSkill = "6022405"}
, 
[20800] = {id = 20800, summonType = 2, summonId = 90007, bornPoint = "20", buffDeletedAfterDeathOrNot = "1", birthSkill = "201612"}
, 
[20801] = {id = 20801, summonType = 2, summonId = 90007, bornPoint = "24", buffDeletedAfterDeathOrNot = "1", birthSkill = "201612"}
, 
[20802] = {id = 20802, summonType = 2, summonId = 90007, bornPoint = "28", buffDeletedAfterDeathOrNot = "1", birthSkill = "201612"}
, 
[20803] = {id = 20803, summonType = 2, summonId = 90008, bornPoint = "20", buffDeletedAfterDeathOrNot = "1", birthSkill = "201612"}
, 
[20804] = {id = 20804, summonType = 2, summonId = 90008, bornPoint = "24", buffDeletedAfterDeathOrNot = "1", birthSkill = "201612"}
, 
[20805] = {id = 20805, summonType = 2, summonId = 90008, bornPoint = "28", buffDeletedAfterDeathOrNot = "1", birthSkill = "201612"}
, 
[20852] = {id = 20852, summonType = 2, summonId = 90009, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "201488"}
, 
[20867] = {id = 20867, summonType = 2, summonId = 90017, bornPoint = "33", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20869] = {id = 20869, summonType = 2, summonId = 90010, bornPoint = "25", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20870] = {id = 20870, summonType = 2, summonId = 90011, bornPoint = "25", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20871] = {id = 20871, summonType = 2, summonId = 90012, bornPoint = "25", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20882] = {id = 20882, summonType = 1, summonId = 90016, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20890] = {id = 20890, summonType = 2, summonId = 90013, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20891] = {id = 20891, summonType = 2, summonId = 90014, bornPoint = "-4", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20892] = {id = 20892, summonType = 2, summonId = 90013, bornPoint = "+4", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20900] = {id = 20900, summonType = 2, summonId = 20234, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20901] = {id = 20901, summonType = 2, summonId = 20235, bornPoint = "-4", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[20902] = {id = 20902, summonType = 2, summonId = 20236, bornPoint = "-1", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[21097] = {id = 21097, summonType = 1, summonId = 90018, bornPoint = "18", buffDeletedAfterDeathOrNot = "1", birthSkill = "201661"}
, 
[21098] = {id = 21098, summonType = 1, summonId = 90019, bornPoint = "20", buffDeletedAfterDeathOrNot = "1", birthSkill = "201661"}
, 
[21099] = {id = 21099, summonType = 1, summonId = 90020, bornPoint = "20", buffDeletedAfterDeathOrNot = "1", birthSkill = "201661"}
, 
[21212] = {id = 21212, summonType = 2, summonId = 90021, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[21359] = {id = 21359, summonType = 2, summonId = 66066, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[21380] = {id = 21380, summonType = 2, summonId = 66068, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "0"}
, 
[21592] = {id = 21592, summonType = 1, summonId = 90023, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "201858"}
, 
[21623] = {id = 21623, summonType = 1, summonId = 90024, bornPoint = "-8", buffDeletedAfterDeathOrNot = "1", birthSkill = "201859"}
}
cbuffsummon.AllIds = {20414, 20478, 20577, 20603, 20604, 20605, 20606, 20800, 20801, 20802, 20803, 20804, 20805, 20852, 20867, 20869, 20870, 20871, 20882, 20890, 20891, 20892, 20900, 20901, 20902, 21097, 21098, 21099, 21212, 21359, 21380, 21592, 21623}
return cbuffsummon


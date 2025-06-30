-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/ctowerdungeontype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ctowerdungeontype = {}
ctowerdungeontype.Data = {
[1] = {id = 1, name = "事象限界·初", nameTextID = 1900210, recommendStrength = 30, describe = "由时之塔，伊敏瑟伦两种要素浮岛组成的事象限界，可以获得各种装备和材料。", describeTextID = 1900213, sort = 1, level = 17, unlockdescribe = "通关2-13解锁", unlockdescribeTextID = 1900216, image = 11679, star = 1, 
sectionid = {10001, 10002, 10003}
, 
sureDropItems = {35002, 35008, 76003}
, 
mayDropItems = {76002, 76001}
}
, 
[2] = {id = 2, name = "事象限界·刻", nameTextID = 1900211, recommendStrength = 60, describe = "由时之塔，伊敏瑟伦，谢波契卡三种要素浮岛组成的事象限界，可以获得各种装备和材料。", describeTextID = 1900214, sort = 2, level = 33, unlockdescribe = "通关3-10和事象限界·初解锁", unlockdescribeTextID = 1900217, image = 11677, star = 11, 
sectionid = {10004, 10005, 10006}
, 
sureDropItems = {35002, 35008, 76004}
, 
mayDropItems = {76003, 76001}
}
, 
[3] = {id = 3, name = "事象限界·终", nameTextID = 1900212, recommendStrength = 70, describe = "由时之塔，伊敏瑟伦，谢波契卡三种要素浮岛组成的事象限界，可以获得各种装备和材料。", describeTextID = 1900215, sort = 3, level = 41, unlockdescribe = "通关3-18和事象限界·刻解锁", unlockdescribeTextID = 1900218, image = 11678, star = 111, 
sectionid = {10007, 10008, 10009}
, 
sureDropItems = {35002, 35008, 76005}
, 
mayDropItems = {76003, 76001}
}
}
ctowerdungeontype.AllIds = {1, 2, 3}
return ctowerdungeontype


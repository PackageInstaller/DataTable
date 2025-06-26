-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/equip/cequipenchantitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cequipenchantitem = {}
cequipenchantitem.Data = {
[70001] = {id = 70001, sort = 1, show = 1, itemText = 1500063, needMana = 100, Luck = 2}
, 
[70002] = {id = 70002, sort = 2, show = 1, itemText = 1500064, needMana = 200, Luck = 3}
, 
[70003] = {id = 70003, sort = 3, show = 1, itemText = 1500065, needMana = 200, Luck = 4}
, 
[70004] = {id = 70004, sort = 4, show = 0, itemText = 1500082, needMana = 200, Luck = 4}
}
cequipenchantitem.AllIds = {70001, 70002, 70003, 70004}
return cequipenchantitem


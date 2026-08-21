-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/item/ctimelimiteditem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ctimelimiteditem = {}
ctimelimiteditem.Data = {
[31036] = {id = 31036, timeLimit = 10080, days = -1}
, 
[31037] = {id = 31037, timeLimit = 10080, days = -1}
, 
[31038] = {id = 31038, timeLimit = 10080, days = -1}
, 
[31132] = {id = 31132, timeLimit = 1440, days = -1}
, 
[31480] = {id = 31480, timeLimit = -1, days = 7}
}
ctimelimiteditem.AllIds = {31036, 31037, 31038, 31132, 31480}
return ctimelimiteditem


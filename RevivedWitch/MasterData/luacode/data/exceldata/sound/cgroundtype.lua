-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/sound/cgroundtype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cgroundtype = {}
cgroundtype.Data = {
[1] = {id = 1, selector = "floor", groundType = 0}
, 
[2] = {id = 2, selector = "rock", groundType = 1}
, 
[3] = {id = 3, selector = "dirt", groundType = 2}
, 
[4] = {id = 4, selector = "grass", groundType = 3}
, 
[5] = {id = 5, selector = "puddle", groundType = 4}
, 
[6] = {id = 6, selector = "carpet", groundType = 5}
, 
[7] = {id = 7, selector = "snow", groundType = 6}
}
cgroundtype.AllIds = {1, 2, 3, 4, 5, 6, 7}
return cgroundtype


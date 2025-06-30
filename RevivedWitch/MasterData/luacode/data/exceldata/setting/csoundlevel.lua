-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/setting/csoundlevel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local csoundlevel = {}
csoundlevel.Data = {
[1] = {id = 1, category = "BGM", categoryID = "5", 
soundLevel = {"0", "0.3", "0.7", "1"}
}
, 
[2] = {id = 2, category = "SOUND", categoryID = "6", 
soundLevel = {"0", "0.3", "0.7", "1"}
}
, 
[3] = {id = 3, category = "VOICE", categoryID = "7", 
soundLevel = {"0", "0.3", "0.7", "1"}
}
, 
[4] = {id = 4, category = "BattleSounds", categoryID = "65", 
soundLevel = {"0", "0.3", "0.7", "1"}
}
}
csoundlevel.AllIds = {1, 2, 3, 4}
return csoundlevel


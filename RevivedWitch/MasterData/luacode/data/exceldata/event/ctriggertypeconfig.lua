-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/event/ctriggertypeconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ctriggertypeconfig = {}
ctriggertypeconfig.Data = {
[1] = {id = 1, name = "区域触发（定点触发）"}
, 
[2] = {id = 2, name = "区域触发（范围触发）"}
, 
[3] = {id = 3, name = "计时触发"}
, 
[4] = {id = 4, name = "计数触发"}
}
ctriggertypeconfig.AllIds = {1, 2, 3, 4}
return ctriggertypeconfig


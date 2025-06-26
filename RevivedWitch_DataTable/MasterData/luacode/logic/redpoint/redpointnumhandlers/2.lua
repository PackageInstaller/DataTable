-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/redpointnumhandlers/2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(params, childRedPointId)
  -- function num : 0_0 , upvalues : _ENV
  return ((NekoData.DataManager).DM_RedPoint):UpdateRedPointNum(childRedPointId, clone(params))
end

return func


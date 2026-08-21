-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/paramtypehandlers/1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(roleId, params)
  -- function num : 0_0 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
end

return func


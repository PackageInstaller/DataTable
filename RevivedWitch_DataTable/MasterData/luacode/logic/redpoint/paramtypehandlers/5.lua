-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/paramtypehandlers/5.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(favourLv, params)
  -- function num : 0_0 , upvalues : _ENV
  local roleId = params[1]
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  if not role then
    return 
  end
  if role:GetIsLeader() then
    return 
  end
  do return favourLv <= role:GetRelationMaxLevel() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return func


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/redpointnumhandlers/8.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(params, childRedPointId, selfRedPointId)
  -- function num : 0_0 , upvalues : _ENV
  local roleId = params[1]
  local skinID = params[2]
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  if not role then
    return 0
  end
  local showRedDot = role:IsShowSkinRedDotById(skinID)
  if showRedDot then
    return 1
  else
    return 0
  end
end

return func


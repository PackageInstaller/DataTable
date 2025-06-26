-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/redpointnumhandlers/7.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(params, childRedPointId)
  -- function num : 0_0 , upvalues : _ENV
  local roleId = params[1]
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  if not role then
    return 0
  end
  local num = 0
  local fashionList = role:GetSkinIDList()
  for i,v in ipairs(fashionList) do
    num = num + ((NekoData.DataManager).DM_RedPoint):UpdateRedPointNum(childRedPointId, {roleId, v})
  end
  return num
end

return func


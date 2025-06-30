-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/redpointnumhandlers/1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(params, childRedPointId)
  -- function num : 0_0 , upvalues : _ENV
  local roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  local num = 0
  for i,v in ipairs(roleList) do
    num = num + ((NekoData.DataManager).DM_RedPoint):UpdateRedPointNum(childRedPointId, {v:GetId()})
  end
  return num
end

return func


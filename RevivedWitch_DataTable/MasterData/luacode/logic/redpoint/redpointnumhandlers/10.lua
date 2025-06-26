-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/redpointnumhandlers/10.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(params, childRedPointId, selfRedPointId)
  -- function num : 0_0 , upvalues : _ENV
  local roleId = params[1]
  local favourLv = params[2]
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  if not role then
    return 0
  end
  if role:GetIsLeader() then
    return 0
  end
  local curRelationLevel = role:GetRelationLevel()
  if favourLv <= curRelationLevel then
    local giftList = role:GetRelationRewardList()
    for i,v in ipairs(giftList) do
      if v.favourLv == favourLv then
        if not v.received then
          return 1
        else
          return 0
        end
      end
    end
    return 0
  else
    do
      do return 0 end
    end
  end
end

return func


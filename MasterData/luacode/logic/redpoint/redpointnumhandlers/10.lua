local function func(params, childRedPointId, selfRedPointId)
  local roleId = params[1]
  
  local favourLv = params[2]
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return 0
  end
  if role:GetIsLeader() then
    return 0
  end
  local curRelationLevel = role:GetRelationLevel()
  if favourLv <= curRelationLevel then
    local giftList = role:GetRelationRewardList()
    for i, v in ipairs(giftList) do
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
    return 0
  end
end

return func

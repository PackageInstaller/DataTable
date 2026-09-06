local function func(params, childRedPointId)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return 0
  end
  if role:GetIsLeader() then
    return 0
  end
  local num = 0
  local giftList = role:GetRelationRewardList()
  for i, v in ipairs(giftList) do
    num = num + NekoData.DataManager.DM_RedPoint:UpdateRedPointNum(childRedPointId, {
      roleId,
      v.favourLv
    })
  end
  return num
end

return func

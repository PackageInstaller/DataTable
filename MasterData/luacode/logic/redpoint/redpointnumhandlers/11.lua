local function func(params, childRedPointId)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return 0
  end
  local maxBreakLv = role:GetMaxBreakLv()
  local num = 0
  for i = 1, maxBreakLv do
    num = num + NekoData.DataManager.DM_RedPoint:UpdateRedPointNum(childRedPointId, {roleId, i})
  end
  return num
end

return func

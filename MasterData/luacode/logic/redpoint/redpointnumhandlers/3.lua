local function func(params, childRedPointId)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return 0
  end
  local allNodes = role:GetAllSkillNodes()
  local num = 0
  for k, v in pairs(allNodes) do
    num = num + NekoData.DataManager.DM_RedPoint:UpdateRedPointNum(childRedPointId, {roleId, k})
  end
  return num
end

return func

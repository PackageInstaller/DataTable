local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(tonumber(params[1]))
  if not role then
    return false
  end
  local level = role:GetLevel()
  if level == nil then
    return false
  end
  return level >= tonumber(params[2])
end

return func

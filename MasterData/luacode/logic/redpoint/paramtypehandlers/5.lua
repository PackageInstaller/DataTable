local function func(favourLv, params)
  local roleId = params[1]
  
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not role then
    return
  end
  if role:GetIsLeader() then
    return
  end
  return favourLv <= role:GetRelationMaxLevel()
end

return func

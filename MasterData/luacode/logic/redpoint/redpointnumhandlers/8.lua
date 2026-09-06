local function func(params, childRedPointId, selfRedPointId)
  local roleId = params[1]
  
  local skinID = params[2]
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
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

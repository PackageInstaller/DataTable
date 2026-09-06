local function func(conditionInfo)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  
  if userInfo then
    local roleId = userInfo.backgroundRole
    return roleId ~= 0
  end
end

return func

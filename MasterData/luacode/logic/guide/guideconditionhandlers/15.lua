local function func(conditionInfo)
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  
  if userInfo then
    local roleId = userInfo.backgroundRole
    if NekoData.BehaviorManager.BM_Guide:HasFinished(24) and roleId == 0 then
      return true
    end
  end
  NekoData.BehaviorManager.BM_Guide:HasFinished(22)
end

return func

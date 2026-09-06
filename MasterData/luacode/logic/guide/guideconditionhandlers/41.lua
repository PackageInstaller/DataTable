local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local curTeamId = NekoData.BehaviorManager.BM_Team:GetCurrentTeamId()
  if curTeamId then
    local teamsInfo = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
    if teamsInfo and teamsInfo[curTeamId] then
      local currentRoleList = teamsInfo[curTeamId].roles
      if currentRoleList[1] then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(currentRoleList[1])
        if role then
          local weapon = role:GetWeapon()
          return weapon and weapon ~= 0
        end
      end
    end
  end
  return false
end

return func

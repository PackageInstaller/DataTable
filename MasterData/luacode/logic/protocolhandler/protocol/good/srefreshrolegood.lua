local function p1(protocol)
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(protocol.roleId)
  
  NekoData.DataManager.DM_AllRoles:OnSRefreshRoleGood(protocol)
  if role then
    local data = {}
    data.id = protocol.roleId
    data.canDrawAward = role:IsShowRelationRedDot()
    NekoData.DataManager.DM_HandBook:OnSRefreshRoleFavorAwardStatus(data)
    LuaNotificationCenter.PostNotification(Common.n_RefreshRoleFavorAwardStatus, nil, data)
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshRoleGood, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRefreshPower(protocol.role)
  
  for k, v in pairs(protocol.role) do
    local userInfo = {}
    userInfo.key = k
    userInfo.name = "schangepower"
    LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, nil, userInfo)
  end
  NekoData.DataManager.DM_Team:OnSRefreshPower(protocol.lineup)
end

local function p2(protocol, client)
end

return {p1, p2}

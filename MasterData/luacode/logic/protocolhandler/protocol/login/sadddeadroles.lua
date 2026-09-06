local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSAddDeadRoles(protocol)
  
  local userInfo = {}
  userInfo.name = "sadddeadroles"
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}

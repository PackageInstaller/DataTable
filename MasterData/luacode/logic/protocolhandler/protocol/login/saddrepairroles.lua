local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSAddRepairRoles(protocol)
  
  local userInfo = {}
  userInfo.name = "saddrepairroles"
  userInfo.data = protocol.roles
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, DM_AllRoles, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}

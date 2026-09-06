local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleUpdateProperties(protocol)
  
  local userInfo = {}
  userInfo.name = "sroleupdateproperties"
  userInfo.key = protocol.roleId
  userInfo.properties = protocol.properties
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, nil, userInfo)
  LuaNotificationCenter.PostNotification(Common.n_UpdateProperties, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

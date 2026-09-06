local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSRoleLock(protocol)
  
  local userInfo = {}
  userInfo.name = "srolelock"
  userInfo.key = protocol.roleId
  userInfo.lock = protocol.lock
  LuaNotificationCenter.PostNotification(Common.n_RoleLocked, nil, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}

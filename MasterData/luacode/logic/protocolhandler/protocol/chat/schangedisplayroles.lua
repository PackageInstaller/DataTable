local function p1(protocol)
  NekoData.DataManager.DM_Friends:OnSChangeDisplayRoles(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_DisplayRolesChanged, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

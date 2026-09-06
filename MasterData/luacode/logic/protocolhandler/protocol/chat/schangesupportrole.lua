local function p1(protocol)
  NekoData.DataManager.DM_Friends:OnSChangeSupportRole(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SupportRoleChanged, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

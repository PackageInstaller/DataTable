local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnSLightPartyRedpoint(protocol.redpointType)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSLightPartyRedpoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

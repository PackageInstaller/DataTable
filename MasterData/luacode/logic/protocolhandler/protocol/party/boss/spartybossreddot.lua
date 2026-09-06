local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnPartyBossRedProcess(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_ClientSetGuildRedpoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

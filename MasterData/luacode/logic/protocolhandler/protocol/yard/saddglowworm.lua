local function p1(protocol)
  NekoData.DataManager.DM_Firefly:OnSAddGlowworm(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_CollectorFireflyNumChanged, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

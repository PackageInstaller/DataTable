local function p1(protocol)
  NekoData.DataManager.DM_Firefly:OnSCollectLightSpot(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_LightRemove, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

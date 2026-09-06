local function p1(protocol)
  NekoData.DataManager.DM_Firefly:OnSRandomLightSpot(protocol)
  
  if protocol.light.key ~= -1 then
    LuaNotificationCenter.PostNotification(Common.n_LightAdd, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  NekoData.DataManager.DM_Currency:OnSResSpirit(protocol)
  
  NekoData.DataManager.DM_Game:OnSResSpirit(protocol)
  local userInfo = {}
  userInfo.spirit = protocol.spirit
  userInfo.spiritFullTime = protocol.spiritFullTime
  LuaNotificationCenter.PostNotification(Common.n_RefreshSpirit, nil, userInfo)
  LuaNotificationCenter.PostNotification(Common.n_StrengthLimitChanged, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

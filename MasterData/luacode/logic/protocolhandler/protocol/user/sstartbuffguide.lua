local function p1(protocol)
  NekoData.DataManager.DM_Game:SStartBuffGuide(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TriggerBuffGuide, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

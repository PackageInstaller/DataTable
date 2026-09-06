local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSRune(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_ReceiveResonanceResult, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

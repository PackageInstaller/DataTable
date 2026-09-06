local function p1(protocol)
  NekoData.DataManager.DM_BagInfo:OnSDecomposeEquips(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_DecomposeEquips, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

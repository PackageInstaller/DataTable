local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnSReceiveDonateAward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SReceiveDonateAward, {}, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

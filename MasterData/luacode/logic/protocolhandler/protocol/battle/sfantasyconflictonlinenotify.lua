local function p1(protocol)
  NekoData.DataManager.DM_Battle:SetSeasonNotify(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SeasonPvpAward, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

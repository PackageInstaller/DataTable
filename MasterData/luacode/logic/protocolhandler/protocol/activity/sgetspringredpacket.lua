local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):SGetSpringRedPacket(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SGetSpringRedPacket, nil, nil)
  LuaNotificationCenter.PostNotification(Common.n_RefreshSpringFestivalRedDot)
end

local function p2(protocol, client)
end

return {p1, p2}

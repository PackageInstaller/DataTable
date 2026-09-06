local function p1(protocol)
  NekoData.DataManager.DM_Friends:OnSNotifyFriendsPoint(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_NotifyFriendsPoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

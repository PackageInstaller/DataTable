local function p1(protocol)
  NekoData.DataManager.DM_Friends:OnSAllFriends(protocol)
  
  NekoData.DataManager.DM_FriendsChat:OnSAllFriendsChat(protocol)
  NekoData.DataManager.DM_Friends:CheckFriendPageRedData()
  LuaNotificationCenter.PostNotification(Common.n_FriendsDataChange, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

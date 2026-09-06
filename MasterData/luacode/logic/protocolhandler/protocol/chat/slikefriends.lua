local function p1(protocol)
  NekoData.DataManager.DM_Friends:OnSLikeFriends(protocol)
  
  local userInfo = {}
  userInfo.userId = protocol.userId
  LuaNotificationCenter.PostNotification(Common.n_FriendsLike, nil, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}

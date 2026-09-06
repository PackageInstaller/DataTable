local function p1(protocol)
  NekoData.DataManager.DM_Friends:RefreshRecommendFriends(protocol)
  
  local userinfo = {}
  userinfo.tag = "Recommend"
  userinfo.users = protocol.users
  LuaNotificationCenter.PostNotification(Common.n_ReceiveRecommendFriends, nil, userinfo)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  local userinfo = {}
  
  userinfo.tag = "Search"
  userinfo.users = {
    protocol.users
  }
  LuaNotificationCenter.PostNotification(Common.n_ReceiveRecommendFriends, nil, userinfo)
end

local function p2(protocol, client)
end

return {p1, p2}

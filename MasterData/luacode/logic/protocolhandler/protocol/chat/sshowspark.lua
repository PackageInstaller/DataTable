local function p1(protocol)
  local userInfo = {}
  
  userInfo.userId = protocol.userId
  LuaNotificationCenter.PostNotification(Common.n_FriendsShowPark, nil, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}

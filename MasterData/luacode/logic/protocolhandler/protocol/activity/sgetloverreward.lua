local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SGetLoverReward, nil, protocol.progressReward)
end

local function p2(protocol, client)
end

return {p1, p2}

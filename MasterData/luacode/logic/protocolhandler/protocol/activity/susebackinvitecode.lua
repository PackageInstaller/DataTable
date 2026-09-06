local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_ReturnPlayerEnterInviteCodeResult, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_SummerActivityCancelBlockSelect, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

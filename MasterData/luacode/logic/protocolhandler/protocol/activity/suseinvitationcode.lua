local function p1(protocol)
  if protocol.result == 1 then
    NekoData.DataManager.DM_Activity:CleanActivityById(8)
    
    LuaNotificationCenter.PostNotification(Common.n_RefreshUseInvite, nil, protocol)
    LuaNotificationCenter.PostNotification(Common.n_RefreshActivities, nil)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

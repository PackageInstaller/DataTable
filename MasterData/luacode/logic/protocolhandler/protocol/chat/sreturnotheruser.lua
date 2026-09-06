local function p1(protocol)
  if NekoData.DataManager.DM_Friends:RemoveRecommendFriend(protocol.userId) then
    LuaNotificationCenter.PostNotification(Common.n_RemoveRecommendFriend, nil, protocol.userId)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

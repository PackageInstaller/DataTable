local function p1(protocol)
  if protocol.userId == NekoData.BehaviorManager.BM_Game:GetUserId() then
    NekoData.DataManager.DM_Guild:OnSNotifyPosition(protocol.position)
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSNotifyPosition, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

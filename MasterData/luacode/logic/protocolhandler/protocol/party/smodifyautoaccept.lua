local function p1(protocol)
  if protocol.partyId == NekoData.BehaviorManager.BM_Guild:GetGuildID() then
    NekoData.DataManager.DM_Guild:OnSModifyAutoAccept(protocol)
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSModifyAutoAccept, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

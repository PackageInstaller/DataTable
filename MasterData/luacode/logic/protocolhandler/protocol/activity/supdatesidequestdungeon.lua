local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSUpdateSideQuestDungeon(protocol.dungeons)
  
  LuaNotificationCenter.PostNotification(Common.n_ReceiveBranchLineData, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

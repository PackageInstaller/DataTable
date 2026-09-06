local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSOpenSideQuestPanel(protocol.dungeons)
  
  if table.nums(protocol.dungeons) > 0 then
    LuaNotificationCenter.PostNotification(Common.n_ReceiveBranchLineData, nil, nil)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

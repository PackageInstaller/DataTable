local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  dm:OnSRefreshMazeBlock(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSRefreshMazeBlock, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

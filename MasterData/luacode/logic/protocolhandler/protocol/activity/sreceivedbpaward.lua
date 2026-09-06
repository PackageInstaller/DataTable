local function p1(protocol)
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  dm:OnSReceivedBpAward(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSReceivedBpAward, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

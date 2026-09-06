local function p1(protocol)
  if PrintTable then
    PrintTable(protocol, 3, "sopenbppuzzle")
  end
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  dm:OnSOpenBpPuzzle(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSOpenBpPuzzle, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

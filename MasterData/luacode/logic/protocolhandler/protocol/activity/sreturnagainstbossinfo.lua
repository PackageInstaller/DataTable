local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):OnSReturnAgainstBossInfo(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_SReturnAgainstBossInfo, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

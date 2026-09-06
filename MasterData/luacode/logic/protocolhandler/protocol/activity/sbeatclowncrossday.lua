local function p1(protocol)
  NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID):ClearBeatClownNumber()
  
  LuaNotificationCenter.PostNotification(Common.n_SBeatClownCrossDay, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

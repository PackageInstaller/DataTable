local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):OnSOpenChallengeMode(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSOpenChallengeMode, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

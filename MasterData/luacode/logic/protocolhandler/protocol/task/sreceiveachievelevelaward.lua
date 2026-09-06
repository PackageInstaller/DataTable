local function p1(protocol)
  NekoData.DataManager.DM_Task:OnSReceiveAchieveLevelAward(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshAchievementLevelAward, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

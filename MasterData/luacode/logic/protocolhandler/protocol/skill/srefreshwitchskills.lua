local function p1(protocol)
  LogInfo("srefreshwitchskills", "receive")
  
  NekoData.DataManager.DM_AllRoles:OnSRefreshWitchSkills(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshWitchSkills, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

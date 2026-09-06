local function p1(protocol)
  NekoData.DataManager.DM_Team:OnSChangeLineUpName(protocol)
  
  local userInfo = {}
  userInfo.name = "schangelineupname"
  LuaNotificationCenter.PostNotification(Common.n_TeamInfoChange, DM_Team, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}

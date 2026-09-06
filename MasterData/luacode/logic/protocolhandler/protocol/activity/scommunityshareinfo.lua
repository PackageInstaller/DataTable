local function p1(protocol)
  NekoData.DataManager.DM_Welfare:OnCommunityShareInfo(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_CommunityWelfareRedPoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

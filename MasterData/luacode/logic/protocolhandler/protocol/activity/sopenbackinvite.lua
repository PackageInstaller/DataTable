local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OpenInviteReturnPlayer, nil, protocol)
  
  NekoData.DataManager.DM_ReturnWelfare:OnSOpenBackInvite(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

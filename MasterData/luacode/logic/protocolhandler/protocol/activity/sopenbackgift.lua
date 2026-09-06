local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OpenReturnEnterCDKey, nil, protocol)
  
  NekoData.DataManager.DM_ReturnWelfare:OnSOpenBackGift(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

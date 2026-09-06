local function p1(protocol)
  NekoData.DataManager.DM_Anniversary:OnSOpenAnniversaryDraw(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSOpenAnniversaryDraw, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  NekoData.DataManager.DM_Shop:OnSFreeLevelGiftIcon()
  
  LuaNotificationCenter.PostNotification(Common.n_SFreeLevelGiftIcon, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  NekoData.DataManager.DM_SkinList:OnSRefreshSkinCollectTask(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshSkinCollectAwardStatus, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

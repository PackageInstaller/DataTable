local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.DoubleElevenActivityID):OnSOpenDoubleElevenCard(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_OnSOpenDoubleElevenCard, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):OnSLittleBattlePass(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_NewDreamSpiralRefresh, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

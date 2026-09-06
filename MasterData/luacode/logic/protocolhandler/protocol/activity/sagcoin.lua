local function p1(protocol)
  LogInfoFormat("SAgCoin", "actId = %s, deadline = %s, highUnlocked = %s, refreshDailyTime = %s, chargeMoneyType = %s, chargePrice = %s, levelPrice = %s, level = %s, chipNum = %s, needChipNum = %s, canReceiveMaxAward = %s, leftTime = %s, maxTaskNum = %s", protocol.actId, protocol.deadline, protocol.highUnlocked, protocol.refreshDailyTime, protocol.chargeMoneyType, protocol.chargePrice, protocol.levelPrice, protocol.level, protocol.chipNum, protocol.needChipNum, protocol.canReceiveMaxAward, protocol.leftTime, protocol.maxTaskNum)
  
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.AgCoinActivityID):OnSAgCoinInfo(protocol)
  LuaNotificationCenter.PostNotification(Common.n_DreamSpiralRefresh, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

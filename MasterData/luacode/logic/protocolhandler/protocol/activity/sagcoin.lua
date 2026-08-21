-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sagcoin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("SAgCoin", "actId = %s, deadline = %s, highUnlocked = %s, refreshDailyTime = %s, chargeMoneyType = %s, chargePrice = %s, levelPrice = %s, level = %s, chipNum = %s, needChipNum = %s, canReceiveMaxAward = %s, leftTime = %s, maxTaskNum = %s", protocol.actId, protocol.deadline, protocol.highUnlocked, protocol.refreshDailyTime, protocol.chargeMoneyType, protocol.chargePrice, protocol.levelPrice, protocol.level, protocol.chipNum, protocol.needChipNum, protocol.canReceiveMaxAward, protocol.leftTime, protocol.maxTaskNum)
  ;
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.AgCoinActivityID)):OnSAgCoinInfo(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_DreamSpiralRefresh, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sminidiscountactivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Welfare):OnMinDiscountInfo(protocol)
  LogInfoFormat("sminidiscountactivityinfo", "activityId %s leftTime %s", (DataCommon.Activities).MinDiscount, protocol.leftTime)
  ;
  ((NekoData.DataManager).DM_Activity):OnSRefreshActTime({activityId = (DataCommon.Activities).MinDiscount, leftTime = protocol.leftTime})
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_OnRefreshMinDiscount, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


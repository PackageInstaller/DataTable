-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/srefreshacttime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("srefreshacttime", "activityId %s leftTime %s", protocol.activityId, protocol.leftTime)
  ;
  ((NekoData.DataManager).DM_Activity):OnSRefreshActTime(protocol)
  if protocol.activityId == (((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnWelfareSignAwardActivityId and protocol.leftTime <= 0 then
    LogInfoFormat("srefreshacttime", "-- actId = %s ---", protocol.activityId)
    ;
    (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SignManagerID)):OnSSignCrossDay(protocol.activityId)
    ;
    ((NekoData.DataManager).DM_Activity):OnActivityStop(protocol.activityId)
    ;
    ((NekoData.BehaviorManager).BM_Activity):OnSSignCrossDay(protocol.activityId)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshSignActivity, nil, protocol.activityId)
  else
    if protocol.activityId == (DataCommon.Activities).AccumulateCost then
      (LuaNotificationCenter.PostNotification)(Common.n_RefreshAccumulateCost, nil, nil)
    else
      if protocol.activityId == (DataCommon.Activities).OldPlayerBenefits then
        (LuaNotificationCenter.PostNotification)(Common.n_OnRefreshOldPlayerBenefits, nil, nil)
      else
        if protocol.activityId == (((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnBattlePass then
          if protocol.leftTime <= 0 then
            ((NekoData.DataManager).DM_ReturnWelfare):OnSReturnPass(nil)
          end
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_RefreshReturnBattlePass, nil, protocol.activityId)
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


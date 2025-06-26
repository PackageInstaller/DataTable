-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/ssigncrossday.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("ssigncrossday", "-- actId = %s ---", protocol.activityId)
  ;
  (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SignManagerID)):OnSSignCrossDay(protocol.activityId)
  ;
  ((NekoData.DataManager).DM_Activity):OnActivityStop(protocol.activityId)
  ;
  ((NekoData.BehaviorManager).BM_Activity):OnSSignCrossDay(protocol.activityId)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshSignActivity, nil, protocol.activityId)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


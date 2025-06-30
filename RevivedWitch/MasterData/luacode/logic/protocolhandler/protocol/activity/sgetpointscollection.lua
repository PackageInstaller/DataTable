-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sgetpointscollection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("SGetPointsCollection", "--- activityId = %s ---", protocol.activityID)
  if protocol.activityID == (DataCommon.Activities).StarMirage then
    (((NekoData.DataManager).DM_Activity):GetManager(DataCommon.StarMirageManagerID)):OnSGetPointsCollection(protocol)
  else
    ;
    ((NekoData.DataManager).DM_Activity):OnSGetPointsCollection(protocol)
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshActivityRewards, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


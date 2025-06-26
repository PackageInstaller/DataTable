-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/sstoptrain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local lastTrainTaskInfo = ((NekoData.BehaviorManager).BM_TrainCamp):GetTrainTaskInfo(protocol.index)
  if lastTrainTaskInfo then
    ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = lastTrainTaskInfo.roleId, buildingId = nil})
  end
  ;
  ((NekoData.DataManager).DM_TrainCamp):OnSSTopTrain(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StopTrainTask, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


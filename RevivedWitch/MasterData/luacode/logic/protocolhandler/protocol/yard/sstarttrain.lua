-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/sstarttrain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = (protocol.train).roleId, buildingId = DataCommon.TrainCamp})
  if (protocol.train).roleId ~= DataCommon.LeaderId then
    ((NekoData.BehaviorManager).BM_Voice):Play((protocol.train).roleId, (((NekoData.BehaviorManager).BM_Voice).VoiceType).Dispatch, nil)
  end
  ;
  ((NekoData.DataManager).DM_TrainCamp):OnSStartTrain(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_StartTrainTask, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


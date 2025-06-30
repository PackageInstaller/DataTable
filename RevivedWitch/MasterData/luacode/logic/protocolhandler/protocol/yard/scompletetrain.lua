-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/scompletetrain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local trainTaskInfo = ((NekoData.BehaviorManager).BM_TrainCamp):GetTrainTaskInfo(protocol.index)
  local roleId = trainTaskInfo.roleId
  ;
  ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = roleId, buildingId = nil})
  ;
  ((NekoData.DataManager).DM_TrainCamp):OnSCompleteTrain(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_CompleteTrainTask, nil, protocol)
  ;
  ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).TrainAccount, 
data = {protocol = protocol, roleId = roleId}
})
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/srefreshtrainroom.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local roleList = ((NekoData.BehaviorManager).BM_TrainCamp):GetDispatchRoles(true)
  for _,v in ipairs(roleList) do
    ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v, buildingId = nil})
  end
  for i,v in ipairs((protocol.room).trainList) do
    if v.roleId ~= 0 then
      ((NekoData.DataManager).DM_AllRoles):OnRefreshBuildingId({roleKey = v.roleId, buildingId = DataCommon.TrainCamp})
    end
  end
  local level = ((NekoData.BehaviorManager).BM_TrainCamp):GetLevel()
  if level == 0 and (protocol.room).level == 1 then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingUnlock, nil, {buildingId = DataCommon.TrainCamp})
  end
  ;
  ((NekoData.DataManager).DM_TrainCamp):OnSRefreshTrainRoom(protocol)
  if level < (protocol.room).level then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingLevelUp, nil, {buildingId = DataCommon.TrainCamp})
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshTrainCamp, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


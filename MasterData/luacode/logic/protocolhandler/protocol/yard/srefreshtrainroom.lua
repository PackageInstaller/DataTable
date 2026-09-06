local function p1(protocol)
  local roleList = NekoData.BehaviorManager.BM_TrainCamp:GetDispatchRoles(true)
  
  for _, v in ipairs(roleList) do
    NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({roleKey = v, buildingId = nil})
  end
  for i, v in ipairs(protocol.room.trainList) do
    if v.roleId ~= 0 then
      NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
        roleKey = v.roleId,
        buildingId = DataCommon.TrainCamp
      })
    end
  end
  local level = NekoData.BehaviorManager.BM_TrainCamp:GetLevel()
  if level == 0 and protocol.room.level == 1 then
    LuaNotificationCenter.PostNotification(Common.n_BuildingUnlock, nil, {
      buildingId = DataCommon.TrainCamp
    })
  end
  NekoData.DataManager.DM_TrainCamp:OnSRefreshTrainRoom(protocol)
  if level < protocol.room.level then
    LuaNotificationCenter.PostNotification(Common.n_BuildingLevelUp, nil, {
      buildingId = DataCommon.TrainCamp
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshTrainCamp, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

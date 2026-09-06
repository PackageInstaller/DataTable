local function p1(protocol)
  local lastTrainTaskInfo = NekoData.BehaviorManager.BM_TrainCamp:GetTrainTaskInfo(protocol.index)
  
  if lastTrainTaskInfo then
    NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
      roleKey = lastTrainTaskInfo.roleId,
      buildingId = nil
    })
  end
  NekoData.DataManager.DM_TrainCamp:OnSSTopTrain(protocol)
  LuaNotificationCenter.PostNotification(Common.n_StopTrainTask, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

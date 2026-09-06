local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
    roleKey = protocol.train.roleId,
    
    buildingId = DataCommon.TrainCamp
  })
  if protocol.train.roleId ~= DataCommon.LeaderId then
    NekoData.BehaviorManager.BM_Voice:Play(protocol.train.roleId, NekoData.BehaviorManager.BM_Voice.VoiceType.Dispatch, nil)
  end
  NekoData.DataManager.DM_TrainCamp:OnSStartTrain(protocol)
  LuaNotificationCenter.PostNotification(Common.n_StartTrainTask, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

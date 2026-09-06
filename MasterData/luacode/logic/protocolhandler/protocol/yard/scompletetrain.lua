local function p1(protocol)
  local trainTaskInfo = NekoData.BehaviorManager.BM_TrainCamp:GetTrainTaskInfo(protocol.index)
  
  local roleId = trainTaskInfo.roleId
  NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({roleKey = roleId, buildingId = nil})
  NekoData.DataManager.DM_TrainCamp:OnSCompleteTrain(protocol)
  LuaNotificationCenter.PostNotification(Common.n_CompleteTrainTask, nil, protocol)
  NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
    tag = DataCommon.ShowDialogType.TrainAccount,
    data = {protocol = protocol, roleId = roleId}
  })
end

local function p2(protocol, client)
end

return {p1, p2}

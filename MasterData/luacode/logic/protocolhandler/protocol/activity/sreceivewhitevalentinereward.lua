local function p1(protocol)
  LogInfoFormat("sreceivewhitevalentinereward", "id = %s", protocol.id)
  
  local data = NekoData.BehaviorManager.BM_Activity:GetWhiteValentine()
  if data and data.id == protocol.id then
    NekoData.DataManager.DM_Activity:OnSReceiveWhiteValentineReward(protocol)
    DialogManager.DestroySingletonDialog("activity.whitevalentine.whitevalentinemaindialog")
  elseif data then
    LogErrorFormat("sreceivewhitevalentinereward", "data is not match! id1: %s, id2: %s.", data.id, protocol.id)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

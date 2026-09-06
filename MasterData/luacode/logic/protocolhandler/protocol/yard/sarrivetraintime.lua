local function p1(protocol)
  NekoData.DataManager.DM_TrainCamp:OnSArriveTrainTime(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_RefreshTrainTask, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

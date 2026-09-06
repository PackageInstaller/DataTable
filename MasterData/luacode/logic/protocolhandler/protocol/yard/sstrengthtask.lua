local function p1(protocol)
  NekoData.DataManager.DM_Firefly:OnSStrengthTask(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_CollectorCapacityLvUp, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

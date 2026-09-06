local function p1(protocol)
  NekoData.DataManager.DM_Guide:OnSRecordProcedure(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}

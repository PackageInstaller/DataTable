local function p1(protocol)
  NekoData.DataManager.DM_Tower:OnSTouchIslandEvent(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TowerEventResponse, {}, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

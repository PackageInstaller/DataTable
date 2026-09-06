local function p1(protocol)
  local level = NekoData.BehaviorManager.BM_Firefly:GetLevel()
  
  if level == 0 and protocol.lampStand.level == 1 then
    LuaNotificationCenter.PostNotification(Common.n_BuildingUnlock, nil, {
      buildingId = DataCommon.Firefly
    })
  end
  NekoData.DataManager.DM_Currency:OnSRefreshLampStand(protocol)
  NekoData.DataManager.DM_Firefly:OnSRefreshLampStand(protocol)
  if level < protocol.lampStand.level then
    LuaNotificationCenter.PostNotification(Common.n_BuildingLevelUp, nil, {
      buildingId = DataCommon.Firefly
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshFirefly, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

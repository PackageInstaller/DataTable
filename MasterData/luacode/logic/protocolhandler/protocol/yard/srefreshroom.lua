local function p1(protocol)
  for k, v in pairs(NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()) do
    for i, v in ipairs(v.roles) do
      NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({roleKey = v, buildingId = nil})
    end
  end
  for k, v in pairs(protocol.room.floors) do
    for roleKey, leftRecoveryTime in pairs(v.rolesLeftRecoveryTime) do
      NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
        roleKey = roleKey,
        buildingId = DataCommon.Cabin
      })
    end
  end
  local level = NekoData.BehaviorManager.BM_Cabin:GetLevel()
  if level == 0 and protocol.room.level == 1 then
    LuaNotificationCenter.PostNotification(Common.n_BuildingUnlock, nil, {
      buildingId = DataCommon.Cabin
    })
  end
  NekoData.DataManager.DM_Cabin:OnSRefreshRoom(protocol)
  if level < protocol.room.level then
    LuaNotificationCenter.PostNotification(Common.n_BuildingLevelUp, nil, {
      buildingId = DataCommon.Cabin
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshCabin, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

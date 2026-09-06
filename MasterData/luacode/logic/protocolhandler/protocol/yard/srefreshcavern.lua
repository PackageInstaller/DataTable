local SlotStateEnum = LuaNetManager.GetBeanDef("protocol.yard.caverntask")

local function p1(protocol)
  local level = NekoData.BehaviorManager.BM_Explore:GetLevel()
  if level == 0 and protocol.cavern.level == 1 then
    LuaNotificationCenter.PostNotification(Common.n_BuildingUnlock, nil, {
      buildingId = DataCommon.Explore
    })
  end
  local roles = NekoData.BehaviorManager.BM_Explore:GetRoles()
  for k, v in pairs(roles) do
    NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({roleKey = k, buildingId = nil})
  end
  NekoData.DataManager.DM_Explore:OnSRefreshCavern(protocol)
  for k, v in pairs(protocol.cavern.tasks) do
    for i, roleInfo in ipairs(v.roles) do
      NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
        roleKey = roleInfo.roleId,
        buildingId = DataCommon.Explore
      })
    end
  end
  if level < protocol.cavern.level then
    LuaNotificationCenter.PostNotification(Common.n_BuildingLevelUp, nil, {
      buildingId = DataCommon.Explore
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshAllExploreSlots, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

local SlotStateEnum = LuaNetManager.GetBeanDef("protocol.yard.caverntask")

local function p1(protocol)
  local slot = NekoData.BehaviorManager.BM_Explore:GetSlotInfoBySlotId(protocol.cavernTask.Id)
  if slot then
    for i, v in ipairs(slot.roles) do
      NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({roleKey = v, buildingId = nil})
    end
  end
  NekoData.DataManager.DM_Explore:OnSRefreshCavernTaskActive(protocol)
  for i, v in ipairs(protocol.cavernTask.roles) do
    NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
      roleKey = v.roleId,
      buildingId = DataCommon.Explore
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshTimesChanged, nil, protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshExploreSlotActive, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

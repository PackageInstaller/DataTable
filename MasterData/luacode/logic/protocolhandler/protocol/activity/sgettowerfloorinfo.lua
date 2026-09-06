local function p1(protocol)
  local auto_changed = protocol.autoExploreState == 1 ~= NekoData.BehaviorManager.BM_TowerV2:IsInAutoExplore()
  
  NekoData.DataManager.DM_TowerV2:OnSGetTowerFloorInfo(protocol)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if not controller then
    GlobalGameFSM:SetNumber("sceneLoadingId", 30014)
  end
  if auto_changed then
    LuaNotificationCenter.PostNotification(Common.n_TowerV2AutoExplore, nil, protocol)
  end
  if protocol.autoExploreState == 1 then
    NekoData.DataManager.DM_Dungeon:SetMode("auto")
  end
  LuaNotificationCenter.PostNotification(Common.n_TowerV2Refresh, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

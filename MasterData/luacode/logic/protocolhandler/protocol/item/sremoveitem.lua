local function p1(protocol)
  NekoData.DataManager.DM_BagInfo:OnSRemoveItem(protocol)
  
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    NekoData.DataManager.DM_Dungeon:OnSRemoveItem(protocol)
  end
  if NekoData.DataManager.DM_AllRoles:CheckShowRoleEvolutionRed(protocol) then
    NekoData.BehaviorManager.BM_AllRoles:PostRoleEvolutionRedDataNotification()
  end
  LuaNotificationCenter.PostNotification(Common.n_ItemRemove, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

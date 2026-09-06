local function p1(protocol)
  NekoData.DataManager.DM_BagInfo:OnSAddItem(protocol)
  
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    NekoData.DataManager.DM_Dungeon:OnSAddItem(protocol)
  end
  if NekoData.DataManager.DM_AllRoles:CheckShowRoleEvolutionRed(protocol) then
    NekoData.BehaviorManager.BM_AllRoles:PostRoleEvolutionRedDataNotification()
  end
  LuaNotificationCenter.PostNotification(Common.n_ItemAdd, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

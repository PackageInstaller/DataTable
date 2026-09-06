local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSChangeEquipment(protocol)
  
  NekoData.DataManager.DM_BagInfo:OnSChangeEquipment(protocol)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    NekoData.DataManager.DM_Dungeon:OnSChangeEquipment(protocol)
  end
  local userInfo = {}
  userInfo.name = "schangeequipment"
  userInfo.data = protocol
  LuaNotificationCenter.PostNotification(Common.n_RoleInfoChange, nil, userInfo)
  LuaNotificationCenter.PostNotification(Common.n_EquipChanged, nil, userInfo)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(protocol.floor.id)
  
  if roomInfo then
    for i, v in ipairs(roomInfo.roles) do
      NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({roleKey = v, buildingId = nil})
    end
  end
  for roleKey, leftRecoveryTime in pairs(protocol.floor.rolesLeftRecoveryTime) do
    NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
      roleKey = roleKey,
      buildingId = DataCommon.Cabin
    })
  end
  NekoData.DataManager.DM_Cabin:OnSPlaceFurniture(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshRoomFurnitures, nil, protocol)
  local dialog = DialogManager.GetDialog("courtcabin.dressupcabindialog")
  if dialog and dialog._willBack then
    LuaNotificationCenter.PostNotification(Common.n_ExitDressUpMode, dialog, nil)
    dialog:PlayExitAnimation()
  else
    DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  end
end

local function p2(protocol, client)
end

return {p1, p2}

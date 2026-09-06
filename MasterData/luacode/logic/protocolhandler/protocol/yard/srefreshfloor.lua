local function p1(protocol)
  local tag = false
  
  local rolesMap = {}
  local rolesNum = 0
  local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(protocol.floor.id)
  if roomInfo then
    for i, v in ipairs(roomInfo.roles) do
      NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({roleKey = v, buildingId = nil})
      rolesMap[v] = true
      rolesNum = rolesNum + 1
    end
  end
  local curRolesNum = 0
  local randomNewRoleKey
  for roleKey, leftRecoveryTime in pairs(protocol.floor.rolesLeftRecoveryTime) do
    NekoData.DataManager.DM_AllRoles:OnRefreshBuildingId({
      roleKey = roleKey,
      buildingId = DataCommon.Cabin
    })
    curRolesNum = curRolesNum + 1
    if not rolesMap[roleKey] then
      tag = true
      if not randomNewRoleKey and roleKey ~= DataCommon.LeaderId then
        randomNewRoleKey = roleKey
      end
    end
  end
  local dialog = DialogManager.GetDialog("magictree.chooseroledialog")
  if dialog and dialog._buildingId == DataCommon.Cabin and dialog._slotId and dialog._slotId == protocol.floor.id and (curRolesNum ~= rolesNum or tag) then
    dialog:Destroy()
    if randomNewRoleKey then
      NekoData.BehaviorManager.BM_Voice:Play(randomNewRoleKey, NekoData.BehaviorManager.BM_Voice.VoiceType.Dispatch, nil)
    end
  end
  NekoData.DataManager.DM_Cabin:OnSRefreshFloor(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshRoom, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}

local function p1(protocol)
  local changed = 0
  
  if protocol.EventID ~= -1 and protocol.EventID ~= 0 then
    for roleid, hp in pairs(protocol.rolesState) do
      if hp ~= 0 then
        local prev = NekoData.BehaviorManager.BM_TowerV2:GetRoleHP(roleid) or 1
        prev = math.ceil(prev * 100)
        local r = 0
        if hp < prev then
          r = -1
        elseif hp > prev then
          r = 1
        end
        if changed ~= 0 and r ~= changed and hp ~= prev then
          LogError("towerv2", "hp inconsist after event")
        end
        changed = r
      end
    end
  end
  local userInfo = {protocol = protocol, hpchange = changed}
  NekoData.DataManager.DM_TowerV2:OnSChoosePointEvent(protocol)
  if #protocol.items ~= 0 then
    local dialog = DialogManager.CreateSingletonDialog("bag.itemaccountdialog")
    dialog:LoadData({
      items = protocol.items
    })
    local scenedlg = DialogManager.GetDialog("towerv2.scene.towerv2scenedialog")
    if scenedlg then
      scenedlg:TryAutoCloseAccount()
    end
    LuaNotificationCenter.AddObserver(protocol, function(observer, notification)
      if notification.userInfo._dialogKey == dialog._dialogKey then
        if scenedlg then
          scenedlg:ClearAutoClose()
        end
        LuaNotificationCenter.RemoveObserver(protocol)
        LuaNotificationCenter.PostNotification(Common.n_TowerV2Response, nil, userInfo)
      end
    end, Common.n_DialogWillDestroy, nil)
  else
    LuaNotificationCenter.PostNotification(Common.n_TowerV2Response, nil, userInfo)
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    controller:SetData("schoosepointevent", userInfo)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

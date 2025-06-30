-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/schoosepointevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local changed = 0
  if protocol.EventID ~= -1 and protocol.EventID ~= 0 then
    do
      for roleid,hp in pairs(protocol.rolesState) do
        if not ((NekoData.BehaviorManager).BM_TowerV2):GetRoleHP(roleid) then
          local prev = hp == 0 or 1
        end
        prev = (math.ceil)(prev * 100)
        local r = 0
        if hp < prev then
          r = -1
        else
          if prev < hp then
            r = 1
          end
        end
        if changed ~= 0 and r ~= changed and hp ~= prev then
          LogError("towerv2", "hp inconsist after event")
        end
        changed = r
      end
    end
  end
  do
    local userInfo = {protocol = protocol, hpchange = changed}
    ;
    ((NekoData.DataManager).DM_TowerV2):OnSChoosePointEvent(protocol)
    if #protocol.items ~= 0 then
      local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
      dialog:LoadData({items = protocol.items})
      local scenedlg = (DialogManager.GetDialog)("towerv2.scene.towerv2scenedialog")
      if scenedlg then
        scenedlg:TryAutoCloseAccount()
      end
      ;
      (LuaNotificationCenter.AddObserver)(protocol, function(observer, notification)
    -- function num : 0_0_0 , upvalues : dialog, scenedlg, _ENV, protocol, userInfo
    if (notification.userInfo)._dialogKey == dialog._dialogKey then
      if scenedlg then
        scenedlg:ClearAutoClose()
      end
      ;
      (LuaNotificationCenter.RemoveObserver)(protocol)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_TowerV2Response, nil, userInfo)
    end
  end
, Common.n_DialogWillDestroy, nil)
    else
      do
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_TowerV2Response, nil, userInfo)
        local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
        if controller then
          controller:SetData("schoosepointevent", userInfo)
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


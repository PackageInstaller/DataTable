local function p1(protocol)
  LuaNotificationCenter.PostNotification(Common.n_OnSEnterMainCity, nil, protocol)
  
  local function doNext()
    EffectFactory.CreateThawEffect():Run()
    DialogManager.DestroySingletonDialog("login.eventreconnectdialog")
    NekoData.DataManager.DM_Game:OnSEnterMainCity(protocol)
    NekoData.DataManager.DM_SEnterDungeon:OnSEnterMainCity()
    NekoData.DataManager.DM_SEnterMainCity:OnSEnterMainCity(protocol)
    NekoData.DataManager.DM_Dungeon:OnSEnterMainCity()
    NekoData.DataManager.DM_Friends:OnSRefreshSupportRoleList({
      rolesFromFriends = {},
      rolesFromStrangers = {}
    })
    NekoData.BehaviorManager.BM_Dungeon:ClearDungeonConquestList()
    GlobalGameFSM:SetNumber("sceneLoadingId", 30001)
    if protocol.curBattleInfo.battleid > 0 then
      NekoData.DataManager.DM_SBattleStart:OnSBattleStart(protocol.curBattleInfo)
      GlobalGameFSM:SetNumber("battleId", protocol.curBattleInfo.battleid)
    end
  end
  
  local dungeonhudDialog = DialogManager.GetDialog("dungeon.dungeonhud")
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "Dungeon" and dungeonhudDialog and dungeonhudDialog:GetLeaveToShowFinishDialog() then
    dungeonhudDialog:ShowFinishExploreDialog({
      money = protocol.money,
      doNext = doNext
    })
  else
    doNext()
  end
end

local function p2(protocol, client)
end

return {p1, p2}

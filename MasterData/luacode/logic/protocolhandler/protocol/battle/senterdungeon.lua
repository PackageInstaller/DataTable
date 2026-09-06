local function p1(protocol)
  LogInfo("senterdungeon", "recevie")
  
  NekoData.DataManager.DM_Game:SetStandAloneMode()
  NekoData.DataManager.DM_Dungeon:OnSEnterDungeon(protocol)
  NekoData.DataManager.DM_SEnterDungeon:OnSEnterDungeon(protocol)
  NekoData.DataManager.DM_Team:OnSEnterDungeon(protocol)
  NekoData.DataManager.DM_MiniMap:OnSEnterDungeon(protocol)
  LuaNotificationCenter.PostNotification(Common.n_EnterDungeon, DM_Dungeon, nil)
  DialogManager.DestroySingletonDialog("maindialog")
  LogInfoFormat("senterdungeon", "--------- id = %s -----------", protocol.id)
  GlobalGameFSM:SetNumber("sceneLoadingId", protocol.id)
  if protocol.curBattleInfo.battleid > 0 then
    NekoData.DataManager.DM_SBattleStart:OnSBattleStart(protocol.curBattleInfo)
    GlobalGameFSM:SetNumber("battleId", protocol.curBattleInfo.battleid)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "TowerV2BattleCrossing Enter")
  NekoData.DataManager.DM_Battle:Clear()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle) or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  local tower_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  LogInfoFormat("Crossing", "id = %s ===========", tower_controller:GetSceneID())
  controller:SetRootGameObjectActive(false)
  SceneManager.UnloadScene(controller:GetSceneID())
  tower_controller:SetRootGameObjectActive(true)
  tower_controller:PlaySceneBGM()
  SceneManager.SetSceneActive(tower_controller)
  local id = NekoData.BehaviorManager.BM_SBattleEnd:GetID()
  local battleid = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleId()
  local result = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleResult()
  LuaNotificationCenter.PostNotification(Common.n_ReturnFromBattle, LuaNotificationCenter, {
    id = id,
    battleId = battleid,
    battleResult = result
  })
  DialogManager.DestroySingletonDialog("dungeon.battlecrossdialog")
  GlobalGameFSM:SetBoolean("crossingEnd", true)
end

function State.Update()
end

function State.OnExit()
  LogInfo("GameFSM", "TowerV2BattleCrossing Exit")
  local id = NekoData.BehaviorManager.BM_SBattleEnd:GetID()
  local battleid = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleId()
  local result = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleResult()
  LuaNotificationCenter.PostNotification(Common.n_BattleRewardEnd, LuaNotificationCenter, {
    id = id,
    battleId = battleid,
    battleResult = result
  })
  GlobalGameFSM:SetBoolean("crossingEnd", false)
  DialogManager.DestroySingletonDialog("battle.battleaccount.battlelosedialog")
end

return State

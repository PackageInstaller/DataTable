local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "SwimSuitActivityBattleCrossing Enter")
  NekoData.DataManager.DM_Battle:Clear()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle) or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  local swinsuit_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.SwimSuit)
  swinsuit_controller = swinsuit_controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.SwimSuitEchoes)
  LogInfoFormat("Crossing", "id = %s ===========", swinsuit_controller:GetSceneID())
  controller:SetRootGameObjectActive(false)
  SceneManager.UnloadScene(controller:GetSceneID())
  swinsuit_controller:SetRootGameObjectActive(true)
  SceneManager.SetSceneActive(swinsuit_controller)
  if swinsuit_controller.SetDayNightInfo then
    swinsuit_controller:SetDayNightInfo()
  end
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

function State.OnExit(nextState)
  LogInfo("GameFSM", "DungeonBattleCrossing Exit")
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

local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "TopDownBattleCrossing Enter")
  local dialog = DialogManager.GetDialog("dungeon.battlecrossdialog")
  if dialog then
    DialogManager.DestroySingletonDialog("dungeon.battlecrossdialog")
  end
  if DialogManager.GetDialog("dungeon.rockerdialog") then
    DialogManager.GetDialog("dungeon.rockerdialog"):UnMute()
  end
  if DialogManager.GetDialog("dungeon.touchlayer") then
    DialogManager.GetDialog("dungeon.touchlayer"):UnMute()
  end
  NekoData.DataManager.DM_Battle:Clear()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  local dungeon_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  controller:SetRootGameObjectActive(false)
  SceneManager.SetSceneActive(dungeon_controller)
  dungeon_controller:SetRootGameObjectActive(true)
  dungeon_controller:ShowUI()
  dungeon_controller:PlaySceneBGM()
  GlobalGameFSM:SetBoolean("crossingEnd", true)
  NekoData.BehaviorManager.BM_MiniMap:SetActive(true)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "TopDownBattleCrossing Exit")
  local id = NekoData.BehaviorManager.BM_SBattleEnd:GetID()
  local battleid = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleId()
  local result = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleResult()
  LuaNotificationCenter.PostNotification(Common.n_BattleRewardEnd, LuaNotificationCenter, {
    id = id,
    battleId = battleid,
    battleResult = result
  })
  GlobalGameFSM:SetBoolean("crossingEnd", false)
end

return State

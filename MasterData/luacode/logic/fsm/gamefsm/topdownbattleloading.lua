local State = {}
local dialog

function State.OnEnter(lastState)
  LogInfo("GameFSM", "TopDownBattleLoading Enter")
  LuaNotificationCenter.AddObserver(State, State.ToCross, Common.n_LoadBattleBeginEffectEnd, nil)
  LuaNotificationCenter.AddObserver(State, State.ToBattle, Common.n_LoadBattleEffectEnd, nil)
  dialog = nil
  if DialogManager.GetDialog("dungeon.rockerdialog") then
    DialogManager.GetDialog("dungeon.rockerdialog"):Mute()
  end
  if DialogManager.GetDialog("dungeon.touchlayer") then
    DialogManager.GetDialog("dungeon.touchlayer"):Mute()
  end
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  dialog = DialogManager.CreateSingletonDialog("dungeon.battlecrossdialog")
  dialog:SetData(protocol.battleid)
  NekoData.BehaviorManager.BM_MiniMap:SetActive(false)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "TopDownBattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

function State.ToCross()
  dialog:PlayEndAnimation()
end

function State.ToBattle(State, notification)
  LuaNotificationCenter.RemoveObserver(State)
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local recorder = BeanManager.GetTableByName("battle.cbattleinfo"):GetRecorder(protocol.battleid)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller:OnSBattleStart(protocol)
  local dungeon_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if dungeon_controller then
    dungeon_controller:SetRootGameObjectActive(false)
    dungeon_controller:HideUI()
    SceneManager.SetSceneActive(controller)
    controller:SetRootGameObjectActive(true)
  end
  LuaAudioManager.PlayBGM(recorder.bgm)
  if DialogManager.GetDialog("loadingdialog") then
    DialogManager.DestroySingletonDialog("loadingdialog")
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State

local State = {}
local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CBattleTransferTable = BeanManager.GetTableByName("battle.cbattletransfer")
local CBattleTransferEffectTable = BeanManager.GetTableByName("battle.cbattletransfereffect")
local CEffectResTable = BeanManager.GetTableByName("skill.ceffectres")
local dialog

function State.OnEnter(lastState)
  LogInfo("GameFSM", "DungeonBattleLoading Enter")
  dialog = nil
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local transferRecord = CBattleTransferTable:GetRecorder(CBattleInfoTable:GetRecorder(protocol.battleid).transferID)
  local transferEffectRecord = CBattleTransferEffectTable:GetRecorder(transferRecord.effectID)
  local flag = NekoData.BehaviorManager.BM_Login:IfCanUseLocalCBattleEnd(NekoData.BehaviorManager.BM_SBattleStart:GetProtocol())
  if not flag and transferEffectRecord and CEffectResTable:GetRecorder(transferEffectRecord.effectName) then
    LuaNotificationCenter.AddObserver(State, State.ToCross, Common.n_LoadBattleBeginEffectEnd, nil)
    LuaNotificationCenter.AddObserver(State, State.ToBattle, Common.n_LoadBattleEffectEnd, nil)
    if DialogManager.GetDialog("dungeon.rockerdialog") then
      DialogManager.GetDialog("dungeon.rockerdialog"):Mute()
    end
    if DialogManager.GetDialog("dungeon.touchlayer") then
      DialogManager.GetDialog("dungeon.touchlayer"):Mute()
    end
    dialog = DialogManager.CreateSingletonDialog("dungeon.battlecrossdialog")
    dialog:SetData(protocol.battleid)
  else
    State.ToBattle()
  end
  if DialogManager.GetDialog("tower.scene.towerscenedialog") then
    DialogManager.GetDialog("tower.scene.towerscenedialog"):Freeze()
  end
  NekoData.BehaviorManager.BM_MiniMap:SetActive(false)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "DungeonBattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

function State.ToCross()
  dialog:PlayEndAnimation()
end

function State.ToBattle()
  if dialog then
    LuaNotificationCenter.RemoveObserver(State)
  end
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local recorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  local dungeon_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if dungeon_controller then
    dungeon_controller:SetRootGameObjectActive(false)
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle) or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  controller:SetRootGameObjectActive(true)
  SceneManager.SetSceneActive(controller)
  controller:OnSBattleStart(protocol)
  LuaAudioManager.PlayBGM(recorder.bgm)
  if DialogManager.GetDialog("loadingdialog") then
    DialogManager.DestroySingletonDialog("loadingdialog")
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State

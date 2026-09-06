local State = {}
local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CBattleTransferTable = BeanManager.GetTableByName("battle.cbattletransfer")
local CBattleTransferEffectTable = BeanManager.GetTableByName("battle.cbattletransfereffect")
local CEffectResTable = BeanManager.GetTableByName("skill.ceffectres")
local dialog
local loadBattleSceneEnd = false

function State.OnEnter(lastState)
  LogInfo("GameFSM", "SwimSuitActivityBattleLoading Enter")
  State.toCross = false
  DialogManager.CreateSingletonDialog("base.hidemaincitymodaldialog")
  dialog = nil
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local battleSceneId = protocol.battleSceneId
  SceneManager.LoadScene(battleSceneId, false, false, true, false, true)
  LuaNotificationCenter.AddObserver(State, function(observer, notification)
    local controller = notification.userInfo
    loadBattleSceneEnd = controller:GetSceneID() == battleSceneId
    if loadBattleSceneEnd then
      if dialog then
        State.ToCross()
      else
        State.ToBattle()
      end
    end
  end, Common.n_EndLoadScene, nil)
  local cBattleInfoRecorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  if cBattleInfoRecorder then
    local transferRecord = CBattleTransferTable:GetRecorder(cBattleInfoRecorder.transferID)
    local transferEffectRecord = CBattleTransferEffectTable:GetRecorder(transferRecord.effectID)
    local flag = NekoData.BehaviorManager.BM_Login:IfCanUseLocalCBattleEnd(NekoData.BehaviorManager.BM_SBattleStart:GetProtocol())
    if not flag and transferEffectRecord and CEffectResTable:GetRecorder(transferEffectRecord.effectName) then
      LuaNotificationCenter.AddObserver(State, State.OnLoadBattleEffectEnd, Common.n_LoadBattleEffectEnd, nil)
      dialog = DialogManager.CreateSingletonDialog("dungeon.battlecrossdialog")
      dialog:SetData(protocol.battleid)
    end
  else
    LogInfoFormat("GameFSM", "MainCityBattleLoading battleid %s dont in cbattleinfo", protocol.battleid)
  end
end

function State.Update()
end

function State.OnExit(nextState)
  LuaNotificationCenter.RemoveObserver(State)
  dialog = nil
  loadBattleSceneEnd = false
  LogInfo("GameFSM", "SwimSuitActivityBattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

function State.ToCross()
  if not State.toCross then
    dialog:PlayEndAnimation()
    State.toCross = true
  end
end

function State.OnLoadBattleEffectEnd()
  if loadBattleSceneEnd then
    State.ToBattle()
  end
end

function State.ToBattle()
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local recorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  local dungeon_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.SwimSuit)
  dungeon_controller = dungeon_controller or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.SwimSuitEchoes)
  if dungeon_controller then
    dungeon_controller:SetRootGameObjectActive(false)
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle) or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
  controller:SetRootGameObjectActive(true)
  SceneManager.SetSceneActive(controller)
  controller:OnSBattleStart(protocol)
  if recorder then
    LuaAudioManager.PlayBGM(recorder.bgm)
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State

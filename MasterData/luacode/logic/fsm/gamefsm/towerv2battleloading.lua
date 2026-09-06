local State = {}
local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CBattleTransferTable = BeanManager.GetTableByName("battle.cbattletransfer")
local CBattleTransferEffectTable = BeanManager.GetTableByName("battle.cbattletransfereffect")
local CEffectResTable = BeanManager.GetTableByName("skill.ceffectres")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local dialog
local loadBattleEffectEnd = false
local loadBattleSceneEnd = false

function State.OnEnter(lastState)
  LogInfo("GameFSM", "TowerV2BattleLoading Enter")
  State.toCross = false
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local battleSceneId = protocol.battleSceneId
  SceneManager.LoadScene(battleSceneId, false, false, true, false, true)
  local loadingDialog = DialogManager.GetDialog("loadingdialog")
  if loadingDialog == nil then
    loadingDialog = DialogManager.CreateSingletonDialog("loadingdialog")
  end
  loadingDialog:ShowTips(battleSceneId)
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
    LogInfoFormat("GameFSM", "TowerV2BattleLoading battleid %s dont in cbattleinfo", protocol.battleid)
  end
end

function State.Update(nextState)
end

function State.OnExit()
  LuaNotificationCenter.RemoveObserver(State)
  dialog = nil
  loadBattleSceneEnd = false
  LogInfo("GameFSM", "TowerV2BattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

function State.ToCross()
  if not State.toCross then
    dialog:PlayEndAnimation()
    if loadBattleSceneEnd then
      DialogManager.DestroySingletonDialog("loadingdialog")
    end
    State.toCross = true
  end
end

function State.OnLoadBattleEffectEnd()
  if loadBattleSceneEnd then
    State.ToBattle()
  end
end

function State.ToBattle()
  if dialog then
    LuaNotificationCenter.RemoveObserver(State)
    dialog = nil
  end
  local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
  local recorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  local dungeon_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if dungeon_controller then
    dungeon_controller:SetRootGameObjectActive(false)
    dungeon_controller:OnDisable()
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle) or SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
  controller:SetRootGameObjectActive(true)
  SceneManager.SetSceneActive(controller)
  controller:OnSBattleStart(protocol)
  if recorder then
    LuaAudioManager.PlayBGM(recorder.bgm)
  end
  if DialogManager.GetDialog("loadingdialog") then
    DialogManager.DestroySingletonDialog("loadingdialog")
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State

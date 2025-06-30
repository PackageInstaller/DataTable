-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/towerv2battleloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CBattleTransferTable = (BeanManager.GetTableByName)("battle.cbattletransfer")
local CBattleTransferEffectTable = (BeanManager.GetTableByName)("battle.cbattletransfereffect")
local CEffectResTable = (BeanManager.GetTableByName)("skill.ceffectres")
local CBattleStartProtocol = (require("protocols.def.protocol.battle.cbattlestart"))
local dialog = nil
local loadBattleEffectEnd = false
local loadBattleSceneEnd = false
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State, loadBattleSceneEnd, dialog, CBattleInfoTable, CBattleTransferTable, CBattleTransferEffectTable, CEffectResTable
  LogInfo("GameFSM", "TowerV2BattleLoading Enter")
  State.toCross = false
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  local battleSceneId = protocol.battleSceneId
  ;
  (SceneManager.LoadScene)(battleSceneId, false, false, true, false, true)
  local loadingDialog = (DialogManager.GetDialog)("loadingdialog")
  if loadingDialog == nil then
    loadingDialog = (DialogManager.CreateSingletonDialog)("loadingdialog")
  end
  loadingDialog:ShowTips(battleSceneId)
  ;
  (LuaNotificationCenter.AddObserver)(State, function(observer, notification)
    -- function num : 0_0_0 , upvalues : loadBattleSceneEnd, battleSceneId, dialog, State
    local controller = notification.userInfo
    loadBattleSceneEnd = controller:GetSceneID() == battleSceneId
    if loadBattleSceneEnd then
      if dialog then
        (State.ToCross)()
      else
        (State.ToBattle)()
      end
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
, Common.n_EndLoadScene, nil)
  local cBattleInfoRecorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  if cBattleInfoRecorder then
    local transferRecord = CBattleTransferTable:GetRecorder(cBattleInfoRecorder.transferID)
    local transferEffectRecord = CBattleTransferEffectTable:GetRecorder(transferRecord.effectID)
    local flag = ((NekoData.BehaviorManager).BM_Login):IfCanUseLocalCBattleEnd(((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol())
    if not flag and transferEffectRecord and CEffectResTable:GetRecorder(transferEffectRecord.effectName) then
      (LuaNotificationCenter.AddObserver)(State, State.OnLoadBattleEffectEnd, Common.n_LoadBattleEffectEnd, nil)
      dialog = (DialogManager.CreateSingletonDialog)("dungeon.battlecrossdialog")
      dialog:SetData(protocol.battleid)
    end
  else
    do
      LogInfoFormat("GameFSM", "TowerV2BattleLoading battleid %s dont in cbattleinfo", protocol.battleid)
    end
  end
end

State.Update = function(nextState)
  -- function num : 0_1
end

State.OnExit = function()
  -- function num : 0_2 , upvalues : _ENV, State, dialog, loadBattleSceneEnd
  (LuaNotificationCenter.RemoveObserver)(State)
  dialog = nil
  loadBattleSceneEnd = false
  LogInfo("GameFSM", "TowerV2BattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

State.ToCross = function()
  -- function num : 0_3 , upvalues : State, dialog, loadBattleSceneEnd, _ENV
  if not State.toCross then
    dialog:PlayEndAnimation()
    if loadBattleSceneEnd then
      (DialogManager.DestroySingletonDialog)("loadingdialog")
    end
    State.toCross = true
  end
end

State.OnLoadBattleEffectEnd = function()
  -- function num : 0_4 , upvalues : loadBattleSceneEnd, State
  if loadBattleSceneEnd then
    (State.ToBattle)()
  end
end

State.ToBattle = function()
  -- function num : 0_5 , upvalues : dialog, _ENV, State, CBattleInfoTable
  if dialog then
    (LuaNotificationCenter.RemoveObserver)(State)
    dialog = nil
  end
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  local recorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  local dungeon_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if dungeon_controller then
    dungeon_controller:SetRootGameObjectActive(false)
    dungeon_controller:OnDisable()
  end
  if not (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle) then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  end
  controller:SetRootGameObjectActive(true)
  ;
  (SceneManager.SetSceneActive)(controller)
  controller:OnSBattleStart(protocol)
  if recorder then
    (LuaAudioManager.PlayBGM)(recorder.bgm)
  end
  if (DialogManager.GetDialog)("loadingdialog") then
    (DialogManager.DestroySingletonDialog)("loadingdialog")
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State


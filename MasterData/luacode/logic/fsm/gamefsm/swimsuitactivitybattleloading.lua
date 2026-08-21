-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/swimsuitactivitybattleloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CBattleTransferTable = (BeanManager.GetTableByName)("battle.cbattletransfer")
local CBattleTransferEffectTable = (BeanManager.GetTableByName)("battle.cbattletransfereffect")
local CEffectResTable = ((BeanManager.GetTableByName)("skill.ceffectres"))
local dialog = nil
local loadBattleSceneEnd = false
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State, dialog, loadBattleSceneEnd, CBattleInfoTable, CBattleTransferTable, CBattleTransferEffectTable, CEffectResTable
  LogInfo("GameFSM", "SwimSuitActivityBattleLoading Enter")
  State.toCross = false
  ;
  (DialogManager.CreateSingletonDialog)("base.hidemaincitymodaldialog")
  dialog = nil
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  local battleSceneId = protocol.battleSceneId
  ;
  (SceneManager.LoadScene)(battleSceneId, false, false, true, false, true)
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
      LogInfoFormat("GameFSM", "MainCityBattleLoading battleid %s dont in cbattleinfo", protocol.battleid)
    end
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV, State, dialog, loadBattleSceneEnd
  (LuaNotificationCenter.RemoveObserver)(State)
  dialog = nil
  loadBattleSceneEnd = false
  LogInfo("GameFSM", "SwimSuitActivityBattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

State.ToCross = function()
  -- function num : 0_3 , upvalues : State, dialog
  if not State.toCross then
    dialog:PlayEndAnimation()
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
  -- function num : 0_5 , upvalues : _ENV, CBattleInfoTable
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  local recorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  local dungeon_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).SwimSuit)
  if not dungeon_controller then
    dungeon_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).SwimSuitEchoes)
  end
  if dungeon_controller then
    dungeon_controller:SetRootGameObjectActive(false)
  end
  if not (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle) then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  controller:SetRootGameObjectActive(true)
  ;
  (SceneManager.SetSceneActive)(controller)
  controller:OnSBattleStart(protocol)
  if recorder then
    (LuaAudioManager.PlayBGM)(recorder.bgm)
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State


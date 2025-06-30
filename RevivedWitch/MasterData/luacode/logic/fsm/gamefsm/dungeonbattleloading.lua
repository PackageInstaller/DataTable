-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/dungeonbattleloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CBattleTransferTable = (BeanManager.GetTableByName)("battle.cbattletransfer")
local CBattleTransferEffectTable = (BeanManager.GetTableByName)("battle.cbattletransfereffect")
local CEffectResTable = ((BeanManager.GetTableByName)("skill.ceffectres"))
local dialog = nil
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, dialog, CBattleTransferTable, CBattleInfoTable, CBattleTransferEffectTable, CEffectResTable, State
  LogInfo("GameFSM", "DungeonBattleLoading Enter")
  dialog = nil
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  local transferRecord = CBattleTransferTable:GetRecorder((CBattleInfoTable:GetRecorder(protocol.battleid)).transferID)
  local transferEffectRecord = CBattleTransferEffectTable:GetRecorder(transferRecord.effectID)
  local flag = ((NekoData.BehaviorManager).BM_Login):IfCanUseLocalCBattleEnd(((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol())
  if not flag and transferEffectRecord and CEffectResTable:GetRecorder(transferEffectRecord.effectName) then
    (LuaNotificationCenter.AddObserver)(State, State.ToCross, Common.n_LoadBattleBeginEffectEnd, nil)
    ;
    (LuaNotificationCenter.AddObserver)(State, State.ToBattle, Common.n_LoadBattleEffectEnd, nil)
    if (DialogManager.GetDialog)("dungeon.rockerdialog") then
      ((DialogManager.GetDialog)("dungeon.rockerdialog")):Mute()
    end
    if (DialogManager.GetDialog)("dungeon.touchlayer") then
      ((DialogManager.GetDialog)("dungeon.touchlayer")):Mute()
    end
    dialog = (DialogManager.CreateSingletonDialog)("dungeon.battlecrossdialog")
    dialog:SetData(protocol.battleid)
  else
    ;
    (State.ToBattle)()
  end
  if (DialogManager.GetDialog)("tower.scene.towerscenedialog") then
    ((DialogManager.GetDialog)("tower.scene.towerscenedialog")):Freeze()
  end
  ;
  ((NekoData.BehaviorManager).BM_MiniMap):SetActive(false)
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "DungeonBattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

State.ToCross = function()
  -- function num : 0_3 , upvalues : dialog
  dialog:PlayEndAnimation()
end

State.ToBattle = function()
  -- function num : 0_4 , upvalues : dialog, _ENV, State, CBattleInfoTable
  if dialog then
    (LuaNotificationCenter.RemoveObserver)(State)
  end
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  local recorder = CBattleInfoTable:GetRecorder(protocol.battleid)
  local dungeon_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
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
  ;
  (LuaAudioManager.PlayBGM)(recorder.bgm)
  if (DialogManager.GetDialog)("loadingdialog") then
    (DialogManager.DestroySingletonDialog)("loadingdialog")
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State


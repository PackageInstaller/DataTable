-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/topdownbattleloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local dialog = nil
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State, dialog
  LogInfo("GameFSM", "TopDownBattleLoading Enter")
  ;
  (LuaNotificationCenter.AddObserver)(State, State.ToCross, Common.n_LoadBattleBeginEffectEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(State, State.ToBattle, Common.n_LoadBattleEffectEnd, nil)
  dialog = nil
  if (DialogManager.GetDialog)("dungeon.rockerdialog") then
    ((DialogManager.GetDialog)("dungeon.rockerdialog")):Mute()
  end
  if (DialogManager.GetDialog)("dungeon.touchlayer") then
    ((DialogManager.GetDialog)("dungeon.touchlayer")):Mute()
  end
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  dialog = (DialogManager.CreateSingletonDialog)("dungeon.battlecrossdialog")
  dialog:SetData(protocol.battleid)
  ;
  ((NekoData.BehaviorManager).BM_MiniMap):SetActive(false)
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "TopDownBattleLoading Exit")
  GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
end

State.ToCross = function()
  -- function num : 0_3 , upvalues : dialog
  dialog:PlayEndAnimation()
end

State.ToBattle = function(State, notification)
  -- function num : 0_4 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(State)
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
  local recorder = ((BeanManager.GetTableByName)("battle.cbattleinfo")):GetRecorder(protocol.battleid)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  controller:OnSBattleStart(protocol)
  local dungeon_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if dungeon_controller then
    dungeon_controller:SetRootGameObjectActive(false)
    dungeon_controller:HideUI()
    ;
    (SceneManager.SetSceneActive)(controller)
    controller:SetRootGameObjectActive(true)
  end
  ;
  (LuaAudioManager.PlayBGM)(recorder.bgm)
  if (DialogManager.GetDialog)("loadingdialog") then
    (DialogManager.DestroySingletonDialog)("loadingdialog")
  end
  GlobalGameFSM:SetBoolean("battleLoadingEnd", true)
end

return State


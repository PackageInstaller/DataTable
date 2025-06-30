-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/maincitybattlecrossing.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("GameFSM", "MainCityBattleCrossing Enter")
  ;
  ((NekoData.DataManager).DM_Battle):Clear()
  if not (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle) then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
  end
  local base_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  LogInfoFormat("Crossing", "id = %s ===========", base_controller:GetSceneID())
  controller:SetRootGameObjectActive(false)
  ;
  (SceneManager.UnloadScene)(controller:GetSceneID())
  base_controller:SetRootGameObjectActive(true)
  ;
  (SceneManager.SetSceneActive)(base_controller)
  local id = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
  local battleid = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleId()
  local result = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleResult()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ReturnFromBattle, LuaNotificationCenter, {id = id, battleId = battleid, battleResult = result})
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.battlecrossdialog")
  GlobalGameFSM:SetBoolean("crossingEnd", true)
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function()
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "MainCityBattleCrossing Exit")
  local id = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
  local battleid = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleId()
  local result = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleResult()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_BattleRewardEnd, LuaNotificationCenter, {id = id, battleId = battleid, battleResult = result})
  GlobalGameFSM:SetBoolean("crossingEnd", false)
  ;
  (DialogManager.DestroySingletonDialog)("battle.battleaccount.battlelosedialog")
end

return State


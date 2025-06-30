-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/swimsuitactivitybattlecrossing.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("GameFSM", "SwimSuitActivityBattleCrossing Enter")
  ;
  ((NekoData.DataManager).DM_Battle):Clear()
  if not (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle) then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  local swinsuit_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).SwimSuit)
  if not swinsuit_controller then
    swinsuit_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).SwimSuitEchoes)
  end
  LogInfoFormat("Crossing", "id = %s ===========", swinsuit_controller:GetSceneID())
  controller:SetRootGameObjectActive(false)
  ;
  (SceneManager.UnloadScene)(controller:GetSceneID())
  swinsuit_controller:SetRootGameObjectActive(true)
  ;
  (SceneManager.SetSceneActive)(swinsuit_controller)
  if swinsuit_controller.SetDayNightInfo then
    swinsuit_controller:SetDayNightInfo()
  end
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

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "DungeonBattleCrossing Exit")
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


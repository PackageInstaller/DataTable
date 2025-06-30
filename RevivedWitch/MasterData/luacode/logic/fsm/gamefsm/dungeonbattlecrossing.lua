-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/dungeonbattlecrossing.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("GameFSM", "DungeonBattleCrossing Enter")
  ;
  ((NekoData.DataManager).DM_Battle):Clear()
  if not (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle) then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
  end
  local dungeon_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  LogInfoFormat("Crossing", "id = %s ===========", dungeon_controller:GetSceneID())
  controller:SetRootGameObjectActive(false)
  dungeon_controller:SetRootGameObjectActive(true)
  ;
  (SceneManager.SetSceneActive)(dungeon_controller)
  if dungeon_controller.PlaySceneBGM then
    dungeon_controller:PlaySceneBGM()
  end
  local id = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
  local battleid = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleId()
  local result = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleResult()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ReturnFromBattle, LuaNotificationCenter, {id = id, battleId = battleid, battleResult = result})
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.battlecrossdialog")
  if (DialogManager.GetDialog)("dungeon.rockerdialog") then
    ((DialogManager.GetDialog)("dungeon.rockerdialog")):UnMute()
  end
  if (DialogManager.GetDialog)("dungeon.touchlayer") then
    ((DialogManager.GetDialog)("dungeon.touchlayer")):UnMute()
  end
  if (DialogManager.GetDialog)("tower.scene.towerscenedialog") then
    ((DialogManager.GetDialog)("tower.scene.towerscenedialog")):Thaw()
  end
  ;
  ((NekoData.BehaviorManager).BM_MiniMap):SetActive(true)
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


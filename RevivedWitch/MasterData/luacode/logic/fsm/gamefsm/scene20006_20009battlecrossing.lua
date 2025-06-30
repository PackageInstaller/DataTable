-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/scene20006_20009battlecrossing.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("GameFSM", "Scene20006_20009BattleCrossing Enter")
  ;
  ((NekoData.DataManager).DM_Battle):Clear()
  GlobalGameFSM:SetBoolean("crossingEnd", true)
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "Scene20006_20009BattleCrossing Exit")
  local id = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
  local battleid = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleId()
  local result = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleResult()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_BattleRewardEnd, LuaNotificationCenter, {id = id, battleId = battleid, battleResult = result})
  GlobalGameFSM:SetBoolean("crossingEnd", false)
end

return State


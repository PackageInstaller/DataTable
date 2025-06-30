-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/topdownbattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("GameFSM", "TopDownBattle Enter")
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_BattleStateEnter, State, nil)
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("GameFSM", "TopDownBattle Exit")
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_BattleStateExit, State, nil)
end

return State


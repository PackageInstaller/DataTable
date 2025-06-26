-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/battleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("BattleFSM", "BattleEnd Enter")
  controller:BSC_BattleEnd()
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BattleFSM", "BattleEnd Exit")
end

return State


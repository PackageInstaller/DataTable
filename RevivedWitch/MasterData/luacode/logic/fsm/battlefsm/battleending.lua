-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/battleending.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local battleFSM = nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, battleFSM
  LogInfo("BattleFSM", "BattleEnding Enter")
  battleFSM = controller._bsc_battleFSM
  battleFSM:SetBoolean("toBreak", not GlobalGameFSM or GlobalGameFSM:GetParameter("toLogin") == "BreakOrReconnection")
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("BattleFSM", "BattleEnding Exit")
end

return State


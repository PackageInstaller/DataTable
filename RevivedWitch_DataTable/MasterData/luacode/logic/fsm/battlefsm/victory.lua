-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/victory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBattleConstCFG = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local State = {}
local timeTask = nil
local DelayToAccounts = function(controller, dontDelay)
  -- function num : 0_0 , upvalues : _ENV, CBattleConstCFG, timeTask
  local battleId = GlobalGameFSM:GetParameter("battleId")
  if (string.find)((CBattleConstCFG:GetRecorder(91)).attr, tostring(battleId)) or dontDelay then
    (controller._bsc_battleFSM):SetBoolean("victoryEnd", true)
  else
    if timeTask then
      (GameTimer.RemoveTask)(timeTask)
      timeTask = nil
    end
    timeTask = (GameTimer.AddTask)(tonumber((CBattleConstCFG:GetRecorder(59)).attr), -1, function()
    -- function num : 0_0_0 , upvalues : timeTask, controller
    timeTask = nil
    ;
    (controller._bsc_battleFSM):SetBoolean("victoryEnd", true)
  end
)
  end
end

State.OnEnter = function(controller, lastState)
  -- function num : 0_1 , upvalues : _ENV, DelayToAccounts
  LogInfo("BattleFSM", "Victory Enter")
  ;
  (LuaAudioManager.PlayBGM)(4)
  local battleId = GlobalGameFSM:GetParameter("battleId")
  if battleId == 1120 then
    DelayToAccounts(controller, true)
  else
    DelayToAccounts(controller)
  end
  controller:BSC_ShowVictoryAnimation()
end

State.Update = function(controller, deltaTime)
  -- function num : 0_2
end

State.OnExit = function(controller, nextState)
  -- function num : 0_3 , upvalues : _ENV
  LogInfo("BattleFSM", "Victory Exit")
  ;
  (controller._bsc_battleFSM):SetBoolean("victoryEnd", false)
end

return State


local CBattleConstCFG = BeanManager.GetTableByName("battle.cbattleconstcfg")
local State = {}
local timeTask

local function DelayToAccounts(controller, dontDelay)
  local battleId = GlobalGameFSM:GetParameter("battleId")
  if string.find(CBattleConstCFG:GetRecorder(91).attr, tostring(battleId)) or dontDelay then
    controller._bsc_battleFSM:SetBoolean("victoryEnd", true)
  else
    if timeTask then
      GameTimer.RemoveTask(timeTask)
      timeTask = nil
    end
    timeTask = GameTimer.AddTask(tonumber(CBattleConstCFG:GetRecorder(59).attr), -1, function()
      timeTask = nil
      controller._bsc_battleFSM:SetBoolean("victoryEnd", true)
    end)
  end
end

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "Victory Enter")
  LuaAudioManager.PlayBGM(4)
  local battleId = GlobalGameFSM:GetParameter("battleId")
  if battleId == 1120 then
    DelayToAccounts(controller, true)
  else
    DelayToAccounts(controller)
  end
  controller:BSC_ShowVictoryAnimation()
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "Victory Exit")
  controller._bsc_battleFSM:SetBoolean("victoryEnd", false)
end

return State

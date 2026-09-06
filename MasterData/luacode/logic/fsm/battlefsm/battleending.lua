local State = {}
local battleFSM

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "BattleEnding Enter")
  battleFSM = controller._bsc_battleFSM
  battleFSM:SetBoolean("toBreak", GlobalGameFSM and GlobalGameFSM:GetParameter("toLogin") == "BreakOrReconnection")
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "BattleEnding Exit")
end

return State

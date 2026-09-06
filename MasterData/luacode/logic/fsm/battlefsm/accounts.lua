local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "Accounts Enter")
  controller:BSC_ShowAwards()
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "Accounts Exit")
end

return State

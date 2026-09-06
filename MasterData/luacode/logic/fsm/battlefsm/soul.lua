local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "Soul Enter")
  controller:BSC_ShowSoulAnimation()
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "Soul Exit")
end

return State

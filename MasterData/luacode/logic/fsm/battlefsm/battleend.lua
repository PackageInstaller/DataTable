local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "BattleEnd Enter")
  controller:BSC_BattleEnd()
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "BattleEnd Exit")
end

return State

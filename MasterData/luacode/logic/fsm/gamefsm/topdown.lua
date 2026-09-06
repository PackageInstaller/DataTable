local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "TopDown Enter")
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "TopDown Exit")
end

return State

local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "FirstScene Enter")
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "FirstScene Exit")
end

return State

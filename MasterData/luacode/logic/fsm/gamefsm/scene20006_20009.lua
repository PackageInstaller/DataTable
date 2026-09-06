local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Scene20006_20009 Enter")
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Scene20006_20009 Exit")
end

return State

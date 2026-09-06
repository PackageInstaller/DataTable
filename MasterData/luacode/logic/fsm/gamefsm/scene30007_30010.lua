local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Scene30007_30010 Enter")
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Scene30007_30010 Exit")
end

return State

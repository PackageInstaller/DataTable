local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "MainCityBattle Enter")
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "MainCityBattle Exit")
end

return State

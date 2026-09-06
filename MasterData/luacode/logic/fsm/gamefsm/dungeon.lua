local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Dungeon Enter")
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, State, nil)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Dungeon Exit")
end

return State

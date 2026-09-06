local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Towerv2Battle Enter")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateEnter, State, nil)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Towerv2Battle Exit")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateExit, State, nil)
end

return State

local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "SwimSuitActivityBattle Enter")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateEnter, State, nil)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "SwimSuitActivityBattle Exit")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateExit, State, nil)
end

return State

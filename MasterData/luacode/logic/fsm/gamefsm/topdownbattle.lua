local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "TopDownBattle Enter")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateEnter, State, nil)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "TopDownBattle Exit")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateExit, State, nil)
end

return State

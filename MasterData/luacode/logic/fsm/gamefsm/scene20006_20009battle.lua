local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Scene20006_20009Battle Enter")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateEnter, State, nil)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Scene20006_20009Battle Exit")
  LuaNotificationCenter.PostNotification(Common.n_BattleStateExit, State, nil)
  LuaAudioManager.StopBGM(137)
  LuaAudioManager.StopBGM(4)
end

return State

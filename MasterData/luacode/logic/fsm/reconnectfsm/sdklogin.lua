local State = {}

function State.OnEnter(gameFSM_breakOrReconnect, lastState)
  LogInfo("ReconnectFSM", "SdkLogin Enter")
  State.gameFSM_breakOrReconnect = gameFSM_breakOrReconnect
  LuaNotificationCenter.RemoveObserver(State)
  LuaNotificationCenter.AddObserver(State, State.OnLoginResult, Common.n_LoginResult, nil)
  SdkManager.Login(JSON.encode({loginType = "normal"}))
end

function State.Update()
end

function State.OnExit(gameFSM_breakOrReconnect, nextState)
  LogInfo("ReconnectFSM", "SdkLogin Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnLoginResult(observer, notification)
  State.gameFSM_breakOrReconnect.reconnectFSM:SetBoolean("toQuestIPAndPort", true)
end

return State

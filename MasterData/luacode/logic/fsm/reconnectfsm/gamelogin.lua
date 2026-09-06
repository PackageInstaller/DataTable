local State = {}

function State.OnEnter(gameFSM_breakOrReconnect, lastState)
  LogInfo("ReconnectFSM", "GameLogin Enter")
  State.gameFSM_breakOrReconnect = gameFSM_breakOrReconnect
  local token = State.gameFSM_breakOrReconnect.token
  if token then
    local ip = State.gameFSM_breakOrReconnect.reconnectFSM:GetParameter("ip")
    local port = State.gameFSM_breakOrReconnect.reconnectFSM:GetParameter("port")
    local account = NekoData.BehaviorManager.BM_Login:GetAccount()
    if type(account) ~= "string" then
      account = tostring(account)
    end
    LogInfoFormat("ReconnectFSM:GameLogin", "ip: [%s], port: [%d] account:%s token:%s", ip, port, account, token)
    LuaNetManager.ConnectToServer(ip, port, account, token, "relogin")
  end
  State.gameFSM_breakOrReconnect.FinishReconnectFSM()
end

function State.Update()
end

function State.OnExit(gameFSM_breakOrReconnect, nextState)
  LogInfo("ReconnectFSM", "GameLogin Exit")
end

return State

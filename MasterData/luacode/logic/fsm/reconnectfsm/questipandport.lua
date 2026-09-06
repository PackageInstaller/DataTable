local State = {}
local ServerListManager = require("logic.net.serverlistmanager")

function State.OnEnter(gameFSM_breakOrReconnect, lastState)
  LogInfo("ReconnectFSM", "QuestIPAndPort Enter")
  State.gameFSM_breakOrReconnect = gameFSM_breakOrReconnect
  LuaNotificationCenter.RemoveObserver(State)
  LuaNotificationCenter.AddObserver(State, State.OnIPServerResponse, Common.n_QuestIPResult, nil)
  ServerListManager.ReQuestIPAndPort()
end

function State.Update()
end

function State.OnExit(gameFSM_breakOrReconnect, nextState)
  LogInfo("ReconnectFSM", "QuestIPAndPort Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnIPServerResponse(observer, notification)
  local resultJson = JSON.decode(notification.userInfo)
  if resultJson.result == ServerListManager.IPServerResponseResultType.RESULT_SUCCESS then
    local ip
    if resultJson.ip then
      ip = resultJson.ip
    else
      LogError("ReconnectFSM:QuestIPAndPort", "ip server return ip is nil")
    end
    local port
    if resultJson.port then
      port = resultJson.port
    else
      LogError("ReconnectFSM:QuestIPAndPort", "ip server return port is nil")
    end
    if ip and port then
      State.gameFSM_breakOrReconnect.reconnectFSM:SetString("ip", ip)
      State.gameFSM_breakOrReconnect.reconnectFSM:SetNumber("port", tonumber(port))
    end
  end
end

return State

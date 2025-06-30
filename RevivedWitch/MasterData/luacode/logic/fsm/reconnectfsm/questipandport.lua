-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/reconnectfsm/questipandport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local ServerListManager = require("logic.net.serverlistmanager")
State.OnEnter = function(gameFSM_breakOrReconnect, lastState)
  -- function num : 0_0 , upvalues : _ENV, State, ServerListManager
  LogInfo("ReconnectFSM", "QuestIPAndPort Enter")
  State.gameFSM_breakOrReconnect = gameFSM_breakOrReconnect
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  ;
  (LuaNotificationCenter.AddObserver)(State, State.OnIPServerResponse, Common.n_QuestIPResult, nil)
  ;
  (ServerListManager.ReQuestIPAndPort)()
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(gameFSM_breakOrReconnect, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("ReconnectFSM", "QuestIPAndPort Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnIPServerResponse = function(observer, notification)
  -- function num : 0_3 , upvalues : _ENV, ServerListManager, State
  local resultJson = (JSON.decode)(notification.userInfo)
  if resultJson.result == (ServerListManager.IPServerResponseResultType).RESULT_SUCCESS then
    local ip = nil
    if resultJson.ip then
      ip = resultJson.ip
    else
      LogError("ReconnectFSM:QuestIPAndPort", "ip server return ip is nil")
    end
    local port = nil
    if resultJson.port then
      port = resultJson.port
    else
      LogError("ReconnectFSM:QuestIPAndPort", "ip server return port is nil")
    end
    if ip and port then
      ((State.gameFSM_breakOrReconnect).reconnectFSM):SetString("ip", ip)
      ;
      ((State.gameFSM_breakOrReconnect).reconnectFSM):SetNumber("port", tonumber(port))
    end
  end
end

return State


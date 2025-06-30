-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/reconnectfsm/gamelogin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(gameFSM_breakOrReconnect, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("ReconnectFSM", "GameLogin Enter")
  State.gameFSM_breakOrReconnect = gameFSM_breakOrReconnect
  local token = (State.gameFSM_breakOrReconnect).token
  if token then
    local ip = ((State.gameFSM_breakOrReconnect).reconnectFSM):GetParameter("ip")
    local port = ((State.gameFSM_breakOrReconnect).reconnectFSM):GetParameter("port")
    local account = ((NekoData.BehaviorManager).BM_Login):GetAccount()
    if type(account) ~= "string" then
      account = tostring(account)
    end
    LogInfoFormat("ReconnectFSM:GameLogin", "ip: [%s], port: [%d] account:%s token:%s", ip, port, account, token)
    ;
    (LuaNetManager.ConnectToServer)(ip, port, account, token, "relogin")
  end
  do
    ;
    ((State.gameFSM_breakOrReconnect).FinishReconnectFSM)()
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(gameFSM_breakOrReconnect, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("ReconnectFSM", "GameLogin Exit")
end

return State


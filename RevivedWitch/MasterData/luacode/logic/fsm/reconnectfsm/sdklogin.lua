-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/reconnectfsm/sdklogin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(gameFSM_breakOrReconnect, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("ReconnectFSM", "SdkLogin Enter")
  State.gameFSM_breakOrReconnect = gameFSM_breakOrReconnect
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  ;
  (LuaNotificationCenter.AddObserver)(State, State.OnLoginResult, Common.n_LoginResult, nil)
  ;
  (SdkManager.Login)((JSON.encode)({loginType = "normal"}))
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(gameFSM_breakOrReconnect, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("ReconnectFSM", "SdkLogin Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnLoginResult = function(observer, notification)
  -- function num : 0_3 , upvalues : State
  ((State.gameFSM_breakOrReconnect).reconnectFSM):SetBoolean("toQuestIPAndPort", true)
end

return State


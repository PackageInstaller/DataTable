-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/reconnectfsm/init.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(gameFSM_breakOrReconnect, lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("ReconnectFSM", "Init Enter")
  LogInfoFormat("ReconnectFSM.Init", "Channel = %s", (SdkManager.GetChannel)())
  if (SdkManager.GetChannel)() == "none" then
    (gameFSM_breakOrReconnect.reconnectFSM):SetNumber("adult", 1)
  else
    local sdkLoginResult = ((NekoData.BehaviorManager).BM_Login):GetSDKLoginResult()
    LogInfoFormat("ReconnectFSM.Init", "sdkLoginResult = %s", sdkLoginResult)
    if sdkLoginResult then
      (gameFSM_breakOrReconnect.reconnectFSM):SetNumber("adult", 1)
    end
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(gameFSM_breakOrReconnect, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("ReconnectFSM", "Init Exit")
end

return State


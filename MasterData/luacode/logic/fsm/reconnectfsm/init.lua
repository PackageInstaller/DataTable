local State = {}

function State.OnEnter(gameFSM_breakOrReconnect, lastState)
  LogInfo("ReconnectFSM", "Init Enter")
  LogInfoFormat("ReconnectFSM.Init", "Channel = %s", SdkManager.GetChannel())
  if SdkManager.GetChannel() == "none" then
    gameFSM_breakOrReconnect.reconnectFSM:SetNumber("adult", 1)
  else
    local sdkLoginResult = NekoData.BehaviorManager.BM_Login:GetSDKLoginResult()
    LogInfoFormat("ReconnectFSM.Init", "sdkLoginResult = %s", sdkLoginResult)
    if sdkLoginResult then
      gameFSM_breakOrReconnect.reconnectFSM:SetNumber("adult", 1)
    end
  end
end

function State.Update()
end

function State.OnExit(gameFSM_breakOrReconnect, nextState)
  LogInfo("ReconnectFSM", "Init Exit")
end

return State

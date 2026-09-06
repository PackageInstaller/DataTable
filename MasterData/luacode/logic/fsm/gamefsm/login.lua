local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Login Enter")
  GlobalGameFSM:SetBoolean("toGame", false)
  State.value = GlobalGameFSM:GetParameter("toLogin")
  if lastState ~= "PlayPV" and State.value ~= "ReconnectionFromLoginState" and State.value ~= "DisconnectionFromLoginState" then
    GlobalGameFSM:SetString("toLogin", "")
    GlobalGameFSM:SetBoolean("loadSceneEnd", false)
    GlobalGameFSM:SetNumber("sceneLoadingId", 0)
    GlobalGameFSM:SetNumber("sceneId", 0)
    GlobalGameFSM:SetNumber("battleId", 0)
    GlobalGameFSM:SetBoolean("battleLoadingEnd", false)
    GlobalGameFSM:SetBoolean("crossingEnd", false)
    GlobalGameFSM:SetBoolean("toBreakOrReconnect", false)
    DialogManager.Clear()
    NekoData.ClearAll()
    EventManager.Clear()
    GameTimer.RemoveAllTask()
    ServerGameTimer.RemoveAllTask()
    GameScene.LoadInGame()
    UIBackManager.Clear()
  else
    DialogManager.Clear()
    UIBackManager.Clear()
    if State.value == "ReconnectionFromLoginState" or State.value == "DisconnectionFromLoginState" then
      NekoData.BehaviorManager.BM_Login:SetLoginFailTimes(NekoData.BehaviorManager.BM_Login:GetLoginFailTimes() + 1)
    end
  end
  DialogManager.GetGroup("Guide"):SetObjectActive(true)
  if State.value == "Reconnection" then
    DialogManager.CreateSingletonDialog("login.reconnectdialog")
  elseif lastState == "PlayPV" or State.value == "Disconnection" then
    SdkManager.OpenLoginDialog()
    if global_var_showFrameRate then
      DialogManager.CreateSingletonDialog("debug.frameratedialog")
    end
  elseif State.value == "ReconnectionFromLoginState" or State.value == "DisconnectionFromLoginState" then
    SdkManager.OpenLoginDialog()
    if global_var_showFrameRate then
      DialogManager.CreateSingletonDialog("debug.frameratedialog")
    end
  end
  DialogManager.CreateSingletonDialog("clickeffect.clickeffectdialog")
  LuaAudioManager.PlayBGM(1)
  NekoData.BehaviorManager.BM_Game:SetVolume()
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Login Exit")
end

return State

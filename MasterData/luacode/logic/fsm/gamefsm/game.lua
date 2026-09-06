local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Game Enter")
  if not DialogManager.GetDialog("clickeffect.clickeffectdialog") then
    DialogManager.CreateSingletonDialog("clickeffect.clickeffectdialog")
  end
  DialogManager.DestroySingletonDialog("login.logindialog")
  DialogManager.DestroySingletonDialog("login.soundlogindialog")
  DialogManager.DestroySingletonDialog("login.loginmaindialog")
  DialogManager.DestroySingletonDialog("login.sdklogindialog")
  DialogManager.DestroySingletonDialog("login.reconnectdialog")
  DialogManager.DestroySingletonDialog("login.loginqueuedialog")
  DialogManager.DestroySingletonDialog("login.loginwaitdialog")
  NekoData.BehaviorManager.BM_Login:SetLoginFailTimes(0)
  NekoData.BehaviorManager.BM_Game:StartSpeedTask()
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Game Exit")
  if nextState ~= "BreakOrReconnect" then
    DialogManager.DestroySingletonDialog("maindialog")
  end
end

return State

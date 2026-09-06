local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "CourtYard Enter")
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, State, nil)
  State.yardController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if State.yardController then
    State.yardController:SetYardFSM()
  end
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "CourtYard Exit")
  DialogManager.GetGroup("Modal"):ReturnModalDialog()
  DialogManager.DestroySingletonDialog("courtyard.yardmaindialog")
end

return State

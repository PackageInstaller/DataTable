local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("YardFSM", "Cabin Enter")
  local sceneId = controller._yardFSM:GetParameter("sceneId")
  State.cabinController = SceneManager.GetSceneControllerByID(sceneId)
  State.cabinController:SetRootGameObjectActive(true)
  State.cabinController:EnterCabin()
  local dialog = DialogManager.CreateSingletonDialog("courtcabin.interactmodaldialog")
  dialog:Init(State.cabinController)
  State.cabinController:SetInteractDialog(dialog)
  DialogManager.CreateSingletonDialog("courtcabin.cabinmaindialog"):Init(State.cabinController)
  State.ThemeFurniture = {sortId = 2, rise = false}
  State.NormalFurniture = {sortId = 1, rise = false}
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, State, nil)
end

function State.Update()
end

function State.OnExit(controller, nextState)
  LogInfo("YardFSM", "Cabin Exit")
  State.cabinController:SetInteractDialog(nil)
  DialogManager.DestroySingletonDialog("courtcabin.cabinmaindialog")
  DialogManager.DestroySingletonDialog("courtcabin.interactmodaldialog")
  State.cabinController:SetRootGameObjectActive(false)
end

return State

local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("YardFSM", "TrainCamp Enter")
  local sceneId = controller._yardFSM:GetParameter("sceneId")
  State.trainCampController = SceneManager.GetSceneControllerByID(sceneId)
  State.trainCampController:SetRootGameObjectActive(true)
  local dialog = DialogManager.CreateSingletonDialog("traincamp.interactmodaldialog")
  dialog:Init(State.trainCampController)
  State.trainCampController:SetInteractDialog(dialog)
  State.trainCampController:EnterTrainCamp()
  DialogManager.CreateSingletonDialog("traincamp.traincampmaindialog")
end

function State.Update()
end

function State.OnExit(controller, nextState)
  LogInfo("YardFSM", "TrainCamp Exit")
  State.trainCampController:SetInteractDialog(nil)
  DialogManager.DestroySingletonDialog("traincamp.traincampmaindialog")
  DialogManager.DestroySingletonDialog("traincamp.interactmodaldialog")
  State.trainCampController:ExitTrainCamp()
  State.trainCampController:SetRootGameObjectActive(false)
end

return State

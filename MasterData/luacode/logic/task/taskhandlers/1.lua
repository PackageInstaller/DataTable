local TaskHandler = {}

function TaskHandler:Handle(record)
  DialogManager.DestroySingletonDialog("task.taskmaindialog")
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  sceneController:SetJumpValue(record.jumpvalue[1])
end

return TaskHandler

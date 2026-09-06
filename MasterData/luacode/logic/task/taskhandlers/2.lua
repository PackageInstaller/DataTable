local CJumpConfig = BeanManager.GetTableByName("jump.cjumpconfig")
local JumpToUIManager = require("logic.manager.jumptouimanager")
local TaskHandler = {}

function TaskHandler:Handle(record)
  local oneline = CJumpConfig:GetRecorder(record.UIjumpvalue)
  if record.jumpAim == 0 or not record.jumpAim then
    local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if sceneController then
      sceneController:SetCameraAnimatorState(oneline.target)
    else
      LogError("taskhandlers.2", "sceneController (SceneManager.LoadType.Base) is nil")
    end
  end
  if JumpToUIManager.RunTaskHandler(string.lower(oneline.Dialog), record.jumpAim) then
    DialogManager.DestroySingletonDialog("task.taskmaindialog")
  end
  if record.missiontype and record.missiontype == 4 then
    DialogManager.DestroySingletonDialog("task.taskmaindialog")
  end
end

return TaskHandler

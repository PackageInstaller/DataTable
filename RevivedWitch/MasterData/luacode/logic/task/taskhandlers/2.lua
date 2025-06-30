-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskhandlers/2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CJumpConfig = (BeanManager.GetTableByName)("jump.cjumpconfig")
local JumpToUIManager = require("logic.manager.jumptouimanager")
local TaskHandler = {}
TaskHandler.Handle = function(self, record)
  -- function num : 0_0 , upvalues : CJumpConfig, _ENV, JumpToUIManager
  local oneline = CJumpConfig:GetRecorder(record.UIjumpvalue)
  do
    if record.jumpAim == 0 or not record.jumpAim then
      local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
      if sceneController then
        sceneController:SetCameraAnimatorState(oneline.target)
      else
        LogError("taskhandlers.2", "sceneController (SceneManager.LoadType.Base) is nil")
      end
    end
    if (JumpToUIManager.RunTaskHandler)((string.lower)(oneline.Dialog), record.jumpAim) then
      (DialogManager.DestroySingletonDialog)("task.taskmaindialog")
    end
    if record.missiontype and record.missiontype == 4 then
      (DialogManager.DestroySingletonDialog)("task.taskmaindialog")
    end
  end
end

return TaskHandler


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskhandlers/1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskHandler = {}
TaskHandler.Handle = function(self, record)
  -- function num : 0_0 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("task.taskmaindialog")
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  sceneController:SetJumpValue((record.jumpvalue)[1])
end

return TaskHandler


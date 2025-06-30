-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/workshopmaterial.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  local dialog = (DialogManager.CreateSingletonDialog)("equip.bagdialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:OnGroupBtnClick(2)
  end
end

return TaskUIHandler


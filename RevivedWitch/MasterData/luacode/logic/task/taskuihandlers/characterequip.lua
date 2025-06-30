-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/characterequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  local dialog = (DialogManager.CreateSingletonDialog)("character.basecharacterlistalldialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:OnActorCellClicked()
    dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
    if dialog then
      dialog:OnEquipPanelClick()
    end
  end
end

return TaskUIHandler


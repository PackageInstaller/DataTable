local TaskUIHandler = {}

function TaskUIHandler:Handle()
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local dialog = DialogManager.CreateSingletonDialog("equip.bagdialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:OnGroupBtnClick(2)
  end
end

return TaskUIHandler

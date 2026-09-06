local TaskUIHandler = {}

function TaskUIHandler:Handle()
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local dialog = DialogManager.CreateSingletonDialog("character.basecharacterlistalldialog")
  if dialog then
    dialog:Init(sceneController)
  end
end

return TaskUIHandler

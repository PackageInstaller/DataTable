local TaskUIHandler = {}

function TaskUIHandler:Handle(id)
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local dialog = DialogManager.CreateSingletonDialog("character.basecharacterlistalldialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:OnSpecificActorCellClicked(id)
  end
end

return TaskUIHandler

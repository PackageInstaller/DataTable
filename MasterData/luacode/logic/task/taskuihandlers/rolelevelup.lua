local TaskUIHandler = {}

function TaskUIHandler:Handle()
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local dialog = DialogManager.CreateSingletonDialog("character.basecharacterlistalldialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:OnActorCellClicked()
    dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
    if dialog and not NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(1) then
      dialog:OnLevelUpPanelClick()
    end
  end
end

return TaskUIHandler

local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Tower) then
    return
  end
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
  if dialog then
    dialog:Init(sceneController)
    if not NekoData.BehaviorManager.BM_Guide:HasCurrentStrongGuide() then
      dialog:OnTypeFourBtnClicked()
    else
      LogInfo("mainlineworlddialog has a strong guide being played.")
    end
  end
end

return TaskUIHandler

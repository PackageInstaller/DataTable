local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Resource) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100199)
    return
  end
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:ItemTipsJump({
      gainType = DataCommon.GainTypeEnum.Resource,
      worldId = nil
    })
  end
end

return TaskUIHandler

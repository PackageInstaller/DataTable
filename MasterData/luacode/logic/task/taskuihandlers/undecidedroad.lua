local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.UndecidedRoad) then
    return
  end
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:ItemTipsJump({
      gainType = DataCommon.GainTypeEnum.UndecidedRoad,
      worldId = nil
    })
  end
end

return TaskUIHandler

local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BossRush) then
    return
  end
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local mlwDialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
  if mlwDialog then
    mlwDialog:Init(sceneController)
    if not NekoData.BehaviorManager.BM_Guide:HasCurrentStrongGuide() then
      mlwDialog:OpenBossRushPanel()
    else
      LogInfo("mainlineworlddialog has a strong guide being played.")
    end
  end
end

return TaskUIHandler

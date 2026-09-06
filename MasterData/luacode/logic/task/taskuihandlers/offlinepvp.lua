local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.OffLinePvp) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100495)
    return
  end
  local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local mlwDialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
  if mlwDialog then
    mlwDialog:Init(sceneController)
    if not NekoData.BehaviorManager.BM_Guide:HasCurrentStrongGuide() then
      mlwDialog:OnTypeFourBtnClicked()
      local fantasyProtocol = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictopenpanel")
      if fantasyProtocol then
        fantasyProtocol:Send()
      end
    else
      LogInfo("mainlineworlddialog has a strong guide being played.")
    end
  end
end

return TaskUIHandler

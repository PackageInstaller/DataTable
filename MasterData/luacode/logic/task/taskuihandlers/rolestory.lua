local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Signboard) then
    local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    local dialog = DialogManager.CreateSingletonDialog("character.basecharacterlistalldialog")
    if dialog then
      dialog:Init(sceneController)
      dialog:JumpToRoleGift()
      dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
      if dialog then
        dialog:OnHeartBtnClicked()
      end
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100312)
  end
end

return TaskUIHandler

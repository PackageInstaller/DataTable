local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfig:GetRecorder(94).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100338)
    return
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Friend) then
    DialogManager.CreateSingletonDialog("friend.friendsmaindialog")
  end
end

return TaskUIHandler

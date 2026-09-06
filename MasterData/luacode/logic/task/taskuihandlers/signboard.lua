local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Signboard) then
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("signboard.signboardmaindialog")
  if dialog then
    dialog:Init()
  end
end

return TaskUIHandler

local TaskUIHandler = {}

function TaskUIHandler:Handle(id)
  if id ~= 2 then
    return
  end
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_Every) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100412)
    return
  end
  local dialogName = "task.taskmaindialog"
  local dialog = DialogManager.GetDialog(dialogName)
  if dialog then
    DialogManager.DestroySingletonDialog(dialogName)
  end
  local dlg = DialogManager.CreateSingletonDialog(dialogName)
  if dlg then
    dlg:ToPage(id)
  end
end

return TaskUIHandler

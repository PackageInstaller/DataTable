local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.CourtYard) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100195)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.yard.copenyard")
  csend:Send()
  DialogManager.DestroySingletonDialog("task.taskmaindialog")
end

return TaskUIHandler

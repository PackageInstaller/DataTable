local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BattleFSM", "TimeLine Enter")
  local dialogId = controller._bsc_battleFSM:GetParameter("chatDialogId")
  if dialogId ~= 0 then
    DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(dialogId)
  else
    controller._bsc_battleFSM:SetBoolean("chatDialogEnd", true)
  end
end

function State.Update(controller, deltaTime)
end

function State.OnExit(controller, nextState)
  LogInfo("BattleFSM", "TimeLine Exit")
end

return State

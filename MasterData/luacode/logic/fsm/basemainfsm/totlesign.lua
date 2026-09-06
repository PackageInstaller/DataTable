local State = {}
local controllera

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "TotleSign Enter")
  if not NekoData.BehaviorManager.BM_Welfare:GetTotleSignState() and NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Signboard) then
    local dialog = DialogManager.CreateSingletonDialog("signboard.signboardmaindialog")
    if dialog then
      controllera = controller
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      dialog:Init(true)
    else
      controller._baseMainFSM:SetBoolean("totleSignBrgin", false)
    end
  else
    controller._baseMainFSM:SetBoolean("totleSignBrgin", false)
  end
  controller._baseMainFSM:SetBoolean("toMonthCardDailyReward", true)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "TotleSign Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogDestroy(observer, notification)
  if notification.userInfo._dialogName == "signboard.signboardmaindialog" then
    controllera._baseMainFSM:SetBoolean("totleSignBrgin", false)
  end
end

return State

local State = {}
local controllera, returnwelfaremaindialog, returnWelfareActivityMailDialog

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "ReturnWelfare Enter")
  returnwelfaremaindialog = nil
  returnWelfareActivityMailDialog = nil
  if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetReturnActivityState() and NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Welfare) then
    returnwelfaremaindialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.returnwelfaremaindialog")
    if returnwelfaremaindialog then
      controllera = controller
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      returnwelfaremaindialog:SetData(true)
    else
      controller._baseMainFSM:SetBoolean("returnwelfareBegin", false)
    end
  elseif NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OverseasReturnWelfareActivityId) and NekoData.BehaviorManager.BM_Activity:GetPopTipsStatusWithActivityId(DataCommon.Activities.OverseasReturnWelfareActivityId) == 1 then
    returnWelfareActivityMailDialog = DialogManager.CreateSingletonDialog("welfare.returnwelfare.returnwelfareactivitymaildialog")
    if returnWelfareActivityMailDialog then
      controllera = controller
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
    else
      controller._baseMainFSM:SetBoolean("returnwelfareBegin", false)
    end
  else
    controller._baseMainFSM:SetBoolean("returnwelfareBegin", false)
  end
  controller._baseMainFSM:SetBoolean("welfareBegin", true)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "ReturnWelfare Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogDestroy(observer, notification)
  if notification.userInfo._dialogName == "welfare.returnwelfare.returnwelfaremaindialog" then
    controllera._baseMainFSM:SetBoolean("returnwelfareBegin", false)
  elseif returnWelfareActivityMailDialog and (not DialogManager.GetDialog("welfare.returnwelfare.returnwelfareactivitymaildialog") and notification.userInfo._dialogName == "bag.itemaccountdialog" or not DialogManager.GetDialog("bag.itemaccountdialog") and notification.userInfo._dialogName == "welfare.returnwelfare.returnwelfareactivitymaildialog") then
    controllera._baseMainFSM:SetBoolean("returnwelfareBegin", false)
    returnWelfareActivityMailDialog = nil
  elseif (notification.userInfo._dialogName == "bag.itemaccountdialog" or notification.userInfo._dialogName == "gacha.gacharesultdialog") and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetReturnActivityState() and returnwelfaremaindialog then
    returnwelfaremaindialog:SelectNextTab()
  end
end

return State

local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "Welfare Enter")
  if (NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityState() or NekoData.BehaviorManager.BM_Welfare:ShowWitchCalendarRedDot()) and NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Welfare) then
    local welfaremaindialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
    if welfaremaindialog then
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      welfaremaindialog:SetData(NekoData.BehaviorManager.BM_Welfare:GetAccumulateSignState(), true)
    else
      controller._baseMainFSM:SetBoolean("welfareBegin", false)
    end
  else
    controller._baseMainFSM:SetBoolean("welfareBegin", false)
  end
  controller._baseMainFSM:SetBoolean("totleSignBrgin", true)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "Welfare Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogDestroy(observer, notification)
  local needDialogsToNext = {
    "bag.itemaccountdialog",
    "gacha.gacharesultdialog",
    "shop.fashionbuyresultdialog"
  }
  if notification.userInfo._dialogName == "welfare.welfaremaindialog" then
    local controller = SceneManager.GetSceneControllerByID(30001)
    if controller and controller._baseMainFSM then
      controller._baseMainFSM:SetBoolean("welfareBegin", false)
    end
  elseif table.contain(needDialogsToNext, notification.userInfo._dialogName) and (NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityState() or NekoData.BehaviorManager.BM_Welfare:ShowWitchCalendarRedDot()) then
    local welfaremaindialogCapture = DialogManager.GetDialog("welfare.welfaremaindialog")
    if welfaremaindialogCapture then
      welfaremaindialogCapture:SelectNextTab()
    end
  end
end

return State

local State = {}
local controllera

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "SimpleShow Enter")
  local data = NekoData.BehaviorManager.BM_Activity:GetWhiteValentine()
  if data and data.state == 1 and data.id ~= 0 and data.rewardState == 0 then
    DialogManager.CreateSingletonDialog("activity.whitevalentine.whitevalentinemaindialog")
  end
  if DialogManager.GetDialog("activity.whitevalentine.whitevalentinemaindialog") then
    controllera = controller
    LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  else
    controller._baseMainFSM:SetBoolean("toSimpleShow", false)
    controller._baseMainFSM:SetBoolean("noticeBegin", true)
  end
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "SimpleShow Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogDestroy(observer, notification)
  local controller = SceneManager.GetSceneControllerByID(30001)
  if not (not (controller and controller._baseMainFSM) or DialogManager.GetDialog("activity.whitevalentine.whitevalentinemaindialog")) and notification.userInfo._dialogName == "bag.itemaccountdialog" or not DialogManager.GetDialog("bag.itemaccountdialog") and notification.userInfo._dialogName == "activity.whitevalentine.whitevalentinemaindialog" then
    local toSimpleShow = controller._baseMainFSM:GetParameter("toSimpleShow")
    local noticeBegin = controller._baseMainFSM:GetParameter("noticeBegin")
    if toSimpleShow and not noticeBegin then
      controller._baseMainFSM:SetBoolean("toSimpleShow", false)
      controller._baseMainFSM:SetBoolean("noticeBegin", true)
    end
  end
end

return State

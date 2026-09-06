local State = {}
local controllera

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "MonthCardDailyReward Enter")
  if NekoData.BehaviorManager.BM_ItemAccountShow:GetShowDialogDataFromCache(DataCommon.ShowDialogType.MonthCardDailyAward) then
    controllera = controller
    NekoData.BehaviorManager.BM_ItemAccountShow:AddShowDialogDataFromCache(DataCommon.ShowDialogType.MonthCardDailyAward)
    LuaNotificationCenter.AddObserver(State, State.OnSingletonDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  else
    controller._baseMainFSM:SetBoolean("toMonthCardDailyReward", false)
  end
  controller._baseMainFSM:SetBoolean("resonanceBegin", true)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "MonthCardDailyReward Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnSingletonDialogDestroy(observer, notification)
  if notification.userInfo._dialogName == "shop.monthcarddailyawarddialog" and not NekoData.BehaviorManager.BM_ItemAccountShow:GetShowDialogDataFromCache(DataCommon.ShowDialogType.MonthCardDailyAward) then
    controllera._baseMainFSM:SetBoolean("toMonthCardDailyReward", false)
  end
end

return State

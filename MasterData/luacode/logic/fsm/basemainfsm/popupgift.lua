local State = {}
local controllera

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "PopUpGift Enter")
  local value_PopUpGift = NekoData.BehaviorManager.BM_Activity:IsAutoPopUpGift()
  local value_PopUpGift7Day = NekoData.BehaviorManager.BM_Activity:IsAutoPopUpGift7Day()
  if not SdkManager.IsOverseas and (value_PopUpGift or value_PopUpGift7Day) then
    if value_PopUpGift then
      DialogManager.CreateSingletonDialog("welfare.popupgiftdialog")
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      local type = DataCommon.LocalCache.PopUpGiftAutoOpenType
      NekoData.BehaviorManager.BM_Game:SetLocalCache(type, value_PopUpGift)
    elseif value_PopUpGift7Day then
      DialogManager.CreateSingletonDialog("welfare.popupgift7daydialog")
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      local type = DataCommon.LocalCache.PopUpGift7DayAutoOpenType
      NekoData.BehaviorManager.BM_Game:SetLocalCache(type, value_PopUpGift7Day)
    end
  else
    controller._baseMainFSM:SetBoolean("autoPopUpGift", false)
    controller._baseMainFSM:SetNumber("witchSkillGuideId", 1)
  end
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "PopUpGift Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnDialogDestroy(observer, notification)
  local controller = SceneManager.GetSceneControllerByID(30001)
  if not (not (controller and controller._baseMainFSM) or DialogManager.GetDialog("welfare.popupgiftdialog") or DialogManager.GetDialog("welfare.popupgift7daydialog")) and notification.userInfo._dialogName == "bag.itemaccountdialog" or not DialogManager.GetDialog("bag.itemaccountdialog") and (notification.userInfo._dialogName == "welfare.popupgiftdialog" or notification.userInfo._dialogName == "welfare.popupgift7daydialog") then
    local autoPopUpGift = controller._baseMainFSM:GetParameter("autoPopUpGift")
    local witchSkillGuideId = controller._baseMainFSM:GetParameter("witchSkillGuideId")
    if autoPopUpGift and witchSkillGuideId == 0 then
      controller._baseMainFSM:SetBoolean("autoPopUpGift", false)
      controller._baseMainFSM:SetNumber("witchSkillGuideId", 1)
    end
  end
end

return State

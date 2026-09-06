local State = {}
local controllera

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "FunctionUnlock Enter")
  controller._baseMainFSM:SetBoolean("toFunctionUnlock", false)
  if NekoData.BehaviorManager.BM_Message:GetFunctionUnlockNum() > 0 then
    controllera = controller
    LuaNotificationCenter.AddObserver(State, State.OnFunctionUnlockDestroy, Common.n_DialogWillDestroy, nil)
    NekoData.BehaviorManager.BM_Message:ShowFunctionUnlockDialog()
    controller._baseMainFSM:SetBoolean("haveFSMHandleOrMainCityGuide", true)
  else
    controller._baseMainFSM:SetBoolean("toNormal", true)
  end
end

function State.Update(controller)
end

function State.OnFunctionUnlockDestroy(observer, noitification)
  if noitification.userInfo._dialogName == "messagetip.functionunlockdialog" and NekoData.BehaviorManager.BM_Message:GetFunctionUnlockNum() == 0 then
    controllera._baseMainFSM:SetBoolean("toNormal", true)
  end
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "FunctionUnlock Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

return State

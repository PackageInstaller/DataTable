-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/functionunlock.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, controllera, State
  LogInfo("BaseMainFSM", "FunctionUnlock Enter")
  ;
  (controller._baseMainFSM):SetBoolean("toFunctionUnlock", false)
  if ((NekoData.BehaviorManager).BM_Message):GetFunctionUnlockNum() > 0 then
    controllera = controller
    ;
    (LuaNotificationCenter.AddObserver)(State, State.OnFunctionUnlockDestroy, Common.n_DialogWillDestroy, nil)
    ;
    ((NekoData.BehaviorManager).BM_Message):ShowFunctionUnlockDialog()
    ;
    (controller._baseMainFSM):SetBoolean("haveFSMHandleOrMainCityGuide", true)
    if ((NekoData.BehaviorManager).BM_Game):GetOpenDeepLinkActivityTag() then
      ((NekoData.BehaviorManager).BM_Game):ClearOpenDeepLinkActivityTag()
      ;
      (DialogManager.CreateSingletonDialog)("activity.activitydeeplinkdialog")
    end
  else
    if ((NekoData.BehaviorManager).BM_Game):GetOpenDeepLinkActivityTag() then
      ((NekoData.BehaviorManager).BM_Game):ClearOpenDeepLinkActivityTag()
      controllera = controller
      ;
      (LuaNotificationCenter.AddObserver)(State, State.OnActivityDeepLinkDialogDestroy, Common.n_DialogWillDestroy, nil)
      ;
      (DialogManager.CreateSingletonDialog)("activity.activitydeeplinkdialog")
    else
      ;
      (controller._baseMainFSM):SetBoolean("toNormal", true)
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnFunctionUnlockDestroy = function(observer, noitification)
  -- function num : 0_2 , upvalues : _ENV, controllera
  if (noitification.userInfo)._dialogName == "messagetip.functionunlockdialog" and ((NekoData.BehaviorManager).BM_Message):GetFunctionUnlockNum() == 0 then
    (controllera._baseMainFSM):SetBoolean("toNormal", true)
  end
end

State.OnActivityDeepLinkDialogDestroy = function(observer, noitification)
  -- function num : 0_3 , upvalues : controllera
  if (noitification.userInfo)._dialogName == "activity.activitydeeplinkdialog" then
    (controllera._baseMainFSM):SetBoolean("toNormal", true)
  end
end

State.OnExit = function(controller, nextState)
  -- function num : 0_4 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "FunctionUnlock Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

return State


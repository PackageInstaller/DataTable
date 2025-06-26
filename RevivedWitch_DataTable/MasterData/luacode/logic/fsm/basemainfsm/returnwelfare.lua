-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/returnwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera, returnwelfaremaindialog, returnWelfareActivityMailDialog = nil, nil, nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, returnwelfaremaindialog, returnWelfareActivityMailDialog, controllera, State
  LogInfo("BaseMainFSM", "ReturnWelfare Enter")
  returnwelfaremaindialog = nil
  returnWelfareActivityMailDialog = nil
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetReturnActivityState() and ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Welfare) then
    returnwelfaremaindialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.returnwelfaremaindialog")
    if returnwelfaremaindialog then
      controllera = controller
      ;
      (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      returnwelfaremaindialog:SetData(true)
    else
      ;
      (controller._baseMainFSM):SetBoolean("returnwelfareBegin", false)
    end
  else
    if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OverseasReturnWelfareActivityId) and ((NekoData.BehaviorManager).BM_Activity):GetPopTipsStatusWithActivityId((DataCommon.Activities).OverseasReturnWelfareActivityId) == 1 then
      returnWelfareActivityMailDialog = (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.returnwelfareactivitymaildialog")
      if returnWelfareActivityMailDialog then
        controllera = controller
        ;
        (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      else
        ;
        (controller._baseMainFSM):SetBoolean("returnwelfareBegin", false)
      end
    else
      ;
      (controller._baseMainFSM):SetBoolean("returnwelfareBegin", false)
    end
  end
  ;
  (controller._baseMainFSM):SetBoolean("welfareBegin", true)
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "ReturnWelfare Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : controllera, returnWelfareActivityMailDialog, _ENV, returnwelfaremaindialog
  if (notification.userInfo)._dialogName == "welfare.returnwelfare.returnwelfaremaindialog" then
    (controllera._baseMainFSM):SetBoolean("returnwelfareBegin", false)
  else
    if (not (DialogManager.GetDialog)("welfare.returnwelfare.returnwelfareactivitymaildialog") and (notification.userInfo)._dialogName == "bag.itemaccountdialog") or not (DialogManager.GetDialog)("bag.itemaccountdialog") and (notification.userInfo)._dialogName == "welfare.returnwelfare.returnwelfareactivitymaildialog" then
      (controllera._baseMainFSM):SetBoolean("returnwelfareBegin", false)
      returnWelfareActivityMailDialog = nil
    else
      if ((notification.userInfo)._dialogName == "bag.itemaccountdialog" or (notification.userInfo)._dialogName == "gacha.gacharesultdialog") and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetReturnActivityState() and returnwelfaremaindialog then
        returnwelfaremaindialog:SelectNextTab()
      end
    end
  end
end

return State


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/welfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "Welfare Enter")
  if ((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetSignActivityState() or ((NekoData.BehaviorManager).BM_Welfare):ShowWitchCalendarRedDot()) and ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Welfare) then
    local welfaremaindialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
    if welfaremaindialog then
      (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      welfaremaindialog:SetData(((NekoData.BehaviorManager).BM_Welfare):GetAccumulateSignState(), true)
    else
      ;
      (controller._baseMainFSM):SetBoolean("welfareBegin", false)
    end
  else
    do
      ;
      (controller._baseMainFSM):SetBoolean("welfareBegin", false)
      ;
      (controller._baseMainFSM):SetBoolean("totleSignBrgin", true)
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "Welfare Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : _ENV
  local needDialogsToNext = {"bag.itemaccountdialog", "gacha.gacharesultdialog", "shop.fashionbuyresultdialog"}
  if (notification.userInfo)._dialogName == "welfare.welfaremaindialog" then
    local controller = (SceneManager.GetSceneControllerByID)(30001)
    if controller and controller._baseMainFSM then
      (controller._baseMainFSM):SetBoolean("welfareBegin", false)
    end
  else
    do
      if (table.contain)(needDialogsToNext, (notification.userInfo)._dialogName) and ((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetSignActivityState() or ((NekoData.BehaviorManager).BM_Welfare):ShowWitchCalendarRedDot()) then
        local welfaremaindialogCapture = (DialogManager.GetDialog)("welfare.welfaremaindialog")
        if welfaremaindialogCapture then
          welfaremaindialogCapture:SelectNextTab()
        end
      end
    end
  end
end

return State


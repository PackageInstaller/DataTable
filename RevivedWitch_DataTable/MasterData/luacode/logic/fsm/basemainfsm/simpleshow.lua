-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/simpleshow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, controllera, State
  LogInfo("BaseMainFSM", "SimpleShow Enter")
  local data = ((NekoData.BehaviorManager).BM_Activity):GetWhiteValentine()
  if data and data.state == 1 and data.id ~= 0 and data.rewardState == 0 then
    (DialogManager.CreateSingletonDialog)("activity.whitevalentine.whitevalentinemaindialog")
  end
  if (DialogManager.GetDialog)("activity.whitevalentine.whitevalentinemaindialog") then
    controllera = controller
    ;
    (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  else
    ;
    (controller._baseMainFSM):SetBoolean("toSimpleShow", false)
    ;
    (controller._baseMainFSM):SetBoolean("noticeBegin", true)
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "SimpleShow Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByID)(30001)
  if (controller and controller._baseMainFSM and not (DialogManager.GetDialog)("activity.whitevalentine.whitevalentinemaindialog") and (notification.userInfo)._dialogName == "bag.itemaccountdialog") or not (DialogManager.GetDialog)("bag.itemaccountdialog") and (notification.userInfo)._dialogName == "activity.whitevalentine.whitevalentinemaindialog" then
    local toSimpleShow = (controller._baseMainFSM):GetParameter("toSimpleShow")
    local noticeBegin = (controller._baseMainFSM):GetParameter("noticeBegin")
    if toSimpleShow and not noticeBegin then
      (controller._baseMainFSM):SetBoolean("toSimpleShow", false)
      ;
      (controller._baseMainFSM):SetBoolean("noticeBegin", true)
    end
  end
end

return State


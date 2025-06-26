-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/monthcarddailyreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, controllera, State
  LogInfo("BaseMainFSM", "MonthCardDailyReward Enter")
  if ((NekoData.BehaviorManager).BM_ItemAccountShow):GetShowDialogDataFromCache((DataCommon.ShowDialogType).MonthCardDailyAward) then
    controllera = controller
    ;
    ((NekoData.BehaviorManager).BM_ItemAccountShow):AddShowDialogDataFromCache((DataCommon.ShowDialogType).MonthCardDailyAward)
    ;
    (LuaNotificationCenter.AddObserver)(State, State.OnSingletonDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  else
    ;
    (controller._baseMainFSM):SetBoolean("toMonthCardDailyReward", false)
  end
  ;
  (controller._baseMainFSM):SetBoolean("resonanceBegin", true)
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "MonthCardDailyReward Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnSingletonDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : _ENV, controllera
  if (notification.userInfo)._dialogName == "shop.monthcarddailyawarddialog" and not ((NekoData.BehaviorManager).BM_ItemAccountShow):GetShowDialogDataFromCache((DataCommon.ShowDialogType).MonthCardDailyAward) then
    (controllera._baseMainFSM):SetBoolean("toMonthCardDailyReward", false)
  end
end

return State


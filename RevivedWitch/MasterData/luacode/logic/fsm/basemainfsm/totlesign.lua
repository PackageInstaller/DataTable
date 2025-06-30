-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/totlesign.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, controllera, State
  LogInfo("BaseMainFSM", "TotleSign Enter")
  if not ((NekoData.BehaviorManager).BM_Welfare):GetTotleSignState() and ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Signboard) then
    local dialog = (DialogManager.CreateSingletonDialog)("signboard.signboardmaindialog")
    if dialog then
      controllera = controller
      ;
      (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      dialog:Init(true)
    else
      ;
      (controller._baseMainFSM):SetBoolean("totleSignBrgin", false)
    end
  else
    do
      ;
      (controller._baseMainFSM):SetBoolean("totleSignBrgin", false)
      ;
      (controller._baseMainFSM):SetBoolean("toMonthCardDailyReward", true)
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "TotleSign Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : controllera
  if (notification.userInfo)._dialogName == "signboard.signboardmaindialog" then
    (controllera._baseMainFSM):SetBoolean("totleSignBrgin", false)
  end
end

return State


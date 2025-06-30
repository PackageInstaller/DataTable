-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/popupgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "PopUpGift Enter")
  local value_PopUpGift = ((NekoData.BehaviorManager).BM_Activity):IsAutoPopUpGift()
  local value_PopUpGift7Day = ((NekoData.BehaviorManager).BM_Activity):IsAutoPopUpGift7Day()
  if not SdkManager.IsOverseas and (value_PopUpGift or value_PopUpGift7Day) then
    if value_PopUpGift then
      (DialogManager.CreateSingletonDialog)("welfare.popupgiftdialog")
      ;
      (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      local type = (DataCommon.LocalCache).PopUpGiftAutoOpenType
      ;
      ((NekoData.BehaviorManager).BM_Game):SetLocalCache(type, value_PopUpGift)
    else
      do
        if value_PopUpGift7Day then
          (DialogManager.CreateSingletonDialog)("welfare.popupgift7daydialog")
          ;
          (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
          local type = (DataCommon.LocalCache).PopUpGift7DayAutoOpenType
          ;
          ((NekoData.BehaviorManager).BM_Game):SetLocalCache(type, value_PopUpGift7Day)
        end
        do
          ;
          (controller._baseMainFSM):SetBoolean("autoPopUpGift", false)
          ;
          (controller._baseMainFSM):SetNumber("witchSkillGuideId", 1)
        end
      end
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "PopUpGift Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByID)(30001)
  if (controller and controller._baseMainFSM and not (DialogManager.GetDialog)("welfare.popupgiftdialog") and not (DialogManager.GetDialog)("welfare.popupgift7daydialog") and (notification.userInfo)._dialogName == "bag.itemaccountdialog") or not (DialogManager.GetDialog)("bag.itemaccountdialog") and ((notification.userInfo)._dialogName == "welfare.popupgiftdialog" or (notification.userInfo)._dialogName == "welfare.popupgift7daydialog") then
    local autoPopUpGift = (controller._baseMainFSM):GetParameter("autoPopUpGift")
    local witchSkillGuideId = (controller._baseMainFSM):GetParameter("witchSkillGuideId")
    if autoPopUpGift and witchSkillGuideId == 0 then
      (controller._baseMainFSM):SetBoolean("autoPopUpGift", false)
      ;
      (controller._baseMainFSM):SetNumber("witchSkillGuideId", 1)
    end
  end
end

return State


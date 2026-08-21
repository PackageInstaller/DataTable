-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/notice.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "Notice Enter")
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Notice) then
    local lastDiableNoticeTimeKey = tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid) .. "_lastDiableNoticeTime"
    local lastDiableNoticeTime = (((CS.UnityEngine).PlayerPrefs).GetInt)(lastDiableNoticeTimeKey, 0)
    if lastDiableNoticeTime ~= 0 then
      local nowDay = tonumber((os.date)("!%Y%m%d", (ServerGameTimer.GetServerTimeForecast)() // 1000))
      if lastDiableNoticeTime < nowDay then
        (((CS.UnityEngine).PlayerPrefs).SetInt)(lastDiableNoticeTimeKey, 0)
      else
        ;
        (NoticeManager.SetAutoPopup)(false)
        ;
        (NoticeManager.RequestInGameNoticeVersionFromLocal)()
        ;
        (NoticeManager.CheckNewInGameNotice)()
      end
    end
  end
  do
    if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Notice) and (NoticeManager.NeedAutoPopup)() then
      (NoticeManager.SetAutoPopup)(false)
      ;
      (DialogManager.CreateSingletonDialog)("notice.noticedialog")
      ;
      (LuaNotificationCenter.AddObserver)(State, function(observer, notification)
    -- function num : 0_0_0 , upvalues : controller
    if (notification.userInfo)._dialogName == "notice.noticedialog" then
      (controller._baseMainFSM):SetBoolean("noticeBegin", false)
      ;
      (controller._baseMainFSM):SetBoolean("autoPopUpGift", true)
    end
  end
, Common.n_DialogWillDestroy, nil)
      ;
      (controller._baseMainFSM):SetBoolean("haveFSMHandleOrMainCityGuide", true)
    else
      ;
      (controller._baseMainFSM):SetBoolean("noticeBegin", false)
      ;
      (controller._baseMainFSM):SetBoolean("autoPopUpGift", true)
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "Notice Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

return State


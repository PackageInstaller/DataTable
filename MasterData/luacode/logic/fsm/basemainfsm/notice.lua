local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "Notice Enter")
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Notice) then
    local lastDiableNoticeTimeKey = tostring(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid) .. "_lastDiableNoticeTime"
    local lastDiableNoticeTime = CS.UnityEngine.PlayerPrefs.GetInt(lastDiableNoticeTimeKey, 0)
    if lastDiableNoticeTime ~= 0 then
      local nowDay = tonumber(os.date("!%Y%m%d", ServerGameTimer.GetServerTimeForecast() // 1000))
      if lastDiableNoticeTime < nowDay then
        CS.UnityEngine.PlayerPrefs.SetInt(lastDiableNoticeTimeKey, 0)
      else
        NoticeManager.SetAutoPopup(false)
        NoticeManager.RequestInGameNoticeVersionFromLocal()
        NoticeManager.CheckNewInGameNotice()
      end
    end
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Notice) and NoticeManager.NeedAutoPopup() then
    NoticeManager.SetAutoPopup(false)
    DialogManager.CreateSingletonDialog("notice.noticedialog")
    LuaNotificationCenter.AddObserver(State, function(observer, notification)
      if notification.userInfo._dialogName == "notice.noticedialog" then
        controller._baseMainFSM:SetBoolean("noticeBegin", false)
        controller._baseMainFSM:SetBoolean("autoPopUpGift", true)
      end
    end, Common.n_DialogWillDestroy, nil)
    controller._baseMainFSM:SetBoolean("haveFSMHandleOrMainCityGuide", true)
  else
    controller._baseMainFSM:SetBoolean("noticeBegin", false)
    controller._baseMainFSM:SetBoolean("autoPopUpGift", true)
  end
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "Notice Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

return State

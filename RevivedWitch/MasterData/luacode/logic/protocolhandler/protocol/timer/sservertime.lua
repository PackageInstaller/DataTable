-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/timer/sservertime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNotice = (BeanManager.GetTableByName)("notice.cnotice")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, CNotice
  (ServerGameTimer.OnServerUpdate)(protocol)
  local mailDialog = (DialogManager.GetDialog)("mail.maildialog")
  if mailDialog then
    ((NekoData.DataManager).DM_Mail):OnRefreshMailExpiryDate()
  end
  local needEveryDayLoginNotification = ((NekoData.BehaviorManager).BM_Game):GetIfNeedEveryDayLoginNotification()
  if needEveryDayLoginNotification then
    local spiritNoticeRecorder = CNotice:GetRecorder(1)
    local timeTable = (os.date)("*t", (os.time)())
    if ((NekoData.BehaviorManager).BM_Game):GetTodayLoginTag() then
      if timeTable.hour < 4 then
        ((NekoData.DataManager).DM_Game):SetTodayLoginTag(false)
        LogInfo("sservertime", "CancelSchedulingWorkerByType(\'everydaylogin\')")
        ;
        ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("everydaylogin")
        local lastTime = ((12 - timeTable.hour - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
        LogInfoFormat("sservertime", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
        ;
        ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
      end
      do
        if timeTable.hour > 12 then
          ((NekoData.DataManager).DM_Game):SetTodayLoginTag(false)
          LogInfo("sservertime", "CancelSchedulingWorkerByType(\'everydaylogin\')")
          ;
          ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("everydaylogin")
          local lastTime = ((24 - timeTable.hour + 12 - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
          LogInfoFormat("sservertime", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
          ;
          ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
        end
        do
          if timeTable.hour >= 4 and timeTable.hour <= 12 then
            ((NekoData.DataManager).DM_Game):SetTodayLoginTag(true)
            LogInfo("sservertime", "CancelSchedulingWorkerByType(\'everydaylogin\')")
            ;
            ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("everydaylogin")
            local lastTime = ((24 - timeTable.hour + 12 - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
            LogInfoFormat("sservertime", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
            ;
            ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
          end
          do
            ;
            (LuaNotificationCenter.PostNotification)(Common.n_SServerTimeReached, nil, nil)
          end
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


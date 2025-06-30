-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/messagetabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNotice = (BeanManager.GetTableByName)("notice.cnotice")
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local SchedulingPushStaticFunctions = ((CS.PixelNeko).Lua).SchedulingPushStaticFunctions
local MessageTabCell = class("MessageTabCell", Dialog)
MessageTabCell.AssetBundleName = "ui/layouts.setting"
MessageTabCell.AssetName = "SettingMessage"
MessageTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MessageTabCell
  ((MessageTabCell.super).Ctor)(self, ...)
end

MessageTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._everyDayLoginBtn = self:GetChild("Login/SwitchBtn")
  self._spiritBtn = self:GetChild("Spirit/SwitchBtn")
  self._activityExploreBtn = self:GetChild("ActivityExplore/SwitchBtn")
  ;
  (self._everyDayLoginBtn):Subscribe_PointerClickEvent(self.OnEveryDayLoginBtnClicked, self)
  ;
  (self._spiritBtn):Subscribe_PointerClickEvent(self.OnSpiritBtnClicked, self)
  ;
  (self._activityExploreBtn):Subscribe_PointerClickEvent(self.OnActivityExploreBtnClicked, self)
  ;
  (self._everyDayLoginBtn):SetSelected(not ((NekoData.BehaviorManager).BM_Game):GetIfNeedEveryDayLoginNotification())
  ;
  (self._spiritBtn):SetSelected(not ((NekoData.BehaviorManager).BM_Game):GetIfNeedSpriteFullNotification())
  ;
  (self._activityExploreBtn):SetSelected(not ((NekoData.BehaviorManager).BM_Game):GetIfNeedActivityExploreNotification())
end

MessageTabCell.OnDestroy = function(self)
  -- function num : 0_2
end

local SchedulingEveryDayLoginWorker = function()
  -- function num : 0_3 , upvalues : CNotice, _ENV, SchedulingPushStaticFunctions
  local spiritNoticeRecorder = CNotice:GetRecorder(1)
  local timeTable = (os.date)("*t", (os.time)())
  if timeTable.hour < 4 then
    ((NekoData.DataManager).DM_Game):SetTodayLoginTag(false)
    LogInfo("MessageTabCell", "CancelSchedulingWorkerByType(\'everydaylogin\')")
    ;
    (SchedulingPushStaticFunctions.CancelSchedulingWorkerByType)("everydaylogin")
    local lastTime = ((12 - timeTable.hour - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
    LogInfoFormat("MessageTabCell", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
    ;
    (SchedulingPushStaticFunctions.SetPushNotification)(spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
  else
    do
      if timeTable.hour > 12 then
        ((NekoData.DataManager).DM_Game):SetTodayLoginTag(false)
      else
        ;
        ((NekoData.DataManager).DM_Game):SetTodayLoginTag(true)
      end
      LogInfo("MessageTabCell", "CancelSchedulingWorkerByType(\'everydaylogin\')")
      ;
      (SchedulingPushStaticFunctions.CancelSchedulingWorkerByType)("everydaylogin")
      local lastTime = ((24 - timeTable.hour + 12 - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
      LogInfoFormat("MessageTabCell", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
      ;
      (SchedulingPushStaticFunctions.SetPushNotification)(spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
    end
  end
end

MessageTabCell.OnEveryDayLoginBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, SchedulingPushStaticFunctions, SchedulingEveryDayLoginWorker
  local key = (((NekoData.DataManager).DM_Game).LocalSystemConfigType).EveryDayLogin
  local value = 1
  if (self._everyDayLoginBtn):IsSelected() then
    if not ((NekoData.BehaviorManager).BM_Game):GetIfHaveAskForNotificationPermission() then
      if not (SchedulingPushStaticFunctions.AreNotificationsEnabled)() then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(109, nil, function()
    -- function num : 0_4_0 , upvalues : _ENV, SchedulingPushStaticFunctions, SchedulingEveryDayLoginWorker, self, key
    local value = 0
    ;
    ((NekoData.DataManager).DM_Game):SetIfHaveAskForNotificationPermission(1)
    ;
    (SchedulingPushStaticFunctions.OpenTheNotificationSettingUI)()
    SchedulingEveryDayLoginWorker()
    ;
    (self._everyDayLoginBtn):SetSelected(value == 1)
    ;
    ((NekoData.DataManager).DM_Game):SetLocalSystemConfig({[key] = value})
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, {}, nil, {})
        return 
      else
        value = 0
      end
    else
      value = 0
    end
    if value == 0 then
      SchedulingEveryDayLoginWorker()
    end
  else
    LogInfo("MessageTabCell", "CancelSchedulingWorkerByType(\'everydaylogin\')")
    ;
    (SchedulingPushStaticFunctions.CancelSchedulingWorkerByType)("everydaylogin")
  end
  ;
  (self._everyDayLoginBtn):SetSelected(value == 1)
  ;
  ((NekoData.DataManager).DM_Game):SetLocalSystemConfig({[key] = value})
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local SchedulingSpiritFullWorker = function()
  -- function num : 0_5 , upvalues : CNotice, _ENV, CSpirit, SchedulingPushStaticFunctions
  local spiritNoticeRecorder = CNotice:GetRecorder(2)
  local deltaSpirit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit - ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  local lastTime = deltaSpirit * (CSpirit:GetRecorder(1)).time
  if lastTime > 0 then
    (SchedulingPushStaticFunctions.CancelSchedulingWorkerByType)("spirit")
    LogInfoFormat("MessageTabCell", "open the notification : scheduling spirit full worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "spirit", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
    ;
    (SchedulingPushStaticFunctions.SetPushNotification)(spiritNoticeRecorder.id, "spirit", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
  end
end

MessageTabCell.OnSpiritBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV, SchedulingPushStaticFunctions, SchedulingSpiritFullWorker
  local key = (((NekoData.DataManager).DM_Game).LocalSystemConfigType).SpriteFull
  local value = 1
  if (self._spiritBtn):IsSelected() then
    if not ((NekoData.BehaviorManager).BM_Game):GetIfHaveAskForNotificationPermission() then
      if not (SchedulingPushStaticFunctions.AreNotificationsEnabled)() then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(109, nil, function()
    -- function num : 0_6_0 , upvalues : _ENV, SchedulingPushStaticFunctions, SchedulingSpiritFullWorker, self, key
    local value = 0
    ;
    ((NekoData.DataManager).DM_Game):SetIfHaveAskForNotificationPermission(1)
    ;
    (SchedulingPushStaticFunctions.OpenTheNotificationSettingUI)()
    SchedulingSpiritFullWorker()
    ;
    (self._spiritBtn):SetSelected(value == 1)
    ;
    ((NekoData.DataManager).DM_Game):SetLocalSystemConfig({[key] = value})
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, {}, nil, {})
        return 
      else
        value = 0
      end
    else
      value = 0
    end
    if value == 0 then
      SchedulingSpiritFullWorker()
    end
  else
    LogInfo("MessageTabCell", "CancelSchedulingWorkerByType(\'spirit\')")
    ;
    (SchedulingPushStaticFunctions.CancelSchedulingWorkerByType)("spirit")
  end
  ;
  (self._spiritBtn):SetSelected(value == 1)
  ;
  ((NekoData.DataManager).DM_Game):SetLocalSystemConfig({[key] = value})
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local SchedulingActivityExploreWorker = function(slots)
  -- function num : 0_7 , upvalues : CNotice, _ENV, SlotStateEnum, SchedulingPushStaticFunctions
  local spiritNoticeRecorder = CNotice:GetRecorder(3)
  for i,slot in ipairs(slots) do
    local canTimerWorker = slot.taskState ~= SlotStateEnum.LOCK and slot.cavernId ~= 0 and slot.taskState ~= SlotStateEnum.UNLOCKING and slot.taskState ~= SlotStateEnum.DEADLINE and slot.finishLeftTime > 0
    if canTimerWorker then
      LogInfoFormat("MessageTabCell", "open the notification : scheduling activity explore worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "slot" .. tostring(slot.slotId), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000)
      ;
      (SchedulingPushStaticFunctions.SetPushNotification)(spiritNoticeRecorder.id, "slot" .. tostring(slot.slotId), (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), slot.finishLeftTime / 1000, (TextManager.GetText)(spiritNoticeRecorder.titleID))
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MessageTabCell.OnActivityExploreBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, SchedulingPushStaticFunctions, SchedulingActivityExploreWorker
  local key = (((NekoData.DataManager).DM_Game).LocalSystemConfigType).ActivityExplore
  local value = 1
  local slots = ((NekoData.BehaviorManager).BM_Explore):GetSlotsInfo()
  if (self._activityExploreBtn):IsSelected() then
    if not ((NekoData.BehaviorManager).BM_Game):GetIfHaveAskForNotificationPermission() then
      if not (SchedulingPushStaticFunctions.AreNotificationsEnabled)() then
        ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(109, nil, function()
    -- function num : 0_8_0 , upvalues : _ENV, SchedulingPushStaticFunctions, SchedulingActivityExploreWorker, slots, self, key
    local value = 0
    ;
    ((NekoData.DataManager).DM_Game):SetIfHaveAskForNotificationPermission(1)
    ;
    (SchedulingPushStaticFunctions.OpenTheNotificationSettingUI)()
    SchedulingActivityExploreWorker(slots)
    ;
    (self._activityExploreBtn):SetSelected(value == 1)
    ;
    ((NekoData.DataManager).DM_Game):SetLocalSystemConfig({[key] = value})
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, {}, nil, {})
        return 
      else
        value = 0
      end
    else
      value = 0
    end
    if value == 0 then
      SchedulingActivityExploreWorker(slots)
    end
  else
    for i,slot in ipairs(slots) do
      LogInfo("MessageTabCell", "CancelSchedulingWorkerByType(\'slot\' .. tostring(slot.slotId))")
      ;
      (SchedulingPushStaticFunctions.CancelSchedulingWorkerByType)("slot" .. tostring(slot.slotId))
    end
  end
  do
    ;
    (self._activityExploreBtn):SetSelected(value == 1)
    ;
    ((NekoData.DataManager).DM_Game):SetLocalSystemConfig({[key] = value})
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

return MessageTabCell


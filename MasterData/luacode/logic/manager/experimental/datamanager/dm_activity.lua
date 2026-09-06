local CBannerAndEntrance = BeanManager.GetTableByName("activity.cbannerandentrance")
local DM_Activity = class("DM_Activity")

function DM_Activity:Ctor()
  self._activities = NekoData.Data.activities
  self._managers = {
    [1] = require("logic.manager.experimental.datamanager.activity.dm_spiritdiscount").Create(),
    [2] = require("logic.manager.experimental.datamanager.activity.dm_agcoin").Create(),
    [3] = require("logic.manager.experimental.datamanager.activity.dm_sign").Create(),
    [4] = require("logic.manager.experimental.datamanager.activity.dm_starmirage").Create(),
    [5] = require("logic.manager.experimental.datamanager.activity.dm_puzzle").Create(),
    [6] = require("logic.manager.experimental.datamanager.activity.dm_summeractivity").Create(),
    [8] = require("logic.manager.experimental.datamanager.activity.dm_halloween").Create(),
    [9] = require("logic.manager.experimental.datamanager.activity.dm_doubleeleven").Create(),
    [10] = require("logic.manager.experimental.datamanager.activity.dm_christmas").Create(),
    [11] = require("logic.manager.experimental.datamanager.activity.dm_birthday").Create(),
    [12] = require("logic.manager.experimental.datamanager.activity.dm_christmascall").Create(),
    [13] = require("logic.manager.experimental.datamanager.activity.dm_springfestival").Create(),
    [14] = require("logic.manager.experimental.datamanager.activity.dm_lover").Create(),
    [15] = require("logic.manager.experimental.datamanager.activity.dm_aprilfoolsday").Create(),
    [16] = require("logic.manager.experimental.datamanager.activity.dm_children").Create(),
    [17] = require("logic.manager.experimental.datamanager.activity.dm_dragonboatfestival").Create(),
    [18] = require("logic.manager.experimental.datamanager.activity.dm_giftoftime").Create(),
    [19] = require("logic.manager.experimental.datamanager.activity.dm_giftoftimepuzzle").Create(),
    [20] = require("logic.manager.experimental.datamanager.activity.dm_giftoftimemaze").Create(),
    [21] = require("logic.manager.experimental.datamanager.activity.dm_summerechoesactivity").Create()
  }
  self._activities.bannerWillOpen = {}
  self._activities.banner = {}
  self._activities.entranceWillOpen = {}
  self._activities.entrance = {}
  self._activities.share = {}
  self._activities.redDot = {}
  self._activities.typeMap = {}
  local allIds = CBannerAndEntrance:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CBannerAndEntrance:GetRecorder(allIds[i])
    if not self._activities.typeMap[record.bannerfunction] then
      self._activities.typeMap[record.bannerfunction] = {}
    end
    table.insert(self._activities.typeMap[record.bannerfunction], record)
  end
  self._activities.others = {}
  self._activities.popTips = {}
  self._activities.whiteValentine = nil
  self._activities.timer = {}
  self._activities.popUpGift = {firstOpenActivityId = nil, data = nil}
  self._activities.popUpGift7Day = nil
  self._activities.dailySupplyMap = {}
  self._activities.accumulateRewardMap = {}
  self._timeCheck = 1
  self._timeCount = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_Activity:Clear()
  for _, v in pairs(self._managers) do
    v:Clear()
  end
  self._activities.time = {}
  self._activities.shatteredZonesClearReward = nil
  self._activities.arenaSeasonId = nil
  self._activities.arenaId = nil
  self._activities.arenaCamp = nil
  self._activities.exchangeTimes = nil
  self._activities.arenaEndDay = nil
  self._activities.arenaReceiveAward = nil
  for k, v in pairs(self._activities.bannerWillOpen) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.bannerWillOpen[k] = nil
  end
  for k, v in pairs(self._activities.banner) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.banner[k] = nil
  end
  for k, v in pairs(self._activities.entranceWillOpen) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.entranceWillOpen[k] = nil
  end
  for k, v in pairs(self._activities.entrance) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.entrance[k] = nil
  end
  if self._activities.share then
    for k, _ in pairs(self._activities.share) do
      self._activities.share[k] = nil
    end
  end
  self._activities.redDot = {}
  for k, v in pairs(self._activities.others) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.others[k] = nil
  end
  self._activities.popTips = {}
  self._activities.midAutumnInfo = nil
  self._activities.whiteValentine = nil
  self._activities.floweract = nil
  for type, timerId in pairs(self._activities.timer) do
    GameTimer.RemoveTask(timerId)
    self._activities.timer[type] = nil
  end
  self._activities.popUpGift = {firstOpenActivityId = nil, data = nil}
  self._activities.popUpGift7Day = nil
  for k, v in pairs(self._activities.dailySupplyMap) do
    self._activities.dailySupplyMap[k] = nil
  end
  for k, v in pairs(self._activities.accumulateRewardMap) do
    self._activities.accumulateRewardMap[k] = nil
  end
end

function DM_Activity:GetManager(id)
  return self._managers[id]
end

function DM_Activity:OnActivityStart(id, time)
  self._activities.time[id] = time
  LuaNotificationCenter.PostNotification(NekoData.Events.Activity.n_ActivityStart, self, id)
end

function DM_Activity:OnActivityStop(id)
  self._activities.time[id] = nil
end

function DM_Activity:OnSGetShatteredZonesClear(data)
  self._activities.shatteredZonesClearReward = data
end

function DM_Activity:ClearShatteredZonesClearReward()
  self._activities.shatteredZonesClearReward = nil
end

function DM_Activity:SetArenaSeasonId(id)
  self._activities.arenaSeasonId = id
end

function DM_Activity:SetArenaId(id)
  self._activities.arenaId = id
end

function DM_Activity:SetArenaCamp(camp)
  self._activities.arenaCamp = camp
end

function DM_Activity:SetKeyExchangeTimes(times)
  self._activities.exchangeTimes = times
end

function DM_Activity:SetArenaEndDay(day)
  self._activities.arenaEndDay = day
end

function DM_Activity:OnSArenaReceiveAward(items)
  self._activities.arenaReceiveAward = items
end

function DM_Activity:ClearArenaReceiveAward(items)
  self._activities.arenaReceiveAward = nil
end

function DM_Activity:OnSActiveBanners(protocol)
  for k, v in pairs(self._activities.bannerWillOpen) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.bannerWillOpen[k] = nil
  end
  for k, v in pairs(self._activities.banner) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.banner[k] = nil
  end
  for k, v in pairs(protocol.activities) do
    local record = CBannerAndEntrance:GetRecorder(k)
    if record then
      if v.leftActiveTime == -2 then
        if not self._activities.bannerWillOpen[k] then
          self._activities.bannerWillOpen[k] = {}
        end
        local map = self._activities.bannerWillOpen[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.startTime = v.leftStartTime
        map.canJump = v.ifJumpActive == 1
        map.gameTimerID = GameTimer.AddTask(math.ceil(map.startTime / 1000), 0, function()
          local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.cactiveactivities")
          protocolSend:Send()
        end)
      else
        if not self._activities.banner[k] then
          self._activities.banner[k] = {}
        end
        local map = self._activities.banner[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.leftTime = v.leftActiveTime
        map.canJump = v.ifJumpActive == 1
        if 0 < map.leftTime then
          map.gameTimerID = GameTimer.AddTask(math.ceil(map.leftTime / 1000), 0, function()
            local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.cactiveactivities")
            protocolSend:Send()
          end)
        end
      end
    else
      LogErrorFormat("DM_Activity:OnSActiveBanners", "bannerAndEntrance with id %s is not exist in cbannerandentrance", k)
    end
  end
  self:CheckActivityTips()
end

function DM_Activity:OnSActiveActivities(protocol)
  for k, v in pairs(self._activities.entranceWillOpen) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.entranceWillOpen[k] = nil
  end
  for k, v in pairs(self._activities.entrance) do
    if v.gameTimerID then
      GameTimer.RemoveTask(v.gameTimerID)
      v.gameTimerID = nil
    end
    self._activities.entrance[k] = nil
  end
  for k, v in pairs(protocol.activities) do
    local record = CBannerAndEntrance:GetRecorder(k)
    if record then
      if v.leftActiveTime == -2 then
        if not self._activities.entranceWillOpen[k] then
          self._activities.entranceWillOpen[k] = {}
        end
        local map = self._activities.entranceWillOpen[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.startTime = v.leftStartTime
        map.canJump = v.ifJumpActive == 1
        if map.startTime > 0 then
          map.gameTimerID = GameTimer.AddTask(math.ceil(map.startTime / 1000), 0, function()
            local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.cactiveactivities")
            protocolSend:Send()
          end)
        end
      else
        if not self._activities.entrance[k] then
          self._activities.entrance[k] = {}
        end
        local map = self._activities.entrance[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.leftTime = v.leftActiveTime
        map.canJump = v.ifJumpActive == 1
        if 0 < map.leftTime then
          map.gameTimerID = GameTimer.AddTask(math.ceil(map.leftTime / 1000), 0, function()
            local protocolSend = LuaNetManager.CreateProtocol("protocol.activity.cactiveactivities")
            protocolSend:Send()
          end)
        end
      end
    else
      LogErrorFormat("DM_Activity:OnSActiveActivities", "bannerAndEntrance with id %s is not exist in cbannerandentrance", k)
    end
  end
  self:CheckActivityTips()
end

function DM_Activity:CheckActivityTips()
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(1) and NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.StarMirageUnlock) then
    NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.StarMirageUnlock)
  end
  local list = self._activities.typeMap[9]
  for _, bannerRecord in ipairs(list) do
    local localTipsKey = "OpenMidAutumnDialog_" .. bannerRecord.eventid
    if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(bannerRecord.id) then
      if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips[localTipsKey]) then
        NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips[localTipsKey])
      end
    else
      local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips[localTipsKey].Tag, DataCommon.LocalTips[localTipsKey].Default)
      if value == DataCommon.LocalTips[localTipsKey].Default then
        CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips[localTipsKey].Tag, DataCommon.LocalTips[localTipsKey].New)
      end
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenByType(10) then
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenPuzzleDialog) then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenPuzzleDialog.Tag, DataCommon.LocalTips.OpenPuzzleDialog.Default)
    end
  else
    local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenPuzzleDialog.Tag, DataCommon.LocalTips.OpenPuzzleDialog.Default)
    if value == DataCommon.LocalTips.OpenPuzzleDialog.Default then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenPuzzleDialog.Tag, DataCommon.LocalTips.OpenPuzzleDialog.New)
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(41) then
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenHalloweenDialog) then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenHalloweenDialog)
    end
  else
    local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenHalloweenDialog.Tag, DataCommon.LocalTips.OpenHalloweenDialog.Default)
    if value == DataCommon.LocalTips.OpenHalloweenDialog.Default then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenHalloweenDialog.Tag, DataCommon.LocalTips.OpenHalloweenDialog.New)
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(56) then
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenBirthDayDialog) then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenBirthDayDialog)
    end
  else
    local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenBirthDayDialog.Tag, DataCommon.LocalTips.OpenBirthDayDialog.Default)
    if value == DataCommon.LocalTips.OpenBirthDayDialog.Default then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenBirthDayDialog.Tag, DataCommon.LocalTips.OpenBirthDayDialog.New)
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(48) then
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.ChristmasCallActivityUnlock) then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.ChristmasCallActivityUnlock)
    end
  else
    local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.ChristmasCallActivityUnlock.Tag, DataCommon.LocalTips.ChristmasCallActivityUnlock.Default)
    if value == DataCommon.LocalTips.OpenBirthDayDialog.Default then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.ChristmasCallActivityUnlock.Tag, DataCommon.LocalTips.ChristmasCallActivityUnlock.New)
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(85) then
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenAprilFoolsDayDialog) then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenAprilFoolsDayDialog)
    end
  else
    local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenAprilFoolsDayDialog.Tag, DataCommon.LocalTips.OpenAprilFoolsDayDialog.Default)
    if value == DataCommon.LocalTips.OpenAprilFoolsDayDialog.Default then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenAprilFoolsDayDialog.Tag, DataCommon.LocalTips.OpenAprilFoolsDayDialog.New)
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(100) then
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenChildrenDialog) then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenChildrenDialog)
    end
  else
    local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenChildrenDialog.Tag, DataCommon.LocalTips.OpenChildrenDialog.Default)
    if value == DataCommon.LocalTips.OpenChildrenDialog.Default then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenChildrenDialog.Tag, DataCommon.LocalTips.OpenChildrenDialog.New)
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(104) then
    if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenDragonBoatFestivalDialog) then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenDragonBoatFestivalDialog)
    end
  else
    local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenDragonBoatFestivalDialog.Tag, DataCommon.LocalTips.OpenDragonBoatFestivalDialog.Default)
    if value == DataCommon.LocalTips.OpenDragonBoatFestivalDialog.Default then
      CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.OpenDragonBoatFestivalDialog.Tag, DataCommon.LocalTips.OpenDragonBoatFestivalDialog.New)
    end
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(125) and NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.Anniversary) then
    NekoData.BehaviorManager.BM_Game:ClearLocalTipsState(DataCommon.LocalTips.Anniversary)
  end
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(157) and NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.StarMirageCopy) then
    NekoData.BehaviorManager.BM_Game:ClearLocalTipsState(DataCommon.LocalTips.StarMirageCopy)
  end
end

function DM_Activity:OnSShareActivity(protocol)
  self._activities.share = protocol.share
  for k, v in pairs(protocol.share) do
  end
end

function DM_Activity:CleanActivityById(aid)
  for k, v in pairs(self._activities.entrance) do
    if v.id == aid then
      self._activities.entrance[k] = nil
      break
    end
  end
  for k, v in pairs(self._activities.banner) do
    if v.id == aid then
      self._activities.banner[k] = nil
      break
    end
  end
  for k, v in pairs(self._activities.others) do
    if v.id == aid then
      self._activities.others[k] = nil
      break
    end
  end
end

function DM_Activity:UpdateInviteRedDot(protocol)
  if self._activities.redDot[9] == nil then
    self._activities.redDot[9] = {false, false}
  end
  for _, v in pairs(protocol.redpoint) do
    self._activities.redDot[9][v] = true
  end
end

function DM_Activity:ClearInviteRedDot(redId)
  self._activities.redDot[9][redId] = false
end

function DM_Activity:RemoveTimer(type)
  local timerId = self._activities.timer[type]
  if timerId then
    GameTimer.RemoveTask(timerId)
    self._activities.timer[type] = nil
  end
end

function DM_Activity:OnSGetMidAutumnInfo(protocol)
  self._activities.midAutumnInfo = protocol
  self:RemoveTimer("MidAutumn")
  if self._activities.midAutumnInfo.leftTime > 0 then
    self._activities.timer.MidAutumn = GameTimer.AddTask(self._activities.midAutumnInfo.leftTime / 1000, -1, function()
      local activityId = NekoData.behaviormanager.BM_Activity:GetMidAutumnActivityId()
      if activityId then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cacttimerefresh")
        protocol.activityId = activityId
        protocol:Send()
      else
        LogError("DM_Activity:OnSGetMidAutumnInfo data error.")
      end
    end)
  end
end

function DM_Activity:OnSLightActivityRedPoint(protocol)
  self._redPointActivityID = protocol.activity
end

function DM_Activity:OnSRefreshActTime(protocol)
  local activityId = protocol.activityId
  local leftTime = protocol.leftTime
  self._activities.others[activityId] = self._activities.others[activityId] or {}
  self._activities.others[activityId].isOpen = false
  if 0 < leftTime then
    self._activities.others[activityId].leftTime = leftTime
    self._activities.others[activityId].isOpen = true
    self._activities.others[activityId].gameTimerId = ServerGameTimer.AddTask(self._activities.others[activityId].leftTime / 1000, -1, function()
      self._activities.others[activityId].isOpen = false
      LuaNotificationCenter.PostNotification(Common.n_OthersActivitysTimeOver, nil, nil)
    end)
  end
  local TimerEnum = {
    [NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnWelfareSignAwardActivityId] = "ReturnWelfareSign",
    [DataCommon.Activities.AccumulateCost] = "AccumulateCost",
    [DataCommon.Activities.OldPlayerBenefits] = "OldPlayerBenefits",
    [NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnBattlePass] = "ReturnBattlePass",
    [DataCommon.Activities.MinDiscount] = "MinDiscount"
  }
  if TimerEnum[activityId] then
    self:RemoveTimer(TimerEnum[activityId])
    if activityId == DataCommon.Activities.MinDiscount and 0 < leftTime then
      self._activities.timer[TimerEnum[activityId]] = GameTimer.AddTask(leftTime / 1000, -1, function()
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cminidiscountactivityinfo")
        protocol:Send()
      end)
      return
    end
    if 0 < leftTime then
      self._activities.timer[TimerEnum[activityId]] = GameTimer.AddTask(leftTime / 1000, -1, function()
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cacttimerefresh")
        protocol.activityId = activityId
        protocol:Send()
      end)
    end
  end
end

function DM_Activity:OnSRefreshPopTips(protocol)
  self._activities.popTips[protocol.activityID] = self._activities.popTips[protocol.activityID] or {}
  self._activities.popTips[protocol.activityID].status = protocol.status
end

function DM_Activity:OnSBackTaskRedPoint()
  self._activities.redDot[NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType] = true
end

function DM_Activity:OnSBackGiftRedPoint()
  self._activities.redDot[NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode] = true
end

function DM_Activity:OnSSendWhiteValentineActivity(protocol)
  self._activities.whiteValentine = protocol
end

function DM_Activity:OnSReceiveWhiteValentineReward(protocol)
  self._activities.whiteValentine = nil
end

function DM_Activity:OnSAllowPopUpGift(protocol)
  local type = DataCommon.LocalCache.PopUpGiftAutoOpenActId
  local value = NekoData.BehaviorManager.BM_Game:GetLocalCache(type)
  if value ~= type.Default and value ~= protocol.activityID then
    NekoData.BehaviorManager.BM_Game:ClearLocalCache(DataCommon.LocalCache.PopUpGiftAutoOpenType)
    NekoData.BehaviorManager.BM_Game:SetLocalCache(type, protocol.activityID)
  end
  self._activities.popUpGift.firstOpenActivityId = protocol.activityID
end

function DM_Activity:OnSPopUpGift(protocol)
  if protocol.leftTime > 0 then
    self._activities.popUpGift.firstOpenActivityId = protocol.activityID
    self._activities.popUpGift.data = protocol
  else
    self._activities.popUpGift = {firstOpenActivityId = nil, data = nil}
    NekoData.BehaviorManager.BM_Game:ClearLocalCache(DataCommon.LocalCache.PopUpGiftAutoOpenType)
  end
end

function DM_Activity:OnUpdate(notification)
  if self._activities.popUpGift.data or next(self._activities.others) or self._activities.popUpGift7Day then
    self._timeCount = self._timeCount + notification.userInfo.unscaledDeltaTime
    if self._timeCount < self._timeCheck then
      return
    end
    local check = self._timeCheck
    if notification.userInfo.unscaledDeltaTime > self._timeCheck then
      check = math.ceil(self._timeCount)
    end
    self._timeCount = self._timeCount - check
    if self._activities.popUpGift.data and self._activities.popUpGift.data.leftTime >= 0 then
      self._activities.popUpGift.data.leftTime = self._activities.popUpGift.data.leftTime - check * 1000
      if self._activities.popUpGift.data.leftTime < 0 then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.callowpopupgift")
        protocol.activityID = self._activities.popUpGift.data.activityID
        protocol:Send()
      end
    end
    if self._activities.popUpGift7Day and self._activities.popUpGift7Day.leftTime >= 0 then
      self._activities.popUpGift7Day.leftTime = self._activities.popUpGift7Day.leftTime - check * 1000
      if self._activities.popUpGift7Day.leftTime < 0 then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cchecksevenpopgiftstatus")
        protocol:Send()
      end
    end
    for k, v in pairs(self._activities.others) do
      if v.isOpen and v.leftTime >= 0 then
        v.leftTime = v.leftTime - check * 1000
      end
    end
  end
end

function DM_Activity:OnSSevenDayPopGIft(protocol)
  if protocol.leftTime > 0 then
    self._activities.popUpGift7Day = protocol
    local activityId = NekoData.BehaviorManager.BM_Activity:GetPopUpGift7DayActivityId()
    local type = DataCommon.LocalCache.PopUpGift7DayAutoOpenActId
    local value = NekoData.BehaviorManager.BM_Game:GetLocalCache(type)
    if value == type.Default or value ~= type.Default and value ~= activityId then
      NekoData.BehaviorManager.BM_Game:ClearLocalCache(DataCommon.LocalCache.PopUpGift7DayAutoOpenType)
      NekoData.BehaviorManager.BM_Game:SetLocalCache(type, activityId)
    end
  else
    self._activities.popUpGift7Day = nil
    NekoData.BehaviorManager.BM_Game:ClearLocalCache(DataCommon.LocalCache.PopUpGift7DayAutoOpenType)
  end
end

function DM_Activity:SSevenPopGiftStatus(protocol)
  if protocol.leftTime <= 0 then
    self._activities.popUpGift7Day = nil
    NekoData.BehaviorManager.BM_Game:ClearLocalCache(DataCommon.LocalCache.PopUpGift7DayAutoOpenType)
  elseif self._activities.popUpGift7Day then
    self._activities.popUpGift7Day.leftTime = protocol.leftTime
  end
end

function DM_Activity:OnSActivityDailySupply(protocol)
  self._activities.dailySupplyMap[protocol.activityId] = protocol.supply
end

function DM_Activity:OnSGetPointsCollection(protocol)
  if not self._activities.accumulateRewardMap[protocol.activityID] then
    self._activities.accumulateRewardMap[protocol.activityID] = {}
  end
  if self._activities.accumulateRewardMap[protocol.activityID].accumulateRewardList then
    local tmp = self._activities.accumulateRewardMap[protocol.activityID].accumulateRewardList
    while tmp[#tmp] do
      table.remove(tmp, #tmp)
    end
  else
    self._activities.accumulateRewardMap[protocol.activityID].accumulateRewardList = {}
  end
  for i, v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_Activity", "-OnSGetPointsCollection- stageId = %s, status = %s ---", v.id, v.status)
    local data = {}
    data.stageId = v.id
    data.status = v.status
    table.insert(self._activities.accumulateRewardMap[protocol.activityID].accumulateRewardList, data)
  end
  if self._activities.accumulateRewardMap[protocol.activityID].accumulatePoints then
    local tmp = self._activities.accumulateRewardMap[protocol.activityID].accumulatePoints
    for k, v in pairs(tmp) do
      tmp[k] = nil
    end
  else
    self._activities.accumulateRewardMap[protocol.activityID].accumulatePoints = {}
  end
  for k, v in pairs(protocol.points) do
    self._activities.accumulateRewardMap[protocol.activityID].accumulatePoints[k] = v
    LogInfoFormat("DM_Activity", "-OnSGetPointsCollection- itemId = %s, num = %s ---", k, v)
  end
end

function DM_Activity:OnSRefreshPointsTasks(protocol)
  if not self._activities.accumulateRewardMap[protocol.activityID] then
    LogErrorFormat("DM_Activity", "No data is sent in the server protocol(srefreshpointstasks) by activityId(%s)", protocol.activityID)
    return
  end
  local tmp = self._activities.accumulateRewardMap[protocol.activityID].accumulateRewardList
  for i, v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_Activity", "-OnSRefreshPointsTasks- stageId = %s, status = %s ---", v.id, v.status)
    for _, data in pairs(tmp) do
      if v.id == data.stageId then
        data.status = v.status
      end
    end
  end
end

function DM_Activity:OnSFlowerActInfo(protocol)
  if protocol.actId > 0 then
    self._activities.floweract = protocol
  else
    self._activities.floweract = nil
    LuaNotificationCenter.PostNotification(Common.n_FlowerActivityEnd, nil, nil)
  end
end

return DM_Activity

-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_activity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBannerAndEntrance = (BeanManager.GetTableByName)("activity.cbannerandentrance")
local DM_Activity = class("DM_Activity")
DM_Activity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CBannerAndEntrance
  self._activities = (NekoData.Data).activities
  self._managers = {[1] = ((require("logic.manager.experimental.datamanager.activity.dm_spiritdiscount")).Create)(), [2] = ((require("logic.manager.experimental.datamanager.activity.dm_agcoin")).Create)(), [3] = ((require("logic.manager.experimental.datamanager.activity.dm_sign")).Create)(), [4] = ((require("logic.manager.experimental.datamanager.activity.dm_starmirage")).Create)(), [5] = ((require("logic.manager.experimental.datamanager.activity.dm_puzzle")).Create)(), [6] = ((require("logic.manager.experimental.datamanager.activity.dm_summeractivity")).Create)(), [8] = ((require("logic.manager.experimental.datamanager.activity.dm_halloween")).Create)(), [9] = ((require("logic.manager.experimental.datamanager.activity.dm_doubleeleven")).Create)(), [10] = ((require("logic.manager.experimental.datamanager.activity.dm_christmas")).Create)(), [11] = ((require("logic.manager.experimental.datamanager.activity.dm_birthday")).Create)(), [12] = ((require("logic.manager.experimental.datamanager.activity.dm_christmascall")).Create)(), [13] = ((require("logic.manager.experimental.datamanager.activity.dm_springfestival")).Create)(), [14] = ((require("logic.manager.experimental.datamanager.activity.dm_lover")).Create)(), [15] = ((require("logic.manager.experimental.datamanager.activity.dm_aprilfoolsday")).Create)(), [16] = ((require("logic.manager.experimental.datamanager.activity.dm_children")).Create)(), [17] = ((require("logic.manager.experimental.datamanager.activity.dm_dragonboatfestival")).Create)(), [18] = ((require("logic.manager.experimental.datamanager.activity.dm_giftoftime")).Create)(), [19] = ((require("logic.manager.experimental.datamanager.activity.dm_giftoftimepuzzle")).Create)(), [20] = ((require("logic.manager.experimental.datamanager.activity.dm_giftoftimemaze")).Create)(), [21] = ((require("logic.manager.experimental.datamanager.activity.dm_summerechoesactivity")).Create)()}
  -- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).bannerWillOpen = {}
  -- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).banner = {}
  -- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).entranceWillOpen = {}
  -- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).entrance = {}
  -- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).share = {}
  -- DECOMPILER ERROR at PC143: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).redDot = {}
  -- DECOMPILER ERROR at PC146: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).typeMap = {}
  local allIds = CBannerAndEntrance:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CBannerAndEntrance:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC169: Confused about usage of register: R8 in 'UnsetPending'

    if not ((self._activities).typeMap)[record.bannerfunction] then
      ((self._activities).typeMap)[record.bannerfunction] = {}
    end
    ;
    (table.insert)(((self._activities).typeMap)[record.bannerfunction], record)
  end
  -- DECOMPILER ERROR at PC181: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).others = {}
  -- DECOMPILER ERROR at PC184: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).popTips = {}
  -- DECOMPILER ERROR at PC186: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).whiteValentine = nil
  -- DECOMPILER ERROR at PC189: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).timer = {}
  -- DECOMPILER ERROR at PC194: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).popUpGift = {firstOpenActivityId = nil, data = nil}
  -- DECOMPILER ERROR at PC196: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).popUpGift7Day = nil
  -- DECOMPILER ERROR at PC199: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).dailySupplyMap = {}
  -- DECOMPILER ERROR at PC202: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._activities).accumulateRewardMap = {}
  self._timeCheck = 1
  self._timeCount = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_Activity.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs(self._managers) do
    v:Clear()
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).time = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).shatteredZonesClearReward = nil
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).arenaSeasonId = nil
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).arenaId = nil
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).arenaCamp = nil
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).exchangeTimes = nil
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).arenaEndDay = nil
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._activities).arenaReceiveAward = nil
  for k,v in pairs((self._activities).bannerWillOpen) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._activities).bannerWillOpen)[k] = nil
  end
  for k,v in pairs((self._activities).banner) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._activities).banner)[k] = nil
  end
  for k,v in pairs((self._activities).entranceWillOpen) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._activities).entranceWillOpen)[k] = nil
  end
  for k,v in pairs((self._activities).entrance) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self._activities).entrance)[k] = nil
  end
  if (self._activities).share then
    for k,_ in pairs((self._activities).share) do
      -- DECOMPILER ERROR at PC108: Confused about usage of register: R6 in 'UnsetPending'

      ((self._activities).share)[k] = nil
    end
  end
  do
    -- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._activities).redDot = {}
    for k,v in pairs((self._activities).others) do
      if v.gameTimerID then
        (GameTimer.RemoveTask)(v.gameTimerID)
        v.gameTimerID = nil
      end
      -- DECOMPILER ERROR at PC129: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._activities).others)[k] = nil
    end
    -- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._activities).popTips = {}
    -- DECOMPILER ERROR at PC136: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._activities).midAutumnInfo = nil
    -- DECOMPILER ERROR at PC138: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._activities).whiteValentine = nil
    for type,timerId in pairs((self._activities).timer) do
      (GameTimer.RemoveTask)(timerId)
      -- DECOMPILER ERROR at PC150: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self._activities).timer)[type] = nil
    end
    -- DECOMPILER ERROR at PC157: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._activities).popUpGift = {firstOpenActivityId = nil, data = nil}
    -- DECOMPILER ERROR at PC159: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._activities).popUpGift7Day = nil
    for k,v in pairs((self._activities).dailySupplyMap) do
      -- DECOMPILER ERROR at PC167: Confused about usage of register: R6 in 'UnsetPending'

      ((self._activities).dailySupplyMap)[k] = nil
    end
    for k,v in pairs((self._activities).accumulateRewardMap) do
      -- DECOMPILER ERROR at PC177: Confused about usage of register: R6 in 'UnsetPending'

      ((self._activities).accumulateRewardMap)[k] = nil
    end
  end
end

DM_Activity.GetManager = function(self, id)
  -- function num : 0_2
  return (self._managers)[id]
end

DM_Activity.OnActivityStart = function(self, id, time)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self._activities).time)[id] = time
  ;
  (LuaNotificationCenter.PostNotification)(((NekoData.Events).Activity).n_ActivityStart, self, id)
end

DM_Activity.OnActivityStop = function(self, id)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._activities).time)[id] = nil
end

DM_Activity.OnSGetShatteredZonesClear = function(self, data)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).shatteredZonesClearReward = data
end

DM_Activity.ClearShatteredZonesClearReward = function(self)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._activities).shatteredZonesClearReward = nil
end

DM_Activity.SetArenaSeasonId = function(self, id)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).arenaSeasonId = id
end

DM_Activity.SetArenaId = function(self, id)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).arenaId = id
end

DM_Activity.SetArenaCamp = function(self, camp)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).arenaCamp = camp
end

DM_Activity.SetKeyExchangeTimes = function(self, times)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).exchangeTimes = times
end

DM_Activity.SetArenaEndDay = function(self, day)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).arenaEndDay = day
end

DM_Activity.OnSArenaReceiveAward = function(self, items)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).arenaReceiveAward = items
end

DM_Activity.ClearArenaReceiveAward = function(self, items)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).arenaReceiveAward = nil
end

DM_Activity.OnSActiveBanners = function(self, protocol)
  -- function num : 0_14 , upvalues : _ENV, CBannerAndEntrance
  for k,v in pairs((self._activities).bannerWillOpen) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._activities).bannerWillOpen)[k] = nil
  end
  for k,v in pairs((self._activities).banner) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._activities).banner)[k] = nil
  end
  for k,v in pairs(protocol.activities) do
    local record = CBannerAndEntrance:GetRecorder(k)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

    if record then
      if v.leftActiveTime == -2 then
        if not ((self._activities).bannerWillOpen)[k] then
          ((self._activities).bannerWillOpen)[k] = {}
        end
        local map = ((self._activities).bannerWillOpen)[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.startTime = v.leftStartTime
        map.canJump = v.ifJumpActive == 1
        map.gameTimerID = (GameTimer.AddTask)((math.ceil)(map.startTime / 1000), 0, function()
    -- function num : 0_14_0 , upvalues : _ENV
    local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.cactiveactivities")
    protocolSend:Send()
  end
)
      else
        -- DECOMPILER ERROR at PC93: Confused about usage of register: R8 in 'UnsetPending'

        if not ((self._activities).banner)[k] then
          ((self._activities).banner)[k] = {}
        end
        local map = ((self._activities).banner)[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.leftTime = v.leftActiveTime
        map.canJump = v.ifJumpActive == 1
        if map.leftTime > 0 then
          map.gameTimerID = (GameTimer.AddTask)((math.ceil)(map.leftTime / 1000), 0, function()
    -- function num : 0_14_1 , upvalues : _ENV
    local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.cactiveactivities")
    protocolSend:Send()
  end
)
        end
      end
    else
      LogErrorFormat("DM_Activity:OnSActiveBanners", "bannerAndEntrance with id %s is not exist in cbannerandentrance", k)
    end
  end
  self:CheckActivityTips()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

DM_Activity.OnSActiveActivities = function(self, protocol)
  -- function num : 0_15 , upvalues : _ENV, CBannerAndEntrance
  for k,v in pairs((self._activities).entranceWillOpen) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._activities).entranceWillOpen)[k] = nil
  end
  for k,v in pairs((self._activities).entrance) do
    if v.gameTimerID then
      (GameTimer.RemoveTask)(v.gameTimerID)
      v.gameTimerID = nil
    end
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._activities).entrance)[k] = nil
  end
  for k,v in pairs(protocol.activities) do
    local record = CBannerAndEntrance:GetRecorder(k)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

    if record then
      if v.leftActiveTime == -2 then
        if not ((self._activities).entranceWillOpen)[k] then
          ((self._activities).entranceWillOpen)[k] = {}
        end
        local map = ((self._activities).entranceWillOpen)[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.startTime = v.leftStartTime
        map.canJump = v.ifJumpActive == 1
        if map.startTime > 0 then
          map.gameTimerID = (GameTimer.AddTask)((math.ceil)(map.startTime / 1000), 0, function()
    -- function num : 0_15_0 , upvalues : _ENV
    local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.cactiveactivities")
    protocolSend:Send()
  end
)
        end
      else
        -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

        if not ((self._activities).entrance)[k] then
          ((self._activities).entrance)[k] = {}
        end
        local map = ((self._activities).entrance)[k]
        map.id = k
        map.order = record.order
        map.record = record
        map.leftTime = v.leftActiveTime
        map.canJump = v.ifJumpActive == 1
        if map.leftTime > 0 then
          map.gameTimerID = (GameTimer.AddTask)((math.ceil)(map.leftTime / 1000), 0, function()
    -- function num : 0_15_1 , upvalues : _ENV
    local protocolSend = (LuaNetManager.CreateProtocol)("protocol.activity.cactiveactivities")
    protocolSend:Send()
  end
)
        end
      end
    else
      LogErrorFormat("DM_Activity:OnSActiveActivities", "bannerAndEntrance with id %s is not exist in cbannerandentrance", k)
    end
  end
  self:CheckActivityTips()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

DM_Activity.CheckActivityTips = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(1) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).StarMirageUnlock) then
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).StarMirageUnlock)
  end
  local list = ((self._activities).typeMap)[9]
  for _,bannerRecord in ipairs(list) do
    local localTipsKey = "OpenMidAutumnDialog_" .. bannerRecord.eventid
    if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(bannerRecord.id) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips)[localTipsKey]) then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips)[localTipsKey])
    end
    local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips)[localTipsKey]).Tag, ((DataCommon.LocalTips)[localTipsKey]).Default)
    if value == ((DataCommon.LocalTips)[localTipsKey]).Default then
      (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips)[localTipsKey]).Tag, ((DataCommon.LocalTips)[localTipsKey]).New)
    end
  end
  if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenByType(10) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenPuzzleDialog) then
    (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenPuzzleDialog).Tag, ((DataCommon.LocalTips).OpenPuzzleDialog).Default)
  end
  do
    local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenPuzzleDialog).Tag, ((DataCommon.LocalTips).OpenPuzzleDialog).Default)
    if value == ((DataCommon.LocalTips).OpenPuzzleDialog).Default then
      (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenPuzzleDialog).Tag, ((DataCommon.LocalTips).OpenPuzzleDialog).New)
    end
    if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(41) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenHalloweenDialog) then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenHalloweenDialog)
    end
    do
      local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenHalloweenDialog).Tag, ((DataCommon.LocalTips).OpenHalloweenDialog).Default)
      if value == ((DataCommon.LocalTips).OpenHalloweenDialog).Default then
        (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenHalloweenDialog).Tag, ((DataCommon.LocalTips).OpenHalloweenDialog).New)
      end
      if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(56) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenBirthDayDialog) then
        ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenBirthDayDialog)
      end
      do
        local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenBirthDayDialog).Tag, ((DataCommon.LocalTips).OpenBirthDayDialog).Default)
        if value == ((DataCommon.LocalTips).OpenBirthDayDialog).Default then
          (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenBirthDayDialog).Tag, ((DataCommon.LocalTips).OpenBirthDayDialog).New)
        end
        if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(48) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).ChristmasCallActivityUnlock) then
          ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).ChristmasCallActivityUnlock)
        end
        do
          local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).ChristmasCallActivityUnlock).Tag, ((DataCommon.LocalTips).ChristmasCallActivityUnlock).Default)
          if value == ((DataCommon.LocalTips).OpenBirthDayDialog).Default then
            (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).ChristmasCallActivityUnlock).Tag, ((DataCommon.LocalTips).ChristmasCallActivityUnlock).New)
          end
          if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(85) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenAprilFoolsDayDialog) then
            ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenAprilFoolsDayDialog)
          end
          do
            local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenAprilFoolsDayDialog).Tag, ((DataCommon.LocalTips).OpenAprilFoolsDayDialog).Default)
            if value == ((DataCommon.LocalTips).OpenAprilFoolsDayDialog).Default then
              (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenAprilFoolsDayDialog).Tag, ((DataCommon.LocalTips).OpenAprilFoolsDayDialog).New)
            end
            if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(100) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenChildrenDialog) then
              ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenChildrenDialog)
            end
            do
              local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenChildrenDialog).Tag, ((DataCommon.LocalTips).OpenChildrenDialog).Default)
              if value == ((DataCommon.LocalTips).OpenChildrenDialog).Default then
                (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenChildrenDialog).Tag, ((DataCommon.LocalTips).OpenChildrenDialog).New)
              end
              if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(104) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenDragonBoatFestivalDialog) then
                ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenDragonBoatFestivalDialog)
              end
              do
                local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenDragonBoatFestivalDialog).Tag, ((DataCommon.LocalTips).OpenDragonBoatFestivalDialog).Default)
                if value == ((DataCommon.LocalTips).OpenDragonBoatFestivalDialog).Default then
                  (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).OpenDragonBoatFestivalDialog).Tag, ((DataCommon.LocalTips).OpenDragonBoatFestivalDialog).New)
                end
                if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(125) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).Anniversary) then
                  ((NekoData.BehaviorManager).BM_Game):ClearLocalTipsState((DataCommon.LocalTips).Anniversary)
                end
                if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(157) and ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).StarMirageCopy) then
                  ((NekoData.BehaviorManager).BM_Game):ClearLocalTipsState((DataCommon.LocalTips).StarMirageCopy)
                end
              end
            end
          end
        end
      end
    end
  end
end

DM_Activity.OnSShareActivity = function(self, protocol)
  -- function num : 0_17 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).share = protocol.share
  for k,v in pairs(protocol.share) do
  end
end

DM_Activity.CleanActivityById = function(self, aid)
  -- function num : 0_18 , upvalues : _ENV
  for k,v in pairs((self._activities).entrance) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    if v.id == aid then
      ((self._activities).entrance)[k] = nil
      break
    end
  end
  do
    for k,v in pairs((self._activities).banner) do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

      if v.id == aid then
        ((self._activities).banner)[k] = nil
        break
      end
    end
    do
      for k,v in pairs((self._activities).others) do
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

        if v.id == aid then
          ((self._activities).others)[k] = nil
          break
        end
      end
    end
  end
end

DM_Activity.UpdateInviteRedDot = function(self, protocol)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if ((self._activities).redDot)[9] == nil then
    ((self._activities).redDot)[9] = {false, false}
  end
  for _,v in pairs(protocol.redpoint) do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

    (((self._activities).redDot)[9])[v] = true
  end
end

DM_Activity.ClearInviteRedDot = function(self, redId)
  -- function num : 0_20
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (((self._activities).redDot)[9])[redId] = false
end

DM_Activity.RemoveTimer = function(self, type)
  -- function num : 0_21 , upvalues : _ENV
  local timerId = ((self._activities).timer)[type]
  if timerId then
    (GameTimer.RemoveTask)(timerId)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self._activities).timer)[type] = nil
  end
end

DM_Activity.OnSGetMidAutumnInfo = function(self, protocol)
  -- function num : 0_22 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).midAutumnInfo = protocol
  self:RemoveTimer("MidAutumn")
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  if ((self._activities).midAutumnInfo).leftTime > 0 then
    ((self._activities).timer).MidAutumn = (GameTimer.AddTask)(((self._activities).midAutumnInfo).leftTime / 1000, -1, function()
    -- function num : 0_22_0 , upvalues : _ENV
    local activityId = ((NekoData.behaviormanager).BM_Activity):GetMidAutumnActivityId()
    if activityId then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cacttimerefresh")
      protocol.activityId = activityId
      protocol:Send()
    else
      do
        LogError("DM_Activity:OnSGetMidAutumnInfo data error.")
      end
    end
  end
)
  end
end

DM_Activity.OnSLightActivityRedPoint = function(self, protocol)
  -- function num : 0_23
  self._redPointActivityID = protocol.activity
end

DM_Activity.OnSRefreshActTime = function(self, protocol)
  -- function num : 0_24 , upvalues : _ENV
  local activityId = protocol.activityId
  local leftTime = protocol.leftTime
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  if not ((self._activities).others)[activityId] then
    ((self._activities).others)[activityId] = {}
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self._activities).others)[activityId]).isOpen = false
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    if leftTime > 0 then
      (((self._activities).others)[activityId]).leftTime = leftTime
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((self._activities).others)[activityId]).isOpen = true
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((self._activities).others)[activityId]).gameTimerId = (ServerGameTimer.AddTask)((((self._activities).others)[activityId]).leftTime / 1000, -1, function()
    -- function num : 0_24_0 , upvalues : self, activityId, _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    (((self._activities).others)[activityId]).isOpen = false
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OthersActivitysTimeOver, nil, nil)
  end
)
    end
    local TimerEnum = {[(((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnWelfareSignAwardActivityId] = "ReturnWelfareSign", [(DataCommon.Activities).AccumulateCost] = "AccumulateCost", [(DataCommon.Activities).OldPlayerBenefits] = "OldPlayerBenefits", [(((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnBattlePass] = "ReturnBattlePass", [(DataCommon.Activities).MinDiscount] = "MinDiscount"}
    if TimerEnum[activityId] then
      self:RemoveTimer(TimerEnum[activityId])
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

      if activityId == (DataCommon.Activities).MinDiscount and leftTime > 0 then
        ((self._activities).timer)[TimerEnum[activityId]] = (GameTimer.AddTask)(leftTime / 1000, -1, function()
    -- function num : 0_24_1 , upvalues : _ENV
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cminidiscountactivityinfo")
    protocol:Send()
  end
)
        return 
      end
      -- DECOMPILER ERROR at PC99: Confused about usage of register: R5 in 'UnsetPending'

      if leftTime > 0 then
        ((self._activities).timer)[TimerEnum[activityId]] = (GameTimer.AddTask)(leftTime / 1000, -1, function()
    -- function num : 0_24_2 , upvalues : _ENV, activityId
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cacttimerefresh")
    protocol.activityId = activityId
    protocol:Send()
  end
)
      end
    end
  end
end

DM_Activity.OnSRefreshPopTips = function(self, protocol)
  -- function num : 0_25
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not ((self._activities).popTips)[protocol.activityID] then
    ((self._activities).popTips)[protocol.activityID] = {}
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self._activities).popTips)[protocol.activityID]).status = protocol.status
  end
end

DM_Activity.OnSBackTaskRedPoint = function(self)
  -- function num : 0_26 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((self._activities).redDot)[((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType] = true
end

DM_Activity.OnSBackGiftRedPoint = function(self)
  -- function num : 0_27 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ((self._activities).redDot)[(((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode] = true
end

DM_Activity.OnSSendWhiteValentineActivity = function(self, protocol)
  -- function num : 0_28
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).whiteValentine = protocol
end

DM_Activity.OnSReceiveWhiteValentineReward = function(self, protocol)
  -- function num : 0_29
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._activities).whiteValentine = nil
end

DM_Activity.OnSAllowPopUpGift = function(self, protocol)
  -- function num : 0_30 , upvalues : _ENV
  local type = (DataCommon.LocalCache).PopUpGiftAutoOpenActId
  local value = ((NekoData.BehaviorManager).BM_Game):GetLocalCache(type)
  if value ~= type.Default and value ~= protocol.activityID then
    ((NekoData.BehaviorManager).BM_Game):ClearLocalCache((DataCommon.LocalCache).PopUpGiftAutoOpenType)
    ;
    ((NekoData.BehaviorManager).BM_Game):SetLocalCache(type, protocol.activityID)
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._activities).popUpGift).firstOpenActivityId = protocol.activityID
end

DM_Activity.OnSPopUpGift = function(self, protocol)
  -- function num : 0_31 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.leftTime > 0 then
    ((self._activities).popUpGift).firstOpenActivityId = protocol.activityID
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._activities).popUpGift).data = protocol
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._activities).popUpGift = {firstOpenActivityId = nil, data = nil}
    ;
    ((NekoData.BehaviorManager).BM_Game):ClearLocalCache((DataCommon.LocalCache).PopUpGiftAutoOpenType)
  end
end

DM_Activity.OnUpdate = function(self, notification)
  -- function num : 0_32 , upvalues : _ENV
  if ((self._activities).popUpGift).data or next((self._activities).others) or (self._activities).popUpGift7Day then
    self._timeCount = self._timeCount + (notification.userInfo).unscaledDeltaTime
    if self._timeCount < self._timeCheck then
      return 
    end
    local check = self._timeCheck
    if self._timeCheck < (notification.userInfo).unscaledDeltaTime then
      check = (math.ceil)(self._timeCount)
    end
    self._timeCount = self._timeCount - check
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

    if ((self._activities).popUpGift).data and (((self._activities).popUpGift).data).leftTime >= 0 then
      (((self._activities).popUpGift).data).leftTime = (((self._activities).popUpGift).data).leftTime - check * 1000
      if (((self._activities).popUpGift).data).leftTime < 0 then
        local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.callowpopupgift")
        protocol.activityID = (((self._activities).popUpGift).data).activityID
        protocol:Send()
      end
    end
    do
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R3 in 'UnsetPending'

      if (self._activities).popUpGift7Day and ((self._activities).popUpGift7Day).leftTime >= 0 then
        ((self._activities).popUpGift7Day).leftTime = ((self._activities).popUpGift7Day).leftTime - check * 1000
        if ((self._activities).popUpGift7Day).leftTime < 0 then
          local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cchecksevenpopgiftstatus")
          protocol:Send()
        end
      end
      do
        for k,v in pairs((self._activities).others) do
          if v.isOpen and v.leftTime >= 0 then
            v.leftTime = v.leftTime - check * 1000
          end
        end
      end
    end
  end
end

DM_Activity.OnSSevenDayPopGIft = function(self, protocol)
  -- function num : 0_33 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.leftTime > 0 then
    (self._activities).popUpGift7Day = protocol
    local activityId = ((NekoData.BehaviorManager).BM_Activity):GetPopUpGift7DayActivityId()
    local type = (DataCommon.LocalCache).PopUpGift7DayAutoOpenActId
    local value = ((NekoData.BehaviorManager).BM_Game):GetLocalCache(type)
    if value == type.Default or value ~= type.Default and value ~= activityId then
      ((NekoData.BehaviorManager).BM_Game):ClearLocalCache((DataCommon.LocalCache).PopUpGift7DayAutoOpenType)
      ;
      ((NekoData.BehaviorManager).BM_Game):SetLocalCache(type, activityId)
    end
  else
    do
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._activities).popUpGift7Day = nil
      ;
      ((NekoData.BehaviorManager).BM_Game):ClearLocalCache((DataCommon.LocalCache).PopUpGift7DayAutoOpenType)
    end
  end
end

DM_Activity.SSevenPopGiftStatus = function(self, protocol)
  -- function num : 0_34 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.leftTime <= 0 then
    (self._activities).popUpGift7Day = nil
    ;
    ((NekoData.BehaviorManager).BM_Game):ClearLocalCache((DataCommon.LocalCache).PopUpGift7DayAutoOpenType)
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    if (self._activities).popUpGift7Day then
      ((self._activities).popUpGift7Day).leftTime = protocol.leftTime
    end
  end
end

DM_Activity.OnSActivityDailySupply = function(self, protocol)
  -- function num : 0_35
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self._activities).dailySupplyMap)[protocol.activityId] = protocol.supply
end

DM_Activity.OnSGetPointsCollection = function(self, protocol)
  -- function num : 0_36 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not ((self._activities).accumulateRewardMap)[protocol.activityID] then
    ((self._activities).accumulateRewardMap)[protocol.activityID] = {}
  end
  if (((self._activities).accumulateRewardMap)[protocol.activityID]).accumulateRewardList then
    local tmp = (((self._activities).accumulateRewardMap)[protocol.activityID]).accumulateRewardList
    while tmp[#tmp] do
      (table.remove)(tmp, #tmp)
    end
  else
    do
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self._activities).accumulateRewardMap)[protocol.activityID]).accumulateRewardList = {}
      for i,v in ipairs(protocol.tasks) do
        LogInfoFormat("DM_Activity", "-OnSGetPointsCollection- stageId = %s, status = %s ---", v.id, v.status)
        local data = {}
        data.stageId = v.id
        data.status = v.status
        ;
        (table.insert)((((self._activities).accumulateRewardMap)[protocol.activityID]).accumulateRewardList, data)
      end
      if (((self._activities).accumulateRewardMap)[protocol.activityID]).accumulatePoints then
        local tmp = (((self._activities).accumulateRewardMap)[protocol.activityID]).accumulatePoints
        for k,v in pairs(tmp) do
          tmp[k] = nil
        end
      else
        do
          -- DECOMPILER ERROR at PC91: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (((self._activities).accumulateRewardMap)[protocol.activityID]).accumulatePoints = {}
          for k,v in pairs(protocol.points) do
            -- DECOMPILER ERROR at PC101: Confused about usage of register: R7 in 'UnsetPending'

            ((((self._activities).accumulateRewardMap)[protocol.activityID]).accumulatePoints)[k] = v
            LogInfoFormat("DM_Activity", "-OnSGetPointsCollection- itemId = %s, num = %s ---", R10_PC107, v)
          end
        end
      end
    end
  end
end

DM_Activity.OnSRefreshPointsTasks = function(self, protocol)
  -- function num : 0_37 , upvalues : _ENV
  if not ((self._activities).accumulateRewardMap)[protocol.activityID] then
    LogErrorFormat("DM_Activity", "No data is sent in the server protocol(srefreshpointstasks) by activityId(%s)", protocol.activityID)
    return 
  end
  local tmp = (((self._activities).accumulateRewardMap)[protocol.activityID]).accumulateRewardList
  for i,v in ipairs(protocol.tasks) do
    LogInfoFormat("DM_Activity", "-OnSRefreshPointsTasks- stageId = %s, status = %s ---", v.id, v.status)
    for _,data in pairs(tmp) do
      if v.id == data.stageId then
        data.status = v.status
      end
    end
  end
end

return DM_Activity


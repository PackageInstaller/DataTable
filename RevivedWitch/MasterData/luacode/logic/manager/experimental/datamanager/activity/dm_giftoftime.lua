-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_giftoftime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_GiftOfTime = class("DM_GiftOfTime")
DM_GiftOfTime.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).giftoftime
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).highUnlocked = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).refreshDailyTime = 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).collection = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).tasks = {}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).actId = 0
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).endTime = 0
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chargeId = 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dreamLevel = 0
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dreamChipNum = 0
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTime = 0
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).weeklyLeftTime = 0
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chargeInfo = {chargeMoneyType = 0, levelPrice = 0, price = 0}
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).canReceiveMaxAward = 0
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chipInfo = {has = 0, max = -1}
  self._timeElapsed = 0
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).curChallengingId = -1
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).weeklyAwardsList = {}
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).witchLevel = 1
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).bossInfoList = {}
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).battleResult = -1
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Update, Common.n_Update, nil)
end

DM_GiftOfTime.UpdateLeftTime = function(self, info)
  -- function num : 0_1 , upvalues : _ENV
  if (self._data).leftTime <= 0 then
    return 
  end
  local data = info.userInfo
  self._timeElapsed = self._timeElapsed + data.deltaTime
  if self._timeElapsed > 1 then
    self._timeElapsed = self._timeElapsed - 1
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._data).leftTime = (self._data).leftTime - 1
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    if (self._data).leftTime <= 0 then
      (self._data).actId = 0
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._data).leftTime = 0
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_NewDreamSpiralRefresh, nil, "close")
    end
  end
end

DM_GiftOfTime.UpdateWeekLeftTime = function(self, info)
  -- function num : 0_2 , upvalues : _ENV
  if (self._data).weeklyLeftTime <= 0 then
    return 
  end
  local data = info.userInfo
  self._timeElapsed = self._timeElapsed + data.deltaTime
  if self._timeElapsed > 1 then
    self._timeElapsed = self._timeElapsed - 1
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._data).weeklyLeftTime = (self._data).weeklyLeftTime - 1
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    if (self._data).weeklyLeftTime <= 0 then
      (self._data).weeklyLeftTime = 0
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._data).bossInfoList = {}
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_WeekActRefresh, nil, nil)
    end
  end
end

DM_GiftOfTime.Update = function(self, info)
  -- function num : 0_3
  self:UpdateLeftTime(info)
  self:UpdateWeekLeftTime(info)
end

DM_GiftOfTime.Clear = function(self)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((NekoData.Data).activities).giftoftime = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).highUnlocked = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).collection = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).tasks = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).actId = 0
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).endTime = 0
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chargeId = 0
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dreamLevel = 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).dreamChipNum = 0
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftTime = 0
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).canReceiveMaxAward = 0
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).weeklyLeftTime = 0
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chargeInfo = {chargeMoneyType = 0, levelPrice = 0, price = 0}
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chipInfo = {has = 0, max = 1}
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).curChallengingId = -1
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).weeklyAwardsList = {}
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).witchLevel = 1
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).bossInfoList = {}
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).battleResult = -1
end

DM_GiftOfTime.OnSLittleBattlePass = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).actId = protocol.actId
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).leftTime = protocol.leftTime // 1000
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).highUnlocked = protocol.highUnlocked
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).refreshDailyTime = protocol.refreshDailyTime
  for key,_ in pairs((self._data).tasks) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).tasks)[key] = nil
  end
  for k,v in pairs(protocol.tasks) do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).tasks)[k] = v
  end
  ;
  (table.sort)((self._data).tasks, function(a, b)
    -- function num : 0_5_0
    do return a.taskid < b.taskid end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).collection = {}
  local num = #protocol.commonCollection
  for i = 1, num do
    local data = {}
    data.index = i
    data.level = ((protocol.commonCollection)[i]).level
    local common = (protocol.commonCollection)[i]
    data.common = {state = common.state, itemId = common.itemId, itemNum = common.itemNum}
    local high = (protocol.highCollection)[i]
    data.high = {state = high.state, itemId = high.itemId, itemNum = high.itemNum}
    ;
    (table.insert)((self._data).collection, data)
  end
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._data).endTime = protocol.deadline
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._data).weeklyLeftTime = protocol.weeklyLeftTime // 1000
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._data).chargeInfo).chargeMoneyType = protocol.chargeMoneyType
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._data).chargeInfo).levelPrice = protocol.levelPrice
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._data).chargeInfo).price = protocol.chargePrice
  -- DECOMPILER ERROR at PC101: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._data).dreamLevel = protocol.level
  -- DECOMPILER ERROR at PC108: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._data).chipInfo = {has = protocol.chipNum, max = protocol.needChipNum}
  -- DECOMPILER ERROR at PC111: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._data).canReceiveMaxAward = protocol.canReceiveMaxAward
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R3 in 'UnsetPending'

  if protocol.actId == 0 or protocol.leftTime // 1000 == 0 then
    (self._data).actId = 0
    -- DECOMPILER ERROR at PC122: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._data).leftTime = 0
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NewDreamSpiralRefresh, nil, "close")
  else
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NewDreamSpiralRefresh, nil, nil)
  end
end

DM_GiftOfTime.OnSCoinTasks = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs(protocol.tasks) do
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

    ((self._data).tasks)[k] = v
  end
  ;
  (table.sort)((self._data).tasks, function(a, b)
    -- function num : 0_6_0
    do return a.taskid < b.taskid end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

DM_GiftOfTime.OnSReturnAgainstBossInfo = function(self, protocol)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).weeklyAwardsList = (protocol.againstBossInfo).weeklyAwardsList
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).witchLevel = ((protocol.againstBossInfo).witchInfo).witchLv
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).bossInfoList = (protocol.againstBossInfo).bossInfoList
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).curChallengingId = protocol.bossId
end

DM_GiftOfTime.OnSendagainstBossBattle = function(self, protocol)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).battleResult = (protocol.bossInfo).result
end

DM_GiftOfTime.OnSwitchinAgainstBossUpLv = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).witchLevel = protocol.witchLv
end

return DM_GiftOfTime


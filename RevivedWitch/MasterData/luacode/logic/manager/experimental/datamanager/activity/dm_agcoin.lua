-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_agcoin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_AgCoin = class("DM_AgCoin")
DM_AgCoin.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).agCoinData
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
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chargeInfo = {chargeMoneyType = 0, levelPrice = 0, price = 0}
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).canReceiveMaxAward = 0
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).taskMaxNum = 0
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chipInfo = {has = 0, max = -1}
  self._timeElapsed = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Update, Common.n_Update, nil)
end

DM_AgCoin.Update = function(self, info)
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
      (LuaNotificationCenter.PostNotification)(Common.n_DreamSpiralRefresh, nil, "close")
    end
  end
end

DM_AgCoin.Clear = function(self)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((NekoData.Data).activities).agCoinData = {}
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
  (self._data).taskMaxNum = 0
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chargeInfo = {chargeMoneyType = 0, levelPrice = 0, price = 0}
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).chipInfo = {has = 0, max = 1}
end

DM_AgCoin.OnSAgCoinInfo = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
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
  local hasAward = false
  for k,v in pairs(protocol.tasks) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    ((self._data).tasks)[k] = v
    hasAward = hasAward or v.taskstatus == 3
  end
  ;
  ((NekoData.DataManager).DM_Task):SetIndexRedValue(7, hasAward)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._data).collection = {}
  hasAward = false
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
    -- DECOMPILER ERROR at PC89: Unhandled construct in 'MakeBoolean' P1

    if not hasAward and common.state ~= 1 and high.state ~= 1 then
      do
        hasAward = i >= num
        -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._data).endTime = protocol.deadline
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._data).chargeInfo).chargeMoneyType = protocol.chargeMoneyType
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._data).chargeInfo).levelPrice = protocol.levelPrice
  -- DECOMPILER ERROR at PC106: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._data).chargeInfo).price = protocol.chargePrice
  -- DECOMPILER ERROR at PC109: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._data).dreamLevel = protocol.level
  -- DECOMPILER ERROR at PC116: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._data).chipInfo = {has = protocol.chipNum, max = protocol.needChipNum}
  -- DECOMPILER ERROR at PC119: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._data).canReceiveMaxAward = protocol.canReceiveMaxAward
  -- DECOMPILER ERROR at PC125: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._data).taskMaxNum = protocol.maxTaskNum or 0
  -- DECOMPILER ERROR at PC134: Confused about usage of register: R4 in 'UnsetPending'

  if protocol.actId == 0 or protocol.leftTime // 1000 == 0 then
    (self._data).actId = 0
    -- DECOMPILER ERROR at PC136: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._data).leftTime = 0
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_DreamSpiralRefresh, nil, "close")
  else
    (LuaNotificationCenter.PostNotification)(Common.n_DreamSpiralRefresh, nil, nil)
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

DM_AgCoin.OnSCoinTasks = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  local hasAward = false
  for k,v in pairs(protocol.tasks) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

    ((self._data).tasks)[k] = v
    hasAward = hasAward or v.taskstatus == 3
  end
  ;
  ((NekoData.DataManager).DM_Task):SetIndexRedValue(7, hasAward)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return DM_AgCoin


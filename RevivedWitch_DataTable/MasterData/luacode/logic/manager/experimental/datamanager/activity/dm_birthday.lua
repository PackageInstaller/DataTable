-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_birthday.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_BirthDay = class("DM_BirthDay")
DM_BirthDay.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._birthday = ((NekoData.Data).activities).birthday
  self:Clear()
end

DM_BirthDay.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._birthday).isOpen = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).startTime = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).endTime = 0
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).rewardRecord = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).shareRecord = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).wishRecord = -1
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).maxTaskID = -1
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).extraItemLeftTime = 0
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._birthday).extraItemIsLeft = false
  if (self._birthday).extraItemLeftTimeTimerID then
    (ServerGameTimer.RemoveTask)((self._birthday).extraItemLeftTimeTimerID)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._birthday).extraItemLeftTimeTimerID = nil
  end
end

DM_BirthDay.OnSBirthdayActivity = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._birthday).isOpen = protocol.state ~= 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).startTime = protocol.startDay
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).endTime = protocol.endDay
  for key,_ in pairs((self._birthday).rewardRecord) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    ((self._birthday).rewardRecord)[key] = nil
  end
  for _,value in pairs(protocol.rewardRecord) do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    ((self._birthday).rewardRecord)[value] = true
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).shareRecord = protocol.share
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).wishRecord = protocol.wish
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).maxTaskID = protocol.maxMissionId
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).extraItemLeftTime = protocol.extraItemLeftTime
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).extraItemIsLeft = true
  if (self._birthday).extraItemLeftTimeTimerID then
    (ServerGameTimer.RemoveTask)((self._birthday).extraItemLeftTimeTimerID)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._birthday).extraItemLeftTimeTimerID = nil
  end
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._birthday).extraItemLeftTimeTimerID = (ServerGameTimer.AddTask)(protocol.extraItemLeftTime / 1000, -1, function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (self._birthday).extraItemIsLeft = false
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_OnExtraItemLeftEnd, nil, nil)
  end
)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DM_BirthDay.OnSChangeWish = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._birthday).wishRecord = protocol.index
end

DM_BirthDay.OnSOpenBirthReward = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._birthday).rewardRecord)[protocol.rewardId] = true
end

DM_BirthDay.OnSBirthShare = function(self, protocol)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._birthday).shareRecord = 1
end

return DM_BirthDay


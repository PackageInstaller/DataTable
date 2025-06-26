-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/activity/dm_christmascall.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_ChristmasCall = class("DM_ChristmasCall")
DM_ChristmasCall.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._christmascall = ((NekoData.Data).activities).chrismascall
  self:Clear()
end

DM_ChristmasCall.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._christmascall).isOpen = false
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._christmascall).totalRemainTime = 0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._christmascall).startTime = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._christmascall).callRemainTime = 0
  if (self._christmascall).rewardIds then
    for key,_ in pairs((self._christmascall).rewardIds) do
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

      ((self._christmascall).rewardIds)[key] = nil
    end
  else
    do
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).rewardIds = {}
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).nowScore = 0
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).canCall = 0
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).globalScore = 0
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).settleState = 0
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).shopCanOpen = false
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).redDotList = {}
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._christmascall).nowGainCallNum = -1
    end
  end
end

DM_ChristmasCall.OnSOpenChristmasSupportActivity = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._christmascall).isOpen = protocol.state ~= 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._christmascall).totalRemainTime = protocol.activityLeftTime
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._christmascall).startTime = (ServerGameTimer.GetServerTimeForecast)()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._christmascall).callRemainTime = protocol.supportLeftTime
  for _,value in pairs(protocol.rewardIds) do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

    ((self._christmascall).rewardIds)[value] = true
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._christmascall).nowScore = protocol.score
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._christmascall).canCall = protocol.canSupport == 1
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DM_ChristmasCall.OnSChristmasSupport = function(self, protocol)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  (self._christmascall).nowScore = (self._christmascall).nowScore + protocol.addScore
end

DM_ChristmasCall.OnSReceiveSupportReward = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._christmascall).rewardIds)[protocol.id] = true
end

DM_ChristmasCall.OnSOpenTotalSupportScore = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._christmascall).globalScore = protocol.score
  for _,value in pairs(protocol.rewardIds) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

    ((self._christmascall).rewardIds)[value] = true
  end
end

DM_ChristmasCall.OnSSettleChristmasSupport = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.state == 0 then
    (self._christmascall).settleState = 0
  else
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    if protocol.settle == 0 then
      (self._christmascall).settleState = 1
    else
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._christmascall).settleState = 2
    end
  end
end

DM_ChristmasCall.OnSChristmasSupportShopState = function(self, protocol)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._christmascall).shopCanOpen = protocol.state == 1
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DM_ChristmasCall.OnSChristmasSupportRedpoint = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV
  for key,_ in pairs((self._christmascall).redDotList) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ((self._christmascall).redDotList)[key] = nil
  end
  for _,value in pairs(protocol.state) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R7 in 'UnsetPending'

    ((self._christmascall).redDotList)[value] = true
  end
end

DM_ChristmasCall.OnSCheckGainNumber = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._christmascall).nowGainCallNum = protocol.number
end

return DM_ChristmasCall


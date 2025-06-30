-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_welfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local C30dayBenefitSignin = (BeanManager.GetTableByName)("welfare.c30daybenefitsignin")
local CMonthLoginDayCell = (BeanManager.GetTableByName)("welfare.cmonthlogindaycell")
local DM_Welfare = class("DM_Welfare")
DM_Welfare.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._welfare = (NekoData.Data).welfare
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).totalSign = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).growGift = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).firstRechargeGiftStates = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).fitstRechargeGiftRedPoint = nil
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).limitedInvestmentInfo = nil
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).monthSignInfo = nil
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).witchCalendarInfo = nil
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).accumulateCost = nil
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).oldPlayerWelfareInfo = nil
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).minDicountWelfareInfo = nil
  self._timeCheck = 1
  self._timeCount = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_Welfare.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._welfare).totalSign = {}
  for k,_ in pairs((self._welfare).growGift) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R6 in 'UnsetPending'

    ((self._welfare).growGift)[k] = nil
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).firstRechargeGiftStates = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).fitstRechargeGiftRedPoint = nil
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).limitedInvestmentInfo = nil
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).monthSignInfo = nil
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).witchCalendarInfo = nil
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).accumulateCost = nil
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).oldPlayerWelfareInfo = nil
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._welfare).minDicountWelfareInfo = nil
end

DM_Welfare.SetSignState = function(self, accumulate)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._welfare).accumulateSignState = accumulate
end

DM_Welfare.SetTotleSignState = function(self, accumulate)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._welfare).totleSignState = accumulate
end

DM_Welfare.SetCumulativeSignDay = function(self, cumulativeDay)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._welfare).totleSignDay = cumulativeDay
end

DM_Welfare.OnSLoginAward = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self._welfare).totalSign).signedNum = (protocol.totalSign).totalDay
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._welfare).totalSign).accumulatedAwardList = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._welfare).totalSign).accumulatedDayList = {}
  for _,a in ipairs((protocol.totalSign).awards) do
    local temp = {id = a.itemId, num = a.num}
    ;
    (table.insert)(((self._welfare).totalSign).accumulatedAwardList, temp)
    ;
    (table.insert)(((self._welfare).totalSign).accumulatedDayList, a.signTimes)
  end
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._welfare).totalSign).accumulatedIndex = (protocol.totalSign).needReceive
end

DM_Welfare.OnSTotalSign = function(self, userInfo)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if userInfo.result == 1 then
    ((self._welfare).totalSign).accumulatedIndex = 0
  end
end

DM_Welfare.OnSLevelUpRewardInfo = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._welfare).growGift).bought = protocol.unlock
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._welfare).growGift).goodId = protocol.goodId
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._welfare).growGift).chargeNum = protocol.chargeNum
  local getMap = ((self._welfare).growGift).getMap
  if getMap then
    for k,_ in pairs(getMap) do
      getMap[k] = nil
    end
  else
    do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self._welfare).growGift).getMap = {}
      for i,v in ipairs(protocol.ids) do
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

        (((self._welfare).growGift).getMap)[v] = true
      end
    end
  end
end

DM_Welfare.SGetFirstRechargeGiftStates = function(self, protocol)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._welfare).firstRechargeGiftStates = protocol
end

DM_Welfare.SFitstRechargeGiftRedPoint = function(self, protocol)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._welfare).fitstRechargeGiftRedPoint = protocol
end

DM_Welfare.OnSRefreshInvestActInfo = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV
  local typeData = (DataCommon.LocalTips).LimitedInvestmentOpen
  local cacheType = (DataCommon.LocalCache).LimitedInvestmentActId
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  if protocol.close == 1 then
    (self._welfare).limitedInvestmentInfo = nil
    ;
    ((NekoData.BehaviorManager).BM_Game):ClearLocalTipsState(typeData)
    ;
    ((NekoData.BehaviorManager).BM_Game):ClearLocalCache(cacheType)
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._welfare).limitedInvestmentInfo = protocol
    local state = ((NekoData.BehaviorManager).BM_Game):GetLocalTipsState(typeData)
    local lastActId = ((NekoData.BehaviorManager).BM_Game):GetLocalCache(cacheType)
    local actId = ((self._welfare).limitedInvestmentInfo).actId
    if state ~= typeData.Default and lastActId ~= actId then
      ((NekoData.BehaviorManager).BM_Game):ClearLocalTipsState(typeData)
      ;
      ((NekoData.BehaviorManager).BM_Game):ClearLocalCache(cacheType)
    end
    if state == typeData.Default and ((self._welfare).limitedInvestmentInfo).currentChannel == 0 then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew(typeData)
      ;
      ((NekoData.BehaviorManager).BM_Game):SetLocalCache(cacheType, actId)
    end
  end
end

DM_Welfare.OnUpdate = function(self, notification)
  -- function num : 0_11 , upvalues : _ENV
  if (self._welfare).limitedInvestmentInfo then
    self._timeCount = self._timeCount + (notification.userInfo).unscaledDeltaTime
    if self._timeCount < self._timeCheck then
      return 
    end
    local check = self._timeCheck
    if self._timeCheck < (notification.userInfo).unscaledDeltaTime then
      check = (math.ceil)(self._timeCount)
    end
    self._timeCount = self._timeCount - check
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    if ((self._welfare).limitedInvestmentInfo).actLeftTime >= 0 then
      ((self._welfare).limitedInvestmentInfo).actLeftTime = ((self._welfare).limitedInvestmentInfo).actLeftTime - check * 1000
    end
  end
end

DM_Welfare.OnSMonthSignInfo = function(self, protocol)
  -- function num : 0_12 , upvalues : _ENV, C30dayBenefitSignin
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._welfare).monthSignInfo then
    (self._welfare).monthSignInfo = {}
  end
  if ((self._welfare).monthSignInfo).receivedIds then
    for k,v in pairs(((self._welfare).monthSignInfo).receivedIds) do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

      (((self._welfare).monthSignInfo).receivedIds)[k] = nil
    end
  else
    do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).monthSignInfo).receivedIds = {}
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

      if not ((self._welfare).monthSignInfo).allRecords then
        ((self._welfare).monthSignInfo).allRecords = {}
        local allIds = C30dayBenefitSignin:GetAllIds()
        local len = #allIds
        for i = 1, len do
          -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

          (((self._welfare).monthSignInfo).allRecords)[allIds[i]] = C30dayBenefitSignin:GetRecorder(allIds[i])
        end
      end
      do
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self._welfare).monthSignInfo).signTotalNum = protocol.signTotalNum
        for _,v in ipairs(protocol.receives) do
          -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

          (((self._welfare).monthSignInfo).receivedIds)[v] = true
        end
        local getAll = true
        for k,v in pairs(((self._welfare).monthSignInfo).allRecords) do
          if not (((self._welfare).monthSignInfo).receivedIds)[k] then
            getAll = false
          end
        end
        -- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self._welfare).monthSignInfo).getAll = getAll
        local typeData = (DataCommon.LocalTips).MonthSignOpen
        if ((NekoData.BehaviorManager).BM_Game):GetLocalTipsState(typeData) == typeData.Default then
          ((NekoData.BehaviorManager).BM_Game):SetLocalTipsNew(typeData)
        else
          if ((self._welfare).monthSignInfo).getAll then
            ((NekoData.BehaviorManager).BM_Game):ClearLocalTipsState(typeData)
          end
        end
      end
    end
  end
end

DM_Welfare.OnWitchCalendarInfo = function(self, protocol)
  -- function num : 0_13 , upvalues : _ENV, CMonthLoginDayCell
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._welfare).witchCalendarInfo then
    (self._welfare).witchCalendarInfo = {}
  end
  if ((self._welfare).witchCalendarInfo).receivedIds then
    for k,v in pairs(((self._welfare).witchCalendarInfo).receivedIds) do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

      (((self._welfare).witchCalendarInfo).receivedIds)[k] = nil
    end
  else
    do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).witchCalendarInfo).receivedIds = {}
      for k,v in pairs(((self._welfare).witchCalendarInfo).receivedIds) do
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

        (((self._welfare).witchCalendarInfo).receivedIds)[k] = nil
      end
      for _,v in ipairs(protocol.receivedAward) do
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

        (((self._welfare).witchCalendarInfo).receivedIds)[v] = true
      end
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).witchCalendarInfo).complementNum = protocol.complementNum
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).witchCalendarInfo).month = protocol.month
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).witchCalendarInfo).today = protocol.days
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).witchCalendarInfo).cfgs = {}
      for i,v in ipairs(protocol.monthDay) do
        local recorder = CMonthLoginDayCell:GetRecorder(v)
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R8 in 'UnsetPending'

        if recorder then
          (((self._welfare).witchCalendarInfo).cfgs)[i] = recorder
        else
          LogErrorFormat("DM_Welfare", "CMonthLoginDayCell Not Exist ID:%s", v)
        end
      end
    end
  end
end

DM_Welfare.OnSOldPlayerWelfare = function(self, protocol)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if not (self._welfare).oldPlayerWelfareInfo then
    (self._welfare).oldPlayerWelfareInfo = {}
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  if not ((self._welfare).oldPlayerWelfareInfo).commonReceiveList then
    ((self._welfare).oldPlayerWelfareInfo).commonReceiveList = {}
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    if not ((self._welfare).oldPlayerWelfareInfo).highReceiveList then
      ((self._welfare).oldPlayerWelfareInfo).highReceiveList = {}
      for k,v in pairs(((self._welfare).oldPlayerWelfareInfo).commonReceiveList) do
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

        (((self._welfare).oldPlayerWelfareInfo).commonReceiveList)[k] = nil
      end
      for i,v in ipairs(protocol.commonReceiveList) do
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

        (((self._welfare).oldPlayerWelfareInfo).commonReceiveList)[v] = true
      end
      for k,v in pairs(((self._welfare).oldPlayerWelfareInfo).highReceiveList) do
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

        (((self._welfare).oldPlayerWelfareInfo).highReceiveList)[k] = nil
      end
      for i,v in ipairs(protocol.highReceiveList) do
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R7 in 'UnsetPending'

        (((self._welfare).oldPlayerWelfareInfo).highReceiveList)[v] = true
      end
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).oldPlayerWelfareInfo).totalSignNum = protocol.totalSignNum
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._welfare).oldPlayerWelfareInfo).isPay = protocol.isPay == 1
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

DM_Welfare.OnSconsumptionInfo = function(self, protocol)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._welfare).accumulateCost = protocol
end

DM_Welfare.OnMinDiscountInfo = function(self, protocol)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._welfare).minDicountWelfareInfo = protocol
end

return DM_Welfare


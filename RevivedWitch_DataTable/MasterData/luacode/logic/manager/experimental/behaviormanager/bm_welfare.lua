-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_welfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CLevelReward = (BeanManager.GetTableByName)("welfare.clevelreward")
local CMonthLoginDayCell = (BeanManager.GetTableByName)("welfare.cmonthlogindaycell")
local SLevelUpRewardInfoDef = (LuaNetManager.GetProtocolDef)("protocol.shop.sleveluprewardinfo")
local CommonAwardsSatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
local COldPlayerWelfareTarget = (BeanManager.GetTableByName)("welfare.coldplayerwelfaretarget")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local Item = require("logic.manager.experimental.types.item")
local BM_Welfare = class("BM_Welfare")
BM_Welfare.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._welfare = (NekoData.Data).welfare
end

BM_Welfare.GetTotalLoginInfo = function(self)
  -- function num : 0_1
  return (self._welfare).totalSign
end

BM_Welfare.GetAccumulatedIndex = function(self)
  -- function num : 0_2
  return ((self._welfare).totalSign).accumulatedIndex
end

BM_Welfare.GetAccumulateSignState = function(self)
  -- function num : 0_3
  return (self._welfare).accumulateSignState
end

BM_Welfare.GetTotleSignState = function(self)
  -- function num : 0_4
  return (self._welfare).totleSignState
end

BM_Welfare.GetTotleSignDay = function(self)
  -- function num : 0_5
  return (self._welfare).totleSignDay
end

BM_Welfare.GetGrowGiftInfo = function(self)
  -- function num : 0_6
  return (self._welfare).growGift
end

BM_Welfare.GrowGiftShowRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV, GuidTypes, CLevelReward
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).GrowGift) then
    local tag = ((NekoData.BehaviorManager).BM_Game):GetGuideTagByType(GuidTypes.LEVEL_GIFT)
    if not tag or tag == 0 then
      return true
    end
    if not self:IsBoughtGrowGift() then
      return false
    end
    local userLevel = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
    local getMap = ((self._welfare).growGift).getMap
    local allIds = CLevelReward:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CLevelReward:GetRecorder(allIds[i])
      if record.level <= userLevel and not getMap[record.id] then
        return true
      end
      do return false end
    end
  end
end

BM_Welfare.IsBoughtGrowGift = function(self)
  -- function num : 0_8 , upvalues : SLevelUpRewardInfoDef
  do return not ((self._welfare).growGift).bought or ((self._welfare).growGift).bought == SLevelUpRewardInfoDef.CHARGE end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Welfare.ShowWelfareEntrance_GrowGift = function(self)
  -- function num : 0_9 , upvalues : _ENV, CLevelReward
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).GrowGift) then
    if not self:IsBoughtGrowGift() then
      return true
    end
    local userLevel = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
    local getMap = ((self._welfare).growGift).getMap
    local allIds = CLevelReward:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CLevelReward:GetRecorder(allIds[i])
      if not getMap[record.id] then
        return true
      end
    end
  end
end

BM_Welfare.GetFirstRechargeGiftState = function(self)
  -- function num : 0_10
  return (self._welfare).firstRechargeGiftStates
end

BM_Welfare.GetFitstRechargeGiftRedPoint = function(self)
  -- function num : 0_11
  return (self._welfare).fitstRechargeGiftRedPoint
end

BM_Welfare.IsFitstRechargeGiftAllGet = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not ((self._welfare).firstRechargeGiftStates).statue or ((self._welfare).firstRechargeGiftStates).statue == 0 then
    return false
  end
  for k,v in pairs(((self._welfare).firstRechargeGiftStates).giftsState) do
    if v == 0 then
      return false
    end
  end
  if (table.nums)(((self._welfare).firstRechargeGiftStates).giftsState) < 2 then
    return false
  end
  return true
end

BM_Welfare.IsLimitedInvestmentOpen = function(self)
  -- function num : 0_13
  local info = (self._welfare).limitedInvestmentInfo
  do return not info or info.currentChannel == 0 or info.leftTimes > 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Welfare.ShowLimitedInvestmentRedDot = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local info = (self._welfare).limitedInvestmentInfo
  do return ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).LimitedInvestmentOpen) or not info or (info.currentChannel ~= 0 and info.todayFetched == 0) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Welfare.GetLimitedInvestmentInfo = function(self)
  -- function num : 0_15
  return (self._welfare).limitedInvestmentInfo
end

BM_Welfare.IsMonthSignOpen = function(self)
  -- function num : 0_16
  if (self._welfare).monthSignInfo and not ((self._welfare).monthSignInfo).getAll then
    return true
  end
end

BM_Welfare.ShowMonthSignRedDot = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).MonthSignOpen) then
    return true
  end
  if self:IsMonthSignOpen() then
    for k,v in pairs(((self._welfare).monthSignInfo).allRecords) do
      if not (((self._welfare).monthSignInfo).receivedIds)[k] and v.cumulativeDays <= ((self._welfare).monthSignInfo).signTotalNum then
        return true
      end
    end
  end
end

BM_Welfare.GetMonthSignInfo = function(self)
  -- function num : 0_18
  return (self._welfare).monthSignInfo
end

BM_Welfare.ShowWelfareEntrance = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Welfare) then
    return false
  end
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):ShowWelfareEntrance_Sign() then
    return true
  end
  if self:ShowWelfareEntrance_GrowGift() then
    return true
  end
  if ((NekoData.BehaviorManager).BM_SevenGrow):GetSevenDaysIsOpen() then
    return true
  end
  if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)):GetCurrentActId() > 0 then
    return true
  end
  if ((NekoData.BehaviorManager).BM_Foresight):GetIsOpen() then
    return true
  end
  if ((NekoData.BehaviorManager).BM_AnniversaryShare):GetIsOpen() then
    return true
  end
  if self:IsLimitedInvestmentOpen() then
    return true
  end
  if self:IsMonthSignOpen() then
    return true
  end
  if self:GetAccumulateCost() then
    return true
  end
end

BM_Welfare.ShowWelfareRedDot = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self:ShowWelfareEntrance() then
    if self:GrowGiftShowRedDot() then
      return true
    end
    if ((NekoData.BehaviorManager).BM_ActivityTasks):SevenDaysShowRedDot() then
      return true
    end
    if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AgCoinActivityID)):ShowRedDot() then
      return true
    end
    if ((NekoData.BehaviorManager).BM_AnniversaryShare):GetHaveRedDot() then
      return true
    end
    if ((NekoData.BehaviorManager).BM_Welfare):ShowLimitedInvestmentRedDot() then
      return true
    end
    if self:ShowMonthSignRedDot() then
      return true
    end
    if self:ShowAccumulateCostRedDot() then
      return true
    end
    if self:ShowOldPlayerWelfareRedDot() then
      return true
    end
    if self:ShowMinDiscountRedDot() then
      return true
    end
  end
end

BM_Welfare.GetWitchCalendarInfo = function(self)
  -- function num : 0_21
  if (self._welfare).witchCalendarInfo then
    return (self._welfare).witchCalendarInfo
  end
end

BM_Welfare.IsWitchCalendarOpen = function(self)
  -- function num : 0_22
  if (self._welfare).witchCalendarInfo then
    return true
  end
end

BM_Welfare.ShowWitchCalendarRedDot = function(self)
  -- function num : 0_23
  if self:IsWitchCalendarOpen() and not (((self._welfare).witchCalendarInfo).receivedIds)[((self._welfare).witchCalendarInfo).today] then
    return true
  end
end

BM_Welfare.GetAccumulateCost = function(self)
  -- function num : 0_24 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).AccumulateCost) then
    return (self._welfare).accumulateCost
  end
end

BM_Welfare.ShowAccumulateCostRedDot = function(self)
  -- function num : 0_25 , upvalues : _ENV, CommonAwardsSatus
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).AccumulateCost) and (self._welfare).accumulateCost then
    for k,v in pairs(((self._welfare).accumulateCost).awardStatus) do
      if v.status == CommonAwardsSatus.UNLOCKED then
        return true
      end
    end
  end
end

BM_Welfare.GetOldPlayerWelfareInfo = function(self)
  -- function num : 0_26 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OldPlayerBenefits) then
    return (self._welfare).oldPlayerWelfareInfo
  end
end

BM_Welfare.GetOldPlayerWelfarePageScore = function(self, pageID)
  -- function num : 0_27 , upvalues : _ENV
  if pageID == 1 then
    return ((self._welfare).oldPlayerWelfareInfo).totalSignNum
  else
    if pageID == 2 then
      return ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
    else
      if not ((NekoData.BehaviorManager).BM_Shop):GetChargAccumulationTotalScore() then
        do return pageID ~= 3 or 0 end
        LogErrorFormat("BM_Welfare", "GetOldPlayerWelfarePageInfoByIndex:%s", pageID)
      end
    end
  end
end

BM_Welfare.GetOldPlayerWelfarePageInfoByPageID = function(self, pageID)
  -- function num : 0_28 , upvalues : COldPlayerWelfareTarget, _ENV
  local result = {}
  local curValue = self:GetOldPlayerWelfarePageScore(pageID)
  local allIds = COldPlayerWelfareTarget:GetAllIds()
  for _,v in pairs(allIds) do
    local record = COldPlayerWelfareTarget:GetRecorder(v)
    if record.targetType == pageID then
      (table.insert)(result, {cfg = record})
    end
  end
  ;
  (table.sort)(result, function(a, b)
    -- function num : 0_28_0
    if (a.cfg).target < (b.cfg).target then
      return true
    end
  end
)
  for i,v in ipairs(result) do
    local cfg = v.cfg
    v.process = curValue / cfg.target
    if v.process <= 1 or not 1 then
      v.process = v.process
      local leftValue = cfg.target < curValue and cfg.target or curValue
      v.cur = leftValue
      v.hasReward = self:HasCanReceiveOldPlayerWelfareByRewardID((v.cfg).id)
      v.isDone = self:IsDoneReceiveOldPlayerWelfareByReWardID((v.cfg).id)
      v.isPay = self:IsPayOldPlayerWelfare()
      do
        local itemData = {}
        ;
        (table.insert)(itemData, {itemID = cfg.itemID, itemCount = cfg.itemNum, isReceived = (((self._welfare).oldPlayerWelfareInfo).commonReceiveList)[(v.cfg).id]})
        for i,v in ipairs(cfg.payItemID) do
          (table.insert)(itemData, {itemID = v, itemCount = (cfg.payItemNum)[i], isLock = not self:IsPayOldPlayerWelfare(), isReceived = (((self._welfare).oldPlayerWelfareInfo).highReceiveList)[cfg.id]})
        end
        v.awardItemData = itemData
        -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return result
end

BM_Welfare.IsDoneReceiveOldPlayerWelfareByReWardID = function(self, rewardID)
  -- function num : 0_29
  if (((self._welfare).oldPlayerWelfareInfo).commonReceiveList)[rewardID] then
    return (((self._welfare).oldPlayerWelfareInfo).highReceiveList)[rewardID]
  end
end

BM_Welfare.HasCanReceiveOldPlayerWelfareByRewardID = function(self, rewardID)
  -- function num : 0_30 , upvalues : _ENV, COldPlayerWelfareTarget
  if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OldPlayerBenefits) then
    return 
  end
  local result = false
  local highResult = false
  local record = COldPlayerWelfareTarget:GetRecorder(rewardID)
  local pageScore = self:GetOldPlayerWelfarePageScore(record.targetType)
  if not pageScore then
    return 
  end
  local enoughPoints = record.target <= pageScore
  result = not (((self._welfare).oldPlayerWelfareInfo).commonReceiveList)[rewardID]
  if self:IsPayOldPlayerWelfare() then
    highResult = not (((self._welfare).oldPlayerWelfareInfo).highReceiveList)[rewardID]
  end
  do return not result and not highResult or enoughPoints end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

BM_Welfare.HasCanReceiveOldPlayerWelfareByPageID = function(self, pageID)
  -- function num : 0_31 , upvalues : _ENV, COldPlayerWelfareTarget
  if not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OldPlayerBenefits) then
    return 
  end
  local allIds = COldPlayerWelfareTarget:GetAllIds()
  for _,v in pairs(allIds) do
    local record = COldPlayerWelfareTarget:GetRecorder(v)
    if record.targetType == pageID then
      local result = self:HasCanReceiveOldPlayerWelfareByRewardID(v)
      if result then
        return true
      end
    end
  end
end

BM_Welfare.ShowOldPlayerWelfareRedDot = function(self)
  -- function num : 0_32 , upvalues : _ENV, COldPlayerWelfareTarget
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OldPlayerBenefits) then
    local allIds = COldPlayerWelfareTarget:GetAllIds()
    for _,v in pairs(allIds) do
      local result = self:HasCanReceiveOldPlayerWelfareByRewardID(v)
      if result then
        return true
      end
    end
  end
end

BM_Welfare.IsPayOldPlayerWelfare = function(self)
  -- function num : 0_33 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).OldPlayerBenefits) then
    return ((self._welfare).oldPlayerWelfareInfo).isPay
  end
end

BM_Welfare.IsShowMinDiscount = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).MinDiscount) and (self._welfare).minDicountWelfareInfo and ((self._welfare).minDicountWelfareInfo).leftTime > 0 then
    return true
  end
end

BM_Welfare.ShowMinDiscountRedDot = function(self)
  -- function num : 0_35 , upvalues : _ENV
  if ((self._welfare).minDicountWelfareInfo).redDot ~= 1 then
    do return not ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).MinDiscount) or not self:IsShowMinDiscount() end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Welfare.GetMinDiscoundtWelfareInfo = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local serverData = (self._welfare).minDicountWelfareInfo
  if serverData then
    local data = {}
    data.goodInfo = serverData.goodInfo
    local itemData = {}
    for i,v in ipairs((data.goodInfo).itemId) do
      (table.insert)(itemData, {itemID = v, itemCount = ((data.goodInfo).itemSum)[i]})
    end
    data.cellData = itemData
    data.leftTime = serverData.leftTime
    return data
  end
end

return BM_Welfare


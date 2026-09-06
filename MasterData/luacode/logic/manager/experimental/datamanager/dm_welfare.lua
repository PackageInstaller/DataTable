local C30dayBenefitSignin = BeanManager.GetTableByName("welfare.c30daybenefitsignin")
local CMonthLoginDayCell = BeanManager.GetTableByName("welfare.cmonthlogindaycell")
local DM_Welfare = class("DM_Welfare")

function DM_Welfare:Ctor()
  self._welfare = NekoData.Data.welfare
  self._welfare.totalSign = {}
  self._welfare.growGift = {}
  self._welfare.firstRechargeGiftStates = {}
  self._welfare.firstChargeData = {}
  self._welfare.fitstRechargeGiftRedPoint = nil
  self._welfare.limitedInvestmentInfo = nil
  self._welfare.monthSignInfo = nil
  self._welfare.witchCalendarInfo = nil
  self._welfare.accumulateCost = nil
  self._welfare.oldPlayerWelfareInfo = nil
  self._welfare.minDicountWelfareInfo = nil
  self._welfare.communityShareInfo = nil
  self._timeCheck = 1
  self._timeCount = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_Welfare:Clear()
  self._welfare.totalSign = {}
  for k, _ in pairs(self._welfare.growGift) do
    self._welfare.growGift[k] = nil
  end
  self._welfare.firstRechargeGiftStates = {}
  self._welfare.firstChargeData = {}
  self._welfare.fitstRechargeGiftRedPoint = nil
  self._welfare.limitedInvestmentInfo = nil
  self._welfare.monthSignInfo = nil
  self._welfare.witchCalendarInfo = nil
  self._welfare.accumulateCost = nil
  self._welfare.oldPlayerWelfareInfo = nil
  self._welfare.minDicountWelfareInfo = nil
  self._welfare.communityShareInfo = nil
end

function DM_Welfare:SetSignState(accumulate)
  self._welfare.accumulateSignState = accumulate
end

function DM_Welfare:SetTotleSignState(accumulate)
  self._welfare.totleSignState = accumulate
end

function DM_Welfare:SetCumulativeSignDay(cumulativeDay)
  self._welfare.totleSignDay = cumulativeDay
end

function DM_Welfare:OnSLoginAward(protocol)
  self._welfare.totalSign.signedNum = protocol.totalSign.totalDay
  self._welfare.totalSign.accumulatedAwardList = {}
  self._welfare.totalSign.accumulatedDayList = {}
  for _, a in ipairs(protocol.totalSign.awards) do
    local temp = {
      id = a.itemId,
      num = a.num
    }
    table.insert(self._welfare.totalSign.accumulatedAwardList, temp)
    table.insert(self._welfare.totalSign.accumulatedDayList, a.signTimes)
  end
  self._welfare.totalSign.accumulatedIndex = protocol.totalSign.needReceive
end

function DM_Welfare:OnSTotalSign(userInfo)
  if userInfo.result == 1 then
    self._welfare.totalSign.accumulatedIndex = 0
  end
end

function DM_Welfare:OnSLevelUpRewardInfo(protocol)
  self._welfare.growGift.bought = protocol.unlock
  self._welfare.growGift.goodId = protocol.goodId
  self._welfare.growGift.chargeNum = protocol.chargeNum
  local getMap = self._welfare.growGift.getMap
  if getMap then
    for k, _ in pairs(getMap) do
      getMap[k] = nil
    end
  else
    self._welfare.growGift.getMap = {}
  end
  for i, v in ipairs(protocol.ids) do
    self._welfare.growGift.getMap[v] = true
  end
end

function DM_Welfare:SGetFirstRechargeGiftStates(protocol)
  self._welfare.firstRechargeGiftStates = protocol
end

function DM_Welfare:SFirstChargeOpenPanel(protocol)
  self._welfare.firstChargeData = protocol
end

function DM_Welfare:SFitstRechargeGiftRedPoint(flag)
  self._welfare.fitstRechargeGiftRedPoint = flag
end

function DM_Welfare:OnSRefreshInvestActInfo(protocol)
  local typeData = DataCommon.LocalTips.LimitedInvestmentOpen
  local cacheType = DataCommon.LocalCache.LimitedInvestmentActId
  if protocol.close == 1 then
    self._welfare.limitedInvestmentInfo = nil
    NekoData.BehaviorManager.BM_Game:ClearLocalTipsState(typeData)
    NekoData.BehaviorManager.BM_Game:ClearLocalCache(cacheType)
  else
    self._welfare.limitedInvestmentInfo = protocol
    local state = NekoData.BehaviorManager.BM_Game:GetLocalTipsState(typeData)
    local lastActId = NekoData.BehaviorManager.BM_Game:GetLocalCache(cacheType)
    local actId = self._welfare.limitedInvestmentInfo.actId
    if state ~= typeData.Default and lastActId ~= actId then
      NekoData.BehaviorManager.BM_Game:ClearLocalTipsState(typeData)
      NekoData.BehaviorManager.BM_Game:ClearLocalCache(cacheType)
    end
    if state == typeData.Default and self._welfare.limitedInvestmentInfo.currentChannel == 0 then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(typeData)
      NekoData.BehaviorManager.BM_Game:SetLocalCache(cacheType, actId)
    end
  end
end

function DM_Welfare:OnUpdate(notification)
  if self._welfare.limitedInvestmentInfo then
    self._timeCount = self._timeCount + notification.userInfo.unscaledDeltaTime
    if self._timeCount < self._timeCheck then
      return
    end
    local check = self._timeCheck
    if notification.userInfo.unscaledDeltaTime > self._timeCheck then
      check = math.ceil(self._timeCount)
    end
    self._timeCount = self._timeCount - check
    if self._welfare.limitedInvestmentInfo.actLeftTime >= 0 then
      self._welfare.limitedInvestmentInfo.actLeftTime = self._welfare.limitedInvestmentInfo.actLeftTime - check * 1000
    end
  end
end

function DM_Welfare:OnSMonthSignInfo(protocol)
  if not self._welfare.monthSignInfo then
    self._welfare.monthSignInfo = {}
  end
  if self._welfare.monthSignInfo.receivedIds then
    for k, v in pairs(self._welfare.monthSignInfo.receivedIds) do
      self._welfare.monthSignInfo.receivedIds[k] = nil
    end
  else
    self._welfare.monthSignInfo.receivedIds = {}
  end
  if not self._welfare.monthSignInfo.allRecords then
    self._welfare.monthSignInfo.allRecords = {}
    local allIds = C30dayBenefitSignin:GetAllIds()
    local len = #allIds
    for i = 1, len do
      self._welfare.monthSignInfo.allRecords[allIds[i]] = C30dayBenefitSignin:GetRecorder(allIds[i])
    end
  end
  self._welfare.monthSignInfo.signTotalNum = protocol.signTotalNum
  for _, v in ipairs(protocol.receives) do
    self._welfare.monthSignInfo.receivedIds[v] = true
  end
  local getAll = true
  for k, v in pairs(self._welfare.monthSignInfo.allRecords) do
    if not self._welfare.monthSignInfo.receivedIds[k] then
      getAll = false
    end
  end
  self._welfare.monthSignInfo.getAll = getAll
  local typeData = DataCommon.LocalTips.MonthSignOpen
  if NekoData.BehaviorManager.BM_Game:GetLocalTipsState(typeData) == typeData.Default then
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(typeData)
  elseif self._welfare.monthSignInfo.getAll then
    NekoData.BehaviorManager.BM_Game:ClearLocalTipsState(typeData)
  end
end

function DM_Welfare:OnWitchCalendarInfo(protocol)
  if not self._welfare.witchCalendarInfo then
    self._welfare.witchCalendarInfo = {}
  end
  if self._welfare.witchCalendarInfo.receivedIds then
    for k, v in pairs(self._welfare.witchCalendarInfo.receivedIds) do
      self._welfare.witchCalendarInfo.receivedIds[k] = nil
    end
  else
    self._welfare.witchCalendarInfo.receivedIds = {}
  end
  for k, v in pairs(self._welfare.witchCalendarInfo.receivedIds) do
    self._welfare.witchCalendarInfo.receivedIds[k] = nil
  end
  for _, v in ipairs(protocol.receivedAward) do
    self._welfare.witchCalendarInfo.receivedIds[v] = true
  end
  self._welfare.witchCalendarInfo.complementNum = protocol.complementNum
  self._welfare.witchCalendarInfo.month = protocol.month
  self._welfare.witchCalendarInfo.today = protocol.days
  self._welfare.witchCalendarInfo.cfgs = {}
  for i, v in ipairs(protocol.monthDay) do
    local recorder = CMonthLoginDayCell:GetRecorder(v)
    if recorder then
      self._welfare.witchCalendarInfo.cfgs[i] = recorder
    else
      LogErrorFormat("DM_Welfare", "CMonthLoginDayCell Not Exist ID:%s", v)
    end
  end
end

function DM_Welfare:OnSOldPlayerWelfare(protocol)
  if not self._welfare.oldPlayerWelfareInfo then
    self._welfare.oldPlayerWelfareInfo = {}
  end
  self._welfare.oldPlayerWelfareInfo.commonReceiveList = self._welfare.oldPlayerWelfareInfo.commonReceiveList or {}
  self._welfare.oldPlayerWelfareInfo.highReceiveList = self._welfare.oldPlayerWelfareInfo.highReceiveList or {}
  for k, v in pairs(self._welfare.oldPlayerWelfareInfo.commonReceiveList) do
    self._welfare.oldPlayerWelfareInfo.commonReceiveList[k] = nil
  end
  for i, v in ipairs(protocol.commonReceiveList) do
    self._welfare.oldPlayerWelfareInfo.commonReceiveList[v] = true
  end
  for k, v in pairs(self._welfare.oldPlayerWelfareInfo.highReceiveList) do
    self._welfare.oldPlayerWelfareInfo.highReceiveList[k] = nil
  end
  for i, v in ipairs(protocol.highReceiveList) do
    self._welfare.oldPlayerWelfareInfo.highReceiveList[v] = true
  end
  self._welfare.oldPlayerWelfareInfo.totalSignNum = protocol.totalSignNum
  self._welfare.oldPlayerWelfareInfo.isPay = protocol.isPay == 1
end

function DM_Welfare:OnSconsumptionInfo(protocol)
  self._welfare.accumulateCost = protocol
end

function DM_Welfare:OnMinDiscountInfo(protocol)
  self._welfare.minDicountWelfareInfo = protocol
end

function DM_Welfare:OnCommunityShareInfo(protocol)
  self._welfare.communityShareInfo = protocol
end

return DM_Welfare

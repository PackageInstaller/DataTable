local CLevelReward = BeanManager.GetTableByName("welfare.clevelreward")
local CMonthLoginDayCell = BeanManager.GetTableByName("welfare.cmonthlogindaycell")
local SLevelUpRewardInfoDef = LuaNetManager.GetProtocolDef("protocol.shop.sleveluprewardinfo")
local CommonAwardsSatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
local COldPlayerWelfareTarget = BeanManager.GetTableByName("welfare.coldplayerwelfaretarget")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local Item = require("logic.manager.experimental.types.item")
local BM_Welfare = class("BM_Welfare")

function BM_Welfare:Ctor()
  self._welfare = NekoData.Data.welfare
end

function BM_Welfare:GetTotalLoginInfo()
  return self._welfare.totalSign
end

function BM_Welfare:GetAccumulatedIndex()
  return self._welfare.totalSign.accumulatedIndex
end

function BM_Welfare:GetAccumulateSignState()
  return self._welfare.accumulateSignState
end

function BM_Welfare:GetTotleSignState()
  return self._welfare.totleSignState
end

function BM_Welfare:GetTotleSignDay()
  return self._welfare.totleSignDay
end

function BM_Welfare:GetGrowGiftInfo()
  return self._welfare.growGift
end

function BM_Welfare:GrowGiftShowRedDot()
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.GrowGift) then
    local tag = NekoData.BehaviorManager.BM_Game:GetGuideTagByType(GuidTypes.LEVEL_GIFT)
    if not tag or tag == 0 then
      return true
    end
    if not self:IsBoughtGrowGift() then
      return false
    end
    local userLevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
    local getMap = self._welfare.growGift.getMap
    local allIds = CLevelReward:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CLevelReward:GetRecorder(allIds[i])
      if userLevel >= record.level then
        if not getMap[record.id] then
          return true
        end
      else
        return false
      end
    end
  end
end

function BM_Welfare:IsBoughtGrowGift()
  return self._welfare.growGift.bought and self._welfare.growGift.bought == SLevelUpRewardInfoDef.CHARGE
end

function BM_Welfare:ShowWelfareEntrance_GrowGift()
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.GrowGift) then
    if not self:IsBoughtGrowGift() then
      return true
    end
    local userLevel = NekoData.BehaviorManager.BM_Game:GetUserLevel()
    local getMap = self._welfare.growGift.getMap
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

function BM_Welfare:GetFirstRechargeGiftState()
  return self._welfare.firstRechargeGiftStates
end

function BM_Welfare:GetFirstChargeData()
  return self._welfare.firstChargeData
end

function BM_Welfare:GetFirstChargeAwardById(id)
  if not self._welfare.firstChargeData.awards then
    return nil
  end
  for k, v in pairs(self._welfare.firstChargeData.awards) do
    if v.id == id then
      return v
    end
  end
  return nil
end

function BM_Welfare:GetFitstRechargeGiftRedPoint()
  return self._welfare.fitstRechargeGiftRedPoint
end

function BM_Welfare:IsFitstRechargeGiftAllGet()
  if not self._welfare.firstRechargeGiftStates.statue or self._welfare.firstRechargeGiftStates.statue == 0 then
    return false
  end
  for k, v in pairs(self._welfare.firstRechargeGiftStates.giftsState) do
    if v == 0 then
      return false
    end
  end
  if table.nums(self._welfare.firstRechargeGiftStates.giftsState) < 2 then
    return false
  end
  return true
end

function BM_Welfare:IsLimitedInvestmentOpen()
  local info = self._welfare.limitedInvestmentInfo
  return info and (info.currentChannel == 0 or 0 < info.leftTimes)
end

function BM_Welfare:ShowLimitedInvestmentRedDot()
  local info = self._welfare.limitedInvestmentInfo
  return NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.LimitedInvestmentOpen) or info and info.currentChannel ~= 0 and info.todayFetched == 0
end

function BM_Welfare:GetLimitedInvestmentInfo()
  return self._welfare.limitedInvestmentInfo
end

function BM_Welfare:IsMonthSignOpen()
  if self._welfare.monthSignInfo and not self._welfare.monthSignInfo.getAll then
    return true
  end
end

function BM_Welfare:ShowMonthSignRedDot()
  if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.MonthSignOpen) then
    return true
  end
  if self:IsMonthSignOpen() then
    for k, v in pairs(self._welfare.monthSignInfo.allRecords) do
      if not self._welfare.monthSignInfo.receivedIds[k] and v.cumulativeDays <= self._welfare.monthSignInfo.signTotalNum then
        return true
      end
    end
  end
end

function BM_Welfare:GetMonthSignInfo()
  return self._welfare.monthSignInfo
end

function BM_Welfare:ShowWelfareEntrance()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Welfare) then
    return false
  end
  if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):ShowWelfareEntrance_Sign() then
    return true
  end
  if self:ShowWelfareEntrance_GrowGift() then
    return true
  end
  if NekoData.BehaviorManager.BM_SevenGrow:GetSevenDaysIsOpen() then
    return true
  end
  if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID):GetCurrentActId() > 0 then
    return true
  end
  if NekoData.BehaviorManager.BM_Foresight:GetIsOpen() then
    return true
  end
  if NekoData.BehaviorManager.BM_AnniversaryShare:GetIsOpen() then
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

function BM_Welfare:ShowWelfareRedDot()
  if self:ShowWelfareEntrance() then
    if self:GrowGiftShowRedDot() then
      return true
    end
    if NekoData.BehaviorManager.BM_ActivityTasks:SevenDaysShowRedDot() then
      return true
    end
    if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID):ShowRedDot() then
      return true
    end
    if NekoData.BehaviorManager.BM_AnniversaryShare:GetHaveRedDot() then
      return true
    end
    if NekoData.BehaviorManager.BM_Welfare:ShowLimitedInvestmentRedDot() then
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

function BM_Welfare:GetWitchCalendarInfo()
  if self._welfare.witchCalendarInfo then
    return self._welfare.witchCalendarInfo
  end
end

function BM_Welfare:IsWitchCalendarOpen()
  if self._welfare.witchCalendarInfo then
    return true
  end
end

function BM_Welfare:ShowWitchCalendarRedDot()
  if self:IsWitchCalendarOpen() and not self._welfare.witchCalendarInfo.receivedIds[self._welfare.witchCalendarInfo.today] then
    return true
  end
end

function BM_Welfare:GetAccumulateCost()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.AccumulateCost) then
    return self._welfare.accumulateCost
  end
end

function BM_Welfare:ShowAccumulateCostRedDot()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.AccumulateCost) and self._welfare.accumulateCost then
    for k, v in pairs(self._welfare.accumulateCost.awardStatus) do
      if v.status == CommonAwardsSatus.UNLOCKED then
        return true
      end
    end
  end
end

function BM_Welfare:GetOldPlayerWelfareInfo()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OldPlayerBenefits) then
    return self._welfare.oldPlayerWelfareInfo
  end
end

function BM_Welfare:GetOldPlayerWelfarePageScore(pageID)
  if pageID == 1 then
    return self._welfare.oldPlayerWelfareInfo.totalSignNum
  elseif pageID == 2 then
    return NekoData.BehaviorManager.BM_Game:GetUserLevel()
  elseif pageID == 3 then
    return NekoData.BehaviorManager.BM_Shop:GetChargAccumulationTotalScore() or 0
  else
    LogErrorFormat("BM_Welfare", "GetOldPlayerWelfarePageInfoByIndex:%s", pageID)
  end
end

function BM_Welfare:GetOldPlayerWelfarePageInfoByPageID(pageID)
  local result = {}
  local curValue = self:GetOldPlayerWelfarePageScore(pageID)
  local allIds = COldPlayerWelfareTarget:GetAllIds()
  for _, v in pairs(allIds) do
    local record = COldPlayerWelfareTarget:GetRecorder(v)
    if record.targetType == pageID then
      table.insert(result, {cfg = record})
    end
  end
  table.sort(result, function(a, b)
    if a.cfg.target < b.cfg.target then
      return true
    end
  end)
  for i, v in ipairs(result) do
    local cfg = v.cfg
    v.process = curValue / cfg.target
    v.process = v.process > 1 and 1 or v.process
    local leftValue = curValue > cfg.target and cfg.target or curValue
    v.cur = leftValue
    v.hasReward = self:HasCanReceiveOldPlayerWelfareByRewardID(v.cfg.id)
    v.isDone = self:IsDoneReceiveOldPlayerWelfareByReWardID(v.cfg.id)
    v.isPay = self:IsPayOldPlayerWelfare()
    local itemData = {}
    table.insert(itemData, {
      itemID = cfg.itemID,
      itemCount = cfg.itemNum,
      isReceived = self._welfare.oldPlayerWelfareInfo.commonReceiveList[v.cfg.id]
    })
    for i, v in ipairs(cfg.payItemID) do
      table.insert(itemData, {
        itemID = v,
        itemCount = cfg.payItemNum[i],
        isLock = not self:IsPayOldPlayerWelfare(),
        isReceived = self._welfare.oldPlayerWelfareInfo.highReceiveList[cfg.id]
      })
    end
    v.awardItemData = itemData
  end
  return result
end

function BM_Welfare:IsDoneReceiveOldPlayerWelfareByReWardID(rewardID)
  return self._welfare.oldPlayerWelfareInfo.commonReceiveList[rewardID] and self._welfare.oldPlayerWelfareInfo.highReceiveList[rewardID]
end

function BM_Welfare:HasCanReceiveOldPlayerWelfareByRewardID(rewardID)
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OldPlayerBenefits) then
    return
  end
  local result = false
  local highResult = false
  local record = COldPlayerWelfareTarget:GetRecorder(rewardID)
  local pageScore = self:GetOldPlayerWelfarePageScore(record.targetType)
  if not pageScore then
    return
  end
  local enoughPoints = pageScore >= record.target
  result = not self._welfare.oldPlayerWelfareInfo.commonReceiveList[rewardID]
  if self:IsPayOldPlayerWelfare() then
    highResult = not self._welfare.oldPlayerWelfareInfo.highReceiveList[rewardID]
  end
  return (result or highResult) and enoughPoints
end

function BM_Welfare:HasCanReceiveOldPlayerWelfareByPageID(pageID)
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OldPlayerBenefits) then
    return
  end
  local allIds = COldPlayerWelfareTarget:GetAllIds()
  for _, v in pairs(allIds) do
    local record = COldPlayerWelfareTarget:GetRecorder(v)
    if record.targetType == pageID then
      local result = self:HasCanReceiveOldPlayerWelfareByRewardID(v)
      if result then
        return true
      end
    end
  end
end

function BM_Welfare:ShowOldPlayerWelfareRedDot()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OldPlayerBenefits) then
    local allIds = COldPlayerWelfareTarget:GetAllIds()
    for _, v in pairs(allIds) do
      local result = self:HasCanReceiveOldPlayerWelfareByRewardID(v)
      if result then
        return true
      end
    end
  end
end

function BM_Welfare:IsPayOldPlayerWelfare()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OldPlayerBenefits) then
    return self._welfare.oldPlayerWelfareInfo.isPay
  end
end

function BM_Welfare:IsShowMinDiscount()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.MinDiscount) and self._welfare.minDicountWelfareInfo and self._welfare.minDicountWelfareInfo.leftTime > 0 then
    return true
  end
end

function BM_Welfare:ShowMinDiscountRedDot()
  if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.MinDiscount) and self:IsShowMinDiscount() then
    return self._welfare.minDicountWelfareInfo.redDot == 1
  end
end

function BM_Welfare:GetMinDiscoundtWelfareInfo()
  local serverData = self._welfare.minDicountWelfareInfo
  if serverData then
    local data = {}
    data.goodInfo = serverData.goodInfo
    local itemData = {}
    for i, v in ipairs(data.goodInfo.itemId) do
      table.insert(itemData, {
        itemID = v,
        itemCount = data.goodInfo.itemSum[i]
      })
    end
    data.cellData = itemData
    data.leftTime = serverData.leftTime
    return data
  end
end

function BM_Welfare:ShowCommunityShareInfoRedDot()
  if self._welfare.communityShareInfo then
    if self._welfare.communityShareInfo.statue == 0 or self._welfare.communityShareInfo.statue == 1 then
      return true
    else
      return false
    end
  end
  return false
end

function BM_Welfare:GetCommunityShareInfo()
  return self._welfare.communityShareInfo
end

return BM_Welfare

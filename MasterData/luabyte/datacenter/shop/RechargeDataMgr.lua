local RechargeDataMgr = BaseClass("RechargeDataMgr", Singleton)
local M = RechargeDataMgr
local ShopBagType = RechargeConst.ShopBagType
local MessageId = Proto.MessageId
local tInsert = table.insert
local tIsNullOrEmpty = table.isNullOrEmpty
local HOURS5 = 18000

function M:__init(obj)
    self._rechargeCfgs = nil
    self._giftPackCfgs = nil
    self._clothCfgs = nil
    self._firstRechargeList = nil
    self._remainingDays = 0
    self._curRecommendType = nil
    self._rechargeInfoCallback = nil
    self._monthCardRewardCallback = nil
    self._firstRechargeInfo = nil
    self._firstRechargeDay = ConfigHelper.GetSystemParams(330)
    self._firstRechargeDays = nil
    self._responseRechargeInfo =
        NetPack:RegistResponse(MessageId.ResponseRechargeInfo, Bind(self, self.OnResponseRechargeInfo))

    self._responseMonthCardInfo =
        NetPack:RegistResponse(MessageId.ResponseMonthCardInfo, Bind(self, self.OnResponseMonthCardInfo))

    self._notifyRechargeMonthCard =
        NetPack:RegistResponse(MessageId.NotifyRechargeMonthCard, Bind(self, self.OnNotifyRechargeMonthCard))

    self._responseFirstChargeReward =
        NetPack:RegistResponse(MessageId.ResponseFirstChargeReward, Bind(self, self.OnResponseFirstChargeReward))
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseRechargeInfo, self._responseRechargeInfo)
    NetPack:UnRegistResponse(MessageId.ResponseMonthCardInfo, self._responseMonthCardInfo)
    NetPack:UnRegistResponse(MessageId.ResponseMonthCardReward, self._responseMonthCardReward)
    NetPack:UnRegistResponse(MessageId.NotifyRechargeMonthCard, self._notifyRechargeMonthCard)
    NetPack:UnRegistResponse(MessageId.ResponseFirstChargeReward, self._responseFirstChargeReward)

    self._rechargeCfgs = nil
    self._giftPackCfgs = nil
    self._clothCfgs = nil
    self._firstRechargeList = nil
    self._remainingDays = nil
    self._rechargeInfoCallback = nil
    self._monthCardRewardCallback = nil
end

---------------------初始化数据Begin----------------------

function M:_InitData()
    self._rechargeCfgs = {}
    self._giftPackCfgs = {}
    self._clothCfgs = {}
    local rechargeShopCfgs = ConfigHelper.GetCfgsByLua("rechargeShop")
    for _, rechargeCfg in pairs(rechargeShopCfgs) do
        if rechargeCfg.isShow == RechargeConst.IsShow.On then
            tInsert(self._rechargeCfgs, rechargeCfg)
        end
    end

    self._clothCfgs = ConfigHelper.GetCfgsByLua("shopSkin")

    local shopBagCfgs = ConfigHelper.GetCfgsByLua("shopBag")
    local isAddFreeLevelPack = false
    local isAddPaidLevelPack = false
    for key, shopBagCfg in pairs(shopBagCfgs) do
        if shopBagCfg.isShow == RechargeConst.IsShow.On then
            if shopBagCfg.type == ShopBagType.WeeklyPack or shopBagCfg.type == ShopBagType.MonthlyPack or
                shopBagCfg.type == ShopBagType.FixedPack then
                --判断礼包是否过期
                if self:GetWeeklyCfg(shopBagCfg) then
                    tInsert(self._giftPackCfgs, shopBagCfg)
                end
            elseif shopBagCfg.type == ShopBagType.FreeLevelPack and isAddFreeLevelPack == false then
                isAddFreeLevelPack = true
                tInsert(self._giftPackCfgs, shopBagCfg)
            elseif shopBagCfg.type == ShopBagType.PaidLevelPack and isAddPaidLevelPack == false then
                isAddPaidLevelPack = true
                tInsert(self._giftPackCfgs, shopBagCfg)
            elseif shopBagCfg.type ~= ShopBagType.FreeLevelPack and shopBagCfg.type ~= ShopBagType.PaidLevelPack then
                tInsert(self._giftPackCfgs, shopBagCfg)
            end
        end
    end
end

---------------------初始化数据End----------------------

---------------------网络消息Begin----------------------

function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:RequestRechargeInfo()
    self:_InitData()
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

function M:Cleanup()
end

function M:RequestRechargeInfo(callback)
    if not self._firstRechargeList then
        self._rechargeInfoCallback = callback
        NetPack:SendMessage(MessageId.RequestRechargeInfo, {})
    else
        if callback then
            callback()
        end
    end
end

function M:OnResponseRechargeInfo(messageId, result, msg)
    self:RequestMonthCardInfo()
    if result ~= 0 then
        self._rechargeInfoCallback = nil
        return
    end

    self:_UpdateRechargeState(msg.RechargeState, msg.Info)
    if self._rechargeInfoCallback then
        self._rechargeInfoCallback()
        self._rechargeInfoCallback = nil
    end
end

function M:RequestMonthCardInfo(callback)
    self._monthCardRewardCallback = callback
    NetPack:SendMessage(MessageId.RequestMonthCardInfo, {})
end

function M:OnResponseMonthCardInfo(messageId, result, msg)
    self._dataLoaded = true
    self._isloading = false
    EventMgr:Broadcast(UIMessageNames.RECHARGE_STATE_UPDATE)
    if result ~= 0 then
        if self._monthCardRewardCallback then
            self._monthCardRewardCallback(false)
            self._monthCardRewardCallback = nil
        end
        return
    end

    self._remainingDays = TimeUtil.GetMonthCardRemainDays(msg.EndTime)
end

function M:OnNotifyRechargeMonthCard(messageId, result, msg)
    if result ~= 0 then
        return
    end

    self._remainingDays = TimeUtil.GetMonthCardRemainDays(msg.EndTime)
    if self._remainingDays > 0 then
        local itemDict = self:_GetItemDictByItems(msg.AwardItems)
        if itemDict then
            GameHelper.ShowGetItems(itemDict)
        end
    end
    self:_UpdateRechargeState(msg.RechargeState, msg.FirstInfo)
    EventMgr:Broadcast(UIMessageNames.MONTH_CARD_DAYS_UPDATE, ShopDataMgr.shopBags)
    SDKHelper.Submit()
end

--请求首充奖励
function M:RequestFirstChargeReward(callback)
    self._firstChargeRewardCallback = callback
    NetPack:SendMessage(MessageId.RequestFirstChargeReward, {})
end

--首充奖励回调
function M:OnResponseFirstChargeReward(messageId, result, msg)
    if result ~= 0 then
        return
    end

    self:_UpdateRechargeState(nil, msg.FirstInfo)
    if self._firstChargeRewardCallback then
        self._firstChargeRewardCallback(msg.Reward)
    end
    self._firstChargeRewardCallback = nil
end

---------------------网络消息End----------------------

---------------------设置数据Begin--------------------

--更新首充状态
function M:_UpdateRechargeState(stateValue, firstRechargeInfo)
    if firstRechargeInfo then
        --首充埋点
        if (self._firstRechargeInfo == nil or self._firstRechargeInfo == 0) and firstRechargeInfo.Timestamp ~= 0 then
            IBuriedPointDataMgr:SubmitData(BuriedPointConst.ActivityRecharge)
        end
        self._firstRechargeInfo = firstRechargeInfo
        if not self._firstRechargeDays then
            self._firstRechargeDays = {}
        end
        for i = 1, self._firstRechargeDay.Length do
            local res = SecurityHelper.GetRechargeState(firstRechargeInfo.AwardMask, i - 1)
            self._firstRechargeDays[i] = res
        end
    end
    if stateValue then
        if not self._firstRechargeList then
            self._firstRechargeList = {}
        end
        local i = 1
        for _, _ in pairs(ConfigHelper.GetCfgsByLua("rechargeShop")) do
            local res = SecurityHelper.GetRechargeState(stateValue, i)
            self._firstRechargeList[i] = res
            i = i + 1
        end
    end
    EventMgr:Broadcast(UIMessageNames.RECHARGE_STATE_UPDATE)
end

---------------------设置数据End----------------------

---------------------获取数据Begin--------------------

function M:_GetItemDict(stoneNum, items)
    local itemDict = {}
    itemDict[6] = stoneNum
    if not tIsNullOrEmpty(items) then
        for i = 1, #items do
            if items[i].Id == 6 then
                itemDict[6] = itemDict[6] + items[i].Cnt
            else
                itemDict[items[i].Id] = items[i].Cnt
            end
        end
    end
    return itemDict
end

function M:_GetItemDictByItems(items)
    if not tIsNullOrEmpty(items) then
        local itemDict = {}
        for i = 1, #items do
            if not itemDict[items[i].Id] then
                itemDict[items[i].Id] = items[i].Cnt
            else
                itemDict[items[i].Id] = itemDict[items[i].Id] + items[i].Cnt
            end
        end
        return itemDict
    end
    return nil
end

function M:GetRechargeCfgs()
    return self._rechargeCfgs
end

function M:GetClothCfgs()
    return self._clothCfgs
end

function M:_GetRechargeCfg(id)
    if not tIsNullOrEmpty(self._rechargeCfgs) then
        for i = 1, #self._rechargeCfgs do
            if self._rechargeCfgs[i].id == id then
                return self._rechargeCfgs[i]
            end
        end
    end
    return nil
end

function M:GetGiftPackCfgs()
    return self._giftPackCfgs
end

function M:GetRemainingDays()
    return self._remainingDays
end

function M:GetMonthBuyItems()
    self.items = {}
    local param1 = ConfigHelper.GetSystemParams(236)
    self:_SetSystemParamsData(param1, false)
    local param2 = ConfigHelper.GetSystemParams(237)
    self:_SetSystemParamsData(param2, true)
    return self.items
end

function M:_SetSystemParamsData(params, everyDay)
    if params and params.Length > 1 then
        for i = 0, params.Length - 1 do
            if i % 2 == 0 then
                local id = params[i]
                local num = params[i + 1]
                local data = {
                    id = id,
                    num = num,
                    every_day = everyDay --每日获得
                }
                tInsert(self.items, data)
            end
        end
    end
end

function M:GetShopBagCfgs(type)
    local shopBagCfgs = ConfigHelper.GetCfgs("shopBag")
    local data = {}
    for _, v in pairs(shopBagCfgs) do
        if v.type == type then
            tInsert(data, v)
        end
    end
    return data
end

function M:GetWeeklyCfg(shopBagcfg)
    local nowTime = TimeUtil.GetNowTimeStamp()
    if shopBagcfg.startTime <= nowTime and shopBagcfg.endTime > nowTime then
        return true
    end
end

---------------------获取数据End----------------------

---------------------数据判断Begin--------------------

function M:IsFirstRecharge(index)
    if self._firstRechargeList then
        return self._firstRechargeList[index]
    end
    return nil
end

function M:IsFirstRechargeDayReward(index)
    if self._firstRechargeDays then
        return self._firstRechargeDays[index]
    end
    return nil
end

function M:IsELessThreeDays()
    if self._remainingDays <= 3 then
        return true
    end
    return false
end

--月卡是否可以购买
function M:CheckBuyMonthCard(cardId)
    local cfg = ConfigHelper.GetCfgByLua("shopCard", cardId)
    return self._remainingDays <= cfg.buyTime
end

--获取首充奖励状态
function M:GetFirstRechargeState()
    return self._firstRechargeInfo.Timestamp ~= 0
end

--判断当天首充奖励是否解锁
function M:CheckFirstRechargeDay(day)
    local curDayIndex = TimeUtil.GetDayIndex(TimeUtil.GetNowTimeStamp() - HOURS5)
    local firstDayIndex = TimeUtil.GetDayIndex(self._firstRechargeInfo.Timestamp - HOURS5)
    local index = curDayIndex - firstDayIndex
    return day <= index + 1
end

--是否有可领取的首充奖励
function M:CheckFirstRechargeReward()
    if not self._dataLoaded then
        return
    end
    local curDayIndex = TimeUtil.GetDayIndex(TimeUtil.GetNowTimeStamp() - HOURS5)
    local firstDayIndex = TimeUtil.GetDayIndex(self._firstRechargeInfo.Timestamp - HOURS5)
    local index = curDayIndex - firstDayIndex
    if self._firstRechargeDays[index + 1] ~= nil then
        if index + 1 == #self._firstRechargeDays then
            if self._firstRechargeDays[index + 1] == false then
                return nil
            else
                return true
            end
        else
            return self._firstRechargeDays[index + 1]
        end
    else
        for key, value in pairs(self._firstRechargeDays) do
            if value == true then
                return true
            end
        end
    end
    return nil
end

--获取首充红点状态
function M:GetFirstRechargeRedPoint()
    if self._firstRechargeInfo.Timestamp > 0 then
        local value = self:CheckFirstRechargeReward()
        if value then
            return 1
        end
    end
    return 0
end

---------------------数据判断End----------------------

return RechargeDataMgr

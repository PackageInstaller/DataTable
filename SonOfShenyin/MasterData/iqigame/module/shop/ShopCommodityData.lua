-- chunkname: @IQIGame\\Module\\Shop\\ShopCommodityData.lua

ShopCommodityData = {
	residueShowTime = 0,
	sortWeight = 0,
	curDataCreateTime = 0,
	isShow = true,
	circulationType = {
		noRefresh = 0,
		limitDay = 2,
		fixationDay = 3,
		weekDay = 1,
		everyDay = -1
	},
	StartShowTime = {},
	EndShowTime = {},
	weightEasy = {
		noLimitBuy = 1,
		noSellOut = 2,
		sellOut = 3
	}
}

function ShopCommodityData.New(commodityCfg, shopID)
	local o = Clone(ShopCommodityData)

	o:Initialize(commodityCfg, shopID)

	return o
end

function ShopCommodityData:Initialize(commodityCfg, shopID)
	self.shopID = shopID
	self.cid = commodityCfg.Id
	self.config = commodityCfg

	local buyCount = PlayerModule.PlayerInfo.commodityBuyRecords[commodityCfg.Id] or 0

	self.buyNum = buyCount
	self.useDouble = buyCount > 0
	self.startTime = 0

	if commodityCfg.OpenTime ~= "" then
		self.startTime = cfgDateTimeToTimeStamp(commodityCfg.OpenTime, PlayerModule.TimeZone)
	end

	self.endTime = 0

	if commodityCfg.CloseTime ~= "" then
		self.endTime = cfgDateTimeToTimeStamp(commodityCfg.CloseTime, PlayerModule.TimeZone)
	end

	local serverTime = PlayerModule.GetServerTime()

	if serverTime <= tonumber(self.startTime) then
		self.itemFreshTime = self.startTime
	else
		self.itemFreshTime = self.endTime
	end

	self.isShow = ConditionModule.Check(commodityCfg.UnlockConditionId)
	self.isBuy = ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(commodityCfg.BuyConditionId))
	self.buyConditionId = commodityCfg.BuyConditionId[1]
	self.isRecommend = commodityCfg.Recommend
	self.buyLimit = self:RefreshLimitInfo()
	self.sortWeight = commodityCfg.sort

	self:CheckSpecialInfo()
	self:CheckShopShowStatus()
end

function ShopCommodityData:CheckSpecialInfo()
	self.TextLimit = ShopUIApi:TextLimitNormal()
	self.refreshType = self.config.ResetType

	if self.startTime ~= nil and self.endTime ~= nil and self.startTime ~= 0 and self.endTime ~= 0 then
		self.refreshType = Constant.ShopRefreshType.Timer
	elseif self.config.ResetType == Constant.ShopRefreshType.Day then
		self.TextLimit = ShopUIApi:TextLimitDay()
	elseif self.config.ResetType == Constant.ShopRefreshType.Weekly then
		self.TextLimit = ShopUIApi:TextLimitWeekly()
	elseif self.config.ResetType == Constant.ShopRefreshType.Month then
		self.TextLimit = ShopUIApi:TextLimitMonth()
	end

	if self.config.Time == 0 then
		self.buyLimitType = Constant.ShopBuyLimitType.Unlimited
		self.sellType = Constant.ShopSellType.NonSellOut
	else
		self.buyLimitType = Constant.ShopBuyLimitType.Limit

		if self.buyNum < self.config.Time then
			self.sellType = Constant.ShopSellType.NonSellOut
		else
			self.sellType = Constant.ShopSellType.SellOut
		end
	end

	self.isDiscount = self.config.DiscountRate ~= 0
	self.isDiscountWithoutPrice = self.isDiscount and #self.config.Discount == 0
end

function ShopCommodityData:CheckShopShowStatus()
	if self.refreshType == Constant.ShopRefreshType.None and self.buyLimitType == Constant.ShopBuyLimitType.Limit and self.buyNum >= self.config.Time and self.config.TimeOvrtShow == 0 then
		self.isShow = false
	end

	if self.refreshType == Constant.ShopRefreshType.Timer then
		if self.buyNum >= self.config.Time and self.config.TimeOvrtShow == 0 then
			self.isShow = false
		end

		local serverTime = PlayerModule.GetServerTime()

		if serverTime >= tonumber(self.endTime) or serverTime <= tonumber(self.startTime) then
			self.isShow = false
		end
	end
end

function ShopCommodityData:GetRefreshTimeText()
	local str

	if self.refreshType == Constant.ShopRefreshType.Day then
		local resetTime = tonumber(PlayerModule.PlayerInfo.baseInfo.todayResetTime) / 1000

		str = DateStandardFormation(resetTime - PlayerModule.GetServerTime())
	elseif self.refreshType == Constant.ShopRefreshType.Weekly then
		local resetTime = tonumber(PlayerModule.PlayerInfo.baseInfo.weekResetTime) / 1000

		str = DateStandardFormation(resetTime - PlayerModule.GetServerTime())
	elseif self.refreshType == Constant.ShopRefreshType.Month then
		local resetTime = tonumber(PlayerModule.PlayerInfo.baseInfo.monthResetTime) / 1000

		str = DateStandardFormation(resetTime - PlayerModule.GetServerTime())
	elseif self.refreshType == Constant.ShopRefreshType.Timer then
		local s = tonumber(self.itemFreshTime) - PlayerModule.GetServerTime()

		if s <= 0 then
			local commodityBuyRecords = {}

			commodityBuyRecords[self.cid] = 0

			ShopModule.NotifychangeShopItems(commodityBuyRecords)
		end

		str = DateStandardFormation(s)
	end

	return str
end

function ShopCommodityData:GetPrice()
	local num = self.buyNum + 1
	local price = 0

	if self.config.Price[num] and #self.config.Price[num] > 1 then
		price = self.config.Price[num][2]
	else
		price = self.config.Price[1][2]
	end

	if self.config.BuyType == Constant.BuyShopType.Rmb then
		price = price / 100
	end

	return price
end

function ShopCommodityData:GetPriceIconId()
	local num = self.buyNum + 1
	local IconID = 0

	if self.config.Price[num] and getCfgTableLength(self.config.Price[num]) > 1 then
		IconID = self.config.Price[num][1]
	else
		IconID = self.config.Price[1][1]
	end

	return IconID
end

function ShopCommodityData:GetDiscount()
	if self.config.BuyType == Constant.BuyShopType.Rmb then
		return self.config.Discount[2] / 100
	else
		return self.config.Discount[2]
	end
end

function ShopCommodityData:GetFinalPrice()
	if self.isDiscount and not self.isDiscountWithoutPrice then
		return self:GetDiscount()
	end

	return self:GetPrice()
end

function ShopCommodityData:GetDiscountPercentText()
	if not self.isDiscount then
		return
	end

	local discount = 0
	local isOverseas = CfgDiscreteDataTable[10002].Data[1] == 0

	if not isOverseas then
		discount = self.config.DiscountRate
	else
		discount = self.config.DiscountRate
	end

	return ShopUIApi:GetDiscountText(discount, isOverseas)
end

function ShopCommodityData:GetLimitText()
	return self.TextLimit
end

function ShopCommodityData:IsLongTremCommodity()
	local isNotBuyLimit = self.buyLimitType == Constant.ShopBuyLimitType.Unlimited
	local isNotBuyTime = self.refreshType == Constant.ShopRefreshType.None

	return isNotBuyLimit and isNotBuyTime
end

function ShopCommodityData:IsDiscountCommodity()
	return self.isDiscount
end

function ShopCommodityData:IsLimitTimeCommodity()
	return self.refreshType == Constant.ShopRefreshType.Timer
end

function ShopCommodityData:IsCyclicRefreshCommodity()
	return self.refreshType ~= Constant.ShopRefreshType.Timer and self.refreshType ~= Constant.ShopRefreshType.None and not self.config.Free
end

function ShopCommodityData:RefreshLimitInfo()
	if #self.config.addTime == 0 or self.config.Time == 0 then
		return self.config.Time
	end

	local shopLv = MazeModule.GetShopLevel()
	local addLimitNum = 0

	if #self.config.addTime > 0 then
		if shopLv > #self.config.addTime then
			addLimitNum = self.config.addTime[#self.config.addTime]
		else
			addLimitNum = self.config.addTime[shopLv]
		end
	end

	return self.config.Time + addLimitNum
end

return ShopCommodityData

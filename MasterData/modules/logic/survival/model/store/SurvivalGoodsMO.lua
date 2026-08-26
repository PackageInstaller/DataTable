-- chunkname: @modules/logic/survival/model/store/SurvivalGoodsMO.lua

module("modules.logic.survival.model.store.SurvivalGoodsMO", package.seeall)

local SurvivalGoodsMO = pureTable("SurvivalGoodsMO")

function SurvivalGoodsMO:setData(survivalOutSideMallItem)
	local survivalOutSideMallItem = survivalOutSideMallItem

	self.goodsId = survivalOutSideMallItem.id
	self.config = lua_survival_reward_shop.configDict[self.goodsId]
	self.remainBuyCount = survivalOutSideMallItem.count
	self.buyCount = self:getMaxBuyCount() - self.remainBuyCount
end

function SurvivalGoodsMO:onReceiveSurvivalOutsideShopBuyReply(count)
	self.buyCount = self.buyCount + count
	self.remainBuyCount = self.remainBuyCount - count
end

function SurvivalGoodsMO:getTagId()
	return self.config.tag
end

function SurvivalGoodsMO:getMaxBuyCount()
	return self.config.maxBuyCount
end

function SurvivalGoodsMO:getRemainBuyCount()
	return self.remainBuyCount
end

function SurvivalGoodsMO:isSoldOut()
	return self:getMaxBuyCount() > 0 and self:getMaxBuyCount() <= self.buyCount
end

function SurvivalGoodsMO:getBuyMaxQuantity()
	local result = -1
	local limitType = StoreEnum.LimitType.Default
	local buyLimit = 0

	buyLimit = self.config.maxBuyCount > 0 and math.max(self.config.maxBuyCount - self.buyCount, 0) or -1

	local currencyChanged = false
	local currencyLimit = 0

	if self.config.cost and self.config.cost ~= "" then
		local spend = {}
		local costs = string.split(self.config.cost, "|")

		if #costs > 1 then
			currencyChanged = true
		end

		local storeMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

		while currencyLimit < storeMaxBuyCount do
			if not costs[self.buyCount + currencyLimit + 1] then
				local costParam = costs[#costs]
				local costInfo = string.splitToNumber(costParam, "#")
				local costType = costInfo[1]
				local costId = costInfo[2]
				local costQuantity = costInfo[3]

				if self.buyCount + currencyLimit + 1 >= #costs then
					if costQuantity == 0 then
						currencyLimit = -1

						break
					end

					local hasQuantity = ItemModel.instance:getItemQuantity(costType, costId)

					for _, item in pairs(spend) do
						if item.type == costType and item.id == costId then
							hasQuantity = hasQuantity - item.quantity
						end
					end

					currencyLimit = currencyLimit + math.floor(hasQuantity / costQuantity)

					break
				else
					table.insert(spend, {
						type = costType,
						id = costId,
						quantity = costQuantity
					})

					local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(spend)

					if not enough then
						break
					end

					currencyLimit = currencyLimit + 1
				end
			end
		end
	else
		currencyLimit = -1
	end

	if currencyChanged then
		result = math.min(buyLimit, 1)
		result = math.min(result, currencyLimit)
		limitType = StoreEnum.LimitType.CurrencyChanged

		if buyLimit < 1 and buyLimit >= 0 then
			limitType = StoreEnum.LimitType.BuyLimit
		elseif currencyLimit < 1 and currencyLimit >= 0 then
			limitType = StoreEnum.LimitType.Currency
		end
	elseif buyLimit < 0 and currencyLimit < 0 then
		logError("商品购买数量计算错误: " .. self.goodsId)

		result = -1
		limitType = StoreEnum.LimitType.Default
	elseif buyLimit < 0 then
		result = currencyLimit
		limitType = StoreEnum.LimitType.Currency
	elseif currencyLimit < 0 then
		result = buyLimit
		limitType = StoreEnum.LimitType.BuyLimit
	else
		result = math.min(buyLimit, currencyLimit)
		limitType = buyLimit <= currencyLimit and StoreEnum.LimitType.BuyLimit or StoreEnum.LimitType.Currency
	end

	return result, limitType
end

function SurvivalGoodsMO:getBuyMaxQuantityByCost2()
	local result = -1
	local limitType = StoreEnum.LimitType.Default
	local buyLimit = 0

	buyLimit = self.config.maxBuyCount > 0 and math.max(self.config.maxBuyCount - self.buyCount, 0) or -1

	local currencyChanged = false
	local currencyLimit = 0

	if self.config.cost2 and self.config.cost2 ~= "" then
		local spend = {}
		local costs = string.split(self.config.cost2, "|")

		if #costs > 1 then
			currencyChanged = true
		end

		local storeMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

		while currencyLimit < storeMaxBuyCount do
			if not costs[self.buyCount + currencyLimit + 1] then
				local costParam = costs[#costs]
				local costInfo = string.splitToNumber(costParam, "#")
				local costType = costInfo[1]
				local costId = costInfo[2]
				local costQuantity = costInfo[3]

				if self.buyCount + currencyLimit + 1 >= #costs then
					if costQuantity == 0 then
						currencyLimit = -1

						break
					end

					local hasQuantity = ItemModel.instance:getItemQuantity(costType, costId)

					for _, item in pairs(spend) do
						if item.type == costType and item.id == costId then
							hasQuantity = hasQuantity - item.quantity
						end
					end

					currencyLimit = currencyLimit + math.floor(hasQuantity / costQuantity)

					break
				else
					table.insert(spend, {
						type = costType,
						id = costId,
						quantity = costQuantity
					})

					local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(spend)

					if not enough then
						break
					end

					currencyLimit = currencyLimit + 1
				end
			end
		end
	else
		currencyLimit = -1
	end

	if currencyChanged then
		result = math.min(buyLimit, 1)
		result = math.min(result, currencyLimit)
		limitType = StoreEnum.LimitType.CurrencyChanged

		if buyLimit < 1 and buyLimit >= 0 then
			limitType = StoreEnum.LimitType.BuyLimit
		elseif currencyLimit < 1 and currencyLimit >= 0 then
			limitType = StoreEnum.LimitType.Currency
		end
	elseif buyLimit < 0 and currencyLimit < 0 then
		logError("商品购买数量计算错误: " .. self.goodsId)

		result = -1
		limitType = StoreEnum.LimitType.Default
	elseif buyLimit < 0 then
		result = currencyLimit
		limitType = StoreEnum.LimitType.Currency
	elseif currencyLimit < 0 then
		result = buyLimit
		limitType = StoreEnum.LimitType.BuyLimit
	else
		result = math.min(buyLimit, currencyLimit)
		limitType = buyLimit <= currencyLimit and StoreEnum.LimitType.BuyLimit or StoreEnum.LimitType.Currency
	end

	return result, limitType
end

function SurvivalGoodsMO:getCost(count)
	if count <= 0 then
		return 0
	end

	local cost = self.config.cost

	if string.nilorempty(cost) then
		return 0
	end

	local result = 0
	local costs = string.split(cost, "|")

	for index = self.buyCount + 1, self.buyCount + count do
		if not costs[index] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")
			local costQuantity = costInfo[3]

			if index >= #costs then
				result = result + costQuantity * (self.buyCount + count - index + 1)

				break
			else
				result = result + costQuantity
			end
		end
	end

	return result
end

function SurvivalGoodsMO:canAffordQuantity()
	if not string.nilorempty(self.config.cost) then
		local afford = 0
		local spend = {}
		local costs = string.split(self.config.cost, "|")
		local storeMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

		while afford < storeMaxBuyCount do
			if not costs[self.buyCount + afford + 1] then
				local costParam = costs[#costs]
				local costInfo = string.splitToNumber(costParam, "#")
				local costType = costInfo[1]
				local costId = costInfo[2]
				local costQuantity = costInfo[3]

				if self.buyCount + afford + 1 >= #costs then
					if costQuantity == 0 then
						return -1
					end

					local hasQuantity = ItemModel.instance:getItemQuantity(costType, costId)

					for _, item in pairs(spend) do
						if item.type == costType and item.id == costId then
							hasQuantity = hasQuantity - item.quantity
						end
					end

					afford = afford + math.floor(hasQuantity / costQuantity)

					break
				else
					table.insert(spend, {
						type = costType,
						id = costId,
						quantity = costQuantity
					})

					local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(spend)

					if not enough then
						break
					end

					afford = afford + 1
				end
			end
		end

		return afford
	else
		return -1
	end
end

return SurvivalGoodsMO

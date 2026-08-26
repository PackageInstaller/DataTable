-- chunkname: @modules/logic/store/model/StoreGoodsMO.lua

module("modules.logic.store.model.StoreGoodsMO", package.seeall)

local StoreGoodsMO = pureTable("StoreGoodsMO")

function StoreGoodsMO:init(belongStoreId, info)
	self.belongStoreId = belongStoreId
	self.goodsId = info.goodsId
	self.buyCount = info.buyCount
	self.offlineTime = tonumber(info.offlineTime) / 1000
	self.config = StoreConfig.instance:getGoodsConfig(self.goodsId)

	if string.nilorempty(self.config.reduction) == false then
		self.reductionInfo = string.splitToNumber(self.config.reduction, "#")
	end

	self:initRedDotTime()
end

function StoreGoodsMO:initRedDotTime()
	self.newStartTime = string.nilorempty(self.config.newStartTime) and 0 or TimeUtil.stringToTimestamp(self.config.newStartTime) - ServerTime.clientToServerOffset()
	self.newEndTime = string.nilorempty(self.config.newEndTime) and 0 or TimeUtil.stringToTimestamp(self.config.newEndTime) - ServerTime.clientToServerOffset()
end

function StoreGoodsMO:getOffTab()
	return self.config.offTag
end

function StoreGoodsMO:getOfflineTime()
	if self.config.activityId > 0 then
		return ActivityModel.instance:getActEndTime(self.config.activityId) / 1000
	else
		return self.offlineTime
	end
end

function StoreGoodsMO:getCost(count)
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

function StoreGoodsMO:getAllCostInfo()
	local costs1 = GameUtil.splitString2(self.config.cost, true)
	local costs2 = GameUtil.splitString2(self.config.cost2, true)

	return costs1, costs2
end

function StoreGoodsMO:getBuyMaxQuantity()
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

					currencyLimit = math.max(currencyLimit + math.floor(hasQuantity / costQuantity), 0)

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

function StoreGoodsMO:getBuyMaxQuantityByCost2()
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

					currencyLimit = math.max(currencyLimit + math.floor(hasQuantity / costQuantity), 0)

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

function StoreGoodsMO:canAffordQuantity()
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

function StoreGoodsMO:getLimitSoldNum()
	local product = self.config.product
	local productArr = GameUtil.splitString2(product, true)
	local itemType = productArr[1][1]
	local itemId = productArr[1][2]

	if itemType == MaterialEnum.MaterialType.Equip then
		local itemConfig = ItemModel.instance:getItemConfig(itemType, itemId)

		if not itemConfig then
			logError(string.format("获取道具配置失败: 道具类型 : %s, 道具id : %s", itemType, itemId))
		end

		return itemConfig.upperLimit
	end
end

function StoreGoodsMO:alreadyHas()
	local product = self.config.product
	local productArr = GameUtil.splitString2(product, true)
	local itemType = productArr[1][1]
	local itemId = productArr[1][2]
	local has = false

	if self.belongStoreId == StoreEnum.StoreId.NewRoomStore or self.belongStoreId == StoreEnum.StoreId.OldRoomStore then
		has = true

		for i, v in ipairs(productArr) do
			itemType = v[1]
			itemId = v[2]

			local hasQuantity = ItemModel.instance:getItemQuantity(v[1], v[2])
			local itemConfig = ItemModel.instance:getItemConfig(itemType, itemId)

			if itemConfig then
				if not itemConfig.numLimit then
					local numLimit = 1

					if numLimit == 0 or hasQuantity < numLimit then
						has = false

						break
					end
				end
			end
		end
	elseif itemType == MaterialEnum.MaterialType.PlayerCloth then
		has = PlayerClothModel.instance:hasCloth(itemId)
	elseif itemType == MaterialEnum.MaterialType.HeroSkin then
		has = HeroModel.instance:checkHasSkin(itemId)
	end

	return has
end

function StoreGoodsMO:buyGoodsReply(num)
	self.buyCount = self.buyCount + num
end

function StoreGoodsMO:hasProduct(type, id)
	local result = false

	if type and id then
		local product = self.config.product
		local productArr = GameUtil.splitString2(product, true)

		for _, productItem in ipairs(productArr) do
			if type == productItem[1] and id == productItem[2] then
				result = true

				break
			end
		end
	end

	return result
end

function StoreGoodsMO:intiActGoods(belongStoreId, actGoodsId, actPoolId)
	self.belongStoreId = belongStoreId
	self.goodsId = nil
	self.actGoodsId = actGoodsId
	self.actPoolId = actPoolId
	self.isActGoods = true
end

function StoreGoodsMO:isSoldOut()
	if self:getIsActGoods() then
		return false
	end

	if self.config.maxBuyCount > 0 and self.config.maxBuyCount <= self.buyCount then
		return true
	end

	return false
end

function StoreGoodsMO:needShowNew()
	if self:getIsActGoods() then
		return false
	end

	if self:isSoldOut() then
		return false
	else
		local serverTime = ServerTime.now()

		return serverTime >= self.newStartTime and serverTime <= self.newEndTime
	end
end

function StoreGoodsMO:getBelongStoreId()
	return self.belongStoreId
end

function StoreGoodsMO:getActGoodsId()
	return self.actGoodsId
end

function StoreGoodsMO:getIsGreatActGoods()
	return (self:getIsActGoods() or nil) and self.actPoolId == FurnaceTreasureEnum.ActGoodsPool.Great
end

function StoreGoodsMO:getIsActGoods()
	return self.isActGoods or false
end

function StoreGoodsMO:getIsJumpGoods()
	return self.config.jumpId ~= 0
end

function StoreGoodsMO:getIsPackageGoods()
	return self.config.bindgoodid ~= 0
end

function StoreGoodsMO:getIsActivityGoods()
	return self.config.activityId ~= 0
end

function StoreGoodsMO:checkJumpGoodCanOpen()
	if not self:getIsJumpGoods() then
		return true
	elseif self:getIsPackageGoods() then
		local storeMO = StoreModel.instance:getGoodsMO(self.config.bindgoodid)

		if storeMO then
			local serverTime = ServerTime.now()
			local onlineTime = TimeUtil.stringToTimestamp(storeMO.config.onlineTime)
			local offlineTime = TimeUtil.stringToTimestamp(storeMO.config.offlineTime)

			return onlineTime <= serverTime and serverTime <= offlineTime
		else
			return false
		end
	elseif self:getIsActivityGoods() then
		local status = ActivityHelper.getActivityStatus(self.config.activityId)

		if status ~= ActivityEnum.ActivityStatus.Normal then
			return false
		end
	end

	return true
end

function StoreGoodsMO:setNewRedDotKey()
	local key = PlayerPrefsKey.StoreRoomTreeItemShowNew .. self.goodsId

	GameUtil.playerPrefsSetStringByUserId(key, self.goodsId)
end

function StoreGoodsMO:checkShowNewRedDot()
	local key = PlayerPrefsKey.StoreRoomTreeItemShowNew .. self.goodsId
	local value = GameUtil.playerPrefsGetStringByUserId(key, nil)

	if self.belongStoreId ~= StoreEnum.StoreId.NewRoomStore and self.belongStoreId ~= StoreEnum.StoreId.Skin then
		return false
	end

	if value then
		return false
	end

	return true
end

function StoreGoodsMO:needShowRead()
	if self:isSoldOut() then
		return false
	else
		local serverTime = ServerTime.now()
		local inTime = serverTime >= self.newStartTime and serverTime <= self.newEndTime
		local isNew = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.StoreGoodsRead, self.goodsId)

		return isNew and inTime
	end
end

return StoreGoodsMO

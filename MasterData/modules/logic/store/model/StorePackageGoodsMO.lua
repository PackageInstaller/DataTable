-- chunkname: @modules/logic/store/model/StorePackageGoodsMO.lua

module("modules.logic.store.model.StorePackageGoodsMO", package.seeall)

local StorePackageGoodsMO = pureTable("StorePackageGoodsMO")

function StorePackageGoodsMO:initCharge(belongStoreId, info)
	self.isChargeGoods = true
	self.belongStoreId = belongStoreId
	self.goodsId = info.id
	self.id = self.goodsId
	self.buyCount = info.buyCount
	self.config = StoreConfig.instance:getChargeGoodsConfig(self.goodsId)
	self.buyLevel = 0

	if self.id == StoreEnum.LittleMonthCardGoodsId then
		local littleMonthCard = StoreConfig.instance:getMonthCardAddConfig(self.id)

		self.refreshTime = StoreEnum.ChargeRefreshTime.None
		self.maxBuyCount = littleMonthCard.limit
	else
		local limitArr = GameUtil.splitString2(self.config.limit, true)
		local arr = limitArr[1]

		self.refreshTime = arr[1]
		self.maxBuyCount = arr[1] == StoreEnum.ChargeRefreshTime.None and 0 or arr[2]

		for i, v in ipairs(limitArr) do
			if v[1] == StoreEnum.ChargeRefreshTime.Level then
				self.buyLevel = v[2]
			end
		end
	end

	self.cost = self.config.price
	self.offlineTime = string.nilorempty(self.config.offlineTime) and 0 or TimeUtil.stringToTimestamp(self.config.offlineTime)
	self._offInfos = string.split(self.config.offTag, "#")

	self:initRedDotTime()
end

function StorePackageGoodsMO:init(belongStoreId, goodsId, buyCount, offlineTime)
	self.isChargeGoods = false
	self.belongStoreId = belongStoreId
	self.goodsId = goodsId
	self.id = self.goodsId
	self.buyCount = buyCount
	self.offlineTime = offlineTime
	self.config = StoreConfig.instance:getGoodsConfig(self.goodsId)
	self.maxBuyCount = self.config.maxBuyCount
	self.refreshTime = self.config.refreshTime
	self.cost = self.config.cost
	self.buyLevel = self.config.buyLevel
	self._offInfos = string.split(self.config.offTag, "#")

	if offlineTime == nil then
		self.offlineTime = string.nilorempty(self.config.offlineTime) and 0 or tonumber(self.config.offlineTime) / 1000
	end

	self:initRedDotTime()
end

function StorePackageGoodsMO:initRedDotTime()
	local haveStartTime = not string.nilorempty(self.config.newStartTime)
	local haveEndTime = not string.nilorempty(self.config.newEndTime)

	self.newStartTime = not haveStartTime and 0 or TimeUtil.stringToTimestamp(self.config.newStartTime) - ServerTime.clientToServerOffset()
	self.newEndTime = not haveEndTime and (haveStartTime and TimeUtil.MaxValue or 0) or TimeUtil.stringToTimestamp(self.config.newEndTime) - ServerTime.clientToServerOffset()
end

function StorePackageGoodsMO:alreadyHas()
	local product = self.config.product
	local productInfo = string.split(product, "#")
	local itemType = tonumber(productInfo[1])
	local itemId = tonumber(productInfo[2])

	if itemType == MaterialEnum.MaterialType.PlayerCloth then
		return PlayerClothModel.instance:hasCloth(itemId)
	else
		return false
	end
end

function StorePackageGoodsMO:isSoldOut()
	if self.maxBuyCount > 0 and self.maxBuyCount <= self.buyCount then
		return true
	end

	return false
end

function StorePackageGoodsMO:isLevelOpen()
	return self.buyLevel <= PlayerModel.instance:getPlayerLevel()
end

function StorePackageGoodsMO:getDiscount()
	if self._offInfos[1] == StoreEnum.Discount.Discount then
		return self._offInfos[2] or 0
	end

	return 0
end

function StorePackageGoodsMO:needShowNew()
	if self:isSoldOut() then
		return false
	else
		local serverTime = ServerTime.now()
		local inTime = serverTime >= self.newStartTime and serverTime <= self.newEndTime
		local isNew = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.StoreChargeGoodsRead, self.goodsId)

		return isNew and inTime
	end
end

return StorePackageGoodsMO

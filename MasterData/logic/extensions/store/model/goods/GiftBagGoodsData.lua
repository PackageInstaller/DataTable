-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/GiftBagGoodsData.lua

module("logic.extensions.store.model.goods.GiftBagGoodsData", package.seeall)

local M = class("GiftBagGoodsData", GoodsBaseData)

function M:ctor(giftBagGoodsNO, tabId, goodsCommonInfo)
	self._goodsId = goodsCommonInfo.goodsId
	self._storeId = goodsCommonInfo.mallId
	self._autoRefreshRemainedSeconds = giftBagGoodsNO.autoRefreshRemainedSeconds
	self._remainedNum = -1

	if giftBagGoodsNO:HasField("remainedNum") then
		self._remainedNum = giftBagGoodsNO.remainedNum
	end

	self._remainedDay = -1

	if giftBagGoodsNO:HasField("remainedDay") then
		self._remainedDay = giftBagGoodsNO.remainedDay
	end

	self._name = false
	self._icon = false
	self._goodsType = false
	self._reward = false
	self._desc = false
	self._cost = false
	self._discountCost = false
	self._buyLimit = 0
	self._isDiscount = false
	self._discount = false
	self._discountPrice = false
	self._onlineEndTime = tonumber(goodsCommonInfo.endRemainedSeconds)
	self._updateTime = ServerTime.now()

	self:initData(self._goodsId, tabId, self._storeId)
end

function M:initData(goodsId, tabId, storeId)
	M.super.initData(self, goodsId, tabId, storeId)

	local goodsCo = StoreConfig.instance:getGiftBagGoods(goodsId)

	if goodsCo then
		local isDiscount, discountTick = StoreUtil._checkDiscountEnable(goodsCo)

		self._isDiscount = isDiscount
		self._discountTick = discountTick
		self._discount = goodsCo.discount

		if isDiscount and goodsCo.discountCost ~= "" then
			self._discountedCostItemId, self._discountPrice = StoreUtil.getCostPrice(goodsCo.discountCost)
		end

		self._costItemId, self._price = StoreUtil.getCostPrice(goodsCo.cost)
		self._name = goodsCo.name
		self._icon = goodsCo.icon
		self._goodsType = goodsCo.goodsType
		self._reward = goodsCo.reward
		self._desc = goodsCo.desc
		self._cost = goodsCo.cost
		self._discountCost = goodsCo.discountCost
		self._quality = goodsCo.quality
		self._onceMaxNum = goodsCo.onceMaxNum
		self._discountStartTime = goodsCo.discountStartTime
		self._discountEndTime = goodsCo.discountStartTime
		self._tag = goodsCo.tag
		self._batchBuyNum = goodsCo.batchBuyNum
		self._batchBuyCost = goodsCo.batchBuyCost
		self._dailyReward = goodsCo.dailyReward
		self._hideSellOut = goodsCo.hideSellOut
		self._autoRefreshType = goodsCo.autoRefreshType

		if goodsCo.batchBuyCost ~= "" then
			self._batchCostItemId, self._batchPrice = StoreUtil.getCostPrice(goodsCo.batchBuyCost)
		end

		local costItems = StoreUtil.formatText(goodsCo.cost)
		local len = #costItems

		if len == 1 then
			local itemId = costItems[1].itemId
			local num = costItems[1].num

			self._price = num
		end

		self._buyLimit = goodsCo.buyLimit

		self:setSortIndex(goodsCo.sortIndex)

		local rewardItems = StoreUtil.formatText(goodsCo.reward)
		local rewardLen = #rewardItems

		if rewardLen >= 1 then
			self._firstRewardTb = rewardItems[1]
		end
	end
end

function M:getName()
	return self._name or ""
end

function M:getIcon()
	return self._icon
end

function M:getBatchBuyNum()
	return self._batchBuyNum or 0
end

function M:getBatchBuyCost()
	return self._batchBuyCost or ""
end

function M:getGoodsType()
	return self._goodsType
end

function M:getReward()
	return self._reward
end

function M:getCost()
	return self._cost
end

function M:getBuyLimit()
	return self._buyLimit
end

function M:getRemainedNum()
	return self._remainedNum
end

function M:getRemainedDay()
	return self._remainedDay
end

function M:getQuality()
	return self._quality or 1
end

function M:getDiscountTimeStr()
	local result = ""

	if self._isDiscount then
		local now = ServerTime.now()

		if not string.nilorempty(self._discountEndTime) then
			local endTimeStamp = TimeUtil.instance:dateStr2TimeStamp(self._discountEndTime)
			local offsetTs = endTimeStamp - now

			if offsetTs > 0 then
				result = TextFormatter.formatFullExpireTime(offsetTs)
			end
		end
	end

	return result
end

function M:getIsDiscount()
	return self._isDiscount
end

function M:getDiscount()
	return self._discount or 0
end

function M:getDiscountPrice()
	return self._discountPrice or false
end

function M:getDiscountedCostItemId()
	return self._discountedCostItemId
end

function M:getPrice()
	return self._price
end

function M:getBatchCostItemId()
	return self._batchCostItemId or 0
end

function M:getBatchPrice()
	return self._batchPrice or 0
end

function M:getDiscountStartTime()
	return self._discountStartTime or false
end

function M:getDiscountEndTime()
	return self._discountEndTime or false
end

function M:getDiscountTick()
	return self._discountTick or false
end

function M:getDiscountCost()
	return self._discountCost
end

function M:getFirstReward()
	return self._firstRewardTb or false
end

function M:getOnceMaxNum()
	return self._onceMaxNum or 0
end

function M:getDesc()
	return self._desc
end

function M:getTag()
	return self._tag
end

function M:getAutoRefreshType()
	return self._autoRefreshType
end

function M:getDailyRewards()
	if not self._dailyRewards then
		if self._dailyReward then
			local rewardItems = StoreUtil.formatText(self._dailyReward)

			self._dailyRewards = rewardItems
		else
			self._dailyRewards = {}
		end
	end

	return self._dailyRewards
end

return M

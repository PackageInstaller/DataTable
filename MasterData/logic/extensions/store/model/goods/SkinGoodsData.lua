-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/SkinGoodsData.lua

module("logic.extensions.store.model.goods.SkinGoodsData", package.seeall)

local M = class("SkinGoodsData", GoodsBaseData)

function M:ctor(skinGoodsNO, tabId, goodsCommonInfo)
	self._goodsId = goodsCommonInfo.goodsId
	self._storeId = goodsCommonInfo.mallId
	self._onlineEndTime = tonumber(goodsCommonInfo.endRemainedSeconds)
	self._isDiscount = false
	self._updateTime = ServerTime.now()
	self._goodsType = false

	self:initData(self._goodsId, tabId, self._storeId)
end

function M:initData(goodsId, tabId, storeId)
	SkinGoodsData.super.initData(self, goodsId, tabId, storeId)

	local goodsCo = StoreConfig.instance:getSkinGoodsCoByKey(goodsId)

	if not goodsCo then
		return
	end

	self._name = goodsCo.name
	self._icon = goodsCo.icon
	self._goodsType = goodsCo.goodsType
	self._cost = goodsCo.cost
	self._tag = goodsCo.tag
	self._skinId = goodsCo.skinId
	self._desc = goodsCo.desc
	self._discountStartTime = goodsCo.discountStartTime
	self._discountEndTime = goodsCo.discountEndTime

	self:setSortIndex(goodsCo.sortIndex)

	local skinCfg = BackpackConfig.instance:getConfigByKey(ConfigName.ItemHeroSkin, self._skinId)

	self._quality = skinCfg and skinCfg.quality or 1

	local isDiscount, discountTick = StoreUtil._checkDiscountEnable(goodsCo)

	self._isDiscount = isDiscount
	self._discountTick = discountTick
	self._discount = goodsCo.discount

	if isDiscount and goodsCo.discountCost ~= "" then
		self._discountedCostItemId, self._discountPrice = StoreUtil.getCostPrice(goodsCo.discountCost)
	end

	self._costItemId, self._price = StoreUtil.getCostPrice(self._cost)
end

function M:getName()
	return self._name or ""
end

function M:getIcon()
	return self._icon
end

function M:getGoodsType()
	return self._goodsType
end

function M:getCost()
	return self._cost
end

function M:getPrice()
	if self._price then
		return self._price / 100
	end

	return 0
end

function M:getQuality()
	return self._quality
end

function M:getTag()
	return self._tag
end

function M:getIsDiscount()
	return self._isDiscount
end

function M:getSkinId()
	return self._skinId or 0
end

function M:getDiscountedCostItemId()
	return self._discountedCostItemId
end

function M:getDiscountPrice()
	return self._discountPrice
end

function M:getPrice()
	return self._price
end

function M:getDiscountTick()
	return self._discountTick or false
end

function M:getDiscountStartTime()
	return self._discountStartTime or false
end

function M:getDiscountEndTime()
	return self._discountEndTime or false
end

function M:getDiscount()
	return self._discount
end

function M:getDesc()
	return self._desc or ""
end

function M:_getCostPrice(cost)
	local costItems = StoreUtil.formatText(cost)
	local len = #costItems

	if len ~= 1 then
		if enableErrorLog then
			printError("Discounted Cost Item Length More then 1?", len)
		end

		return false, false
	end

	local itemId = costItems[1].itemId
	local num = costItems[1].num

	return itemId, num
end

return M

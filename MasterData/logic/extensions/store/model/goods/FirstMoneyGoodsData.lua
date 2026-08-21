-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/FirstMoneyGoodsData.lua

module("logic.extensions.store.model.goods.FirstMoneyGoodsData", package.seeall)

local M = class("FirstMoneyGoodsData", GoodsBaseData)

function M:ctor(goodsCommonInfo, tabId)
	self._goodsId = goodsCommonInfo.goodsId
	self._storeId = goodsCommonInfo.mallId
	self._name = false
	self._icon = false
	self._goodsType = false
	self._price = false
	self._sdkPayId = false
	self._exchangeNum = false
	self._onlineEndTime = goodsCommonInfo.endRemainedSeconds
	self._updateTime = ServerTime.now()

	self:initData(self._goodsId, tabId, self._storeId)
end

function M:initData(goodsId, tableId, storeId)
	M.super.initData(self, goodsId, tableId, storeId)

	local goodsCo = StoreConfig.instance:getFirstMoneyGoods(goodsId)

	if goodsCo then
		self._name = goodsCo.name
		self._icon = goodsCo.icon
		self._goodsType = goodsCo.goodsType
		self._exchangeNum = goodsCo.exchangeNum
		self._quality = goodsCo.quality

		self:setSortIndex(goodsCo.sortIndex)
	end

	local goodsPayCo = StoreConfig.instance:getGoodsPayCO(goodsId)

	if goodsPayCo then
		self._price = goodsPayCo.price
		self._sdkPayId = goodsPayCo.sdkPayId
	end
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

function M:getPrice()
	if self._price then
		return self._price / 100
	end

	return 0
end

function M:getSdkPayId()
	return self._sdkPayId
end

function M:getExchangeNum()
	return self._exchangeNum
end

function M:getQuality()
	return self._quality
end

return M

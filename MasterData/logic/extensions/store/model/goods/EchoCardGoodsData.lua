-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/EchoCardGoodsData.lua

module("logic.extensions.store.model.goods.EchoCardGoodsData", package.seeall)

local M = class("EchoCardGoodsData", GoodsBaseData)

function M:ctor(echoCardPackGoodsNO, tabId, goodsCommonInfo)
	self._goodsId = goodsCommonInfo.goodsId
	self._storeId = goodsCommonInfo.mallId
	self._onlineEndTime = tonumber(goodsCommonInfo.endRemainedSeconds)
	self._updateTime = ServerTime.now()

	self:initData(self._goodsId, tabId, self._storeId)
end

function M:initData(goodsId, tabId, storeId)
	EchoCardGoodsData.super.initData(self, goodsId, tabId, storeId)

	local goodsCo = StoreConfig.instance:getGoodsCO(goodsId)

	if not goodsCo then
		return
	end

	self._name = goodsCo.name
	self._icon = goodsCo.icon
	self._goodsType = goodsCo.goodsType
	self._cost = goodsCo.cost

	self:setSortIndex(goodsCo.sortIndex)

	self._quality = goodsCo.quality or 1
	self._onceMaxNum = goodsCo.onceMaxNum
	self._exchangeable = goodsCo.exchangeable
	self._reward = goodsCo.reward
	self._costItemId, self._costNum = StoreUtil.getCostPrice(self._cost)
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

function M:getCostNum()
	return self._costNum
end

function M:getCostItemId()
	return self._costItemId
end

function M:getQuality()
	return self._quality
end

function M:getDesc()
	return self._desc or ""
end

function M:getOnceMaxNum()
	return self._onceMaxNum
end

function M:isCanExchange()
	return self._exchangeable
end

function M:getReward()
	return self._reward
end

return M

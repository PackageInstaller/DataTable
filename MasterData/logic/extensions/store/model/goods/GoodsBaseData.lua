-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/GoodsBaseData.lua

module("logic.extensions.store.model.goods.GoodsBaseData", package.seeall)

local M = class("GoodsBaseData")

function M:ctor()
	self._goodsId = false
	self._tabId = false
	self._storeId = false
	self._sortIndex = 0
	self._hasSellOut = false
	self._costItemId = false
end

function M:initData(goodsId, tabId, storeId)
	self._goodsId = goodsId
	self._tabId = tabId
	self._storeId = storeId
end

function M:getGoodsId()
	return self._goodsId or 0
end

function M:getTabId()
	return self._tabId
end

function M:getStoreId()
	return self._storeId
end

function M:setSortIndex(sortIndex)
	self._sortIndex = sortIndex
end

function M:getSortIndex()
	return self._sortIndex or 0
end

function M:setSellState(state)
	self._hasSellOut = state
end

function M:getSellOut()
	return self._hasSellOut
end

function M:getDiscountTimeStr()
	return ""
end

function M:getHisBuyLimit()
	return 0
end

function M:getDailyBuyMaxNum()
	return 0
end

function M:getQuality()
	return 1
end

function M:getGoodsType()
	return 0
end

function M:getCostItemId()
	return self._costItemId
end

function M:getIsDiscount()
	return false
end

function M:getTag()
	return 0
end

function M:isHideSellOut()
	return self._hideSellOut == 1
end

function M:getHisBuyLimit()
	return self._hisBuyLimit or 0
end

function M:getGoodsTimeStr()
	local result = ""

	if self._onlineEndTime > 0 then
		local resultTime = self:getGoodEndRemainedSeconds()

		result = TextFormatter.formatExpireTime(resultTime)
	end

	return result
end

function M:getGoodEndRemainedSeconds()
	if self._onlineEndTime > 0 then
		local now = ServerTime.now()
		local offsetTs = now - self._updateTime
		local endTimeStamp = self._onlineEndTime - offsetTs

		if endTimeStamp > 0 and endTimeStamp <= 8553600 then
			return endTimeStamp
		end
	end

	return 0
end

return M

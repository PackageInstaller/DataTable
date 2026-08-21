-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/goods/MonthlyCardGoodsData.lua

module("logic.extensions.store.model.goods.MonthlyCardGoodsData", package.seeall)

local M = class("MonthlyCardGoodsData", GoodsBaseData)

function M:ctor(monthlyCardGoodsNO, tabId, goodsCommonInfo)
	self._goodsId = goodsCommonInfo.goodsId
	self._remainedDay = monthlyCardGoodsNO.remainedDay
	self._storeId = goodsCommonInfo.mallId
	self._name = false
	self._icon = false
	self._reward = false
	self._dailyReward = false
	self._goodsType = false
	self._price = false
	self._sdkPayId = false
	self._effectiveDays = false
	self._totalDayLimit = false
	self._onlineEndTime = goodsCommonInfo.endRemainedSeconds

	self:initData(self._goodsId, tabId, self._storeId)
end

function M:initData(goodsId, tabId, storeId)
	M.super.initData(self, goodsId, tabId, storeId)

	local mothyCardCO = StoreConfig.instance:getMonthyCardCO(goodsId)

	if mothyCardCO then
		self._name = mothyCardCO.name
		self._icon = mothyCardCO.icon
		self._reward = mothyCardCO.reward
		self._dailyReward = mothyCardCO.dailyReward
		self._explainId = mothyCardCO.explainId
		self._goodsType = mothyCardCO.goodsType
		self._effectiveDays = mothyCardCO.effectiveDays
		self._totalDayLimit = mothyCardCO.totalDayLimit
		self._desc = mothyCardCO.desc
		self._costItemId = GameEnum.CurrencyCodeEnum.CfjzCode
	end

	local goodsPayCo = StoreConfig.instance:getGoodsPayCO(goodsId)

	if goodsPayCo then
		self._price = goodsPayCo.price
		self._sdkPayId = goodsPayCo.sdkPayId
	end
end

function M:getRemainedDay()
	return self._remainedDay or 0
end

function M:getTotalDayLimit()
	return self._totalDayLimit
end

function M:getName()
	return self._name or ""
end

function M:getIcon()
	return self._icon
end

function M:getReward()
	return self._reward
end

function M:getDailyReward()
	return self._dailyReward
end

function M:getExplainId()
	return self._explainId
end

function M:getGoodsType()
	return self._goodsType
end

function M:getEffectiveDays()
	return self._effectiveDays or 0
end

function M:getDesc()
	return self._desc or ""
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

function M:getQuality()
	return 0
end

return M

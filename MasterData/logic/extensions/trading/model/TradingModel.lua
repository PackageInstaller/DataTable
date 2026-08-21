-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/model/TradingModel.lua

module("logic.extensions.trading.model.TradingModel", package.seeall)

local M = class("TradingModel", BaseModel)
local INFO_TYPE = {
	Combine = 2,
	Normal = 1
}

M.SORT_TYPE = {
	QUALITY = 0,
	PRICE = 1,
	ITEM_COUNT = 2
}

function M:ctor()
	self._tradingPostMo = TradingPostMo.New()
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._recommendGoods = {}
	self._goodsByPriceLst = {}
	self._tradeInfoIndex = 0
	self._tradeInfoIds = {}
	self._tradeInfoCombineParams = {}
	self._tradeCenterInfo = {}
end

function M:updateTradePostInfo(tradePost)
	self._tradingPostMo:updateByNo(tradePost)

	local dailyOrderIds = TradingModel.instance:getDailyOrder()

	HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.tradeOrderFull, #dailyOrderIds)
	GlobalDispatcher:dispatchEvent(EventType.TRADING_POST_INFO, self._tradingPostMo)
end

function M:updateTradePostLevel(level)
	self._tradingPostMo:setLevel(level)
	GlobalDispatcher:dispatchEvent(EventType.TRADING_POST_INFO, self._tradingPostMo)
end

function M:getTradePostMo()
	return self._tradingPostMo
end

function M:updateDailyOrder(dailyOrder)
	self._tradingPostMo:setDailyOrder(dailyOrder)
end

function M:getDailyOrder()
	return self._tradingPostMo:getDailyOrder() or {}
end

function M:getDailyOrderFull()
	local co = TradingConfig.instance:getHouseCoByLevel(self._tradingPostMo:getLevel())
	local dailyOrderIds = self:getDailyOrder()

	return #dailyOrderIds >= co.maxDailyOrder
end

function M:getRemainTimeToDailyOrderFull()
	return self._tradingPostMo:getRemainTimeToDailyOrderFull()
end

function M:updateWeeklyOrder(weeklyOrder)
	self._tradingPostMo:setWeeklyOrder(weeklyOrder)
end

function M:getWeeklyOrder()
	return self._tradingPostMo:getWeeklyOrder() or {}
end

function M:getProductHouseRatio()
	return self._tradingPostMo:getProductHouseRatio() or 0
end

function M:updateProductivity(productivity)
	if not productivity then
		return
	end

	self._tradingPostMo:setProductivity(productivity)
	GlobalDispatcher:dispatchEvent(EventType.TRADING_POST_INFO, self._tradingPostMo)
end

function M:getRemainTime()
	local remainTime = self._tradingPostMo:getNextProductTimeStamp() - ServerTime.now()

	return math.max(0, remainTime)
end

function M:getTotalProductProgress()
	if self._tradingPostMo:getLevel() then
		local ownOrders = self:getDailyOrder()
		local ownOrderNum = #ownOrders
		local maxOrderNum = self._tradingPostMo:getMaxDailyOrder()

		if ownOrderNum < maxOrderNum then
			local needProductivity = TradingConfig.instance:getConstCoByKey("OrderProductivity").numValue
			local curProductivity = self._tradingPostMo:getProductivity()

			return curProductivity / (needProductivity * (maxOrderNum - ownOrderNum))
		end
	end

	return 1
end

function M:getCurrProductProgress()
	if self._tradingPostMo:getLevel() then
		local ownOrders = self:getDailyOrder()
		local ownOrderNum = #ownOrders
		local maxOrderNum = self._tradingPostMo:getMaxDailyOrder()

		if ownOrderNum < maxOrderNum then
			local needProductivity = TradingConfig.instance:getConstCoByKey("OrderProductivity").numValue
			local curProductivity = self._tradingPostMo:getProductivity()

			return curProductivity / needProductivity
		end
	end

	return 1
end

function M:getOrderRefreshTimes()
	return self._tradingPostMo:getOrderRefreshTimes() or 0
end

function M:setOrderRefreshTimes(orderRefreshTimes)
	self._tradingPostMo:setOrderRefreshTimes(orderRefreshTimes)
end

function M:updateGoodsList(goodList)
	self._goodList = goodList

	self:_dealGoodsLst(goodList)
	GlobalDispatcher:dispatchEvent(EventType.TRADING_GOOD_LIST, self._goodList)
end

function M:updatePriceRefreshTime(priceRefreshTime)
	self._priceRefreshTime = priceRefreshTime

	GlobalDispatcher:dispatchEvent(EventType.TRADING_REFRESH_TIME, priceRefreshTime)
end

function M:_dealGoodsLst(goodList)
	self._recommendGoods = {}
	self._goodsByPriceLst = {}

	for _, good in pairs(goodList or {}) do
		if good.itemId then
			if good.recommend then
				table.insert(self._recommendGoods, good)
			end

			local lv = good.priceLevel

			if not self._goodsByPriceLst[lv] then
				self._goodsByPriceLst[lv] = {}
			end

			table.insert(self._goodsByPriceLst[lv], good)
		end
	end
end

function M:getGoodList()
	return self._goodList
end

function M:getRecommendGoodLst()
	return self._recommendGoods
end

function M:getGoodLstByPriceLv(lv)
	return self._goodsByPriceLst[lv] or {}
end

function M:hasGoodsInPriceLv(lv)
	local t = self:getGoodLstByPriceLv(lv)

	return #t > 0
end

function M:getJobCount()
	local cfg = TradingConfig.instance:getHouseCoByLevel(self:getLv())

	return cfg.jobCount
end

function M:getLv()
	return self._tradingPostMo:getLevel()
end

function M:getLimitLv()
	return SupervisorModel.instance:getModuleLvLimit()
end

function M:canUpgradeLv(showFloatWord)
	local canUpgrade = true
	local maxLv = SupervisorConfig.instance:getMaxModuleLv()
	local currLv = self._tradingPostMo:getLevel()
	local limitLv = self:getLimitLv()

	if currLv < limitLv then
		local costEnough = true
		local cfg = TradingConfig.instance:getHouseCoByLevel(currLv)

		for _, costInfo in ipairs(cfg.cost or {}) do
			local ownCount = ItemModel.instance:getItemCountByItemId(costInfo.id)

			if ownCount < costInfo.num then
				costEnough = false

				break
			end
		end

		if not costEnough then
			canUpgrade = false

			if showFloatWord then
				FloatWordMgr.instance:show(lang("tip_trading_lang_8"))
			end
		end
	else
		canUpgrade = false

		if showFloatWord then
			if limitLv < maxLv then
				FloatWordMgr.instance:show(lang("tip_trading_lang_9"))
			else
				FloatWordMgr.instance:show(lang("tip_trading_lang_10"))
			end
		end
	end

	return canUpgrade
end

function M:setTradeCenterInfo(sortTyp, sortUp)
	self._tradeCenterInfo.sortTyp = sortTyp
	self._tradeCenterInfo.sortUp = sortUp
end

function M:getTradeCenterInfo()
	local sortTyp = self._tradeCenterInfo.sortTyp and self._tradeCenterInfo.sortTyp or M.SORT_TYPE.QUALITY
	local sortUp = self._tradeCenterInfo.sortUp ~= nil and self._tradeCenterInfo.sortUp or false

	return sortTyp, sortUp
end

function M:updateTradeInfo(simpleIds, combineLst)
	self._tradeInfoIds = {}
	self._tradeInfoCombineParams = {}

	if simpleIds and #simpleIds > 0 then
		TableUtil.addRange(self._tradeInfoIds, simpleIds)
	end

	if combineLst and #combineLst > 0 then
		for _, data in ipairs(combineLst) do
			if data.id then
				table.insert(self._tradeInfoIds, data.id)

				self._tradeInfoCombineParams[data.id] = data.params
			end
		end
	end

	if #self._tradeInfoIds > 0 then
		for i = 1, #self._tradeInfoIds do
			local index = math.random(1, #self._tradeInfoIds)

			self._tradeInfoIds[i], self._tradeInfoIds[index] = self._tradeInfoIds[index], self._tradeInfoIds[i]
		end
	end
end

function M:getTradeInfoIds()
	return self._tradeInfoIds or {}
end

function M:getTradeInfoParams(id)
	return self._tradeInfoCombineParams[id]
end

function M:getNextTradeInfo()
	local ids = self:getTradeInfoIds()
	local len = #ids

	if len == 0 then
		return nil
	end

	local index = self:_getNextTradeInfoIndex(self._tradeInfoIndex)
	local msg, success = HouseTradeUtil.deserializeTradeInfo(ids[index])

	if not success then
		index = self:_getNextTradeInfoIndex(index + 1)
		msg, success = HouseTradeUtil.deserializeTradeInfo(ids[index])
	end

	self._tradeInfoIndex = index

	return msg
end

function M:_getNextTradeInfoIndex(curIndex)
	local ids = self:getTradeInfoIds()
	local len = #ids
	local index = len < curIndex + 1 and 1 or curIndex + 1

	return index
end

M.instance = M.New()

return M

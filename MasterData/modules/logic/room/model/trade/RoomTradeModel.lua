-- chunkname: @modules/logic/room/model/trade/RoomTradeModel.lua

module("modules.logic.room.model.trade.RoomTradeModel", package.seeall)

local RoomTradeModel = class("RoomTradeModel", BaseModel)
local firstEnter = "RoomTrade_Barrage_FirstEnter"
local barrageBatch = "RoomTrade_BarrageBatch"
local playTradeEnterBtnAnim = "RoomTrade_PlayTradeEnterBtnAnim"

function RoomTradeModel:onInit()
	self:clearData()
end

function RoomTradeModel:reInit()
	self:clearData()
end

function RoomTradeModel:clearData()
	self._traceItemDict = {}
	self._traceChildItemDict = {}
	self._isGetOrderInfo = false
end

function RoomTradeModel:onGetOrderInfo(msg)
	self.purchaseOrderFinishCount = msg.purchaseOrderFinishCount

	local purchaseOrderInfos = msg.purchaseOrderInfos
	local wholesaleOrderInfos = msg.wholesaleOrderInfos

	self._remainRefreshCount = msg.remainRefreshCount
	self.weeklyWholesaleRevenue = msg.weeklyWholesaleRevenue or 0
	self._dailyOrderMos = {}

	if purchaseOrderInfos then
		for i = 1, #purchaseOrderInfos do
			local info = purchaseOrderInfos[i]
			local mo = RoomDailyOrderMo.New()

			mo:initMo(info, false)
			table.insert(self._dailyOrderMos, mo)
		end
	end

	self:calTracedItemDict()

	self._wholesaleOrderMos = {}

	if wholesaleOrderInfos then
		for i = 1, #wholesaleOrderInfos do
			local info = wholesaleOrderInfos[i]
			local mo = RoomWholesaleOrderMo.New()

			mo:initMo(info)
			table.insert(self._wholesaleOrderMos, mo)
		end
	end

	self._isGetOrderInfo = true
end

function RoomTradeModel:getDailyOrderFinishCount()
	local co = self:getCurLevelOrderConfig()

	if not co.finishLimitDaily then
		return self.purchaseOrderFinishCount or 0, co.finishLimitDaily
	end
end

function RoomTradeModel:onFinishDailyOrder(orderId, newPurchaseOrderInfo, remainRefreshCount)
	self._remainRefreshCount = remainRefreshCount
	self.purchaseOrderFinishCount = self.purchaseOrderFinishCount + 1

	local orderMo = self:getDailyOrderById(orderId)

	if newPurchaseOrderInfo and #newPurchaseOrderInfo.goodsInfo > 0 then
		if orderMo then
			orderMo:initMo(newPurchaseOrderInfo, true)
		end
	else
		orderMo:setFinish()
	end

	self:calTracedItemDict()
end

function RoomTradeModel:onRefeshDailyOrder(orderInfo, remainRefreshCount)
	self._remainRefreshCount = remainRefreshCount

	local orders = self:getDailyOrders()

	if orders then
		for _, orderMo in ipairs(orders) do
			if orderMo:isWaitRefresh() then
				orderMo:initMo(orderInfo, true)

				return
			end
		end
	end

	self:calTracedItemDict()
end

function RoomTradeModel:getRefreshCount()
	local max = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyOrderFinishMaxCount, true)

	return self._remainRefreshCount or 0, max or 0
end

function RoomTradeModel:isCanRefreshDailyOrder()
	return self._remainRefreshCount ~= 0
end

function RoomTradeModel:onTracedDailyOrder(orderId, isTrace)
	local orderMo = self:getDailyOrderById(orderId)

	if orderMo then
		orderMo:setTraced(isTrace)
	end

	self:calTracedItemDict()
end

function RoomTradeModel:calTracedItemDict()
	self._traceItemDict = {}
	self._traceChildItemDict = {}

	local orders = self:getDailyOrders()

	for _, order in ipairs(orders) do
		if order.isTraced then
			for _, info in ipairs(order:getGoodsInfo()) do
				local itemId = ManufactureConfig.instance:getItemId(info.productionId)

				self._traceItemDict[itemId] = (self._traceItemDict[itemId] or 0) + info.quantity

				local hasQuantity, inSlotCount = ManufactureModel.instance:getManufactureItemCount(info.productionId, true, true)
				local totalQuantity = hasQuantity + inSlotCount
				local lackCount = info.quantity - totalQuantity

				self:_addMatTracedCount(info.productionId, lackCount)
			end
		end
	end
end

function RoomTradeModel:_addMatTracedCount(manuItemId, count)
	if manuItemId then
		::label_12_0::

		local matList = ManufactureConfig.instance:getNeedMatItemList(manuItemId)

		if not matList or #matList <= 0 then
			return
		end

		count = math.max(0, count)

		for _, matData in ipairs(matList) do
			local matItemId = ManufactureConfig.instance:getItemId(matData.id)
			local needCount = matData.quantity * count

			self._traceChildItemDict[matItemId] = (self._traceChildItemDict[matItemId] or 0) + needCount

			local hasQuantity, inSlotCount = ManufactureModel.instance:getManufactureItemCount(matData.id, true, true)
			local totalQuantity = hasQuantity + inSlotCount
			local lackCount = needCount - totalQuantity

			self:_addMatTracedCount(matData.id, lackCount)
		end
	end
end

function RoomTradeModel:isTracedGoods(goodsId)
	local result = false
	local count, max = self:getDailyOrderFinishCount()

	if count < max then
		local itemId = ManufactureConfig.instance:getItemId(goodsId)

		if self._traceItemDict then
			if self._traceChildItemDict then
				local traceChildItemCount = self._traceChildItemDict[itemId]

				result = self._traceItemDict or traceChildItemCount
			end
		end
	end

	return result
end

function RoomTradeModel:getTracedGoodsCount(goodsId)
	local traceItemCount, traceChildItemCount = 0, 0
	local isGoodsTraced = self:isTracedGoods(goodsId)

	if not isGoodsTraced then
		return traceItemCount, traceChildItemCount
	end

	local itemId = ManufactureConfig.instance:getItemId(goodsId)

	traceItemCount = self._traceItemDict and self._traceItemDict[itemId] or 0
	traceChildItemCount = self._traceChildItemDict and self._traceChildItemDict[itemId] or 0

	return traceItemCount, traceChildItemCount
end

function RoomTradeModel:setIsLockedOrder(orderId, isLocked)
	local orderMo = self:getDailyOrderById(orderId)

	if orderMo then
		orderMo:setLocked(isLocked)
	end
end

function RoomTradeModel:isLockedOrder(orderId)
	local orderMo = self:getDailyOrderById(orderId)

	if orderMo then
		return orderMo:getLocked()
	end
end

function RoomTradeModel:getDailyOrders()
	self._dailyOrderMos = self._dailyOrderMos or {}

	return self._dailyOrderMos
end

function RoomTradeModel:getDailyOrderById(orderId)
	local orders = self:getDailyOrders()

	if orders then
		for i, orderMo in ipairs(orders) do
			if orderMo.orderId == orderId then
				return orderMo, i
			end
		end
	end
end

function RoomTradeModel:getCurrencyType()
	return CurrencyEnum.CurrencyType.RoomTrade
end

function RoomTradeModel:onFinishWholesaleGoods(orderId, soldCount, weeklyWholesaleRevenue)
	local orderMo = self:getWholesaleGoodsById(orderId)

	if orderMo then
		orderMo:refreshTodaySoldCount(soldCount)
	end

	self.weeklyWholesaleRevenue = weeklyWholesaleRevenue
end

RoomTradeModel.WholesaleGoodPageCount = 4

function RoomTradeModel:getWholesaleGoods()
	self._wholesaleOrderMos = self._wholesaleOrderMos or {}

	return self._wholesaleOrderMos
end

function RoomTradeModel:getWholesaleGoodsCount()
	return tabletool.len(self:getWholesaleGoods())
end

function RoomTradeModel:getWholesaleGoodsById(orderId)
	local orders = self:getWholesaleGoods()

	if orders then
		for i, orderMo in ipairs(orders) do
			if orderMo.orderId == orderId then
				return orderMo, i
			end
		end
	end
end

function RoomTradeModel:getWholesaleGoodsPageMaxCount()
	local maxCount = self:getWholesaleGoodsCount()

	return math.ceil(maxCount / RoomTradeModel.WholesaleGoodPageCount)
end

function RoomTradeModel:getWholesaleGoodsByPageIndex(index)
	if index > self:getWholesaleGoodsPageMaxCount() then
		return
	end

	local orderIndex = index * RoomTradeModel.WholesaleGoodPageCount
	local maxCount = self:getWholesaleGoodsCount()

	if maxCount < orderIndex then
		logError("超出订单数量")

		return
	end

	local orderMos = self:getWholesaleGoods()
	local moList = {}
	local lastIndex = math.min(orderIndex + RoomTradeModel.WholesaleGoodPageCount, maxCount)

	for i = orderIndex + 1, lastIndex do
		local mo = orderMos[i]

		if mo then
			table.insert(moList, mo)
		end
	end

	return moList
end

function RoomTradeModel:getWeeklyWholesaleRevenue()
	local max = self:getWholesaleRevenueWeeklyLimit()
	local lang = luaLang("room_wholesale_weekly_revenue")
	local count = math.min(self.weeklyWholesaleRevenue, max)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(lang, count, max)
end

function RoomTradeModel:getWholesaleRevenueWeeklyLimit()
	local co = self:getCurLevelOrderConfig()

	return co.wholesaleRevenueWeeklyLimit
end

function RoomTradeModel:isMaxWeelyOrder()
	return self.weeklyWholesaleRevenue >= self:getWholesaleRevenueWeeklyLimit()
end

function RoomTradeModel:getCurLevelOrderConfig()
	local tradeLevel = ManufactureModel.instance:getTradeLevel()
	local info = RoomTradeConfig.instance:getOrderRefreshInfo(tradeLevel)

	return info.co
end

function RoomTradeModel:_isFirstEnterToday()
	return TimeUtil.getDayFirstLoginRed(firstEnter)
end

function RoomTradeModel:_saveEnterToday()
	TimeUtil.setDayFirstLoginRed(firstEnter)
end

function RoomTradeModel:_getPrefBarrageBatch(type)
	return GameUtil.playerPrefsGetNumberByUserId(barrageBatch .. type, 0)
end

function RoomTradeModel:_setPrefBarrageBatch(type, batch)
	GameUtil.playerPrefsSetNumberByUserId(barrageBatch .. type, batch)
end

function RoomTradeModel:initBarrage()
	self._barrageList = {}

	if self:_isFirstEnterToday() then
		for _, type in pairs(RoomTradeEnum.BarrageType) do
			if type == RoomTradeEnum.BarrageType.Dialogue then
				local value = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DialogueBarrageOdds, true)

				value = value and value * 100 or 0

				local random = math.random(1, 100)

				if random <= value then
					self:_setBarrage(type)
				else
					self._barrageList[type] = 0

					self:_setPrefBarrageBatch(type, 0)
				end
			else
				self:_setBarrage(type)
			end
		end

		self:_saveEnterToday()
	else
		for _, type in pairs(RoomTradeEnum.BarrageType) do
			self._barrageList[type] = self:_getPrefBarrageBatch(type)
		end
	end
end

function RoomTradeModel:_setBarrage(type)
	local barrage = self:_randomBarrage(type)

	self._barrageList[type] = barrage

	self:_setPrefBarrageBatch(type, barrage)
end

function RoomTradeModel:_getBarrageIndex(type)
	return self._barrageList[type]
end

function RoomTradeModel:getBarrageCo(type)
	local index = self:_getBarrageIndex(type)

	if index and index > 0 then
		return RoomTradeConfig.instance:getBarrageCoByTypeIndex(type, index)
	end
end

function RoomTradeModel:_randomBarrage(type)
	local count = RoomTradeConfig.instance:getBarrageTypeCount(type)

	if count > 0 then
		return (math.random(1, count))
	end

	return 0
end

function RoomTradeModel:isCanPlayTradeEnterBtnUnlockAnim()
	return GameUtil.playerPrefsGetNumberByUserId(playTradeEnterBtnAnim, 0) == 0
end

function RoomTradeModel:setPlayTradeEnterBtnUnlockAnim()
	GameUtil.playerPrefsSetNumberByUserId(playTradeEnterBtnAnim, 1)
end

function RoomTradeModel:isGetOrderInfo()
	return self._isGetOrderInfo
end

RoomTradeModel.instance = RoomTradeModel.New()

return RoomTradeModel

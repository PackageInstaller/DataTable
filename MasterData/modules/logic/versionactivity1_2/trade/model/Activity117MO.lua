-- chunkname: @modules/logic/versionactivity1_2/trade/model/Activity117MO.lua

module("modules.logic.versionactivity1_2.trade.model.Activity117MO", package.seeall)

local Activity117MO = pureTable("Activity117MO")

function Activity117MO:init(actId)
	self._actId = actId
	self._durationDay = Activity117Config.instance:getTotalActivityDays(actId)

	self:initRewardDict()
	self:resetData()
end

function Activity117MO:resetData()
	self._orderDataDict = {}
	self._score = 0
	self._inQuote = nil

	self:setSelectOrder()
end

function Activity117MO:onNegotiateResult(serverData)
	self:setInQuote(false)
	self:updateOrder(serverData.order)
end

function Activity117MO:onDealSuccess(serverData)
	self:setInQuote(false)
	self:setSelectOrder()

	local data = self:updateOrder(serverData.order)

	if data then
		local source = data:getLastRound() or 0
		local priceType = data:checkPrice(source)

		if priceType == Activity117Enum.PriceType.Bad then
			source = data:getMinPrice()
		end

		local param = {}

		param.score = source
		param.curScore = self._score
		param.nextScore = self:getNextScore(self._score)
		self._score = self._score + source

		Activity117Controller.instance:openTradeSuccessView(param)
	end
end

function Activity117MO:onOrderPush(serverData)
	local oldData = self:getOrderData(serverData.order.id)
	local isProgressEnough = oldData and oldData:isProgressEnough()
	local newData = self:updateOrder(serverData.order)

	if not isProgressEnough and newData and newData:isProgressEnough() then
		local cfg = Activity117Config.instance:getOrderConfig(self._actId, newData.id)

		if cfg then
			local name = string.match(cfg.name, "<.->(.-)<.->") or cfg.name

			GameFacade.showToast(ToastEnum.TradeSuccess, name)
		end
	end
end

function Activity117MO:onInitServerData(serverData)
	self:resetData()
	self:updateOrders(serverData.orders)

	self._score = serverData.score

	self:updateHasGetBonusIds(serverData.hasGetBonusIds)
end

function Activity117MO:updateHasGetBonusIds(rewardIds)
	if not rewardIds then
		return
	end

	for i = 1, #rewardIds do
		local data = self:getRewardData(rewardIds[i])

		if data then
			data:updateServerData(true)
		end
	end
end

function Activity117MO:updateOrders(orders)
	if not orders then
		return
	end

	for i = 1, #orders do
		self:updateOrder(orders[i])
	end
end

function Activity117MO:updateOrder(order)
	if not order then
		return
	end

	local data = self:getOrderData(order.id)

	if data then
		data:updateServerData(order)
	end

	return data
end

function Activity117MO:getOrderData(id, noCreate)
	local dict = self._orderDataDict
	local data = dict[id]

	if not dict[id] and not noCreate then
		data = Activity117OrderMO.New()

		data:init(self._actId, id)

		dict[id] = data
	end

	return data
end

function Activity117MO:getOrderList(noSort)
	local dict = self._orderDataDict
	local list = {}

	if dict then
		for k, v in pairs(dict) do
			table.insert(list, v)
		end

		if not noSort then
			table.sort(list, Activity117OrderMO.sortOrderFunc)
		end
	end

	return list
end

function Activity117MO:setInQuote(inQuote)
	self._inQuote = inQuote
end

function Activity117MO:isInQuote()
	return self._inQuote
end

function Activity117MO:getRemainDay()
	local actMO = ActivityModel.instance:getActMO(self._actId)

	if actMO then
		if not actMO.endTime then
			local endTime = 0

			endTime = endTime / 1000

			local curTime = ServerTime.nowInLocal()

			return TimeUtil.secondsToDDHHMMSS(endTime - curTime)
		end
	end
end

function Activity117MO:getCurrentScore()
	return self._score or 0
end

function Activity117MO:getActId()
	return self._actId
end

function Activity117MO:setSelectOrder(order)
	if order == self._selectOrder then
		return
	end

	self._selectOrder = order

	if not order then
		Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, self._actId)
	end

	Activity117Controller.instance:dispatchEvent(Activity117Event.BargainStatusChange, self._actId)
end

function Activity117MO:getSelectOrder()
	return self._selectOrder
end

function Activity117MO:initRewardDict()
	local cfgList = Activity117Config.instance:getAllBonusConfig(self._actId)

	self.rewardDict = {}

	if cfgList then
		for i, v in ipairs(cfgList) do
			local data = self:getRewardData(v.id, true)

			data:updateServerData(false)
		end
	end
end

function Activity117MO:getRewardData(id, create)
	local data = self.rewardDict[id]

	if not data and create then
		local co = Activity117Config.instance:getBonusConfig(self._actId, id)

		if co then
			data = Activity117RewardMO.New()

			data:init(co)

			self.rewardDict[id] = data
		end
	end

	return data
end

function Activity117MO:getRewardList()
	local list = {}
	local count = 0

	for k, v in pairs(self.rewardDict) do
		if v:getStatus() == Activity117Enum.Status.CanGet then
			count = count + 1
		end

		table.insert(list, v)
	end

	table.sort(list, Activity117RewardMO.sortFunc)

	return list, count
end

function Activity117MO:getFinishOrderCount()
	local limitCount = CommonConfig.instance:getConstNum(ConstEnum.ActivityTradeMaxTimes)
	local list = self:getOrderList(true)
	local finishCount = 0

	for k, v in pairs(list) do
		if v.hasGetBonus then
			finishCount = finishCount + 1
		end
	end

	return finishCount, limitCount
end

function Activity117MO:getNextScore(score)
	local cfgList = Activity117Config.instance:getAllBonusConfig(self._actId)
	local nextScore = 0

	if cfgList then
		local list = {}

		for k, v in pairs(cfgList) do
			table.insert(list, v)
		end

		table.sort(list, function(a, b)
			return a.needScore < b.needScore
		end)

		for i, v in ipairs(list) do
			if score < v.needScore then
				nextScore = v.needScore

				break
			end
		end
	end

	return nextScore
end

return Activity117MO

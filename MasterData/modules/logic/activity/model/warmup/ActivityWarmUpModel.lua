-- chunkname: @modules/logic/activity/model/warmup/ActivityWarmUpModel.lua

module("modules.logic.activity.model.warmup.ActivityWarmUpModel", package.seeall)

local ActivityWarmUpModel = class("ActivityWarmUpModel", BaseModel)

function ActivityWarmUpModel:onInit()
	return
end

function ActivityWarmUpModel:reInit()
	return
end

function ActivityWarmUpModel:release()
	self._startTime = nil
	self._activityDurationDay = nil
	self._selectedIndex = nil
	self._orderInfoMap = nil
	self._daysOrderMap = nil
	self._actId = nil
	self._hasOrderAccepted = nil
end

function ActivityWarmUpModel:init(actId)
	self._actId = actId
	self._selectedIndex = nil
	self._startTime = 0

	self:initOrders()
	self:updateAcceptedStatus()
end

function ActivityWarmUpModel:setStartTime(startTime)
	self._startTime = startTime / 1000
end

function ActivityWarmUpModel:initOrders()
	local orderMap = Activity106Config.instance:getActivityWarmUpAllOrderCo(self._actId)

	self._daysOrderMap = {}
	self._orderInfoMap = {}

	local maxOpenDay = -1

	if not orderMap then
		logNormal("can't find config warmup : " .. tostring(self._actId))
	else
		for id, co in pairs(orderMap) do
			local mo = ActivityWarmUpOrderMO.New()

			mo:init(co)

			self._orderInfoMap[id] = mo

			local openDay = co.openDay

			self._daysOrderMap[openDay] = self._daysOrderMap[openDay] or {}

			table.insert(self._daysOrderMap[openDay], mo)

			if maxOpenDay < openDay then
				maxOpenDay = openDay
			end
		end
	end

	for day, coList in pairs(self._daysOrderMap) do
		table.sort(coList, ActivityWarmUpModel.sortOrder)
	end

	self._activityDurationDay = maxOpenDay
end

function ActivityWarmUpModel.sortOrder(a, b)
	return a.cfg.order < b.cfg.order
end

function ActivityWarmUpModel:setServerOrderInfos(orders)
	for i = 1, #orders do
		local orderInfo = orders[i]
		local mo = self._orderInfoMap[orderInfo.orderId]

		if mo then
			mo:initServerData(orderInfo)
		end
	end

	self:updateAcceptedStatus()
end

function ActivityWarmUpModel:updateSingleOrder(orderInfo)
	if not self._orderInfoMap then
		return
	end

	local mo = self._orderInfoMap[orderInfo.orderId]

	if mo then
		mo:initServerData(orderInfo)
	end

	self:updateAcceptedStatus()
end

function ActivityWarmUpModel:updateAcceptedStatus()
	for _, mo in pairs(self._orderInfoMap) do
		if mo.accept then
			self._hasOrderAccepted = true

			return
		end
	end

	self._hasOrderAccepted = false
end

function ActivityWarmUpModel:selectDayTab(index)
	self._selectedIndex = index
end

function ActivityWarmUpModel:getSelectedDay()
	return self._selectedIndex
end

function ActivityWarmUpModel:getCurrentDay()
	local daySec = 86400
	local dateObj = os.date("*t", ServerTime.timeInLocal(self._startTime))

	dateObj.hour = 5
	dateObj.min = 0
	dateObj.sec = 0

	local today5H = os.time(dateObj) or 0
	local svrDay = today5H - ServerTime.clientToServerOffset()
	local offset = ServerTime.now() - svrDay
	local day = math.floor(offset / daySec + 1)

	return math.min(day, self._activityDurationDay)
end

function ActivityWarmUpModel:getSelectedDayOrders()
	return self._daysOrderMap[self._selectedIndex]
end

function ActivityWarmUpModel:getAllOrders()
	return self._orderInfoMap
end

function ActivityWarmUpModel:getTotalContentDays()
	return self._activityDurationDay
end

function ActivityWarmUpModel:hasOrderAccepted()
	return self._hasOrderAccepted
end

function ActivityWarmUpModel:getOrderAccepted()
	if not self._orderInfoMap then
		return nil
	end

	for _, mo in pairs(self._orderInfoMap) do
		if mo.accept then
			return mo
		end
	end
end

function ActivityWarmUpModel:getActId()
	return self._actId
end

function ActivityWarmUpModel:getOrderMo(id)
	return self._orderInfoMap[id]
end

ActivityWarmUpModel.instance = ActivityWarmUpModel.New()

return ActivityWarmUpModel

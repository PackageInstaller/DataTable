-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/MonsterShopActivity.lua

MonsterShopActivity = class("MonsterShopActivity", BaseActivity, _M)

MonsterShopActivity:has("_developSystem", {
	is = "rw"
}):injectWith("DevelopSystem")
MonsterShopActivity:has("_allProducts", {
	is = "r"
})
MonsterShopActivity:has("_timeStamp", {
	is = "r"
})
MonsterShopActivity:has("_activityId", {
	is = "r"
})
MonsterShopActivity:has("_todayOpen", {
	is = "r"
})
MonsterShopActivity:has("_day", {
	is = "r"
})

function MonsterShopActivity:initialize()
	super.initialize(self)

	self._exchangeMap = {}
	self._allProducts = {}
	self._timeStamp = {}
	self._activityId = ""
	self._todayOpen = false
	self._developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
	self._day = 1
end

function MonsterShopActivity:dispose()
	super.dispose(self)
end

function MonsterShopActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.products then
		for id, value in pairs(data.products) do
			if self._exchangeMap[id] == nil then
				self._exchangeMap[id] = {}
				self._exchangeMap[id].id = id
				self._exchangeMap[id].config = ConfigReader:getRecordById("ActivityMonsterShop", id)
				self._exchangeMap[id].index = self:getExchangeIndex(id)
				self._exchangeMap[id].amount = {}
			end

			if value.amount and next(value.amount) then
				for k, v in pairs(value.amount) do
					self._exchangeMap[id].amount[k + 1] = v
				end
			end

			if value.discount then
				self._exchangeMap[id].discount = value.discount
			end
		end
	end

	if data.allProducts then
		self._allProducts = data.allProducts
	end

	if data.todayOpen then
		self._todayOpen = data.todayOpen
	end

	if data.timeStamp then
		self._timeStamp = data.timeStamp
	end

	if data.activityId then
		self._activityId = data.activityId
	end

	if data.day then
		self._day = data.day or 1
	end

	self:updateExchageMap()
end

function MonsterShopActivity:getSortExchangeList()
	if self._exchangeMap and next(self._exchangeMap) then
		local list = {}

		for id, data in pairs(self._exchangeMap) do
			list[#list + 1] = data
		end

		table.sort(list, function(a, b)
			return a.config.Order < b.config.Order
		end)

		return list
	end

	return {}
end

function MonsterShopActivity:getExchangeIndex(id)
	local actConfig = self:getActivityConfig()

	if actConfig and actConfig.MonsterExchange then
		for i, value in pairs(actConfig.MonsterExchange) do
			if value == id then
				return i
			end
		end
	end
end

function MonsterShopActivity:updateExchageMap()
	local actConfig = self:getActivityConfig()

	if actConfig and actConfig.MonsterExchange then
		for i, value in pairs(actConfig.MonsterExchange) do
			local id = value

			if self._exchangeMap[id] == nil then
				self._exchangeMap[id] = {}
				self._exchangeMap[id].id = id
				self._exchangeMap[id].config = ConfigReader:getRecordById("ActivityMonsterShop", id)
				self._exchangeMap[id].index = self:getExchangeIndex(id)
				self._exchangeMap[id].amount = {}
			end
		end
	end
end

function MonsterShopActivity:getCostRateById(id)
	local data = self._exchangeMap[id]
	local discount = data.discount

	if not discount then
		return 1
	end

	local rate = data.config.Rate

	for k, value in pairs(rate) do
		if value.rate == discount then
			return k
		end
	end

	return 3
end

function MonsterShopActivity:getFirstUnlockIndex(day)
	local list = self:getSortExchangeList()

	if list and next(list) then
		for i = 1, #list do
			if list[i].config.Day == day then
				return i
			end
		end
	end

	return 1
end

function MonsterShopActivity:hasRedPoint()
	return false
end

function MonsterShopActivity:getExchangeCountById(id)
	local data = self._exchangeMap[id]
	local config = data.config
	local costList = config.Cost
	local count = 999999

	for i, value in pairs(costList) do
		local have = self._developSystem:getBagSystem():getItemCount(value.Item)
		local c = math.floor(have / value.price)

		count = c < count and c or count
	end

	return count
end

function MonsterShopActivity:getExchangeAmount(id)
	local data = self._exchangeMap[id]

	if not data then
		return 0
	end

	return data.amount
end

function MonsterShopActivity:getStartTime()
	local timeType = self._config.Time
	local startTime = self._startTime
	local timeStr = self._config.TimeFactor

	if timeType == "RANGE_CONTINUE" and timeStr.start then
		local startTemp = string.split(type(timeStr.start) == "table" and string.split(timeStr.start[1], " ")[1] or string.split(timeStr.start, " ")[1], "-")

		startTime = TimeUtil:timeByRemoteDate({
			hour = 5,
			min = 0,
			sec = 0,
			year = startTemp[1],
			month = startTemp[2],
			day = startTemp[3]
		})
		startTime = startTime * 1000
	end

	return startTime
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ExchangeActivity.lua

ExchangeActivity = class("ExchangeActivity", BaseActivity, _M)

ExchangeActivity:has("_allData", {
	is = "r"
})
ExchangeActivity:has("_summerExchangeList", {
	is = "r"
})
ExchangeActivity:has("_timeStamp", {
	is = "r"
})
ExchangeActivity:has("_activityId", {
	is = "r"
})
ExchangeActivity:has("_todayOpen", {
	is = "r"
})

function ExchangeActivity:initialize()
	super.initialize(self)

	self._exchangeMap = {}
	self._allData = {}
	self._summerExchangeList = {}
	self._timeStamp = {}
	self._activityId = ""
	self._todayOpen = false
end

function ExchangeActivity:dispose()
	super.dispose(self)
end

function ExchangeActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.exchangeAmount then
		for id, amount in pairs(data.exchangeAmount) do
			if self._exchangeMap[id] == nil then
				self._exchangeMap[id] = {}
				self._exchangeMap[id].id = id
				self._exchangeMap[id].config = ConfigReader:getRecordById("ActivityExchange", id)
				self._exchangeMap[id].index = self:getExchangeIndex(id)
			end

			self._exchangeMap[id].amount = amount

			if self._summerExchangeList[id] == nil then
				local data = ConfigReader:getRecordById("ActivityExchange", id)

				if data then
					self._summerExchangeList[id] = PassExchange:new(data)
				end
			end

			if self._summerExchangeList[id] ~= nil then
				self._summerExchangeList[id]:syncData({
					leftCount = amount
				})
			end
		end
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

	if self:getUI() == ActivityType_UI.kActivityPassShop then
		self._allData = data
	end
end

function ExchangeActivity:getSortSummerExchangeList()
	local list = {}

	for id, data in pairs(self._summerExchangeList) do
		list[#list + 1] = data
	end

	local function sortFun(a, b)
		if a:getLeftExchangeCount() == b:getLeftExchangeCount() then
			return a:getOrder() > b:getOrder()
		end

		return a:getLeftExchangeCount() > b:getLeftExchangeCount()
	end

	table.sort(list, sortFun)

	return list
end

function ExchangeActivity:getSortExchangeList()
	local list = {}

	for id, data in pairs(self._exchangeMap) do
		list[#list + 1] = data
	end

	table.sort(list, function(a, b)
		if a.amount == 0 then
			return false
		end

		if b.amount == 0 then
			return true
		end

		return a.index < b.index
	end)

	return list
end

function ExchangeActivity:getCostSortExchangeList()
	local list = {}

	for id, data in pairs(self._exchangeMap) do
		list[#list + 1] = data
	end

	table.sort(list, function(a, b)
		if a.amount == 0 then
			return false
		end

		if b.amount == 0 then
			return true
		end

		local aCost = a.config.Cost[1].amount
		local bCost = b.config.Cost[1].amount

		if aCost == bCost then
			return a.index < b.index
		else
			return bCost < aCost
		end
	end)

	return list
end

function ExchangeActivity:getExchangeIndex(id)
	local actConfig = self:getActivityConfig()

	if actConfig and actConfig.exchange then
		for i, value in pairs(actConfig.exchange) do
			if value == id then
				return i
			end
		end
	end
end

function ExchangeActivity:getExchangeDataById(id)
	return self._exchangeMap[id]
end

function ExchangeActivity:hasRedPoint()
	if self._activityId == "ActivityBlock_Summer_Exchange" then
		return false
	end

	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local list = self:getSortExchangeList()

	for i, value in pairs(list) do
		local rid = developSystem:getPlayer():getRid()
		local key = "ActivityExchange_" .. self._id .. "_" .. rid .. "_" .. value.index
		local sta = cc.UserDefault:getInstance():getBoolForKey(key, (value.config.isRemind == 0 or nil) and false)

		if sta and value.amount > 0 then
			local count = self:getExchangeCountById(value.id)

			if count > 0 then
				return true
			end
		end
	end

	return false
end

function ExchangeActivity:getExchangeCountById(id)
	local data = self._exchangeMap[id]
	local config = data.config
	local costList = config.Cost
	local count = 999999

	for i, value in pairs(costList) do
		local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
		local have = developSystem:getBagSystem():getItemCount(value.code)
		local c = math.floor(have / value.amount)

		count = c < count and c or count
	end

	return count
end

function ExchangeActivity:getExchangeAmount(id)
	local data = self._exchangeMap[id]

	if not data then
		return 0
	end

	return data.amount
end

function ExchangeActivity:getExchangeAmountStatus()
	for key, value in pairs(self._exchangeMap) do
		if value.amount > 0 then
			return true
		end
	end

	return false
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/model/PassListModel.lua

require("dm.gameplay.pass.model.PassReward")

PassListModel = class("PassListModel", objectlua.Object, _M)

PassListModel:has("_passTaskList", {
	is = "r"
})

PassTaskType = {
	kWeekTask = 2,
	kDailyTask = 1,
	kAllTask = 4,
	kMonthTask = 3
}

local s_PassListModel

function PassListModel.class:getInstance()
	if s_PassListModel == nil then
		s_PassListModel = PassListModel:new()
	end

	return s_PassListModel
end

function PassListModel:initialize()
	super.initialize(self)

	self._levelRewardList = {}
	self._passTaskList = {}
	self._passExchangeList = {}
	self._passShopList = {}
end

function PassListModel:initLevelReward(levelIDs, currentLevel, HasRemarkableBadge)
	for i = 1, #levelIDs do
		local levelId = levelIDs[i]
		local data = ConfigReader:getRecordById("ActivityBattlePassLevel", levelId)

		if data then
			local level = data.Level

			if self._levelRewardList[levelId] == nil then
				local oneLevel = PassReward:new(data)
				local statusData = {}

				if level <= currentLevel then
					if oneLevel:getRewardsId1() ~= "" then
						statusData.status = 1
					end

					if HasRemarkableBadge >= 1 then
						statusData.excellentStatus = 1
					end

					oneLevel:synchronize(statusData)
				end

				self._levelRewardList[levelId] = oneLevel
			end
		end
	end
end

function PassListModel:synchronizeLevelRewardStatusByCurrentLevel(formlevel, tolevel, hasRemarkableStatus)
	local count = tolevel - formlevel

	for id, data in pairs(self._levelRewardList) do
		if formlevel < data:getLevel() and tolevel >= data:getLevel() then
			local statusData = {}

			if data ~= nil then
				if data:getStatus() == 0 and data:getRewardsId1() ~= "" then
					statusData.status = 1
				end

				if hasRemarkableStatus >= 1 and data:getExcellentStatus() == 0 then
					statusData.excellentStatus = 1
				end

				data:synchronize(statusData)

				count = count - 1
			end
		end

		if count <= 0 then
			break
		end
	end

	self:refreshLevelRewardVector()
end

function PassListModel:checkHaveRewardCanDoGain()
	local has = false

	for id, data in pairs(self._levelRewardList) do
		if data:getStatus() == 1 or data:getExcellentStatus() == 1 then
			has = true

			break
		end
	end

	return has
end

function PassListModel:synchronizeLevelRewardStatus(haveGainLevel, type)
	if haveGainLevel ~= nil then
		for id, data in pairs(haveGainLevel) do
			local statusData = {}

			if self._levelRewardList[id] ~= nil then
				if type == 1 then
					statusData.status = 2
				end

				if type == 2 then
					statusData.excellentStatus = 2
				end

				self._levelRewardList[id]:synchronize(statusData)
			end
		end
	end

	self:refreshLevelRewardVector()
end

function PassListModel:refreshLevelRewardVector()
	self._levelRewardVector = {}

	for id, data in pairs(self._levelRewardList) do
		self._levelRewardVector[data:getLevel()] = data
	end
end

function PassListModel:initPassTask(DailyTask, WeekTask, MonthTask)
	if DailyTask then
		for id, value in pairs(DailyTask) do
			if self._passTaskList[PassTaskType.kDailyTask] == nil then
				self._passTaskList[PassTaskType.kDailyTask] = {}
			end

			self:updataActivityTask(id, value, PassTaskType.kDailyTask)
		end
	end

	if WeekTask then
		for id, value in pairs(WeekTask) do
			if self._passTaskList[PassTaskType.kWeekTask] == nil then
				self._passTaskList[PassTaskType.kWeekTask] = {}
			end

			self:updataActivityTask(id, value, PassTaskType.kWeekTask)
		end
	end

	if MonthTask then
		for id, value in pairs(MonthTask) do
			if self._passTaskList[PassTaskType.kMonthTask] == nil then
				self._passTaskList[PassTaskType.kMonthTask] = {}
			end

			self:updataActivityTask(id, value, PassTaskType.kMonthTask)
		end
	end

	self:sortActivityTask()
end

function PassListModel:updataActivityTask(id, value, passTaskType)
	value.taskId = value.taskId or id

	local task = self:getActivityTaskById(id, passTaskType)

	if task then
		task:updateModel(value)
	else
		local taskConfig = ConfigReader:getRecordById("ActivityTask", id)

		if taskConfig ~= nil and taskConfig.Id ~= nil then
			task = ActivityTask:new()

			task:synchronizeModel(value)

			self._passTaskList[passTaskType][#self._passTaskList[passTaskType] + 1] = task
		end
	end
end

function PassListModel:sortActivityTask()
	local function sortFun(a, b)
		if a:getOrderStatusNum() == b:getOrderStatusNum() then
			return a:getOrderNum() < b:getOrderNum()
		end

		return a:getOrderStatusNum() > b:getOrderStatusNum()
	end

	table.sort(self._passTaskList[PassTaskType.kDailyTask], sortFun)
	table.sort(self._passTaskList[PassTaskType.kWeekTask], sortFun)

	if self._passTaskList[PassTaskType.kMonthTask] ~= nil then
		table.sort(self._passTaskList[PassTaskType.kMonthTask], sortFun)
	end
end

function PassListModel:checkHaveTaskRewardCanDoGain(passTaskType)
	local has = false
	local oneTask

	if (passTaskType == PassTaskType.kDailyTask or passTaskType == PassTaskType.kAllTask) and self._passTaskList[PassTaskType.kDailyTask] ~= nil and #self._passTaskList[PassTaskType.kDailyTask] > 0 then
		oneTask = self._passTaskList[PassTaskType.kDailyTask][1]

		if self._passTaskList[PassTaskType.kDailyTask][1] ~= nil and oneTask:getStatus() == 1 then
			has = true

			return true
		end
	end

	if (passTaskType == PassTaskType.kWeekTask or passTaskType == PassTaskType.kAllTask) and self._passTaskList[PassTaskType.kWeekTask] ~= nil and #self._passTaskList[PassTaskType.kWeekTask] > 0 then
		oneTask = self._passTaskList[PassTaskType.kWeekTask][1]

		if self._passTaskList[PassTaskType.kWeekTask][1] ~= nil and oneTask:getStatus() == 1 then
			has = true

			return true
		end
	end

	if (passTaskType == PassTaskType.kMonthTask or passTaskType == PassTaskType.kAllTask) and self._passTaskList[PassTaskType.kMonthTask] ~= nil and #self._passTaskList[PassTaskType.kMonthTask] > 0 then
		oneTask = self._passTaskList[PassTaskType.kMonthTask][1]

		if self._passTaskList[PassTaskType.kMonthTask][1] ~= nil and oneTask:getStatus() == 1 then
			has = true
		end
	end

	return has
end

function PassListModel:getActivityTaskById(taskId, passTaskType)
	if self._passTaskList[passTaskType] then
		for k, v in pairs(self._passTaskList[passTaskType]) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function PassListModel:synchronizePassExchangeList(exchangeAmount)
	if exchangeAmount ~= nil then
		for id, value in pairs(exchangeAmount) do
			if self._passExchangeList[id] == nil then
				local data = ConfigReader:getRecordById("ActivityExchange", id)

				if data then
					self._passExchangeList[id] = PassExchange:new(data)
				end
			end

			if self._passExchangeList[id] ~= nil then
				self._passExchangeList[id]:syncData({
					leftCount = value
				})
			end
		end
	end
end

function PassListModel:synchronizePassShopList(exchangeAmount)
	if exchangeAmount ~= nil then
		for id, value in pairs(exchangeAmount) do
			if self._passShopList[id] == nil then
				local data = ConfigReader:getRecordById("ActivityExchange", id)

				if data then
					self._passShopList[id] = PassExchange:new(data)
				end
			end

			if self._passShopList[id] ~= nil then
				self._passShopList[id]:syncData({
					leftCount = value
				})
			end
		end
	end
end

function PassListModel:getPassExchangeList()
	local list = {}

	for id, data in pairs(self._passExchangeList) do
		list[#list + 1] = data
	end

	local function sortFun(a, b)
		return a:getOrder() > b:getOrder()
	end

	table.sort(list, sortFun)

	return list
end

function PassListModel:getPassShopList()
	local list = {}

	for id, data in pairs(self._passShopList) do
		list[#list + 1] = data
	end

	local function sortFun(a, b)
		return a:getOrder() > b:getOrder()
	end

	table.sort(list, sortFun)

	return list
end

function PassListModel:getLevelRewardList()
	return self._levelRewardVector
end

function PassListModel:getLevelUpExpByRewardLevel(level)
	local levelExp = 0

	for id, data in pairs(self._levelRewardList) do
		if level == data:getLevel() then
			levelExp = data:getLevelExp()

			break
		end
	end

	return levelExp
end

function PassListModel:synLevelReward(level, rewardData)
	local reward

	if self._levelRewardList[level] ~= nil then
		reward = self:getRewardByLevel(level)
	else
		reward = PassReward:new()
		self._levelRewardList[level] = reward
	end

	reward:synchronize(rewardData)
end

function PassListModel:getRewardsFromXLevelToYLevel(xLevel, yLevel, isHasRemarkableBadge)
	local rewards = {}

	if xLevel < 0 then
		xLevel = 0
	end

	if yLevel > #self._levelRewardVector then
		yLevel = #self._levelRewardVector
	end

	if yLevel <= xLevel then
		return rewards
	end

	while xLevel < yLevel do
		local index = xLevel + 1
		local oneReward = self._levelRewardVector[index]

		if oneReward then
			for i = 1, #oneReward:getRewardsItems1() do
				table.insert(rewards, oneReward:getRewardsItems1()[i])
			end

			if isHasRemarkableBadge then
				for i = 1, #oneReward:getRewardsItems2() do
					table.insert(rewards, oneReward:getRewardsItems2()[i])
				end
			end
		end

		xLevel = xLevel + 1
	end

	return rewards
end

function PassListModel:getAllNomalRewardsAndRemarkableReward()
	local nomalrewards = {}
	local remarkablerewards = {}

	for id, data in pairs(self._levelRewardList) do
		for i = 1, #data:getRewardsItems1() do
			table.insert(nomalrewards, data:getRewardsItems1()[i])
		end

		for i = 1, #data:getRewardsItems2() do
			table.insert(remarkablerewards, data:getRewardsItems2()[i])
		end
	end

	return nomalrewards, remarkablerewards
end

function PassListModel:getMinCanGainReawrdLevel()
	local resultLevel = 0

	for i = 1, #self._levelRewardVector do
		local oneReward = self._levelRewardVector[i]

		if oneReward and (oneReward:getStatus() == 1 or oneReward:getExcellentStatus() == 1) then
			resultLevel = i

			break
		end
	end

	return resultLevel
end

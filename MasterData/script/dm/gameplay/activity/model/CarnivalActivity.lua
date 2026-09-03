-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/CarnivalActivity.lua

CarnivalActivity = class("CarnivalActivity", BaseActivity, _M)

CarnivalActivity:has("_subActivityMap", {
	is = "r"
})
CarnivalActivity:has("_rewardCount", {
	is = "r"
})
CarnivalActivity:has("_obtainedRewardBoxes", {
	is = "r"
})
CarnivalActivity:has("_isCanShow", {
	is = "rw"
})

function CarnivalActivity:initialize()
	super.initialize(self)

	self._subActivityMap = {}
	self._rewardCount = 0
	self._isCanShow = "false"
	self._obtainedRewardBoxes = {}
end

function CarnivalActivity:dispose()
	super.dispose(self)
end

function CarnivalActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.subActivities then
		for id, value in pairs(data.subActivities) do
			local activity = self:getSubActivityById(id)

			if activity ~= nil then
				activity:synchronize(value)
			else
				local config = ConfigReader:getRecordById("Activity", id)

				if config and ActivityModel[config.Type] then
					activity = ActivityModel[config.Type]:new()

					activity:synchronize(value)

					self._subActivityMap[id] = activity
				end
			end
		end

		self:sortSubActivity()
	end

	if data.rewardCount then
		self._rewardCount = data.rewardCount
	end

	if data.obtainedRewardBoxes then
		for k, v in pairs(data.obtainedRewardBoxes) do
			self._obtainedRewardBoxes[k + 1] = v
		end
	end
end

function CarnivalActivity:sortSubActivity()
	for k, v in pairs(self._subActivityMap) do
		table.sort(v._taskList, function(a, b)
			if a:getStatus() ~= b:getStatus() then
				if a:getStatus() == 1 then
					return true
				elseif b:getStatus() == 1 then
					return false
				elseif a:getStatus() == 0 and b:getStatus() == 2 then
					return true
				elseif a:getStatus() == 2 and a:getStatus() == 0 then
					return false
				end
			elseif a:getStatus() == b:getStatus() then
				local valueA = a:getConfig().OrderNum
				local valueB = b:getConfig().OrderNum

				return valueA < valueB
			end
		end)
	end
end

function CarnivalActivity:isScoreRewardReceived(num)
	for k, v in pairs(self._obtainedRewardBoxes) do
		if v == num then
			return true
		end
	end

	return false
end

function CarnivalActivity:reset()
	super.reset(self)

	self._subActivityMap = {}
	self._rewardCount = 0
	self._obtainedRewardBoxes = {}
end

function CarnivalActivity:getSubActivityById(id)
	if id then
		return self._subActivityMap[id]
	end
end

function CarnivalActivity:hasRedPoint()
	if self:scoreRewardsHasRedPoint() then
		return true
	end

	local acts = self:getActivity()

	for i = 1, #acts do
		local id = acts[i]
		local index = i

		if self:subActivityHasRedPoint(id) and self:isGroupOpen(index) then
			return true
		end
	end

	return false
end

function CarnivalActivity:subActivityHasRedPoint(id)
	local activity = self:getSubActivityById(id)

	if activity then
		local taskList = activity:getTaskList()

		for index, task in pairs(taskList) do
			local status = task:getStatus()

			if status == ActivityTaskStatus.kFinishNotGet then
				return true
			end
		end
	end

	return false
end

function CarnivalActivity:scoreRewardsHasRedPoint()
	local rewardList = self:getRewardList()

	if rewardList then
		for k, v in pairs(rewardList) do
			if self:scoreRewardHasRedPoint(v.Num) then
				return true
			end
		end
	end

	return false
end

function CarnivalActivity:scoreRewardHasRedPoint(num)
	local isReceived = self:isScoreRewardReceived(num)

	if num <= self._rewardCount and not isReceived then
		return true
	end

	return false
end

function CarnivalActivity:subActivityHasNoFinish(id)
	local activity = self:getSubActivityById(id)

	if activity then
		local taskList = activity:getTaskList()

		for index, task in pairs(taskList) do
			local status = task:getStatus()

			if status == ActivityTaskStatus.kUnfinish then
				return true
			end
		end
	end

	return false
end

function CarnivalActivity:getDefaultActivityIndex()
	local subActivities = self:getActivity()

	if subActivities then
		for index, id in ipairs(subActivities) do
			if self:subActivityHasRedPoint(id) then
				return index
			end
		end

		for index, id in ipairs(subActivities) do
			if self:subActivityHasNoFinish(id) then
				return index
			end
		end
	end

	return 1
end

function CarnivalActivity:getActivity()
	local actConfig = self:getActivityConfig()

	return actConfig.Activity
end

function CarnivalActivity:getGroup(index)
	local subActivity = self:getActivity()

	return (self:getSubActivityById(subActivity[index]))
end

function CarnivalActivity:getGroupConfig(index)
	local subActivity = self:getActivity()
	local configForChild = ConfigReader:getRecordById("Activity", subActivity[index])

	if configForChild then
		return configForChild
	end
end

function CarnivalActivity:getRewardList()
	local actConfig = self:getActivityConfig()

	return actConfig.RewardList
end

function CarnivalActivity:isGroupOpen(index)
	local group = self:getGroup(index)

	if group then
		local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimeMillis()

		if curTime < group:getStartTime() or curTime > group:getEndTime() or not group:getIsTodayOpen() then
			return false
		end

		local today5ClockTimeStemp = TimeUtil:getTimeByDateForTargetTimeInToday({
			sec = 0,
			min = 0,
			hour = 5
		})

		today5ClockTimeStemp = today5ClockTimeStemp * 1000

		local starTime = group:getStartTime()
		local delayConfig = group:getConfig().TimeFactor.client
		local days = math.ceil((today5ClockTimeStemp - starTime) / 86400000)
		local lerp = today5ClockTimeStemp <= curTime and 0 or 1

		if days >= delayConfig[1] + lerp then
			return true
		end
	end

	return false
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/LoginActivity.lua

LoginActivity = class("LoginActivity", BaseActivity, _M)

LoginActivity:has("_loginDays", {
	is = "rw"
})
LoginActivity:has("_canHomePop", {
	is = "rw"
})
LoginActivity:has("_list", {
	is = "rw"
})

function LoginActivity:initialize()
	super.initialize(self)

	self._loginDays = 0
	self._canHomePop = true
	self._list = {}
end

function LoginActivity:initList()
	local totalDay = self:getTotalDay()
	local rewardList = self:getRewards()

	for i = 1, totalDay do
		local data = {}

		data.day = i
		data.state = ActivityTaskStatus.kUnfinish
		data.reward = ConfigReader:getRecordById("Reward", tostring(rewardList[i]))
		self._list[#self._list + 1] = data
	end
end

function LoginActivity:dispose()
	super.dispose(self)
end

function LoginActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if not next(self._list) then
		self:initList()
	end

	if data.loginDays then
		self._loginDays = data.loginDays
	end

	if data.obtainedDays then
		for k, v in pairs(data.obtainedDays) do
			for i = 1, #self._list do
				if self._list[i].day == v then
					self._list[i].state = ActivityTaskStatus.kGet
				end
			end
		end
	end

	table.sort(self._list, function(a, b)
		return self:compare(a, b)
	end)
end

function LoginActivity:compare(a, b)
	if a.state == b.state then
		return a.day < b.day
	else
		return kTaskStatusPriorityMap[a.state] < kTaskStatusPriorityMap[b.state]
	end
end

function LoginActivity:getTotalDay()
	local rewardList = self:getRewards()

	return #rewardList
end

function LoginActivity:getRewardStatusByDay(day)
	for i, value in pairs(self._list) do
		if value.day == day then
			return value.state
		end
	end
end

function LoginActivity:getTitleDesc()
	local actConfig = self:getActivityConfig()

	return actConfig and actConfig.title
end

function LoginActivity:getBGImageName()
	local actConfig = self:getActivityConfig()

	return actConfig and actConfig.bg
end

function LoginActivity:getRewards()
	local actConfig = self:getActivityConfig()

	return (actConfig or nil) and (actConfig.reward or {})
end

function LoginActivity:hasRedPoint()
	local loginDays = self:getLoginDays()
	local activityList = self:getList()

	for i = 1, #activityList do
		local activityData = activityList[i]
		local day = activityData.day
		local state = activityData.state

		if day <= loginDays and state ~= ActivityTaskStatus.kGet then
			return true
		end
	end

	return false
end

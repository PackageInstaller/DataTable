-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/RecheargeActivity.lua

RecheargeActivity = class("RecheargeActivity", BaseActivity, _M)

RecheargeActivity:has("_rewardList", {
	is = "r"
})
RecheargeActivity:has("_bagSystem", {
	is = "r"
})
RecheargeActivity:has("_isDailyRecharge", {
	is = "r"
})

function RecheargeActivity:initialize()
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)

	self._bagSystem = developSystem:getBagSystem()

	super.initialize(self)
end

function RecheargeActivity:dispose()
	super.dispose(self)
end

function RecheargeActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.isDailyRecharge ~= nil then
		self._isDailyRecharge = data.isDailyRecharge
	end

	if data.curGashaponId then
		self:setGashapon(data.curGashaponId, data.rewards)
	end
end

function RecheargeActivity:reset()
	super.reset(self)
end

function RecheargeActivity:setGashapon(gashaponId, rewards)
	local gashaponData = ConfigReader:getRecordById("Gashapon", gashaponId)
	local rewardShow = gashaponData.NormalRewardShow
	local middleReward = gashaponData.MiddleRewardShow
	local keyReword = gashaponData.KeyReword
	local map = {}

	self._rewardList = {}

	for i = 1, #rewardShow do
		self:setRewards(rewardShow[i], map, gashaponData)

		if i == 4 then
			for j = 1, #middleReward do
				self:setRewards(middleReward[j], map, gashaponData)
			end
		end
	end

	for k, v in pairs(keyReword) do
		self:setRewards(k, map, gashaponData)
	end

	if rewards then
		for k, v in pairs(rewards) do
			map[v].state = 1
		end
	end
end

function RecheargeActivity:setRewards(id, map, gashaponData)
	local item = ConfigReader:getDataByNameIdAndKey("Reward", id, "Content")[1]
	local reward = {
		state = 0,
		id = id,
		data = item,
		type = item.type
	}

	map[reward.id] = reward
	self._rewardList[#self._rewardList + 1] = reward
end

function RecheargeActivity:hasRedPoint()
	local drawTime = self:getDrawTime()

	if drawTime then
		return drawTime > 0
	end

	return false
end

function RecheargeActivity:isDailyRecharge()
	return self._isDailyRecharge
end

function RecheargeActivity:getNextGetRewardTime(gameServerAgent)
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endDate = TimeUtil:localDate("*t", remoteTimestamp)

	if endDate.hour >= 5 then
		endDate = TimeUtil:localDate("*t", remoteTimestamp + 86400)
	end

	local str = string.format("%d-%02d-%02d 05:00:00", endDate.year, endDate.month, endDate.day)

	return TimeUtil:getTimeByDateForTargetTime(TimeUtil:parseDateTime({}, str))
end

function RecheargeActivity:getActivitySurplus(gameServerAgent)
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endDate = self:getEndTime() * 0.001

	return endDate - remoteTimestamp
end

function RecheargeActivity:getConfigEndTime()
	local config = self._config.TimeFactor
	local hourText = Strings:get("TimeUtil_Hour")
	local startTimeText = " " .. tonumber(string.sub(config.start[1], 12, 13))
	local endTimeText = " " .. tonumber(string.sub(config["end"], 12, 13))
	local str = string.sub(config.start[1], 1, 10)

	str = string.gsub(str, "-", ".") .. startTimeText .. hourText
	str = str .. "-" .. string.gsub(string.sub(config["end"], 1, 10), "-", ".") .. endTimeText .. hourText

	return str
end

function RecheargeActivity:getDrawTime()
	return self._bagSystem:getItemCount("IM_Gashapon")
end

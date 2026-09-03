-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityDrawCardFeedback.lua

ActivityDrawCardFeedback = class("ActivityDrawCardFeedback", BaseActivity, _M)

ActivityDrawCardFeedback:has("_rewardList", {
	is = "r"
})
ActivityDrawCardFeedback:has("_extraRewardList", {
	is = "r"
})
ActivityDrawCardFeedback:has("_allScore", {
	is = "r"
})
ActivityDrawCardFeedback:has("_extraTimes", {
	is = "r"
})
ActivityDrawCardFeedback:has("_maxNomalScore", {
	is = "r"
})

function ActivityDrawCardFeedback:initialize()
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)

	super.initialize(self)
end

function ActivityDrawCardFeedback:dispose()
	super.dispose(self)
end

function ActivityDrawCardFeedback:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.score then
		self._allScore = data.score
	end

	if data.gotAward then
		self:initRewardList(data.gotAward)
	end

	if data.extraTimes then
		self._extraTimes = data.extraTimes
	end

	self:checkCurrent()
	self:initExtraRewardList()
end

function ActivityDrawCardFeedback:reset()
	super.reset(self)
end

function ActivityDrawCardFeedback:initRewardList(gotAward)
	if self._rewardList == nil then
		self._rewardList = {}

		local TaskReward = self:getActivityConfig().TaskReward

		for k, v in pairs(TaskReward) do
			local oneReward = {}

			for k_1, v_1 in pairs(v) do
				oneReward.rewardId = k_1
				oneReward.score = v_1
			end

			if gotAward[oneReward.rewardId] ~= nil then
				oneReward.hasGot = gotAward[oneReward.rewardId]
			end

			oneReward.canGain = oneReward.hasGot == 1
			self._rewardList[#self._rewardList + 1] = oneReward
		end

		table.sort(self._rewardList, function(a, b)
			return a.score < b.score
		end)

		self._maxNomalScore = self._rewardList[#self._rewardList].score
	else
		for i = 1, #self._rewardList do
			if gotAward[self._rewardList[i].rewardId] ~= nil then
				self._rewardList[i].hasGot = gotAward[self._rewardList[i].rewardId]
			end

			self._rewardList[i].canGain = self._rewardList[i].hasGot == 1
		end
	end
end

function ActivityDrawCardFeedback:checkCurrent()
	local frontScore = 0

	for i = 1, #self._rewardList do
		self._rewardList[i].currentBar = false

		if frontScore < self._allScore and self._allScore <= self._rewardList[i].score then
			self._rewardList[i].currentBar = true
			self._rewardList[i].per_Score = self._allScore - frontScore
			self._rewardList[i].oneLevelScore = self._rewardList[i].score - frontScore

			break
		end

		frontScore = self._rewardList[i].score
	end
end

function ActivityDrawCardFeedback:checkRecruitIdIsInActivity(recruitId)
	local result = false
	local drawCard = self:getActivityConfig().DrawCard

	for i = 1, #recruitId do
		if recruitId == drawCard[i] then
			result = true

			break
		end
	end

	return result
end

function ActivityDrawCardFeedback:initExtraRewardList()
	self._extraRewardList = {}

	local Circulate = self:getActivityConfig().Circulate
	local index = 1
	local extraScore = self._maxNomalScore

	for k, v in pairs(Circulate) do
		local oneReward = {}

		oneReward.isExtra = true

		for k_1, v_1 in pairs(v) do
			oneReward.rewardId = k_1
			oneReward.score = extraScore + v_1
			oneReward.oneLevelScore = v_1

			if extraScore <= self._allScore and self._allScore < oneReward.score then
				oneReward.currentBar = true
				oneReward.per_Score = self._allScore - extraScore
			end

			extraScore = extraScore + v_1
		end

		oneReward.hasGot = index <= self._extraTimes and 1 or 0
		oneReward.canGain = self._allScore >= oneReward.score
		index = index + 1
		self._extraRewardList[#self._extraRewardList + 1] = oneReward
	end
end

function ActivityDrawCardFeedback:hasRedPoint()
	local result = false

	for i = 1, #self._rewardList do
		local oneData = self._rewardList[i]

		if oneData.canGain == true and oneData.hasGot == 0 then
			result = true

			break
		end
	end

	if result then
		return result
	end

	for j = 1, #self._extraRewardList do
		local oneData = self._extraRewardList[j]

		if oneData.canGain == true and oneData.hasGot == 0 then
			result = true

			break
		end
	end

	return result
end

function ActivityDrawCardFeedback:getActivitySurplus(gameServerAgent)
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endDate = self:getEndTime() * 0.001

	return endDate - remoteTimestamp
end

function ActivityDrawCardFeedback:getConfigEndTime()
	local config = self._config.TimeFactor
	local hourText = Strings:get("TimeUtil_Hour")
	local startTimeText = " " .. tonumber(string.sub(config.start[1], 12, 13))
	local endTimeText = " " .. tonumber(string.sub(config["end"], 12, 13))
	local str = string.sub(config.start[1], 1, 10)

	str = string.gsub(str, "-", ".") .. startTimeText .. hourText
	str = str .. "-" .. string.gsub(string.sub(config["end"], 1, 10), "-", ".") .. endTimeText .. hourText

	return str
end

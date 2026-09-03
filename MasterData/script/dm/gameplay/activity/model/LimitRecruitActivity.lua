-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/LimitRecruitActivity.lua

LimitRecruitActivity = class("LimitRecruitActivity", BaseActivity, _M)

LimitRecruitActivity:has("_curScore", {
	is = "r"
})
LimitRecruitActivity:has("_scoreRewardList", {
	is = "r"
})
LimitRecruitActivity:has("_rankList", {
	is = "r"
})
LimitRecruitActivity:has("_rewardList", {
	is = "r"
})
LimitRecruitActivity:has("_recruitPools", {
	is = "r"
})
LimitRecruitActivity:has("_curRank", {
	is = "r"
})
LimitRecruitActivity:has("_obtainedRewardBoxes", {
	is = "r"
})
LimitRecruitActivity:has("_closeTime", {
	is = "r"
})
LimitRecruitActivity:has("_closeStatus", {
	is = "rw"
})
LimitRecruitActivity:has("_ifUseNewCoupon", {
	is = "rw"
})
LimitRecruitActivity:has("_taskList", {
	is = "rw"
})
LimitRecruitActivity:has("_showHeroIndex", {
	is = "rw"
})
LimitRecruitActivity:has("_diamondDrawTimesTotal", {
	is = "rw"
})
LimitRecruitActivity:has("_diamondDrawTimesDaliy", {
	is = "rw"
})
LimitRecruitActivity:has("_recruitPool", {
	is = "r"
})
LimitRecruitActivity:has("_singleTimes", {
	is = "r"
})
LimitRecruitActivity:has("_tenTimes", {
	is = "r"
})

function LimitRecruitActivity:initialize(id)
	super.initialize(self, id)

	self._curScore = 0
	self._rankList = {}
	self._rewardList = {}
	self._recruitPools = {}
	self._curRank = -1
	self._obtainedRewardBoxes = {}
	self._closeTime = 0

	self:initScoreList()
	self:initRewardList()
	self:initRecruitPool()

	self._closeStatus = false
	self._taskList = {}
	self._showHeroIndex = 1
	self._diamondDrawTimesTotal = 0
	self._diamondDrawTimesDaliy = 0
	self._singleTimes = 0
	self._tenTimes = 0
end

function LimitRecruitActivity:dispose()
	super.dispose(self)
end

function LimitRecruitActivity:initScoreList()
	self._scoreRewardList = {}

	local list = self:getScoreReward()

	for i, v in pairs(list) do
		local data = {}

		data.index = i
		data.score = v.Score
		data.rewardId = v.Reward
		data.status = ActivityTaskStatus.kUnfinish
		self._scoreRewardList[#self._scoreRewardList + 1] = data
	end
end

function LimitRecruitActivity:initRewardList()
	local actConfig = self:getActivityConfig()
	local list = actConfig.Rank

	for i, v in pairs(list) do
		local config = ConfigReader:getRecordById("RankReward", v)

		for rank = config.Rank[1], config.Rank[2] do
			self._rewardList[rank] = {}
			self._rewardList[rank].rewardId = config.Reward
			self._rewardList[rank].score = config.Score
		end
	end
end

function LimitRecruitActivity:initRecruitPool()
	local activityConfig = self:getActivityConfig()

	if activityConfig.DRAW then
		local recruitId = activityConfig.DRAW
		local configData = ConfigReader:getRecordById("DrawCard", recruitId)

		if configData then
			self._recruitPool = RecruitPool:new(recruitId)
		end
	end
end

function LimitRecruitActivity:getDrawCardId(index)
	local actConfig = self:getActivityConfig()
	local drawCardIds = actConfig.drawCardId

	return drawCardIds and drawCardIds[index]
end

function LimitRecruitActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)
	self:syncRankData(data)

	if data.closeTs then
		self._closeTime = data.closeTs
	end

	if data.score then
		self._curScore = data.score

		self:updateScoreRewardStatus()
	end

	if data.drawMap then
		for id, recruitPoolData in pairs(data.drawMap) do
			local recruitPool = self._recruitPools[id]

			if recruitPool then
				recruitPool:sync(recruitPoolData)
			end
		end
	end

	if data.obtainedRewardBoxes then
		for i, v in pairs(data.obtainedRewardBoxes) do
			self._obtainedRewardBoxes[v] = true
		end

		self:updateScoreRewardStatus()
	end

	if data.activityTask and data.activityTask.taskList then
		self:syncTaskList(data.activityTask.taskList)
	end

	if data.ifUseNewCoupon ~= nil then
		self._ifUseNewCoupon = data.ifUseNewCoupon
	end

	if data.drawTimesTotal ~= nil then
		self._diamondDrawTimesTotal = data.drawTimesTotal
	end

	if data.drawTimesDaliy ~= nil then
		self._diamondDrawTimesDaliy = data.drawTimesDaliy
	end

	if data.singleTimes ~= nil then
		self._singleTimes = data.singleTimes
	end

	if data.tenTimes ~= nil then
		self._tenTimes = data.tenTimes
	end
end

function LimitRecruitActivity:syncRankData(data)
	if data.lb then
		self._rankList = {}

		for i, value in pairs(data.lb) do
			local record = CombatRankRecord:new()

			record:synchronize(value)

			self._rankList[record:getRank()] = record
		end
	end

	if data.pr then
		if data.pr.rank then
			self._curRank = data.pr.rank
		end

		if data.pr.rank then
			self._curScore = data.pr.value
		end
	end
end

function LimitRecruitActivity:getIsDrawCardBagin(currentTime)
	local resuit = false
	local startTime = 0
	local activityConfig = self:getActivityConfig()

	if activityConfig.Activity then
		local subActivity = activityConfig.Activity[1]
		local timeStamp = ConfigReader:getDataByNameIdAndKey("Activity", subActivity, "TimeFactor")
		local _, _, y, mon, d, h, m, s = string.find(timeStamp["end"], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

		startTime = TimeUtil:timeByRemoteDate({
			year = y,
			month = mon,
			day = d,
			hour = h,
			min = m,
			sec = s
		})

		if startTime < currentTime then
			resuit = true
		end
	end

	return resuit, startTime
end

function LimitRecruitActivity:updateScoreRewardStatus()
	for i, v in pairs(self._scoreRewardList) do
		if self._obtainedRewardBoxes[v.score] then
			v.status = ActivityTaskStatus.kGet
		elseif self._curScore >= v.score then
			v.status = ActivityTaskStatus.kFinishNotGet
		end
	end
end

function LimitRecruitActivity:syncTaskList(taskList)
	for id, value in pairs(taskList) do
		local task = self:getActivityTaskById(id)

		if task then
			task:updateModel(value)
		else
			local taskConfig = ConfigReader:getRecordById("ActivityTask", id)

			if taskConfig ~= nil and taskConfig.Id ~= nil then
				task = ActivityTask:new()

				task:synchronizeModel(value)

				self._taskList[#self._taskList + 1] = task
			end
		end
	end
end

function LimitRecruitActivity:syncDeleteData(data)
	if type(data) == "table" and data.tasks and self._taskList then
		for k, v in pairs(data.tasks) do
			for i = #self._taskList, 1, -1 do
				local task = self._taskList[i]

				if k == task:getId() then
					table.remove(self._taskList, i)
				end
			end
		end
	end
end

function LimitRecruitActivity:getActivityTaskById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function LimitRecruitActivity:isTaskCanShow(taskData)
	if taskData:getBeforeTask() then
		local beforeId = taskData:getBeforeTask()
		local beforeTask = self:getActivityTaskById(beforeId)

		if beforeTask and beforeTask:getStatus() ~= ActivityTaskStatus.kGet then
			return false
		end
	end

	if taskData:getNextTask() then
		local nextId = taskData:getNextTask()
		local nextTask = self:getActivityTaskById(nextId)

		if nextTask and taskData:getStatus() == ActivityTaskStatus.kGet then
			return false
		end
	end

	return true
end

function LimitRecruitActivity:getSortActivityList()
	local list = {}

	for i, taskData in pairs(self._taskList) do
		if self:isTaskCanShow(taskData) then
			list[#list + 1] = taskData
		end
	end

	table.sort(list, function(a, b)
		if a:getStatus() ~= b:getStatus() then
			return kTaskStatusPriorityMap[a:getStatus()] < kTaskStatusPriorityMap[b:getStatus()]
		else
			return a:getOrderNum() < b:getOrderNum()
		end
	end)

	return list
end

function LimitRecruitActivity:getTaskCountByStatus(status)
	local value = 0

	if self._taskList then
		for i, task in pairs(self._taskList) do
			if task ~= nil and task:getStatus() == status then
				value = value + 1
			end
		end
	end

	return value
end

function LimitRecruitActivity:hasRedPoint()
	for id, recruitPool in pairs(self._recruitPools) do
		if not self._closeStatus and recruitPool:getFreeTimes() > 0 then
			return true
		end
	end

	for i, v in pairs(self._scoreRewardList) do
		if v.status == ActivityTaskStatus.kFinishNotGet then
			return true
		end
	end

	if self._taskList and #self._taskList > 0 and self:getTaskCountByStatus(ActivityTaskStatus.kFinishNotGet) > 0 then
		return true
	end

	return false
end

function LimitRecruitActivity:getHeroId()
	local actConfig = self:getActivityConfig()

	return actConfig.hero
end

function LimitRecruitActivity:getDiamondDrawTimes()
	if self:getActivityConfig().diamondDrawTimes then
		return self:getActivityConfig() and self:getActivityConfig().diamondDrawTimes
	end
end

function LimitRecruitActivity:getDiamondDrawTimesReset()
	if self:getActivityConfig().diamondDrawTimesReset then
		return self:getActivityConfig() and self:getActivityConfig().diamondDrawTimesReset
	end
end

function LimitRecruitActivity:getRankAmount()
	local rankData = self:getRank()

	return #rankData
end

function LimitRecruitActivity:getScoreReward()
	local actConfig = self:getActivityConfig()

	return actConfig.RewardBox
end

function LimitRecruitActivity:getShowTime()
	local actConfig = self:getActivityConfig()

	return actConfig.ShowTime or 0
end

function LimitRecruitActivity:getActivityTimeLimit()
	local actConfig = self:getActivityConfig()

	return actConfig.Rank
end

function LimitRecruitActivity:getOnceScore()
	local actConfig = self:getActivityConfig()

	return 10
end

function LimitRecruitActivity:getHeroImage()
	local actConfig = self:getActivityConfig()

	return actConfig.bmg
end

function LimitRecruitActivity:getShineItem()
	local actConfig = self:getActivityConfig()

	return actConfig.shineItem
end

function LimitRecruitActivity:getSwitch()
	return GameConfigs.closeLimitRecruit
end

function LimitRecruitActivity:isShineItem(id)
	local list = self:getShineItem()

	for i, v in pairs(list) do
		if v == id then
			return true
		end
	end

	return false
end

function LimitRecruitActivity:getBubbleDesc()
	local actConfig = self:getActivityConfig()

	return actConfig.bubbleDesc
end

function LimitRecruitActivity:getEntranceNormalImg()
	local actConfig = self:getActivityConfig()

	return actConfig.buttonImg
end

function LimitRecruitActivity:getEntrancePressImg()
	local actConfig = self:getActivityConfig()

	return actConfig.buttonPressImg
end

function LimitRecruitActivity:getRank()
	local actConfig = self:getActivityConfig()
	local rankIds = actConfig.Rank
	local rankList = {}
	local rankRewardConfig = {}

	for i, id in pairs(rankIds) do
		local config = ConfigReader:getRecordById("RankReward", id)

		table.insert(rankRewardConfig, config)
	end

	for i = 1, 30 do
		local rankConfig = {}

		for k, v in pairs(rankRewardConfig) do
			if i >= v.Rank[1] and i <= v.Rank[2] then
				rankConfig.Sort = i
				rankConfig.RankReward = v.Reward
				rankConfig.RankStand = v.Score
				rankConfig.rank = v.Rank
			end
		end

		table.insert(rankList, rankConfig)
	end

	table.sort(rankList, function(a, b)
		return a.Sort < b.Sort
	end)

	return rankList
end

function LimitRecruitActivity:getRecommendData()
	local actConfig = self:getActivityConfig()

	return {
		hero = actConfig.recommendHero,
		name = actConfig.recommendName,
		desc = actConfig.recommendDesc
	}
end

function LimitRecruitActivity:getPreviewData()
	local actConfig = self:getActivityConfig()

	return actConfig.rewardShow
end

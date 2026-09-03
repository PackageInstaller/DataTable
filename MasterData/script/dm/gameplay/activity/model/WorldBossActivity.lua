-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/WorldBossActivity.lua

WorldBossActivity = class("WorldBossActivity", BaseActivity, _M)

WorldBossActivity:has("_maxVanguardHurt", {
	is == "rw"
})
WorldBossActivity:has("_maxBossHurt", {
	is == "rw"
})
WorldBossActivity:has("_totalVanguardHurt", {
	is == "rw"
})
WorldBossActivity:has("_taskList", {
	is == "rw"
})
WorldBossActivity:has("_team", {
	is == "rw"
})
WorldBossActivity:has("_isFightBoss", {
	is == "rw"
})
WorldBossActivity:has("_moveRoles", {
	is == "rw"
})
WorldBossActivity:has("_myRank", {
	is == "rw"
})
WorldBossActivity:has("_rankId", {
	is == "rw"
})
WorldBossActivity:has("_oldMaxHurtNum", {
	is == "rw"
})
WorldBossActivity:has("_bossRank", {
	is == "rw"
})
WorldBossActivity:has("_preNickname", {
	is == "rw"
})
WorldBossActivity:has("_fightBossTimes", {
	is == "rw"
})
WorldBossActivity:has("_fightVanguardTimes", {
	is == "rw"
})
WorldBossActivity:has("_vanguardBuyTimes", {
	is == "rw"
})
WorldBossActivity:has("_curBuffIndex", {
	is == "rw"
})

WorldBossPointType = {
	kVanguard = 1,
	kBoss = 2
}

function WorldBossActivity:initialize(id)
	super.initialize(self, id)

	self._moveRoles = {}
	self._taskList = {}
	self._maxBossHurt = 0
	self._maxVanguardHurt = 0
	self._totalVanguardHurt = 0
	self._isFightBoss = false
	self._myRank = -1
	self._oldMaxHurtNum = 0
	self._bossRank = -1
	self._preNickname = nil
	self._fightBossTimes = nil
	self._fightVanguardTimes = nil
	self._vanguardBuyTimes = nil
	self._curBuffIndex = 0
end

function WorldBossActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.maxVanguardHurt then
		self._maxVanguardHurt = data.maxVanguardHurt
	end

	if data.maxBossHurt then
		self._maxBossHurt = data.maxBossHurt
	end

	if data.totalVanguardHurt then
		self._totalVanguardHurt = data.totalVanguardHurt
	end

	if data.isFightBoss ~= nil then
		self._isFightBoss = data.isFightBoss
	end

	if data.team then
		self._team = self._team or Team:new({})

		self._team:synchronize(data.team)
	end

	if data.taskList then
		for id, value in pairs(data.taskList) do
			value.taskId = value.taskId or id
			value.activityId = value.activityId or data.activityId

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

	if not self._pointList then
		self:initPoints()
	end

	if data.rank then
		self._myRank = data.rank
	end

	if data.rankId then
		self._rankId = data.rankId
	end

	if data.playerData then
		self._moveRoles = {}

		for i, v in pairs(data.playerData) do
			local role = WorldBossRoleInfo:new()

			role:synchronize(v)

			self._moveRoles[#self._moveRoles + 1] = role
		end
	end

	if data.bossRank then
		self._bossRank = data.bossRank
	end

	if data.preNickname then
		self._preNickname = data.preNickname
	end

	if data.fightBossTimes then
		self._fightBossTimes = data.fightBossTimes
	end

	if data.fightVanguardTimes then
		self._fightVanguardTimes = data.fightVanguardTimes
	end

	if data.vanguardBuyTimes then
		self._vanguardBuyTimes = data.vanguardBuyTimes
	end
end

function WorldBossActivity:initPoints()
	self._pointList = {}
	self._pointMap = {}

	local config = self:getActivityConfig().Boss

	for i, v in pairs(config) do
		local point = ActivityStagePoint:new(v.Boss, "WolrdBossBlockBattle")

		point:setIndex(i)
		point:setOwner(self)

		self._pointList[i] = point
		self._pointMap[v.Boss] = point
	end
end

function WorldBossActivity:getPointById(id)
	return self._pointMap[id]
end

function WorldBossActivity:getSortActivityList()
	local list = {}

	for i, taskData in pairs(self._taskList) do
		list[#list + 1] = taskData
	end

	if self._allAchieveTaskList then
		for i, taskData in pairs(self._allAchieveTaskList) do
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

function WorldBossActivity:getActivityTaskById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function WorldBossActivity:getTaskCountByStatus(status)
	local value = 0

	for i, task in pairs(self._taskList) do
		if task ~= nil and task:getStatus() == status then
			value = value + 1
		end
	end

	return value
end

function WorldBossActivity:getFightTimes(pointType)
	if pointType == WorldBossPointType.kVanguard then
		return self._fightVanguardTimes
	end

	if pointType == WorldBossPointType.kBoss then
		return self._fightBossTimes
	end
end

function WorldBossActivity:hasRewardToGet()
	return self:getTaskCountByStatus(ActivityTaskStatus.kFinishNotGet) > 0
end

function WorldBossActivity:hasRedPoint()
	if self:isPointCanChallenge(WorldBossPointType.kVanguard) and self._fightVanguardTimes > 0 then
		return true
	end

	if self:isPointCanChallenge(WorldBossPointType.kBoss) and self._fightBossTimes > 0 then
		return true
	end

	if self:hasRewardToGet() then
		return true
	end

	return false
end

function WorldBossActivity:getPointOpenTime(pointType)
	local config = self:getActivityConfig().Boss
	local boss = config[pointType]

	if boss then
		local startDate = boss.Time[1]
		local endDate = boss.Time[2]
		local startTs = TimeUtil:timeByRemoteDate(TimeUtil:parseDateTime({}, startDate))
		local endTs = TimeUtil:timeByRemoteDate(TimeUtil:parseDateTime({}, endDate))

		return {
			startTime = startTs,
			endTime = endTs
		}
	end
end

function WorldBossActivity:isPointCanChallenge(pointType)
	local curTime = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
	local ts = self:getPointOpenTime(pointType)

	if curTime >= ts.startTime and curTime <= ts.endTime then
		return true
	end

	return false
end

function WorldBossActivity:getBuffOpenTime()
	local config = self:getActivityConfig().Boss
	local timeList = {}

	for i, boss in pairs(config) do
		local bossData = self:getPointById(boss.Boss)
		local buffConfig = bossData:getConfig().SoulForceRotatesBuff

		if buffConfig then
			for _, v in pairs(buffConfig) do
				local time = v.Time
				local startT = TimeUtil:parseDateTime({}, time[1])
				local startTime = TimeUtil:timeByRemoteDate(startT)
				local endT = TimeUtil:parseDateTime({}, time[2])
				local endTime = TimeUtil:timeByRemoteDate(endT)
				local data = table.deepcopy({}, v)

				data.startTime = startTime
				data.endTime = endTime
				data.pointType = i
				timeList[#timeList + 1] = data
			end
		end
	end

	table.sort(timeList, function(a, b)
		return a.startTime < b.startTime
	end)

	return timeList
end

function WorldBossActivity:isCanBuyTimes(pointType)
	local config = self:getActivityConfig().Boss
	local boss = config[pointType]

	if boss.buyLimit then
		if self._vanguardBuyTimes < boss.buyLimit then
			return true
		end

		return false
	end

	return true
end

function WorldBossActivity:getBossConfig(pointType)
	local config = self:getActivityConfig().Boss

	return config[pointType]
end

function WorldBossActivity:getCostBuyTimes(pointType)
	local boss = self:getBossConfig(pointType)
	local data = {}

	data.id = boss.buyTimesCost.id
	data.eachBuyNum = boss.eachBuyNum

	if pointType == WorldBossPointType.kVanguard then
		data.amount = boss.buyTimesCost.amount[self._vanguardBuyTimes + 1]
	else
		data.id = boss.buyTimesCost.id
		data.amount = boss.buyTimesCost.amount
	end

	return data
end

function WorldBossActivity:getTask()
	return self:getActivityConfig().task
end

function WorldBossActivity:getRuleDesc()
	return self:getActivityConfig().RuleDesc
end

function WorldBossActivity:getResourcesBanner()
	return self:getActivityConfig().ResourcesBanner
end

function WorldBossActivity:getRankReward()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBoss_RankReward", "content")
end

function WorldBossActivity:getPointIdByType(pointType)
	local config = self:getActivityConfig().Boss

	return config[pointType].Boss
end

function WorldBossActivity:getBgm()
	return self:getActivityConfig().bgm
end

function WorldBossActivity:getBuffIdByIndex(index)
	local buffs = self:getActivityConfig().Buff

	return buffs[index]
end

WorldBossRoleInfo = class("WorldBossRoleInfo", objectlua.Object, _M)

WorldBossRoleInfo:has("_rid", {
	is = "r"
})
WorldBossRoleInfo:has("_nickName", {
	is = "r"
})
WorldBossRoleInfo:has("_level", {
	is = "r"
})
WorldBossRoleInfo:has("_head", {
	is = "r"
})
WorldBossRoleInfo:has("_headFrame", {
	is = "r"
})
WorldBossRoleInfo:has("_modelId", {
	is = "r"
})

function WorldBossRoleInfo:initialize()
	super.initialize(self)

	self._rid = ""
	self._nickName = ""
	self._level = 0
	self._head = ""
	self._headFrame = ""
	self._modelId = 0
end

function WorldBossRoleInfo:synchronize(data)
	if not data then
		return
	end

	if data.r then
		self._rid = data.r
	end

	if data.n then
		self._nickName = data.n
	end

	if data.l then
		self._level = data.l
	end

	if data.h then
		self._head = data.h
	end

	if data.f then
		self._headFrame = data.f
	end

	if data.s then
		self._modelId = data.s
	end
end

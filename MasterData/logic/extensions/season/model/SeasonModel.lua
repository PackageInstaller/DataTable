-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonModel.lua

module("logic.extensions.season.model.SeasonModel", package.seeall)

local M = class("SeasonModel", BaseModel)

local function _sortTask(moList)
	table.sort(moList, function(moA, moB)
		local activeA = moA:canGetReward()
		local activeB = moB:canGetReward()
		local finishedA = moA:isFinished()
		local finishedB = moB:isFinished()
		local priorityA = moA:getPriority()
		local priorityB = moB:getPriority()

		if activeA and not activeB then
			return true
		end

		if not activeA and activeB then
			return false
		end

		if finishedA and not finishedB then
			return false
		end

		if not finishedA and finishedB then
			return true
		end

		if priorityA ~= priorityB then
			return priorityB < priorityA
		end

		return moA:getId() > moB:getId()
	end)
end

M.SCORE_ITEM_ID = 2901101

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:_resetData()
end

function M:onReset()
	self:clear()
end

function M:clear()
	if self._arrayAllLvMO then
		table.clear(self._arrayAllLvMO)
		table.clear(self._arrayNormalLvMO)
		table.clear(self._arrayLoopLvMO)
	end

	if self._dictAllTask then
		table.clear(self._dictAllTask)
		table.clear(self._arrayWeeklyTask)
		table.clear(self._arrayFixedTask)
		table.clear(self._arrayDayTasks)
	end

	if self._arrayReportScore then
		table.clear(self._arrayReportScore)
		table.clear(self._arrayReportTask)
	end

	self:_resetData()
end

function M:_resetData()
	self._seasonId = 0
	self._currLevel = 0
	self._currScore = 0
	self._vipStatus = SeasonEnum.VipStatus.None
	self._todayScore = 0
	self._arrayAllLvMO = nil
	self._arrayNormalLvMO = nil
	self._arrayLoopLvMO = nil
	self._lastSeasonId = nil
	self._lastSeasonLv = nil
	self._lastSeasonScore = nil
	self._lastSeasonTaskPoint = nil
	self._dictAllTask = nil
	self._arrayWeeklyTask = nil
	self._arrayFixedTask = nil
	self._hasLvActive = false
	self._arrayReportScore = nil
	self._arrayReportTask = nil
	self._needShowSummarize = false
	self._arrayDayTasks = nil
	self._canGotRewardMinLv = nil
	self._scheduleRewards = nil
end

function M:setSummarizeInfo(msg)
	self._needShowSummarize = true
	self._lastSeasonId = msg.id
	self._lastSeasonLv = msg.lv
	self._lastSeasonScore = msg.point
	self._lastSeasonTaskPoint = msg.taskPoint

	local append = true
	local code = LoginPopEnum.PopCode[LoginPopEnum.PopType.SeasonReset]
	local otherCode
	local jumpId = 11100001
end

function M:needShowSummarize()
	return self._needShowSummarize
end

function M:clearSummarize()
	self._needShowSummarize = false
end

function M:updateDataByAgent(msg)
	self._seasonId = checknumber(msg.id)
	self._currLevel = msg.lv
	self._currScore = msg.point
	self._vipStatus = msg.vip
	self._todayScore = msg.today

	if self._seasonId > 0 then
		self:tryCreateMOList()
		self:updateRewardStatus(msg.lvs, msg.vipLvs)
	end
end

function M:tryCreateMOList()
	if self._arrayAllLvMO == nil then
		self._arrayAllLvMO = {}
		self._arrayNormalLvMO = {}
		self._arrayLoopLvMO = {}
	end

	local showMaxLv = self:getShowMaxLv()
	local limitLv = self:getLimitLv()

	for lv = 1, showMaxLv do
		if not self._arrayAllLvMO[lv] then
			local mo = SeasonLvMO.New(lv)
			local cfg = SeasonConfig.instance:getLevelCfg(self._seasonId, lv)

			mo:setLvCfg(cfg)

			local isLoop = limitLv < lv

			mo:setIsLoop(isLoop)

			self._arrayAllLvMO[lv] = mo

			if isLoop then
				self._arrayLoopLvMO[lv] = mo
			else
				self._arrayNormalLvMO[lv] = mo
			end
		end
	end
end

function M:updateRewardStatus(lvs, vipLvs)
	self._hasLvActive = false
	self._canGotRewardMinLv = -1

	if self._currLevel > 0 then
		for lv = 1, self._currLevel do
			local mo = self:getMOByLv(lv)

			if mo then
				mo:setRewardStatus(SeasonEnum.RewardStatus.Finished)
			end
		end

		for _, lv in ipairs(lvs or {}) do
			local mo = self:getMOByLv(lv)

			if mo then
				mo:setRewardStatus(SeasonEnum.RewardStatus.AllActive)

				self._hasLvActive = true
				self._canGotRewardMinLv = self:_getCanGotRewardMinLv(self._canGotRewardMinLv, lv)
			end
		end

		if self:isVip() then
			for _, lv in ipairs(vipLvs or {}) do
				local mo = self:getMOByLv(lv)

				if mo and mo:getRewardStatus() == SeasonEnum.RewardStatus.Finished then
					mo:setRewardStatus(SeasonEnum.RewardStatus.VipActive)

					self._hasLvActive = true
					self._canGotRewardMinLv = self:_getCanGotRewardMinLv(self._canGotRewardMinLv, lv)
				end
			end
		end
	end
end

function M:_getCanGotRewardMinLv(canGotRewardMinLv, lv)
	if canGotRewardMinLv < 0 then
		return lv
	end

	if lv <= canGotRewardMinLv then
		return lv
	end

	return canGotRewardMinLv
end

function M:updateTasksByAgent(msg)
	if self._dictAllTask == nil then
		self._dictAllTask = {}
		self._arrayWeeklyTask = {}
		self._arrayFixedTask = {}
		self._arrayDayTasks = {}
	end

	local taskIds = {}

	for _, taskNO in ipairs(msg.tasks or {}) do
		local id = taskNO.id
		local mo = self._dictAllTask[id]

		taskIds[id] = true

		if not mo then
			mo = SeasonTaskMO.New(id)

			local cfg = SeasonConfig.instance:getConfigByKey(ConfigName.SeasonTask, id)

			cfg = cfg or ChamberConfig.instance:getConfigByKey(ConfigName.ChamberTask, id)

			if cfg == nil then
				taskIds[id] = false

				printWarn("client season task cfg has been deleted! server task id is ", id)
			else
				mo:setTaskCfg(cfg)

				self._dictAllTask[id] = mo

				if mo:getType() == SeasonEnum.TaskType.Weekly then
					table.insert(self._arrayWeeklyTask, mo)
				elseif mo:getType() == SeasonEnum.TaskType.Fixed then
					table.insert(self._arrayFixedTask, mo)
				elseif mo:getType() == SeasonEnum.TaskType.Unlimited or mo:getType() == SeasonEnum.TaskType.dayOnce then
					table.insert(self._arrayDayTasks, mo)
				end
			end
		end

		mo:updateByAgent(taskNO)
	end

	local removeIds = {}

	for id, mo in pairs(self._dictAllTask) do
		if not taskIds[id] then
			table.insert(removeIds, id)
		end
	end

	for _, id in ipairs(removeIds) do
		self:_removeTask(id)
	end

	self._scheduleRewards = msg.scheduleRewards
end

function M:_removeTask(id)
	for idx, mo in ipairs(self._arrayDayTasks) do
		if mo:getId() == id then
			table.remove(self._arrayDayTasks, idx)

			break
		end
	end

	for idx, mo in ipairs(self._arrayWeeklyTask) do
		if mo:getId() == id then
			table.remove(self._arrayWeeklyTask, idx)

			break
		end
	end

	for idx, mo in ipairs(self._arrayFixedTask) do
		if mo:getId() == id then
			table.remove(self._arrayFixedTask, idx)

			break
		end
	end

	self._dictAllTask[id] = nil
end

function M:updateReportByAgent(msg)
	if self._arrayReportScore then
		table.clear(self._arrayReportScore)
		table.clear(self._arrayReportTask)
	else
		self._arrayReportScore = {}
		self._arrayReportTask = {}
	end

	for i, v in ipairs(msg.history or {}) do
		table.insert(self._arrayReportScore, v)
	end

	for _, NO in ipairs(msg.tasks or {}) do
		local mo = SeasonReportMO.New()

		mo:updateByAgent(NO)
		table.insert(self._arrayReportTask, mo)
	end
end

function M:setTaskFinished(id)
	if id == 0 then
		for _, taskMO in pairs(self._dictAllTask) do
			if taskMO:isActive() then
				taskMO:setFinished()
			end
		end
	else
		local taskMO = self._dictAllTask[id]

		if taskMO:isActive() then
			taskMO:setFinished()
		end
	end
end

function M:getTaskById(id)
	local taskMO = self._dictAllTask[id]

	return taskMO
end

function M:getAllMOs()
	return self._arrayAllLvMO
end

function M:getNormalMOs()
	return self._arrayNormalLvMO
end

function M:getLoopMOs()
	return self._arrayLoopLvMO
end

function M:getMOByLv(lv)
	return self._arrayAllLvMO[lv]
end

function M:getWeeklyTasks(needSort)
	local list = self._arrayWeeklyTask or {}

	if needSort then
		_sortTask(list)
	end

	return list
end

function M:getFixedTasks(needSort)
	local list = self._arrayFixedTask or {}

	if needSort then
		_sortTask(list)
	end

	return list
end

function M:getDayTasks(needSort)
	local list = self._arrayDayTasks or {}

	if needSort then
		_sortTask(list)
	end

	return list
end

function M:getTaskIndexById(id, needSort)
	local taskMO = self._dictAllTask[id]
	local list = self._arrayWeeklyTask

	if taskMO:getType() == SeasonEnum.TaskType.Fixed then
		list = self._arrayFixedTask
	end

	if needSort then
		_sortTask(list)
	end

	local index = 1

	for i, mo in ipairs(list) do
		if mo:getId() == id then
			index = i

			break
		end
	end

	return index
end

function M:getSeasonId()
	return self._seasonId
end

function M:getCurrLv()
	return self._currLevel
end

function M:getCurrScore()
	return self._currScore
end

function M:getVipStatus()
	return self._vipStatus
end

function M:getTodayScore()
	return self._todayScore
end

function M:getTotalProgress()
	local perScore = SeasonConfig.instance:getScorePerLv()
	local progress = (self._currLevel * perScore + self._currScore) / (perScore * self:getLimitLv())

	return math.min(1, progress)
end

function M:getNextLvProgress()
	local perScore = SeasonConfig.instance:getScorePerLv()

	return self._currScore / perScore
end

function M:getLimitLv()
	return SeasonConfig.instance:getLimitLv(self._seasonId)
end

function M:isVip()
	return self._vipStatus == SeasonEnum.VipStatus.Vip1 or self._vipStatus == SeasonEnum.VipStatus.Vip2
end

function M:hasLvActive()
	if not SeasonFacade.instance:isSysTaskOpen() then
		return false
	end

	return self._hasLvActive
end

function M:getCurLocationLv()
	return self._canGotRewardMinLv > 0 and self._canGotRewardMinLv or self:getCurrLv()
end

function M:getShowMaxLv()
	local normalMaxLv = self:getLimitLv()
	local loopAddLv = SeasonConfig.instance:getLoopRewardAddLvCount()

	if normalMaxLv > self._currLevel then
		return normalMaxLv
	end

	local showLv = self._currLevel - math.fmod(self._currLevel - normalMaxLv, loopAddLv) + loopAddLv
	local maxLv = SeasonConfig.instance:getMaxLv()

	return math.min(showLv, maxLv)
end

function M:isAllNormalFinished()
	local allFinished = true

	for _, mo in ipairs(self._arrayNormalLvMO) do
		if mo:getRewardStatus() ~= SeasonEnum.RewardStatus.Finished then
			allFinished = false

			break
		end
	end

	return allFinished
end

function M:hasTaskActive()
	return self:hasWeeklyTaskActive() or self:hasFixedTaskActive() or self:hasDayTaskActive()
end

function M:hasWeeklyTaskActive()
	return self:_hasActiveTask(self:getWeeklyTasks())
end

function M:hasFixedTaskActive()
	return self:_hasActiveTask(self:getFixedTasks())
end

function M:hasDayTaskActive()
	return self:_hasActiveTask(self:getDayTasks())
end

function M:_hasActiveTask(moList)
	if not SeasonFacade.instance:isSysTaskOpen() then
		return false
	end

	local hasActive = false

	for _, taskMO in ipairs(moList) do
		if taskMO:canGetReward() then
			hasActive = true

			break
		end
	end

	return hasActive
end

function M:hasDailyTaskProgressActive()
	local scheduleRewards = self:getScheduleRewards()
	local finishedCount = self:getDailyTaskFinishedNum()
	local dailyProgressCO = SeasonConfig.instance:getDailyProgressReward(self:getSeasonId())

	for _, co in ipairs(dailyProgressCO) do
		if finishedCount >= co.count and not table.indexof(scheduleRewards, co.id) then
			return true
		end
	end
end

function M:hasWeeklyTaskProgressActive()
	local scheduleRewards = self:getScheduleRewards()
	local finishedCount = self:getWeeklyTaskFinishedNum()
	local weeklyProgressCO = SeasonConfig.instance:getWeeklyProgressReward(self:getSeasonId())

	for _, co in ipairs(weeklyProgressCO) do
		if finishedCount >= co.count and not table.indexof(scheduleRewards, co.id) then
			return true
		end
	end

	return false
end

function M:hasTaskProgressActive()
	return self:hasDailyTaskProgressActive() or self:hasWeeklyTaskProgressActive() or false
end

function M:getLastSeasonLv()
	return self._lastSeasonLv
end

function M:getLastSeasonScore()
	return self._lastSeasonScore
end

function M:getLastSeasonTaskPoint()
	return self._lastSeasonTaskPoint
end

function M:getReportScores()
	return self._arrayReportScore or {}
end

function M:getReportTasks()
	return self._arrayReportTask or {}
end

function M:getVip1ExtraRewardId()
	local cfg = SeasonConfig.instance:getConfigByKey(ConfigName.Season, self._seasonId)

	if cfg then
		return cfg.rewardId1
	end

	return 0
end

function M:getVip2ExtraRewardId()
	local cfg = SeasonConfig.instance:getConfigByKey(ConfigName.Season, self._seasonId)

	if cfg then
		return cfg.rewardId2
	end

	return 0
end

function M:getRemainTimeStr(useColor)
	local timeStr = ""
	local needShowTime = false
	local mo = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.SEASON, self._seasonId)

	if mo then
		local seconds = mo:getLeftSeconds()

		timeStr = self:_getTimeStr(seconds, useColor)
		needShowTime = seconds < 691200
	end

	return timeStr, needShowTime
end

function M:getRemainWeekTimeStr(useColor)
	local seconds = TimeUtil.instance:getRemainTimeToNextWeek()
	local mo = ActivityController.instance:getActivityByLogicTypeAndCode(ActivityEnum.LogicType.SEASON, self._seasonId)

	if mo then
		seconds = math.min(seconds, mo:getLeftSeconds())
	end

	local timeStr = self:_getTimeStr(seconds, useColor)

	return timeStr
end

function M:_getTimeStr(sec, useColor)
	local time, timeUnit = TimeUtil.instance:trsSeconds2BriefStr(sec, 3)
	local timeStr = useColor and string.format("<color=#d9d8d8>%s</color>", time) or tostring(time)

	return timeStr .. timeUnit
end

function M:getRewardsByPromoteLv(promoteLv)
	local rewards = {}

	for lv = self._currLevel + 1, self._currLevel + promoteLv do
		local mo = self:getMOByLv(lv)

		if mo then
			local items = mo:getRewards()

			for _, item in ipairs(items) do
				table.insert(rewards, item)
			end
		end
	end

	return rewards
end

function M:setNew(isNew)
	local hasKey, key = self:_getNewKey()

	if hasKey then
		local value = isNew and 1 or 0

		Astral.LocalStorage.Instance:SetInt(key, value)
	end
end

function M:isNew()
	local hasKey, key = self:_getNewKey()

	if hasKey then
		local value = Astral.LocalStorage.Instance:GetInt(key, 1)

		return value == 1
	else
		return false
	end
end

function M:_getNewKey()
	local id = tonumber(PlayerModel.instance:getId())

	if id == 0 then
		return false, ""
	else
		return true, string.format("__season_is_new_%s__", id)
	end
end

function M:getDailyTaskFinishedNum()
	local count = 0

	for _, taskMO in ipairs(self._arrayDayTasks or {}) do
		count = taskMO:isFinished() and count + 1 or count
	end

	return count
end

function M:getWeeklyTaskFinishedNum()
	local count = 0

	for _, taskMO in ipairs(self._arrayWeeklyTask or {}) do
		count = taskMO:isFinished() and count + 1 or count
	end

	return count
end

function M:getScheduleRewards()
	return self._scheduleRewards
end

function M:receiveScheduleReward(id)
	table.insert(self._scheduleRewards or {}, id)
end

function M:_hasReward(taskMoList)
	for _, taskMo in ipairs(taskMoList) do
		if taskMo:canGetReward() then
			return true
		end
	end

	return false
end

function M:_hasProgressReward(rewardCoList, finishedCount)
	local scheduleRewards = SeasonModel.instance:getScheduleRewards()

	for _, progressCo in ipairs(rewardCoList) do
		local isReceived = progressCo and table.indexof(scheduleRewards or {}, progressCo.id) or false
		local canReceive = finishedCount >= progressCo.count and not isReceived or false

		if canReceive then
			return true
		end
	end

	return false
end

function M:hasDailyReward()
	local tasks = self:getDayTasks(false)

	if self:_hasReward(tasks) then
		return true
	end

	local rewardCoList = SeasonConfig.instance:getDailyProgressReward(SeasonModel.instance:getSeasonId())
	local finishedCount = SeasonModel.instance:getDailyTaskFinishedNum()

	return self:_hasProgressReward(rewardCoList, finishedCount)
end

function M:hasWeeklyReward()
	local tasks = self:getWeeklyTasks(false)

	if self:_hasReward(tasks) then
		return true
	end

	local rewardCoList = SeasonConfig.instance:getWeeklyProgressReward(SeasonModel.instance:getSeasonId())
	local finishedCount = SeasonModel.instance:getWeeklyTaskFinishedNum()

	return self:_hasProgressReward(rewardCoList, finishedCount)
end

function M:hasFixedReward()
	local tasks = self:getFixedTasks(false)

	return self:_hasReward(tasks)
end

function M:hasAchievementReward()
	return self:hasLvActive()
end

M.instance = M.New()

return M

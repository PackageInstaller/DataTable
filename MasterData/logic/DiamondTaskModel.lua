-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/model/DiamondTaskModel.lua

module("logic.extensions.diamondtask.model.DiamondTaskModel", package.seeall)

local DiamondTaskModel = class("DiamondTaskModel", BaseModel)

DiamondTaskModel.TaskPeriodType = {}
DiamondTaskModel.TaskPeriodType.Daily = 1
DiamondTaskModel.TaskPeriodType.Weekly = 2

local dailyFuncId = 31
local weeklyFuncId = 32

DiamondTaskModel.dailyFuncId = dailyFuncId
DiamondTaskModel.weeklyFuncId = weeklyFuncId

function DiamondTaskModel:ctor()
	self:onReset()
end

function DiamondTaskModel:onInit()
	self:_initAllTask()
end

function DiamondTaskModel:onReset()
	self._taskInfo = {}

	for i = 1, 2 do
		self._taskInfo[i] = {}
		self._taskInfo[i].activityScore = 0
		self._taskInfo[i].maxActivityScore = 100
		self._taskInfo[i].scoreGainBit = 0
		self._taskInfo[i].accumulateActivityScore = 0
		self._taskInfo[i].tasks = {}
		self._taskInfo[i].recommendType = -1
		self._taskInfo[i].activeData = {}
	end
end

function DiamondTaskModel:_initAllTask()
	for i, v in ipairs(DiamondTaskConfig.instance:getTaskCfgs()) do
		if v and v.periodType then
			local task = {}

			task.taskId = v.id
			task.desc = v.desc
			task.taskType = v.taskType
			task.gift = v.gift
			task.maxProgerss = v.progress
			task.activityScore = v.activityScore
			task.progress = 0
			task.describe = v.describe
			task.hasGain = false
			task.mofangLevel = v.mofangLevel
			task.taskLimit = v.taskLimit
			task.bindFuncId = v.bindFuncId
			task.state = 2
			task.jumpTo = v.jumpTo
			task.recommendTypes = v.recommendType
			task.params = v.params

			table.insert(self._taskInfo[v.periodType].tasks, task)
		end
	end
end

function DiamondTaskModel:finishTaskes(newfinishtaskids)
	if newfinishtaskids then
		for i = 1, #newfinishtaskids do
			local task = self:_getTaskById(newfinishtaskids[i])

			if task then
				task.progress = task.maxProgerss
				task.state = 1
			end
		end
	end
end

function DiamondTaskModel:addScoreByType(type, addactivityscore)
	local info = self._taskInfo[checknumber(type)]

	if info then
		info.activityScore = info.activityScore + addactivityscore
	end
end

function DiamondTaskModel:onScoreAdd(addactivityscore, taskId)
	for i, v in ipairs(self._taskInfo) do
		for k, v1 in ipairs(v.tasks) do
			if v1.taskId == taskId then
				v.activityScore = v.activityScore + addactivityscore
			end
		end
	end
end

function DiamondTaskModel:_getTaskById(taskId)
	for i, v in ipairs(self._taskInfo) do
		for k, v1 in ipairs(v.tasks) do
			if v1.taskId == taskId then
				return v1
			end
		end
	end
end

function DiamondTaskModel:refreshPeriodInfo()
	local weekday = ServerTime.formatNowServerLook("%w")

	if weekday == "0" then
		weekday = "7"
	end

	for i = 1, 2 do
		local planId = DiamondTaskConfig.instance:getPlanId(i, weekday)
		local plans = DiamondTaskConfig.instance:getPlanCfgs(planId)

		if plans then
			local cfgs = table.values(plans)

			self._taskInfo[i].maxActivityScore = self:_getMaxScore(cfgs)
			self._taskInfo[i].activeData = {}

			table.sort(cfgs, function(x, y)
				return x.id < y.id
			end)

			for k, v in ipairs(cfgs) do
				local giftData = {}

				giftData.score = v.score
				giftData.gift = v.gift
				giftData.got = self:_isActiveGiftGot(i, v.id)

				table.insert(self._taskInfo[i].activeData, giftData)
			end
		end
	end
end

function DiamondTaskModel:_isActiveGiftGot(periodType, id)
	return GameUtil.isBitOpenByDigit(self._taskInfo[periodType].scoreGainBit, id)
end

function DiamondTaskModel:_getMaxScore(cfg)
	local max = 0

	for k, v in pairs(cfg) do
		if max < v.score then
			max = v.score
		end
	end

	return max
end

function DiamondTaskModel:onTaskInfoGot(tasks)
	self:onReset()
	self:_initAllTask()

	for i, v in ipairs(tasks) do
		self._taskInfo[v.periodType].activityScore = v.activityScore
		self._taskInfo[v.periodType].scoreGainBit = v.scoreGainBit
		self._taskInfo[v.periodType].accumulateActivityScore = v.accumulateActivityScore

		for _, t in ipairs(v.tasks) do
			local task

			for k, j in ipairs(self._taskInfo[v.periodType].tasks) do
				if j.taskId == t.taskId then
					j.progress = t.progress
					j.hasGain = t.hasGain
					j.state = j.hasGain and 3 or j.progress >= j.maxProgerss and 1 or 2
				end
			end
		end

		self._taskInfo[v.periodType].recommendType = v.recommendType

		self:_sortTasks(self._taskInfo[v.periodType].tasks)
	end
end

function DiamondTaskModel:updateAccumulateScore(msg)
	if self._taskInfo and self._taskInfo[msg.periodType] then
		self._taskInfo[msg.periodType].accumulateActivityScore = msg.accumulateActivityScore
	end
end

function DiamondTaskModel:_sortTasks(tasks)
	table.sort(tasks, function(a, b)
		if a.state == b.state then
			return a.taskId < b.taskId
		end

		return a.state < b.state
	end)
end

function DiamondTaskModel:onGiftGained(taskId)
	for i, v in ipairs(self._taskInfo) do
		for k, v1 in ipairs(v.tasks) do
			if v1.taskId == taskId then
				v1.state = 3
			end
		end

		self:_sortTasks(v.tasks)
	end
end

function DiamondTaskModel:onActiveGiftGained(periodType, index)
	self._taskInfo[periodType].activeData[index + 1].got = true
end

function DiamondTaskModel:getTaskActivity(periodType)
	if self._taskInfo and self._taskInfo[periodType] then
		return self._taskInfo[periodType].activityScore, self._taskInfo[periodType].maxActivityScore
	end

	return 0, 100
end

function DiamondTaskModel:getTasksData(periodType, withFinish)
	if withFinish == nil then
		withFinish = true
	end

	local curMfLv = MofangModel.instance:getCurLv()
	local list = {}

	for k, v in ipairs(self._taskInfo[periodType].tasks) do
		local isTaskFinish = self:_isMainTaskFinished(v)

		if isTaskFinish and curMfLv >= v.mofangLevel then
			local isOnline = true

			if not string.nilorempty(v.onlineTimeRange) then
				local aa = string.split(v.onlineTimeRange, "#")

				if not string.nilorempty(aa[1]) and not string.nilorempty(aa[2]) then
					isOnline = GameUtil.checkIsInTimePeriod(aa[1], aa[2])
				end
			end

			if isOnline then
				local newTaskType = string.format("%s#%s", v.taskType, string.nilorempty(v.params) and "default" or v.params)
				local taskes = list[newTaskType]

				if not taskes then
					taskes = {}
					list[newTaskType] = taskes
				end

				local task = {}

				table.merge(task, v)
				table.insert(taskes, task)
			end
		end
	end

	for k, v in pairs(list) do
		table.sort(v, function(x, y)
			if x == y then
				return false
			end

			if x.maxProgerss < y.maxProgerss then
				return true
			end

			if x.maxProgerss > y.maxProgerss then
				return false
			end

			return false
		end)
	end

	local taskes = {}

	for k, v in pairs(list) do
		local found = false

		for i = 1, #v do
			if v[i].state and v[i].state ~= 3 then
				found = true

				table.insert(taskes, v[i])

				break
			end
		end

		if withFinish and not found and #v > 0 then
			table.insert(taskes, v[#v])
		end
	end

	table.sort(taskes, function(x, y)
		if x == y then
			return false
		end

		if x.state == 1 and y.state ~= 1 then
			return true
		end

		if x.state ~= 1 and y.state == 1 then
			return false
		end

		if x.state == 2 and y.state ~= 2 then
			return true
		end

		if x.state ~= 2 and y.state == 2 then
			return false
		end

		if x.taskId < y.taskId then
			return true
		end

		return false
	end)

	return taskes
end

function DiamondTaskModel:getCurCanGetTasks(periodType, withFinish)
	if withFinish == nil then
		withFinish = true
	end

	local curMfLv = MofangModel.instance:getCurLv()
	local list = {}

	for k, v in ipairs(self._taskInfo[periodType].tasks) do
		local isTaskFinish = self:_isMainTaskFinished(v)

		if isTaskFinish and curMfLv >= v.mofangLevel then
			local isOnline = true

			if not string.nilorempty(v.onlineTimeRange) then
				local aa = string.split(v.onlineTimeRange, "#")

				if not string.nilorempty(aa[1]) and not string.nilorempty(aa[2]) then
					isOnline = GameUtil.checkIsInTimePeriod(aa[1], aa[2])
				end
			end

			if isOnline then
				local newTaskType = string.format("%s#%s", v.taskType, string.nilorempty(v.params) and "default" or v.params)
				local taskes = list[newTaskType]

				if not taskes then
					taskes = {}
					list[newTaskType] = taskes
				end

				local task = {}

				table.merge(task, v)
				table.insert(taskes, task)
			end
		end
	end

	local taskes = {}

	for k, v in pairs(list) do
		for i = 1, #v do
			if v[i].state and v[i].state == 1 then
				table.insert(taskes, v[i])
			end
		end
	end

	return taskes
end

function DiamondTaskModel:_isMainTaskFinished(task)
	local funcId = checknumber(task.bindFuncId)

	if funcId > 0 then
		if funcId == 69 then
			local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

			return FuncOpenController.instance:getConditionReached(funcCfg.openCondition)
		end

		return FuncOpenModel.instance:getFuncIsOpen(funcId)
	else
		return true
	end
end

function DiamondTaskModel:isUnLock(taskType)
	if taskType == GameEnum.TaskViewTab.Daily then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(dailyFuncId)

		return FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)
	elseif taskType == GameEnum.TaskViewTab.Weekly then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(weeklyFuncId)

		return FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)
	end

	return true
end

function DiamondTaskModel:checkJumptoUnlock(data)
	local isTaskFinish = self:_isMainTaskFinished(data)

	if not isTaskFinish then
		return
	end

	if data.mofangLevel and data.mofangLevel > 0 and MofangModel.instance:getCurLv() < data.mofangLevel then
		TipsFacade.instance:openLockTips(moFangLevel, nil, data.desc)

		return
	end

	return true
end

function DiamondTaskModel:getActiveGiftsData(periodType)
	return self._taskInfo[periodType].activeData
end

function DiamondTaskModel:getTaskInfoByType(periodType)
	return self._taskInfo[periodType]
end

function DiamondTaskModel:isRecommendType(periodType, id)
	local task = self:_getTaskById(id)

	if not task.recommendTypes then
		return false
	end

	return TableUtil.isHad(task.recommendTypes, self._taskInfo[periodType].recommendType)
end

DiamondTaskModel.instance = DiamondTaskModel.New()

return DiamondTaskModel

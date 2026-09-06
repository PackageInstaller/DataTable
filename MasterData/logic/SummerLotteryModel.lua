-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/model/SummerLotteryModel.lua

module("logic.extensions.summerlottery.model.SummerLotteryModel", package.seeall)

local SummerLotteryModel = class("SummerLotteryModel", BaseModel)

SummerLotteryModel.PeriodRefreshTypeById = {
	[GameEnum.PeriodRefreshType.None] = "none",
	[GameEnum.PeriodRefreshType.Daily] = "daily",
	[GameEnum.PeriodRefreshType.Weekly] = "weekly",
	[GameEnum.PeriodRefreshType.Monthly] = "monthly",
	[GameEnum.PeriodRefreshType.AllTime] = "allTime"
}

function SummerLotteryModel:ctor()
	self:onReset()
end

function SummerLotteryModel:onInit()
	self:onReset()
end

function SummerLotteryModel:onReset()
	self._taskInfosMap = {}
	self._taskInfoTypeMap = {}
	self.curScore = 0
	self.floorTimes = 0
	self._gainedProcessPrizeMap = {}
	self.koiInfos = {}
	self.curKoiPrizeNums = {}
	self.koiPrizeId = 0

	local configInstance = SummerLotteryConfig.instance
	local lotteryConfig = configInstance:getSummerLotteryConfig(self:getActivityId())

	self.poolConfig = configInstance:getSummerLotteryPoolConfig(lotteryConfig.poolPlanId)

	local matType, matId, _ = MaterialMgr.getMatParams(self.poolConfig.lotteryCost)

	self.lotteryCostMaterial = {
		matType = matType,
		matId = matId
	}

	local poolPrize = configInstance:getSummerLotteryAllPrize(self.poolConfig.poolPrizePlanId)

	self._prizeId2GroupId = {}
	self._groupCount = {}

	for prizeId, conf in pairs(poolPrize) do
		if checknumber(prizeId) > 0 then
			local groupId = checknumber(conf.group)

			if groupId > 0 then
				self._prizeId2GroupId[prizeId] = groupId
			end
		end
	end
end

function SummerLotteryModel:getTaskInfoListByType(tabId)
	local typeStr = SummerLotteryModel.PeriodRefreshTypeById[tabId]

	return typeStr and self._taskInfoTypeMap[typeStr]
end

function SummerLotteryModel:handleGetInfo(msg)
	local configInstance = SummerLotteryConfig.instance
	local showPrizeConfs = configInstance:getPrizeShowConfs(self.poolConfig.poolPrizePlanId)

	for groupId, conf in pairs(showPrizeConfs) do
		self._groupCount[groupId] = conf.count
	end

	self.koiPrizeId = msg.koiPrizeId or 0
	self.koiInfos = msg.koiInfos
	self.gainedBigPrizeIds = msg.gainedBigPrizeIds
	self.floorTimes = msg.floorTimes
	self.dailyTimes = msg.dailyTimes

	for _, prizeId in ipairs(self.gainedBigPrizeIds) do
		local groupId = self._prizeId2GroupId[prizeId]

		self._groupCount[groupId] = self._groupCount[groupId] - 1
	end

	self.curKoiPrizeNums = msg.curKoiPrizeNums or {}
end

function SummerLotteryModel:getRemainKoiNum(id)
	if self.curKoiPrizeNums[id] ~= nil then
		local config = SummerLotteryConfig.instance:getKoiPrize(self.poolConfig.koiPrizePlanId, id) or {}

		return math.max(checknumber(config.count) - checknumber(self.curKoiPrizeNums[id]), 0)
	else
		return 0
	end
end

function SummerLotteryModel:handleDraw(msg)
	return
end

function SummerLotteryModel:handleGetTaskInfo(msg)
	if not msg.taskInfos then
		self._taskInfosMap = {}
		self._taskInfoTypeMap = {}

		local configInstance = SummerLotteryConfig.instance

		for _, taskInfo in ipairs(msg.taskInfos) do
			self._taskInfosMap[taskInfo.taskId] = taskInfo

			local conf = configInstance:getTaskConf(self.poolConfig.taskPlanId, taskInfo.taskId)

			if conf then
				self._taskInfoTypeMap[conf.periodType] = self._taskInfoTypeMap[conf.periodType] or {}

				local taskInfoTypeList = self._taskInfoTypeMap[conf.periodType]

				table.insert(taskInfoTypeList, taskInfo)
			else
				printError("cant find task", taskInfo.taskId)
			end
		end

		self.curScore = msg.curScore
		self._gainedProcessPrizeMap = {}

		for _, id in ipairs(msg.gainedProcessPrizeIds or {}) do
			self._gainedProcessPrizeMap[id] = true
		end
	end
end

function SummerLotteryModel:handleGainTaskPrize(taskIds, gainScore)
	for _, taskId in ipairs(taskIds or {}) do
		local taskInfo = self._taskInfosMap[taskId]

		if taskInfo then
			taskInfo.gainedPrize = true
		end
	end

	self.curScore = self.curScore + checknumber(gainScore)
end

function SummerLotteryModel:handleGainTaskProgressPrize(progressPrizeIds)
	for _, progressPrizeId in ipairs(progressPrizeIds or {}) do
		self._gainedProcessPrizeMap[progressPrizeId] = true
	end
end

function SummerLotteryModel:getActivityId()
	return checknumber(SummerLotteryConfig.instance:getCommonValue("ActId"))
end

function SummerLotteryModel:getRemainByGroupId(groupId)
	return math.max(checknumber(self._groupCount[groupId]), 0)
end

function SummerLotteryModel:isGainAllLargePrize()
	for _, count in pairs(self._groupCount) do
		if count > 0 then
			return false
		end
	end

	return true
end

function SummerLotteryModel:isGainAllLargePrizeWithKoi()
	for groupId, count in pairs(self._groupCount) do
		if count > 0 then
			return false
		end
	end

	return true
end

function SummerLotteryModel:getRemain2NextLargePrize()
	return Mathf.Clamp(self.poolConfig.floorTimes - self.floorTimes, 0, self.poolConfig.floorTimes)
end

function SummerLotteryModel:isTaskInfoRed(taskInfo)
	local bGainedPrize = taskInfo.gainedPrize == true

	if not bGainedPrize then
		local conf = SummerLotteryConfig.instance:getTaskConf(self.poolConfig.taskPlanId, taskInfo.taskId)
		local maxProgress = conf.maxProgress
		local progress = taskInfo.curProgress

		if maxProgress <= progress then
			return true
		end
	end

	return false
end

function SummerLotteryModel:isTaskPrizeGain(taskId)
	local taskInfo = self._taskInfosMap[taskId]

	return taskInfo and taskInfo.gainedPrize == true
end

function SummerLotteryModel:isTaskTypeRed(taskTypeStr)
	local taskInfos = self._taskInfoTypeMap[taskTypeStr]

	if taskInfos then
		for _, taskInfo in ipairs(taskInfos) do
			if self:isTaskInfoRed(taskInfo) then
				return true
			end
		end
	end

	return false
end

function SummerLotteryModel:isProgressPrizeGain(id)
	return self._gainedProcessPrizeMap[id]
end

function SummerLotteryModel:isProgressPrizeCanGain(id, needScore)
	if not self:isProgressPrizeGain(id) then
		return needScore <= self.curScore
	end
end

SummerLotteryModel.instance = SummerLotteryModel.New()

return SummerLotteryModel

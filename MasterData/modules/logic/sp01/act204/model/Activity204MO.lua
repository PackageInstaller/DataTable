-- chunkname: @modules/logic/sp01/act204/model/Activity204MO.lua

module("modules.logic.sp01.act204.model.Activity204MO", package.seeall)

local Activity204MO = pureTable("Activity204MO")

function Activity204MO:init(activityId)
	self.id = activityId
	self.spBonusStage = 0
	self.taskDict = {}
end

function Activity204MO:setSpBonusStage(stage)
	self.spBonusStage = stage
end

function Activity204MO:updateInfo(actInfo, taskInfos)
	self:updateActivityInfo(actInfo)
	self:updateTaskInfos(taskInfos)
end

function Activity204MO:updateActivityInfo(info)
	self.currentStage = info.currentStage
	self.getDailyCollection = info.getDailyCollection
	self.getOneceBonus = info.getOneceBonus
	self.getMilestoneProgress = tonumber(info.getMilestoneProgress)
end

function Activity204MO:onGetOnceBonus()
	self.getOneceBonus = true

	if self.spBonusStage == 0 then
		self.spBonusStage = 1
	end
end

function Activity204MO:acceptRewards(progress)
	self.getMilestoneProgress = tonumber(progress)
end

function Activity204MO:getMilestoneRewardStatus(rewardId)
	local status = Activity204Enum.RewardStatus.None
	local config = Activity204Config.instance:getMileStoneConfig(self.id, rewardId)

	if config then
		if not config.coinNum then
			local coinNum = 0

			if config then
				if not config.isLoopBonus then
					local isLoop = false
					local currencyId = Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)
					local hasCurrencyNum = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)

					if isLoop then
						if coinNum <= self.getMilestoneProgress then
							if config then
								if not config.loopBonusIntervalNum then
									local loopNum = 1

									if loopNum <= hasCurrencyNum - self.getMilestoneProgress then
										status = Activity204Enum.RewardStatus.Canget
									end
								end
							end
						elseif coinNum <= hasCurrencyNum then
							status = Activity204Enum.RewardStatus.Canget
						end
					elseif coinNum <= self.getMilestoneProgress then
						status = Activity204Enum.RewardStatus.Hasget
					elseif coinNum <= hasCurrencyNum then
						status = Activity204Enum.RewardStatus.Canget
					end

					return status
				end
			end
		end
	end
end

function Activity204MO:getMilestoneValue(rewardId)
	local config = Activity204Config.instance:getMileStoneConfig(self.id, rewardId)

	if config then
		if not config.coinNum then
			local coinNum = 0

			if config then
				if not config.isLoopBonus then
					local isLoop = false

					if not isLoop then
						return coinNum
					end

					if config then
						if not config.loopBonusIntervalNum then
							local loopNum = 1

							return (coinNum <= self.getMilestoneProgress or nil) and coinNum + math.floor((self.getMilestoneProgress - coinNum) / loopNum) * loopNum + loopNum
						end
					end
				end
			end
		end
	end
end

function Activity204MO:onGetDailyCollection()
	self.getDailyCollection = true
end

function Activity204MO:updateTaskInfos(infos)
	self.taskDict = {}

	if infos then
		for i = 1, #infos do
			self:updateTaskInfo(infos[i])
		end
	end
end

function Activity204MO:updateTaskInfo(info)
	local taskInfo = self:getTaskInfo(info.taskId, true)

	taskInfo.progress = info.progress
	taskInfo.hasGetBonus = info.hasGetBonus
	taskInfo.expireTime = tonumber(info.expireTime)
end

function Activity204MO:getTaskInfo(taskId, createIfNil)
	local taskInfo = self.taskDict[taskId]

	if not taskInfo and createIfNil then
		taskInfo = {
			taskId = taskId
		}
		taskInfo.progress = 0
		taskInfo.hasGetBonus = false
		taskInfo.expireTime = 0
		self.taskDict[taskId] = taskInfo
	end

	return taskInfo
end

function Activity204MO:getTaskList()
	local list = {}

	if self.taskDict then
		for k, v in pairs(self.taskDict) do
			local taskMo = {}

			taskMo.id = v.taskId
			taskMo.progress = v.progress
			taskMo.hasGetBonus = v.hasGetBonus
			taskMo.expireTime = v.expireTime
			taskMo.canGetReward = self:checkTaskCanReward(v)
			taskMo.config = Activity204Config.instance:getTaskConfig(v.taskId)
			taskMo.missionorder = taskMo.config.missionorder
			taskMo.status = Activity204Enum.TaskStatus.None

			if taskMo.hasGetBonus then
				taskMo.status = Activity204Enum.TaskStatus.Hasget
			elseif taskMo.canGetReward then
				taskMo.status = Activity204Enum.TaskStatus.Canget
			end

			table.insert(list, taskMo)
		end
	end

	local stageConfig = Activity204Config.instance:getStageConfig(self.id, self.currentStage)

	if stageConfig then
		if not stageConfig.globalTaskId then
			local globalTaskId = 0
			local taskInfo = TaskModel.instance:getTaskById(globalTaskId)
			local taskMo = {}

			taskMo.id = globalTaskId
			taskMo.config = Activity173Config.instance:getTaskConfig(globalTaskId)

			if taskInfo then
				taskMo.progress = taskInfo.progress or 0
			end

			taskMo.hasGetBonus = taskInfo and taskInfo.finishCount > 0 or false
			taskMo.canGetReward = not taskMo.hasGetBonus and taskInfo and taskMo.progress >= taskMo.config.maxProgress
			taskMo.missionorder = 0
			taskMo.isGlobalTask = true
			taskMo.status = Activity204Enum.TaskStatus.None

			if taskMo.hasGetBonus then
				taskMo.status = Activity204Enum.TaskStatus.Hasget
			elseif taskMo.canGetReward then
				taskMo.status = Activity204Enum.TaskStatus.Canget
			end

			table.insert(list, taskMo)

			return list
		end
	end
end

function Activity204MO:finishTask(taskId)
	local taskInfo = self:getTaskInfo(taskId)

	if taskInfo then
		taskInfo.hasGetBonus = true
	end
end

function Activity204MO:pushTask(act204Tasks, deleteTasks)
	self:checkHasNewTask(act204Tasks)

	if act204Tasks then
		for i = 1, #act204Tasks do
			self:updateTaskInfo(act204Tasks[i])
		end
	end

	if deleteTasks then
		for i = 1, #deleteTasks do
			local taskInfo = deleteTasks[i]

			self.taskDict[taskInfo.taskId] = nil
		end
	end
end

function Activity204MO:checkHasNewTask(act204Tasks)
	self._hasNewTask = false

	if act204Tasks then
		for i = 1, #act204Tasks do
			local taskId = act204Tasks[i].taskId
			local taskInfo = self:getTaskInfo(taskId)

			if not taskInfo then
				self._hasNewTask = true

				break
			end
		end
	end
end

function Activity204MO:hasNewTask()
	return self._hasNewTask
end

function Activity204MO:recordHasReadNewTask()
	self._hasNewTask = false
end

function Activity204MO:checkTaskCanReward(param)
	local taskInfo = type(param) == "number" and self:getTaskInfo(param) or param

	if not taskInfo then
		return false
	end

	if taskInfo.hasGetBonus then
		return false
	end

	local config = Activity204Config.instance:getTaskConfig(taskInfo.taskId)

	if config then
		if not config.maxProgress then
			local maxProgress = 0

			return maxProgress <= taskInfo.progress
		end
	end
end

function Activity204MO:hasCanRewardTask()
	for k, v in pairs(self.taskDict) do
		if self:checkTaskCanReward(v) then
			return true
		end
	end

	return false
end

function Activity204MO:hasActivityReward()
	if not self.getDailyCollection then
		return true
	end

	local list = Activity204Config.instance:getMileStoneList(self.id)

	if list then
		for i, v in ipairs(list) do
			local status = self:getMilestoneRewardStatus(v.rewardId)

			if status == Activity204Enum.RewardStatus.Canget then
				return true
			end
		end
	end

	return false
end

function Activity204MO:hasAnyLimitTask()
	local taskList = self:getTaskList()

	for _, taskMo in ipairs(taskList or {}) do
		if taskMo.status == Activity204Enum.TaskStatus.None and taskMo.config and taskMo.config.durationHour ~= 0 then
			return true
		end
	end

	return false
end

return Activity204MO

-- chunkname: @modules/logic/versionactivity2_5/act186/model/Activity186MO.lua

module("modules.logic.versionactivity2_5.act186.model.Activity186MO", package.seeall)

local Activity186MO = pureTable("Activity186MO")

function Activity186MO:init(activityId)
	self.id = activityId
	self.spBonusStage = 0
	self.taskDict = {}
end

function Activity186MO:setSpBonusStage(stage)
	self.spBonusStage = stage
end

function Activity186MO:updateInfo(info)
	self:updateActivityInfo(info.info)
	self:updateTaskInfos(info.taskInfos)
	self:updateLikeInfos(info.likeInfos)
	self:updateGameInfos(info.gameInfos)
end

function Activity186MO:updateActivityInfo(info)
	self.currentStage = info.currentStage
	self.getDailyCollection = info.getDailyCollection
	self.getOneceBonus = info.getOneceBonus
	self.getMilestoneProgress = tonumber(info.getMilestoneProgress)
end

function Activity186MO:onGetOnceBonus()
	self.getOneceBonus = true

	if self.spBonusStage == 0 then
		self.spBonusStage = 1
	end
end

function Activity186MO:acceptRewards(progress)
	self.getMilestoneProgress = tonumber(progress)
end

function Activity186MO:getMilestoneRewardStatus(rewardId)
	local status = Activity186Enum.RewardStatus.None
	local config = Activity186Config.instance:getMileStoneConfig(self.id, rewardId)

	if config then
		if not config.coinNum then
			local coinNum = 0

			if config then
				if not config.isLoopBonus then
					local isLoop = false
					local currencyId = Activity186Config.instance:getConstNum(self.id, Activity186Enum.ConstId.CurrencyId)
					local hasCurrencyNum = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)

					if isLoop then
						if coinNum <= self.getMilestoneProgress then
							if config then
								if not config.loopBonusIntervalNum then
									local loopNum = 1

									if loopNum <= hasCurrencyNum - self.getMilestoneProgress then
										status = Activity186Enum.RewardStatus.Canget
									end
								end
							end
						elseif coinNum <= hasCurrencyNum then
							status = Activity186Enum.RewardStatus.Canget
						end
					elseif coinNum == 0 then
						status = self.getMilestoneProgress < 0 and Activity186Enum.RewardStatus.Canget or Activity186Enum.RewardStatus.Hasget
					elseif coinNum <= self.getMilestoneProgress then
						status = Activity186Enum.RewardStatus.Hasget
					elseif coinNum <= hasCurrencyNum then
						status = Activity186Enum.RewardStatus.Canget
					end

					return status
				end
			end
		end
	end
end

function Activity186MO:getMilestoneValue(rewardId)
	local config = Activity186Config.instance:getMileStoneConfig(self.id, rewardId)

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
							local currencyId = Activity186Config.instance:getConstNum(self.id, Activity186Enum.ConstId.CurrencyId)
							local hasCurrencyNum = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)

							return (coinNum <= self.getMilestoneProgress or nil) and coinNum + math.floor((self.getMilestoneProgress - coinNum) / loopNum) * loopNum + loopNum
						end
					end
				end
			end
		end
	end
end

function Activity186MO:onGetDailyCollection()
	self.getDailyCollection = true
end

function Activity186MO:updateTaskInfos(infos)
	self.taskDict = {}

	if infos then
		for i = 1, #infos do
			self:updateTaskInfo(infos[i])
		end
	end
end

function Activity186MO:updateTaskInfo(info)
	local taskInfo = self:getTaskInfo(info.taskId, true)

	taskInfo.progress = info.progress
	taskInfo.hasGetBonus = info.hasGetBonus
	taskInfo.expireTime = tonumber(info.expireTime)
end

function Activity186MO:getTaskInfo(taskId, createIfNil)
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

function Activity186MO:getTaskList()
	local list = {}

	if self.taskDict then
		for k, v in pairs(self.taskDict) do
			local taskMo = {}

			taskMo.id = v.taskId
			taskMo.progress = v.progress
			taskMo.hasGetBonus = v.hasGetBonus
			taskMo.expireTime = v.expireTime
			taskMo.canGetReward = self:checkTaskCanReward(v)
			taskMo.config = Activity186Config.instance:getTaskConfig(v.taskId)
			taskMo.missionorder = taskMo.config.missionorder
			taskMo.status = Activity186Enum.TaskStatus.None

			if taskMo.hasGetBonus then
				taskMo.status = Activity186Enum.TaskStatus.Hasget
			elseif taskMo.canGetReward then
				taskMo.status = Activity186Enum.TaskStatus.Canget
			end

			table.insert(list, taskMo)
		end
	end

	local stageConfig = Activity186Config.instance:getStageConfig(self.id, self.currentStage)

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
			taskMo.status = Activity186Enum.TaskStatus.None

			if taskMo.hasGetBonus then
				taskMo.status = Activity186Enum.TaskStatus.Hasget
			elseif taskMo.canGetReward then
				taskMo.status = Activity186Enum.TaskStatus.Canget
			end

			table.insert(list, taskMo)

			return list
		end
	end
end

function Activity186MO:finishTask(taskId)
	local taskInfo = self:getTaskInfo(taskId)

	if taskInfo then
		taskInfo.hasGetBonus = true
	end
end

function Activity186MO:pushTask(act186Tasks, deleteTasks)
	if act186Tasks then
		for i = 1, #act186Tasks do
			self:updateTaskInfo(act186Tasks[i])
		end
	end

	if deleteTasks then
		for i = 1, #deleteTasks do
			local taskInfo = deleteTasks[i]

			self.taskDict[taskInfo.taskId] = nil
		end
	end
end

function Activity186MO:checkTaskCanReward(param)
	local taskInfo = type(param) == "number" and self:getTaskInfo(param) or param

	if not taskInfo then
		return false
	end

	if taskInfo.hasGetBonus then
		return false
	end

	local config = Activity186Config.instance:getTaskConfig(taskInfo.taskId)

	if config then
		if not config.maxProgress then
			local maxProgress = 0

			return maxProgress <= taskInfo.progress
		end
	end
end

function Activity186MO:hasCanRewardTask()
	for k, v in pairs(self.taskDict) do
		if self:checkTaskCanReward(v) then
			return true
		end
	end

	return false
end

function Activity186MO:updateLikeInfos(infos)
	self.likeDict = {}

	if infos then
		for i = 1, #infos do
			self:updateLikeInfo(infos[i])
		end
	end
end

function Activity186MO:updateLikeInfo(info)
	local likeInfo = self:getLikeInfo(info.likeType)

	if not likeInfo then
		likeInfo = {
			likeType = info.likeType
		}
		self.likeDict[info.likeType] = likeInfo
	end

	likeInfo.value = info.value
end

function Activity186MO:getLikeInfo(likeType)
	return self.likeDict[likeType]
end

function Activity186MO:getLikeValue(likeType)
	local info = self:getLikeInfo(likeType)

	return (info or nil) and (info.value or 0)
end

function Activity186MO:pushLike(infos)
	if infos then
		for i = 1, #infos do
			self:updateLikeInfo(infos[i])
		end
	end
end

function Activity186MO:getCurLikeType()
	local baseLikeValue = Activity186Config.instance:getConstNum(self.id, Activity186Enum.ConstId.BaseLikeValue)
	local curBaseLikeValue = self:getLikeValue(4)

	if curBaseLikeValue < baseLikeValue then
		return 0
	end

	local maxVal
	local curLikeType = 0

	for k, v in pairs(self.likeDict) do
		if k ~= 4 and (not maxVal or maxVal < v.value) then
			curLikeType = k
			maxVal = v.value
		end
	end

	return curLikeType
end

function Activity186MO:checkLikeEqual(likeType)
	local curLikeType = self:getCurLikeType()

	return curLikeType == likeType
end

function Activity186MO:updateGameInfos(infos)
	self.gameDict = {}

	if infos then
		for i = 1, #infos do
			self:updateGameInfo(infos[i])
		end
	end
end

function Activity186MO:updateGameInfo(info)
	local gameInfo = self:getGameInfo(info.gameId)

	if not gameInfo then
		gameInfo = {
			gameId = info.gameId
		}
		self.gameDict[info.gameId] = gameInfo
	end

	gameInfo.gameTypeId = info.gameTypeId
	gameInfo.expireTime = info.expireTime

	local bGameInfo = info.bTypeGameInfo

	if bGameInfo then
		gameInfo.rewardId = bGameInfo.rewardId
		gameInfo.bTypeRetryCount = bGameInfo.bTypeRetryCount
	end
end

function Activity186MO:getGameInfo(gameId)
	return self.gameDict[gameId]
end

function Activity186MO:finishGame(info)
	local gameInfo = self:getGameInfo(info.gameId)

	if gameInfo then
		self.gameDict[info.gameId] = nil
	end
end

function Activity186MO:playBTypeGame(info)
	local gameInfo = self:getGameInfo(info.gameId)

	if gameInfo then
		gameInfo.rewardId = info.rewardId

		if gameInfo.bTypeRetryCount then
			gameInfo.bTypeRetryCount = gameInfo.bTypeRetryCount - 1
		end
	end
end

function Activity186MO:getOnlineGameList()
	local result = {}

	if self.gameDict then
		for k, v in pairs(self.gameDict) do
			if v.expireTime > ServerTime.now() then
				table.insert(result, v)
			end
		end
	end

	return result
end

function Activity186MO:isGameOnline(gameId)
	local gameInfo = self:getGameInfo(gameId)

	return gameInfo and gameInfo.expireTime > ServerTime.now()
end

function Activity186MO:hasGameCanPlay()
	local list = self:getOnlineGameList()

	return #list > 0
end

function Activity186MO:getQuestionConfig(gameId)
	local uniqueKey = Activity186Model.instance:prefabKeyPrefs(Activity186Enum.LocalPrefsKey.Question, self.id)
	local saveStr = Activity186Controller.instance:getPlayerPrefs(uniqueKey)
	local saveList = string.splitToNumber(saveStr, "#")
	local saveGameId = saveList[1]
	local saveQuestionId = saveList[2]

	if saveGameId == gameId then
		local questionConfig = Activity186Config.instance:getQuestionConfig(gameId, saveQuestionId)

		if questionConfig then
			return questionConfig
		end
	end

	local questionConfig = Activity186Config.instance:getNextQuestion(self.id, saveQuestionId)

	if questionConfig then
		Activity186Controller.instance:setPlayerPrefs(uniqueKey, string.format("%s#%s", gameId, questionConfig.id))
	end

	return questionConfig
end

function Activity186MO:hasActivityReward()
	if not self.getDailyCollection then
		return true
	end

	if Activity186Model.instance:isShowSignRed() then
		return true
	end

	local list = Activity186Config.instance:getMileStoneList(self.id)

	if list then
		for i, v in ipairs(list) do
			local status = self:getMilestoneRewardStatus(v.rewardId)

			if status == Activity186Enum.RewardStatus.Canget then
				return true
			end
		end
	end

	return false
end

function Activity186MO:isInAvgTime()
	local str = Activity186Config.instance:getConstStr(self.id, Activity186Enum.ConstId.AvgOpenTime)
	local list = string.split(str, "#")
	local openTime = TimeUtil.stringToTimestamp(list[1])
	local closeTime = TimeUtil.stringToTimestamp(list[2])
	local nowTime = ServerTime.now()

	return openTime <= nowTime and nowTime <= closeTime
end

function Activity186MO:isCanShowAvgBtn()
	if self.getOneceBonus then
		return false
	end

	return self:isInAvgTime()
end

function Activity186MO:isCanPlayAvgStory()
	if self.getOneceBonus then
		return false
	end

	if not self:isInAvgTime() then
		return
	end

	local value = Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.AvgMark, 0)

	return value == 0
end

return Activity186MO

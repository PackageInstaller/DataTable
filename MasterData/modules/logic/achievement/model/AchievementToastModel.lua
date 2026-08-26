-- chunkname: @modules/logic/achievement/model/AchievementToastModel.lua

module("modules.logic.achievement.model.AchievementToastModel", package.seeall)

local AchievementToastModel = class("AchievementToastModel", BaseModel)

function AchievementToastModel:onInit()
	self._waitToastList = {}
	self._waitNamePlateToastList = {}
	self._groupUnlockToastMap = {}
	self._groupFinishedToastMap = {}
end

function AchievementToastModel:reInit()
	self:release()
end

function AchievementToastModel:release()
	self._waitToastList = nil
	self._waitNamePlateToastList = nil
	self._groupUnlockToastMap = nil
	self._groupFinishedToastMap = nil
end

function AchievementToastModel:updateNeedPushToast(taskInfos)
	self._waitToastList = self._waitToastList or {}
	self._waitToastMap = self._waitToastMap or {}
	self._waitNamePlateToastList = self._waitNamePlateToastList or {}
	self._groupUnlockToastMap = self._groupUnlockToastMap or {}
	self._groupFinishedToastMap = self._groupFinishedToastMap or {}

	if taskInfos then
		local nameplatelist = {}

		for _, taskInfo in ipairs(taskInfos) do
			local taskId = taskInfo.id
			local isNew = taskInfo and taskInfo.new
			local taskCo = AchievementConfig.instance:getTask(taskId)
			local achievementId = taskCo.achievementId
			local achievementCO = AchievementConfig.instance:getAchievement(achievementId)

			if achievementCO and achievementCO.category == AchievementEnum.Type.NamePlate then
				if isNew then
					nameplatelist[achievementId] = nameplatelist[achievementId] or {}

					table.insert(nameplatelist[achievementId], {
						taskId = taskId,
						achievementId = achievementId
					})
				end
			elseif isNew then
				self:checkTaskSatify(taskId)
			end
		end

		for _, achievementtasklist in pairs(nameplatelist) do
			local maxLevelTaskId, lastTaskId

			for _, taskInfo in ipairs(achievementtasklist) do
				local taskCfg = AchievementConfig.instance:getTask(taskInfo.taskId)

				if not lastTaskId then
					lastTaskId = taskInfo.taskId
					maxLevelTaskId = taskInfo.taskId
				else
					local lasttaskCfg = AchievementConfig.instance:getTask(lastTaskId)

					if taskCfg.level > lasttaskCfg.level then
						maxLevelTaskId = taskInfo.taskId
					end

					lastTaskId = taskInfo.taskId
				end
			end

			local taskCo = AchievementConfig.instance:getTask(maxLevelTaskId)
			local achievementId = taskCo.achievementId
			local hasNew = AchievementModel.instance:achievementHasNewWithTaskId(achievementId, maxLevelTaskId)

			if hasNew then
				table.insert(self._waitNamePlateToastList, taskCo)
			end
		end
	end
end

function AchievementToastModel:checkTaskSatify(taskId)
	local taskCfg = AchievementConfig.instance:getTask(taskId)
	local toastTypeList = self:getToastTypeList()

	if taskCfg and toastTypeList then
		for toastType, value in ipairs(toastTypeList) do
			local toastCheckFunction = self:getToastCheckFunction(value)

			if toastCheckFunction then
				local isPass = toastCheckFunction(self, taskCfg)

				if isPass then
					table.insert(self._waitToastList, {
						taskId = taskId,
						toastType = toastType
					})
				end
			end
		end
	end
end

function AchievementToastModel:getToastCheckFunction(toastType)
	self._toastCheckFuncTab = self._toastCheckFuncTab or {
		[AchievementEnum.ToastType.TaskFinished] = self.checkIsTaskFinished,
		[AchievementEnum.ToastType.GroupUnlocked] = self.checkGroupUnlocked,
		[AchievementEnum.ToastType.GroupUpgrade] = self.checkGroupUpgrade,
		[AchievementEnum.ToastType.GroupFinished] = self.checkIsGroupFinished
	}

	return self._toastCheckFuncTab[toastType]
end

function AchievementToastModel:getToastTypeList()
	self._toastTypeList = self._toastTypeList or {
		AchievementEnum.ToastType.TaskFinished,
		AchievementEnum.ToastType.GroupUnlocked,
		AchievementEnum.ToastType.GroupUpgrade,
		AchievementEnum.ToastType.GroupFinished
	}

	return self._toastTypeList
end

function AchievementToastModel:checkIsTaskFinished(taskCfg)
	return AchievementModel.instance:isAchievementTaskFinished(taskCfg.id)
end

function AchievementToastModel:checkGroupUnlocked(taskCfg)
	local isGroupUnlocked = false
	local isTaskFinished = AchievementModel.instance:isAchievementTaskFinished(taskCfg.id)
	local achievementCfg = AchievementConfig.instance:getAchievement(taskCfg.achievementId)
	local groupId = achievementCfg and achievementCfg.groupId

	if isTaskFinished and AchievementUtils.isActivityGroup(taskCfg.achievementId) and not self._groupUnlockToastMap[groupId] then
		local finishTaskList = AchievementModel.instance:getGroupFinishTaskList(groupId)

		if finishTaskList then
			if not #finishTaskList then
				local finishTaskCount = 0

				if finishTaskCount <= 1 then
					isGroupUnlocked = true
					self._groupUnlockToastMap[groupId] = true
				end
			end
		end
	end

	return isGroupUnlocked
end

function AchievementToastModel:checkGroupUpgrade(taskCfg)
	local achievementCfg = AchievementConfig.instance:getAchievement(taskCfg.achievementId)
	local isGroupUpgrade = false

	if achievementCfg and AchievementUtils.isActivityGroup(taskCfg.achievementId) then
		local groupCfg = AchievementConfig.instance:getGroup(achievementCfg.groupId)

		isGroupUpgrade = groupCfg and groupCfg.unLockAchievement == taskCfg.id
	end

	return isGroupUpgrade
end

function AchievementToastModel:checkIsGroupFinished(taskCfg)
	local achievementCfg = AchievementConfig.instance:getAchievement(taskCfg.achievementId)
	local isGroupFinished = false
	local groupId = achievementCfg and achievementCfg.groupId

	if AchievementUtils.isActivityGroup(taskCfg.achievementId) and not self._groupFinishedToastMap[groupId] then
		isGroupFinished = AchievementModel.instance:isGroupFinished(achievementCfg.groupId)

		if isGroupFinished then
			self._groupFinishedToastMap[groupId] = true
		end
	end

	return isGroupFinished
end

function AchievementToastModel:getWaitToastList()
	return self._waitToastList
end

function AchievementToastModel:onToastFinished()
	self._waitToastList = nil
	self._waitNamePlateToastList = nil
end

function AchievementToastModel:getWaitNamePlateToastList()
	return self._waitNamePlateToastList
end

AchievementToastModel.instance = AchievementToastModel.New()

return AchievementToastModel

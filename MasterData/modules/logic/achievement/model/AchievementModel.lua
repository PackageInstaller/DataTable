-- chunkname: @modules/logic/achievement/model/AchievementModel.lua

module("modules.logic.achievement.model.AchievementModel", package.seeall)

local AchievementModel = class("AchievementModel", BaseModel)

function AchievementModel:onInit()
	self._levelMap = {}
end

function AchievementModel:reInit()
	self:release()

	self._levelMap = {}
end

function AchievementModel:release()
	self._record = nil
	self._achievementMap = nil
	self._levelMap = nil
	self._isInited = false
end

function AchievementModel:initDatas(taskInfos)
	self:checkBuildAchievementMap()

	self._isInited = true

	local list = {}

	if taskInfos then
		for i = 1, #taskInfos do
			local taskInfo = taskInfos[i]
			local co = AchievementConfig.instance:getTask(taskInfo.id)

			if co then
				local mo = AchiementTaskMO.New()

				mo:init(co)
				mo:updateByServerData(taskInfo)
				table.insert(list, mo)
			end
		end
	end

	self:setList(list)
	self:updateLevelMap()
end

function AchievementModel:updateDatas(taskInfos)
	self:checkBuildAchievementMap()

	if not taskInfos then
		return
	end

	local newFinishList = {}

	for i = 1, #taskInfos do
		local taskInfo = taskInfos[i]
		local mo = self:getById(taskInfo.id)

		if mo == nil then
			local co = AchievementConfig.instance:getTask(taskInfo.id)

			if co then
				mo = AchiementTaskMO.New()

				mo:init(co)
				mo:updateByServerData(taskInfo)
				self:addAtLast(mo)
			end
		else
			local oldFinishStatus = mo.hasFinished

			mo:updateByServerData(taskInfo)

			if mo.hasFinished and not oldFinishStatus then
				table.insert(newFinishList, mo)
			end
		end
	end

	self:updateLevelMap()

	return newFinishList
end

function AchievementModel:updateLevelMap()
	for achievementId, taskCOList in pairs(self._achievementMap) do
		local level = 0

		for i, taskCO in ipairs(taskCOList) do
			local mo = self:getById(taskCO.id)

			if mo and mo.hasFinished then
				level = taskCO.level
			end
		end

		self._levelMap[achievementId] = level
	end
end

function AchievementModel:checkBuildAchievementMap()
	self._achievementMap = {}

	local allTasks = AchievementConfig.instance:getAllTasks()

	for i, taskCo in ipairs(allTasks) do
		self._achievementMap[taskCo.achievementId] = self._achievementMap[taskCo.achievementId] or {}

		table.insert(self._achievementMap[taskCo.achievementId], taskCo)
	end

	for achievementId, list in pairs(self._achievementMap) do
		if not AchievementConfig.instance:getAchievement(achievementId) then
			logError("achievementId in achievement_task not in config : [" .. tostring(achievementId) .. "]")
		end

		table.sort(list, AchievementModel.sortMapTask)
	end
end

function AchievementModel.sortMapTask(a, b)
	return a.level < b.level
end

function AchievementModel:getAchievementLevel(achievementId)
	if self._levelMap then
		return self._levelMap[achievementId] or 0
	end

	return 0
end

function AchievementModel:getGroupLevel(groupId)
	local groupLevel = 0
	local achievementCfgList = AchievementConfig.instance:getAchievementsByGroupId(groupId)

	if achievementCfgList then
		for _, achievementCfg in pairs(achievementCfgList) do
			local achievementLevel = self:getAchievementLevel(achievementCfg.id)

			if groupLevel < achievementLevel then
				groupLevel = achievementLevel
			end
		end
	end

	return groupLevel
end

function AchievementModel:cleanAchievementNew(idList)
	local isDirty = false

	if not idList then
		return isDirty
	end

	for i = 1, #idList do
		local taskMo = self:getById(idList[i])

		taskMo.isNew = false
		isDirty = true
	end

	return isDirty
end

function AchievementModel:achievementHasNew(achievementId)
	local taskCoList = self:getAchievementTaskCoList(achievementId)

	if taskCoList then
		for _, taskCo in ipairs(taskCoList) do
			local taskMo = self:getById(taskCo.id)

			if taskMo and taskMo.isNew then
				return true
			end
		end
	end

	return false
end

function AchievementModel:achievementHasNewWithTaskId(achievementId, taskId)
	local taskCoList = self:getAchievementTaskCoList(achievementId)

	if taskCoList then
		for _, taskCo in ipairs(taskCoList) do
			if taskCo.id == taskId then
				local taskMo = self:getById(taskCo.id)

				if taskMo and taskMo.isNew then
					return true
				end
			end
		end
	end

	return false
end

function AchievementModel:getAchievementTaskCoList(achievementId)
	if self._achievementMap then
		return self._achievementMap[achievementId]
	end
end

function AchievementModel:getGroupUnlockTime(groupId)
	local firstUnlockTime
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(groupId)

	if achievementCfgs then
		for _, cfg in ipairs(achievementCfgs) do
			local taskCoList = self:getAchievementTaskCoList(cfg.id)

			if taskCoList then
				for _, taskCo in ipairs(taskCoList) do
					local taskMo = self:getById(taskCo.id)

					if taskMo and taskMo.hasFinished and (not firstUnlockTime or firstUnlockTime > taskMo.finishTime) then
						firstUnlockTime = taskMo.finishTime
					end
				end
			end
		end
	end

	return firstUnlockTime
end

function AchievementModel:getAchievementUnlockTime(achievementId)
	local firstUnlockTime
	local taskCfgList = self:getAchievementTaskCoList(achievementId)

	if taskCfgList then
		for _, taskCfg in ipairs(taskCfgList) do
			local taskMo = self:getById(taskCfg.id)

			if taskMo and taskMo.hasFinished and (not firstUnlockTime or firstUnlockTime > taskMo.finishTime) then
				firstUnlockTime = taskMo.finishTime
			end
		end
	end

	return firstUnlockTime
end

function AchievementModel:achievementHasLocked(achievementId)
	local taskCoList = self:getAchievementTaskCoList(achievementId)

	if taskCoList then
		for _, taskCo in ipairs(taskCoList) do
			local taskMo = self:getById(taskCo.id)

			if taskMo and taskMo.hasFinished then
				return false
			end
		end
	end

	return true
end

function AchievementModel:achievementGroupHasLocked(groupId)
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(groupId)

	if achievementCfgs then
		for _, cfg in pairs(achievementCfgs) do
			if not self:achievementHasLocked(cfg.id) then
				return false
			end
		end
	end

	return true
end

function AchievementModel:isGroupFinished(groupId)
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(groupId)
	local isAllAchievementsFinish = false

	if achievementCfgs then
		for _, cfg in pairs(achievementCfgs) do
			local taskCoList = self:getAchievementTaskCoList(cfg.id)

			if taskCoList then
				local isAchievementFinish = false

				for _, taskCo in pairs(taskCoList) do
					local taskMo = self:getById(taskCo.id)

					isAchievementFinish = taskMo and taskMo.hasFinished

					if not isAchievementFinish then
						break
					end
				end

				isAllAchievementsFinish = isAchievementFinish

				if not isAchievementFinish then
					break
				end
			end
		end
	end

	return isAllAchievementsFinish
end

function AchievementModel:isAchievementFinished(achievementId)
	local taskCoList = self:getAchievementTaskCoList(achievementId)

	if taskCoList then
		for _, taskCo in ipairs(taskCoList) do
			local taskMo = self:getById(taskCo.id)

			if not taskMo or not taskMo.hasFinished then
				return false
			end
		end

		return true
	end
end

function AchievementModel:getGroupFinishTaskList(groupId)
	local achievementCfgs = AchievementConfig.instance:getAchievementsByGroupId(groupId)

	if achievementCfgs then
		local finishTaskList = {}

		for _, achievementCfg in ipairs(achievementCfgs) do
			local taskCfgs = AchievementConfig.instance:getTasksByAchievementId(achievementCfg.id)

			if taskCfgs then
				for _, taskCfg in ipairs(taskCfgs) do
					local taskMo = self:getById(taskCfg.id)

					if taskMo and taskMo.hasFinished then
						table.insert(finishTaskList, taskCfg)
					end
				end
			end
		end

		return finishTaskList
	end
end

function AchievementModel:isAchievementTaskFinished(taskId)
	local taskMo = self:getById(taskId)

	return taskMo and taskMo.hasFinished
end

AchievementModel.instance = AchievementModel.New()

return AchievementModel

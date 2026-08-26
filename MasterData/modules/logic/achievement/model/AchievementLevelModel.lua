-- chunkname: @modules/logic/achievement/model/AchievementLevelModel.lua

module("modules.logic.achievement.model.AchievementLevelModel", package.seeall)

local AchievementLevelModel = class("AchievementLevelModel", BaseModel)

function AchievementLevelModel:initData(achievementId, achievementIdList)
	self._achievementId = achievementId
	self._achievementIds = achievementIdList

	self:initAchievement()
end

function AchievementLevelModel:initAchievement()
	self._taskList = AchievementConfig.instance:getTasksByAchievementId(self._achievementId)
	self._selectIndex = self:initSelectIndex()
end

function AchievementLevelModel:initSelectIndex()
	if self._taskList then
		for k, taskCO in ipairs(self._taskList) do
			local taskMO = AchievementModel.instance:getById(taskCO.id)

			if taskMO and not taskMO.hasFinished then
				return k
			end
		end

		return #self._taskList
	end

	return 0
end

function AchievementLevelModel:setSelectTask(taskId)
	local taskCO = AchievementConfig.instance:getTask(taskId)

	if taskCO then
		self._selectIndex = tabletool.indexOf(self._taskList, taskCO) or 0
	end
end

function AchievementLevelModel:getCurrentTask()
	if self._selectIndex ~= 0 then
		return self._taskList[self._selectIndex]
	end
end

function AchievementLevelModel:getTaskByIndex(index)
	return self._taskList[index]
end

function AchievementLevelModel:scrollTask(isNext)
	local index = tabletool.indexOf(self._achievementIds, self._achievementId)

	if index then
		if isNext and self:hasNext() then
			self._achievementId = self._achievementIds[index + 1]

			self:initAchievement()

			return true
		elseif not isNext and self:hasPrev() then
			self._achievementId = self._achievementIds[index - 1]

			self:initAchievement()

			return true
		end
	end

	return false
end

function AchievementLevelModel:hasNext()
	local index = tabletool.indexOf(self._achievementIds, self._achievementId)

	if index then
		return index < #self._achievementIds
	end
end

function AchievementLevelModel:hasPrev()
	local index = tabletool.indexOf(self._achievementIds, self._achievementId)

	if index then
		return index > 1
	end
end

function AchievementLevelModel:getCurPageIndex()
	return tabletool.indexOf(self._achievementIds, self._achievementId)
end

function AchievementLevelModel:getTotalPageCount()
	return (self._achievementIds or nil) and (#self._achievementIds or 0)
end

function AchievementLevelModel:getAchievement()
	return self._achievementId
end

function AchievementLevelModel:getCurrentSelectIndex()
	return self._selectIndex
end

AchievementLevelModel.instance = AchievementLevelModel.New()

return AchievementLevelModel

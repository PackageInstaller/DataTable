-- chunkname: @modules/logic/achievement/controller/AchievementLevelController.lua

module("modules.logic.achievement.controller.AchievementLevelController", package.seeall)

local AchievementLevelController = class("AchievementLevelController", BaseController)

function AchievementLevelController:onOpenView(achievementId, achievementIds)
	AchievementLevelModel.instance:initData(achievementId, achievementIds)
	AchievementLevelController.instance:cleanAchievementIsNew(achievementId)
end

function AchievementLevelController:onCloseView()
	return
end

function AchievementLevelController:selectTask(taskId)
	AchievementLevelModel.instance:setSelectTask(taskId)
	self:dispatchEvent(AchievementEvent.LevelViewUpdated)
end

function AchievementLevelController:scrollTask(isNext)
	if AchievementLevelModel.instance:scrollTask(isNext) then
		local achievementId = AchievementLevelModel.instance:getAchievement()

		self:cleanAchievementIsNew(achievementId)
		self:dispatchEvent(AchievementEvent.LevelViewUpdated)
	end
end

function AchievementLevelController:cleanAchievementIsNew(achievementId)
	local taskCoList = AchievementModel.instance:getAchievementTaskCoList(achievementId)

	if taskCoList then
		local taskIds = {}

		for i, taskCo in ipairs(taskCoList) do
			local taskMo = AchievementModel.instance:getById(taskCo.id)

			if taskMo and taskMo.isNew then
				table.insert(taskIds, taskCo.id)
			end
		end

		if #taskIds > 0 then
			AchievementRpc.instance:sendReadNewAchievementRequest(taskIds)
		end
	end
end

function AchievementLevelController:cleanNotShowTaskIsNew()
	if not self._hasCleanNotShowTaskIsNewTask then
		self._hasCleanNotShowTaskIsNewTask = true

		TaskDispatcher.runDelay(self._onRunCleanNotShowTaskIsNew, self, 0.5)
	end
end

function AchievementLevelController:_onRunCleanNotShowTaskIsNew()
	self._hasCleanNotShowTaskIsNewTask = false

	local taskMOList = AchievementModel.instance:getList()
	local taskIds
	local tAchievementConfig = AchievementConfig.instance

	for i, taskMO in ipairs(taskMOList) do
		if taskMO and taskMO.isNew then
			local taskCfg = tAchievementConfig:getTask(taskMO.id)

			if taskCfg then
				local acCfg = tAchievementConfig:getAchievement(taskCfg.achievementId)

				if acCfg and AchievementEnum.HideType[acCfg.category] then
					taskIds = taskIds or {}

					table.insert(taskIds, taskMO.id)
				end
			end
		end
	end

	if taskIds and #taskIds > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(taskIds)
	end
end

AchievementLevelController.instance = AchievementLevelController.New()

LuaEventSystem.addEventMechanism(AchievementLevelController.instance)

return AchievementLevelController

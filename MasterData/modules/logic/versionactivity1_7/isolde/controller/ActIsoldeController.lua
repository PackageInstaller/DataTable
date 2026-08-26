-- chunkname: @modules/logic/versionactivity1_7/isolde/controller/ActIsoldeController.lua

module("modules.logic.versionactivity1_7.isolde.controller.ActIsoldeController", package.seeall)

local ActIsoldeController = class("ActIsoldeController", BaseController)

function ActIsoldeController:onInit()
	return
end

function ActIsoldeController:addConstEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.OnUpdateDungeonInfo, self)
end

function ActIsoldeController:OnUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo then
		ActIsoldeModel.instance:checkFinishLevel(dungeonInfo.episodeId, dungeonInfo.star)
	end
end

function ActIsoldeController:enterActivity()
	local actConfig = ActivityConfig.instance:getActivityCo(VersionActivity1_7Enum.ActivityId.Isolde)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self._drirectOpenLevelView, self)
		ActIsoldeModel.instance:setFirstEnter()
	else
		self:_drirectOpenLevelView()
	end
end

function ActIsoldeController:openLevelView(viewParam)
	if ViewMgr.instance:isOpen(ViewName.ActIsoldeLevelView) then
		if viewParam ~= nil then
			self:dispatchEvent(ActIsoldeEvent.TabSwitch, viewParam.needShowFight)
		end
	else
		self:_drirectOpenLevelView(viewParam)
	end
end

function ActIsoldeController:_drirectOpenLevelView(viewParam)
	ViewMgr.instance:openView(ViewName.ActIsoldeLevelView, viewParam)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function ActIsoldeController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function ActIsoldeController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == ActIsoldeEnum.TaskMOAllFinishId or actTaskMO:alreadyGotReward()) then
		ActIsoldeTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, ActIsoldeEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function ActIsoldeController:_onRewardTask()
	local taskId = self._actTaskId

	self._actTaskId = nil

	if taskId then
		if taskId == ActIsoldeEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, VersionActivity1_7Enum.ActivityId.Isolde)
		else
			TaskRpc.instance:sendFinishTaskRequest(taskId)
		end
	end
end

ActIsoldeController.instance = ActIsoldeController.New()

return ActIsoldeController

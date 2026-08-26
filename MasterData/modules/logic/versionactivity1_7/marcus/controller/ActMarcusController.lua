-- chunkname: @modules/logic/versionactivity1_7/marcus/controller/ActMarcusController.lua

module("modules.logic.versionactivity1_7.marcus.controller.ActMarcusController", package.seeall)

local ActMarcusController = class("ActMarcusController", BaseController)

function ActMarcusController:onInit()
	return
end

function ActMarcusController:addConstEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.OnUpdateDungeonInfo, self)
end

function ActMarcusController:OnUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo then
		ActMarcusModel.instance:checkFinishLevel(dungeonInfo.episodeId, dungeonInfo.star)
	end
end

function ActMarcusController:enterActivity()
	local actConfig = ActivityConfig.instance:getActivityCo(VersionActivity1_7Enum.ActivityId.Marcus)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self._drirectOpenLevelView, self)
		ActMarcusModel.instance:setFirstEnter()
	else
		self:_drirectOpenLevelView()
	end
end

function ActMarcusController:openLevelView(viewParam)
	if ViewMgr.instance:isOpen(ViewName.ActMarcusLevelView) then
		if viewParam ~= nil then
			self:dispatchEvent(ActMarcusEvent.TabSwitch, viewParam.needShowFight)
		end
	else
		self:_drirectOpenLevelView(viewParam)
	end
end

function ActMarcusController:_drirectOpenLevelView(viewParam)
	ViewMgr.instance:openView(ViewName.ActMarcusLevelView, viewParam)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function ActMarcusController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function ActMarcusController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == ActMarcusEnum.TaskMOAllFinishId or actTaskMO:alreadyGotReward()) then
		ActMarcusTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, ActMarcusEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function ActMarcusController:_onRewardTask()
	local taskId = self._actTaskId

	self._actTaskId = nil

	if taskId then
		if taskId == ActMarcusEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, VersionActivity1_7Enum.ActivityId.Marcus)
		else
			TaskRpc.instance:sendFinishTaskRequest(taskId)
		end
	end
end

ActMarcusController.instance = ActMarcusController.New()

return ActMarcusController

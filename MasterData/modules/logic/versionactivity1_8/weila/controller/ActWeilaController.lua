-- chunkname: @modules/logic/versionactivity1_8/weila/controller/ActWeilaController.lua

module("modules.logic.versionactivity1_8.weila.controller.ActWeilaController", package.seeall)

local ActWeilaController = class("ActWeilaController", BaseController)

function ActWeilaController:onInit()
	return
end

function ActWeilaController:addConstEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.OnUpdateDungeonInfo, self)
end

function ActWeilaController:OnUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo then
		ActWeilaModel.instance:checkFinishLevel(dungeonInfo.episodeId, dungeonInfo.star)
	end
end

function ActWeilaController:enterActivity()
	local actConfig = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self._drirectOpenLevelView, self)
	else
		self:_drirectOpenLevelView()
	end
end

function ActWeilaController:openLevelView(viewParam)
	if ViewMgr.instance:isOpen(ViewName.ActWeilaLevelView) then
		if viewParam ~= nil then
			self:dispatchEvent(ActWeilaEvent.TabSwitch, viewParam.needShowFight)
		end
	else
		self:_drirectOpenLevelView(viewParam)
	end
end

function ActWeilaController:_drirectOpenLevelView(viewParam)
	ViewMgr.instance:openView(ViewName.ActWeilaLevelView, viewParam)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function ActWeilaController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function ActWeilaController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == 0 or actTaskMO.hasFinished) then
		ActWeilaTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, ActWeilaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function ActWeilaController:_onRewardTask()
	local taskId = self._actTaskId

	self._actTaskId = nil

	if taskId then
		if taskId == 0 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, VersionActivity1_8Enum.ActivityId.Weila)
		else
			TaskRpc.instance:sendFinishTaskRequest(taskId)
		end
	end
end

ActWeilaController.instance = ActWeilaController.New()

return ActWeilaController

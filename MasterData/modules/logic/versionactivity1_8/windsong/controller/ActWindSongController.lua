-- chunkname: @modules/logic/versionactivity1_8/windsong/controller/ActWindSongController.lua

module("modules.logic.versionactivity1_8.windsong.controller.ActWindSongController", package.seeall)

local ActWindSongController = class("ActWindSongController", BaseController)

function ActWindSongController:onInit()
	return
end

function ActWindSongController:addConstEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.OnUpdateDungeonInfo, self)
end

function ActWindSongController:OnUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo then
		ActWindSongModel.instance:checkFinishLevel(dungeonInfo.episodeId, dungeonInfo.star)
	end
end

function ActWindSongController:enterActivity()
	local actConfig = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.WindSong)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self._drirectOpenLevelView, self)
	else
		self:_drirectOpenLevelView()
	end
end

function ActWindSongController:openLevelView(viewParam)
	if ViewMgr.instance:isOpen(ViewName.ActWindSongLevelView) then
		if viewParam ~= nil then
			self:dispatchEvent(ActWindSongEvent.TabSwitch, viewParam.needShowFight)
		end
	else
		self:_drirectOpenLevelView(viewParam)
	end
end

function ActWindSongController:_drirectOpenLevelView(viewParam)
	ViewMgr.instance:openView(ViewName.ActWindSongLevelView, viewParam)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function ActWindSongController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function ActWindSongController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == 0 or actTaskMO.hasFinished) then
		ActWindSongTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, ActWindSongEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function ActWindSongController:_onRewardTask()
	local taskId = self._actTaskId

	self._actTaskId = nil

	if taskId then
		if taskId == 0 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, VersionActivity1_8Enum.ActivityId.WindSong)
		else
			TaskRpc.instance:sendFinishTaskRequest(taskId)
		end
	end
end

ActWindSongController.instance = ActWindSongController.New()

return ActWindSongController

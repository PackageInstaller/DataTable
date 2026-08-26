-- chunkname: @modules/logic/roleactivity/controller/RoleActivityController.lua

module("modules.logic.roleactivity.controller.RoleActivityController", package.seeall)

local RoleActivityController = class("RoleActivityController", BaseController)

function RoleActivityController:onInit()
	return
end

function RoleActivityController:addConstEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.OnUpdateDungeonInfo, self)
end

function RoleActivityController:OnUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo then
		RoleActivityModel.instance:checkFinishLevel(dungeonInfo.episodeId, dungeonInfo.star)
	end
end

function RoleActivityController:enterActivity(actId)
	local actConfig = ActivityConfig.instance:getActivityCo(actId)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self._drirectOpenLevelView, self, {
			_actId = actId
		})
	else
		self:_drirectOpenLevelView({
			_actId = actId
		})
	end
end

function RoleActivityController:openLevelView(viewParam)
	local viewName = RoleActivityEnum.LevelView[viewParam.actId]

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	ViewMgr.instance:openView(viewName, viewParam)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function RoleActivityController:_drirectOpenLevelView(param)
	local viewName = RoleActivityEnum.LevelView[param._actId]

	ViewMgr.instance:openView(viewName)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

function RoleActivityController:delayReward(delayTime, taskMO)
	self.actId = RoleActivityTaskListModel.instance:getActivityId()

	if self._actTaskMO == nil and taskMO and self.actId then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function RoleActivityController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == 0 or actTaskMO.hasFinished) then
		RoleActivityTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, RoleActivityEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function RoleActivityController:_onRewardTask()
	local taskId = self._actTaskId

	self._actTaskId = nil

	if taskId then
		if taskId == 0 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, self.actId)
		else
			TaskRpc.instance:sendFinishTaskRequest(taskId)
		end
	end

	self.actId = nil
end

function RoleActivityController:enterActivity220(actId)
	local actConfig = ActivityConfig.instance:getActivityCo(actId)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self._drirectOpenLevelView220, self, {
			_actId = actId
		})
	else
		self:_drirectOpenLevelView220({
			_actId = actId
		})
	end
end

function RoleActivityController:_drirectOpenLevelView220(param)
	local actId = param._actId

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, self._onSendGetAct220InfoRequestCb, self)
end

function RoleActivityController:_onSendGetAct220InfoRequestCb(_, resultCode, msg)
	if resultCode ~= 0 then
		logError("RoleActivityController:_drirectOpenLevelView220 resultCode=" .. tostring(resultCode))

		return
	end

	local activityId = msg.activityId
	local viewName = RoleActivityEnum.LevelView[activityId]

	ViewMgr.instance:openView(viewName)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.level_view_open)
end

RoleActivityController.instance = RoleActivityController.New()

return RoleActivityController

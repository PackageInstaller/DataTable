-- chunkname: @modules/logic/versionactivity1_6/getian/controller/ActGeTianController.lua

module("modules.logic.versionactivity1_6.getian.controller.ActGeTianController", package.seeall)

local ActGeTianController = class("ActGeTianController", BaseController)

function ActGeTianController:onInit()
	return
end

function ActGeTianController:addConstEvents()
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self.OnUpdateDungeonInfo, self)
end

function ActGeTianController:OnUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo then
		ActGeTianModel.instance:checkFinishLevel(dungeonInfo.episodeId, dungeonInfo.star)
	end
end

function ActGeTianController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function ActGeTianController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == ActGeTianEnum.TaskMOAllFinishId or actTaskMO:alreadyGotReward()) then
		ActGeTianTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, ActGeTianEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function ActGeTianController:_onRewardTask()
	local taskId = self._actTaskId

	self._actTaskId = nil

	if taskId then
		if taskId == ActGeTianEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, ActGeTianEnum.ActivityId)
		else
			TaskRpc.instance:sendFinishTaskRequest(taskId)
		end
	end
end

function ActGeTianController:oneClaimReward(actId)
	local list = ActGeTianTaskListModel.instance:getList()

	for _, taskMO in pairs(list) do
		if taskMO:alreadyGotReward() and taskMO.id ~= ActGeTianEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(taskMO.id)
		end
	end
end

function ActGeTianController:enterActivity()
	local actConfig = ActivityConfig.instance:getActivityCo(ActGeTianEnum.ActivityId)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self.storyCallback, self)
		ActGeTianModel.instance:setFirstEnter()
	else
		self:_drirectOpenLevelView()
	end
end

function ActGeTianController:storyCallback()
	self:_drirectOpenLevelView()
end

function ActGeTianController:openLevelView(viewParam)
	if ViewMgr.instance:isOpen(ViewName.ActGeTianLevelView) then
		if viewParam ~= nil then
			self:dispatchEvent(ActGeTianEvent.TabSwitch, viewParam.needShowFight)
		end
	else
		self:_drirectOpenLevelView(viewParam)
	end
end

function ActGeTianController:_drirectOpenLevelView(viewParam)
	ViewMgr.instance:openView(ViewName.ActGeTianLevelView, viewParam)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_open)
end

ActGeTianController.instance = ActGeTianController.New()

return ActGeTianController

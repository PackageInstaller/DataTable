-- chunkname: @modules/logic/versionactivity1_6/quniang/controller/ActQuNiangController.lua

module("modules.logic.versionactivity1_6.quniang.controller.ActQuNiangController", package.seeall)

local ActQuNiangController = class("ActQuNiangController", BaseController)

function ActQuNiangController:onInit()
	return
end

function ActQuNiangController:addConstEvents()
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self.OnUpdateDungeonInfo, self)
end

function ActQuNiangController:OnUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo then
		ActQuNiangModel.instance:checkFinishLevel(dungeonInfo.episodeId, dungeonInfo.star)
	end
end

function ActQuNiangController:delayReward(delayTime, taskMO)
	if self._actTaskMO == nil and taskMO then
		self._actTaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function ActQuNiangController:_onPreFinish()
	local actTaskMO = self._actTaskMO

	self._actTaskMO = nil

	if actTaskMO and (actTaskMO.id == ActQuNiangEnum.TaskMOAllFinishId or actTaskMO:alreadyGotReward()) then
		ActQuNiangTaskListModel.instance:preFinish(actTaskMO)

		self._actTaskId = actTaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, ActQuNiangEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function ActQuNiangController:_onRewardTask()
	local taskId = self._actTaskId

	self._actTaskId = nil

	if taskId then
		if taskId == ActQuNiangEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleActivity, nil, nil, nil, nil, ActQuNiangEnum.ActivityId)
		else
			TaskRpc.instance:sendFinishTaskRequest(taskId)
		end
	end
end

function ActQuNiangController:oneClaimReward(actId)
	local list = ActQuNiangTaskListModel.instance:getList()

	for _, taskMO in pairs(list) do
		if taskMO:alreadyGotReward() and taskMO.id ~= ActQuNiangEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(taskMO.id)
		end
	end
end

function ActQuNiangController:enterActivity()
	local actConfig = ActivityConfig.instance:getActivityCo(ActQuNiangEnum.ActivityId)
	local storyId = actConfig.storyId

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:playStory(storyId, nil, self.storyCallback, self)
		ActQuNiangModel.instance:setFirstEnter()
	else
		self:_drirectOpenLevelView()
	end
end

function ActQuNiangController:storyCallback()
	self:_drirectOpenLevelView()
end

function ActQuNiangController:openLevelView(viewParam)
	if ViewMgr.instance:isOpen(ViewName.ActQuNiangLevelView) then
		if viewParam ~= nil then
			self:dispatchEvent(ActQuNiangEvent.TabSwitch, viewParam.needShowFight)
		end
	else
		self:_drirectOpenLevelView(viewParam)
	end
end

function ActQuNiangController:_drirectOpenLevelView(viewParam)
	ViewMgr.instance:openView(ViewName.ActQuNiangLevelView, viewParam)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_open)
end

ActQuNiangController.instance = ActQuNiangController.New()

return ActQuNiangController

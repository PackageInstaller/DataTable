-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerFinishTask.lua

module("modules.logic.guide.controller.trigger.GuideTriggerFinishTask", package.seeall)

local GuideTriggerFinishTask = class("GuideTriggerFinishTask", BaseGuideTrigger)

function GuideTriggerFinishTask:ctor(triggerKey)
	GuideTriggerFinishTask.super.ctor(self, triggerKey)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._checkStartGuide, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._checkStartGuide, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._checkStartGuide, self)
end

function GuideTriggerFinishTask:assertGuideSatisfy(param, configParam)
	local taskId = tonumber(configParam)
	local taskMO = TaskModel.instance:getTaskById(taskId)

	return taskMO and taskMO.finishCount >= taskMO.config.maxFinishCount
end

function GuideTriggerFinishTask:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerFinishTask:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerFinishTask

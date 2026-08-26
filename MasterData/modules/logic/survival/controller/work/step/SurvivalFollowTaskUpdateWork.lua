-- chunkname: @modules/logic/survival/controller/work/step/SurvivalFollowTaskUpdateWork.lua

module("modules.logic.survival.controller.work.step.SurvivalFollowTaskUpdateWork", package.seeall)

local SurvivalFollowTaskUpdateWork = class("SurvivalFollowTaskUpdateWork", SurvivalStepBaseWork)

function SurvivalFollowTaskUpdateWork:onStart2(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local followTask

	if self._stepMo.followTask.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
		followTask = sceneMo.mainTask
	elseif self._stepMo.followTask.moduleId == SurvivalEnum.TaskModule.NormalTask then
		followTask = sceneMo.followTask
	end

	if followTask then
		followTask:init(self._stepMo.followTask)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnFollowTaskUpdate, followTask)
	end

	self:onDone(true)
end

return SurvivalFollowTaskUpdateWork

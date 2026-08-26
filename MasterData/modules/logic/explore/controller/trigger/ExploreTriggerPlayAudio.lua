-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerPlayAudio.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerPlayAudio", package.seeall)

local ExploreTriggerPlayAudio = class("ExploreTriggerPlayAudio", ExploreTriggerBase)

function ExploreTriggerPlayAudio:handle(id, unit)
	id = tonumber(id) or 0

	if id > 0 then
		local cameraMoveStepIndex = ExploreStepController.instance:getStepIndex(ExploreEnum.StepType.CameraMove)
		local ShowAreaStepIndex = ExploreStepController.instance:getStepIndex(ExploreEnum.StepType.ShowArea)

		if cameraMoveStepIndex >= 0 then
			local stepData = {
				stepType = ExploreEnum.StepType.TriggerAudio,
				id = id
			}

			ExploreStepController.instance:insertClientStep(stepData, cameraMoveStepIndex + 1)
		elseif ShowAreaStepIndex > 0 then
			local stepData = {
				stepType = ExploreEnum.StepType.TriggerAudio,
				id = id
			}

			ExploreStepController.instance:insertClientStep(stepData, ShowAreaStepIndex)
		else
			AudioMgr.instance:trigger(id)
		end
	end

	self:onDone(true)
end

return ExploreTriggerPlayAudio

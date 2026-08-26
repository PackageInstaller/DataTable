-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerOpenArchiveView.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerOpenArchiveView", package.seeall)

local ExploreTriggerOpenArchiveView = class("ExploreTriggerOpenArchiveView", ExploreTriggerBase)

function ExploreTriggerOpenArchiveView:handle(id, unit)
	local stepData = {
		stepType = ExploreEnum.StepType.ArchiveClient,
		archiveId = unit.mo.archiveId
	}

	ExploreStepController.instance:insertClientStep(stepData, 1)
	ExploreStepController.instance:startStep()
	self:onDone(true)
end

return ExploreTriggerOpenArchiveView

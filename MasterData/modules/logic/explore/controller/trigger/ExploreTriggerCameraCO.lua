-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerCameraCO.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerCameraCO", package.seeall)

local ExploreTriggerCameraCO = class("ExploreTriggerCameraCO", ExploreTriggerBase)

function ExploreTriggerCameraCO:handle(id, unit)
	self.cameraId = tonumber(id)

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChangeCameraCO, self.cameraId)
	self:onStepDone(true)
end

function ExploreTriggerCameraCO:clearWork()
	return
end

return ExploreTriggerCameraCO

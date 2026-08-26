-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerMoveCamera.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerMoveCamera", package.seeall)

local ExploreTriggerMoveCamera = class("ExploreTriggerMoveCamera", ExploreTriggerBase)

function ExploreTriggerMoveCamera:handle(param, unit)
	local arr = string.splitToNumber(param, "#")
	local stepData = {
		stepType = ExploreEnum.StepType.CameraMove,
		id = arr[1],
		moveTime = arr[2],
		keepTime = arr[3]
	}

	ExploreStepController.instance:insertClientStep(stepData, 1)
	ExploreStepController.instance:startStep()
	ExploreController.instance:getMap():getHero():stopMoving()
	self:onDone(true)
end

return ExploreTriggerMoveCamera

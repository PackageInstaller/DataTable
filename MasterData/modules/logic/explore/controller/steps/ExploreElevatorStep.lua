-- chunkname: @modules/logic/explore/controller/steps/ExploreElevatorStep.lua

module("modules.logic.explore.controller.steps.ExploreElevatorStep", package.seeall)

local ExploreElevatorStep = class("ExploreElevatorStep", ExploreStepBase)

function ExploreElevatorStep:onStart()
	local interactMo = ExploreModel.instance:getInteractInfo(self._data.interactId)

	if interactMo then
		interactMo.statusInfo.height = self._data.height
	end

	self:onDone()
end

return ExploreElevatorStep

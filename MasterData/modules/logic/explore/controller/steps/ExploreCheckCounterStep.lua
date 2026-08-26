-- chunkname: @modules/logic/explore/controller/steps/ExploreCheckCounterStep.lua

module("modules.logic.explore.controller.steps.ExploreCheckCounterStep", package.seeall)

local ExploreCheckCounterStep = class("ExploreCheckCounterStep", ExploreStepBase)

function ExploreCheckCounterStep:onStart()
	local unit = ExploreController.instance:getMap():getUnit(self._data.id)

	unit.mo:checkActiveCount()
	self:onDone()
end

return ExploreCheckCounterStep

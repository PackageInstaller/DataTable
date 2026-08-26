-- chunkname: @modules/logic/explore/controller/steps/ExploreTransferStep.lua

module("modules.logic.explore.controller.steps.ExploreTransferStep", package.seeall)

local ExploreTransferStep = class("ExploreTransferStep", ExploreStepBase)

function ExploreTransferStep:onStart()
	ExploreMapModel.instance:updatHeroPos(self._data.x, self._data.y, 0)
	ExploreHeroTeleportFlow.instance:begin(self._data)
	self:onDone()
end

return ExploreTransferStep

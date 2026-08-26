-- chunkname: @modules/logic/explore/controller/steps/ExploreDelUnitStep.lua

module("modules.logic.explore.controller.steps.ExploreDelUnitStep", package.seeall)

local ExploreDelUnitStep = class("ExploreDelUnitStep", ExploreStepBase)
local waitUnitTypes = {
	[ExploreEnum.ItemType.Rock] = true
}

function ExploreDelUnitStep:onStart()
	local interact = self._data.interact
	local unit = ExploreController.instance:getMap():getUnit(interact.id, true)

	if unit then
		ExploreController.instance:removeUnit(interact.id)

		if not ExploreModel.instance.isReseting and waitUnitTypes[unit:getUnitType()] then
			unit:setExitCallback(self.onDone, self)
		else
			self:onDone()
		end
	else
		self:onDone()
	end
end

return ExploreDelUnitStep

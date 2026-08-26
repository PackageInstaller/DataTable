-- chunkname: @modules/logic/explore/controller/steps/ExploreRotateStep.lua

module("modules.logic.explore.controller.steps.ExploreRotateStep", package.seeall)

local ExploreRotateStep = class("ExploreRotateStep", ExploreStepBase)

function ExploreRotateStep:onStart()
	local comp = ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.RotateUnit)

	if not comp then
		self:onDone()

		return
	end

	comp:rotateByServer(self._data.interactId, self._data.newDir, self.onDone, self)
end

return ExploreRotateStep

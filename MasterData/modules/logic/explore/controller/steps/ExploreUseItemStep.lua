-- chunkname: @modules/logic/explore/controller/steps/ExploreUseItemStep.lua

module("modules.logic.explore.controller.steps.ExploreUseItemStep", package.seeall)

local ExploreUseItemStep = class("ExploreUseItemStep", ExploreStepBase)

function ExploreUseItemStep:onStart()
	ExploreModel.instance:setUseItemUid(tostring(self._data.itemUid))
	ExploreController.instance:getMap():checkAllRuneTrigger()
	self:onDone()
end

return ExploreUseItemStep

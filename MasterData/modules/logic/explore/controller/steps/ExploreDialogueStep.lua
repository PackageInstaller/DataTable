-- chunkname: @modules/logic/explore/controller/steps/ExploreDialogueStep.lua

module("modules.logic.explore.controller.steps.ExploreDialogueStep", package.seeall)

local ExploreDialogueStep = class("ExploreDialogueStep", ExploreStepBase)

function ExploreDialogueStep:onStart()
	ViewMgr.instance:openView(ViewName.ExploreInteractView, self._data)
	self:onDone()
end

return ExploreDialogueStep

-- chunkname: @modules/logic/explore/controller/steps/ExploreArchiveStep.lua

module("modules.logic.explore.controller.steps.ExploreArchiveStep", package.seeall)

local ExploreArchiveStep = class("ExploreArchiveStep", ExploreStepBase)

function ExploreArchiveStep:onStart()
	ExploreSimpleModel.instance:onGetArchive(self._data.archiveId)
	self:onDone()
end

return ExploreArchiveStep

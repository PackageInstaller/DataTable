-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/ResourceDataChangeStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.ResourceDataChangeStep", package.seeall)

local ResourceDataChangeStep = class("ResourceDataChangeStep", EliminateTeamChessStepBase)

function ResourceDataChangeStep:onStart()
	local data = self._data
	local resourceIdMap = data.resourceIdMap

	if resourceIdMap == nil then
		self:onDone(true)

		return
	end

	for resourceId, diffValue in pairs(resourceIdMap) do
		EliminateTeamChessModel.instance:updateResourceData(resourceId, diffValue)
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ResourceDataChange, resourceIdMap)
	self:onDone(true)
end

return ResourceDataChangeStep

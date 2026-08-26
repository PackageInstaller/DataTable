-- chunkname: @modules/logic/explore/model/mo/unit/ExploreStepUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreStepUnitMO", package.seeall)

local ExploreStepUnitMO = pureTable("ExploreStepUnitMO", ExploreBaseUnitMO)

function ExploreStepUnitMO:initTypeData()
	self.enterTriggerType = true
end

function ExploreStepUnitMO:getUnitClass()
	return ExploreStepUnit
end

function ExploreStepUnitMO:isInActive()
	local interactInfoMO = self:getInteractInfoMO()

	return interactInfoMO:getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
end

return ExploreStepUnitMO

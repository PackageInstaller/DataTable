-- chunkname: @modules/logic/explore/model/mo/unit/ExploreGravityGearUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreGravityGearUnitMO", package.seeall)

local ExploreGravityGearUnitMO = pureTable("ExploreGravityGearUnitMO", ExploreBaseUnitMO)

function ExploreGravityGearUnitMO:initTypeData()
	self.keyUnitTypes = string.splitToNumber(self.specialDatas[1], "#")
	self.enterTriggerType = true
end

function ExploreGravityGearUnitMO:getUnitClass()
	return ExploreGravityTriggerUnit
end

return ExploreGravityGearUnitMO

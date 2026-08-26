-- chunkname: @modules/logic/explore/model/mo/unit/ExploreObstacleMO.lua

module("modules.logic.explore.model.mo.unit.ExploreObstacleMO", package.seeall)

local ExploreObstacleMO = pureTable("ExploreObstacleMO", ExploreBaseUnitMO)

function ExploreObstacleMO:initTypeData()
	self.triggerByClick = false
end

function ExploreObstacleMO:getUnitClass()
	return ExploreBaseDisplayUnit
end

function ExploreObstacleMO:isWalkable()
	return false
end

return ExploreObstacleMO

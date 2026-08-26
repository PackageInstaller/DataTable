-- chunkname: @modules/logic/explore/model/mo/unit/ExploreDoorUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreDoorUnitMO", package.seeall)

local ExploreDoorUnitMO = pureTable("ExploreDoorUnitMO", ExploreBaseUnitMO)

function ExploreDoorUnitMO:getUnitClass()
	return ExploreDoor
end

function ExploreDoorUnitMO:isWalkable()
	return self:isDoorOpen()
end

function ExploreDoorUnitMO:initTypeData()
	self.isPreventItem = tonumber(self.specialDatas[1]) == 1
end

function ExploreDoorUnitMO:updateWalkable()
	self:setNodeOpenKey(self:isWalkable())
end

function ExploreDoorUnitMO:isDoorOpen()
	return self:isInteractActiveState()
end

return ExploreDoorUnitMO

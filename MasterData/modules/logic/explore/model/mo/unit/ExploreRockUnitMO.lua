-- chunkname: @modules/logic/explore/model/mo/unit/ExploreRockUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreRockUnitMO", package.seeall)

local ExploreRockUnitMO = pureTable("ExploreRockUnitMO", ExploreBaseUnitMO)

function ExploreRockUnitMO:initTypeData()
	self.canTriggerGear = true
	self.triggerByClick = true
	self.preNodeKey = nil
	self.showRes = lua_explore_unit.configDict[ExploreEnum.ItemType.Rock].asset
	self.triggerEffects = {}

	local data = {
		ExploreEnum.TriggerEvent.ItemUnit,
		""
	}

	table.insert(self.triggerEffects, data)
end

function ExploreRockUnitMO:getUnitClass()
	return ExploreRockUnit
end

function ExploreRockUnitMO:isInteractEnabled()
	return true
end

function ExploreRockUnitMO:isWalkable()
	return false
end

return ExploreRockUnitMO

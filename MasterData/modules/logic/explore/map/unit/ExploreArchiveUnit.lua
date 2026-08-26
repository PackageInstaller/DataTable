-- chunkname: @modules/logic/explore/map/unit/ExploreArchiveUnit.lua

module("modules.logic.explore.map.unit.ExploreArchiveUnit", package.seeall)

local ExploreArchiveUnit = class("ExploreArchiveUnit", ExploreBaseMoveUnit)

function ExploreArchiveUnit:needInteractAnim()
	return true
end

function ExploreArchiveUnit:canTrigger()
	if self.mo:isInteractActiveState() then
		return false
	end

	return ExploreArchiveUnit.super.canTrigger(self)
end

return ExploreArchiveUnit

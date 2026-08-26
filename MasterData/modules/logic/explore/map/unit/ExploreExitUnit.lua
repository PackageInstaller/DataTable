-- chunkname: @modules/logic/explore/map/unit/ExploreExitUnit.lua

module("modules.logic.explore.map.unit.ExploreExitUnit", package.seeall)

local ExploreExitUnit = class("ExploreExitUnit", ExploreBaseDisplayUnit)

function ExploreExitUnit:canTrigger()
	if not self.mo:isInteractActiveState() then
		return false
	end

	return ExploreExitUnit.super.canTrigger(self)
end

return ExploreExitUnit

-- chunkname: @modules/logic/explore/map/unit/ExploreGravityTriggerUnit.lua

module("modules.logic.explore.map.unit.ExploreGravityTriggerUnit", package.seeall)

local ExploreGravityTriggerUnit = class("ExploreGravityTriggerUnit", ExploreBaseDisplayUnit)

function ExploreGravityTriggerUnit:onRoleEnter(nowNode, preNode, unit)
	if unit:isRole() or unit.mo.canTriggerGear then
		self:tryTrigger()
	end
end

return ExploreGravityTriggerUnit

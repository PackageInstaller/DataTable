-- chunkname: @modules/logic/explore/map/unit/ExploreStepUnit.lua

module("modules.logic.explore.map.unit.ExploreStepUnit", package.seeall)

local ExploreStepUnit = class("ExploreStepUnit", ExploreBaseDisplayUnit)

function ExploreStepUnit:onInit()
	return
end

function ExploreStepUnit:onRoleEnter(nowNode, preNode, unit)
	if not preNode then
		return
	end

	if not self:canTrigger() then
		return
	end

	if not unit:isRole() then
		return
	end

	self:tryTrigger()
end

return ExploreStepUnit

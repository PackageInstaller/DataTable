-- chunkname: @modules/logic/explore/map/unit/ExploreIlluminantUnit.lua

module("modules.logic.explore.map.unit.ExploreIlluminantUnit", package.seeall)

local ExploreIlluminantUnit = class("ExploreIlluminantUnit", ExploreBaseDisplayUnit)

function ExploreIlluminantUnit:onEnter()
	self:updatePrism()
	ExploreIlluminantUnit.super.onEnter(self)
end

function ExploreIlluminantUnit:onExit()
	self:updatePrism()
end

function ExploreIlluminantUnit:updatePrism()
	local mapLight = ExploreController.instance:getMapLight()

	if not mapLight:isInitDone() then
		return
	end

	mapLight:beginCheckStatusChange()

	local units = ExploreController.instance:getMap():getUnitByPos(self.nodePos)

	for _, unit in pairs(units) do
		if unit.mo:isInteractEnabled() and ExploreEnum.PrismTypes[unit:getUnitType()] then
			unit:onBallLightChange()
		end
	end

	mapLight:endCheckStatus()
end

return ExploreIlluminantUnit

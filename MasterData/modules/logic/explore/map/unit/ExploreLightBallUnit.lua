-- chunkname: @modules/logic/explore/map/unit/ExploreLightBallUnit.lua

module("modules.logic.explore.map.unit.ExploreLightBallUnit", package.seeall)

local ExploreLightBallUnit = class("ExploreLightBallUnit", ExploreItemUnit)

function ExploreLightBallUnit:onEnter()
	self:updateRoundPrism(self.nodePos)
	ExploreLightBallUnit.super.onEnter(self)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreLightBallEnterExit)
end

function ExploreLightBallUnit:onExit()
	self:updateRoundPrism(self.nodePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreLightBallEnterExit)
end

function ExploreLightBallUnit:onNodeChange(preNode, nowNode)
	if preNode then
		self:updateRoundPrism(preNode)
		self:updateRoundPrism(nowNode)
	end
end

function ExploreLightBallUnit:updateRoundPrism(nodePos)
	local mapLight = ExploreController.instance:getMapLight()

	if not mapLight:isInitDone() then
		return
	end

	local pos = {
		x = 0,
		y = 0
	}

	mapLight:beginCheckStatusChange()

	for dir = 0, 270, 90 do
		local xy = ExploreHelper.dirToXY(dir)

		pos.x = nodePos.x + xy.x
		pos.y = nodePos.y + xy.y

		local units = ExploreController.instance:getMap():getUnitByPos(pos)

		for _, unit in pairs(units) do
			if unit.mo:isInteractEnabled() and ExploreEnum.PrismTypes[unit:getUnitType()] then
				unit:onBallLightChange()
			end
		end
	end

	mapLight:endCheckStatus()
end

return ExploreLightBallUnit

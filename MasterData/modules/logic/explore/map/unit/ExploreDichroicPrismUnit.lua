-- chunkname: @modules/logic/explore/map/unit/ExploreDichroicPrismUnit.lua

module("modules.logic.explore.map.unit.ExploreDichroicPrismUnit", package.seeall)

local ExploreDichroicPrismUnit = class("ExploreDichroicPrismUnit", ExplorePrismUnit)

function ExploreDichroicPrismUnit:addLights()
	self.lightComp:addLight(self.mo.unitDir - 45)
	self.lightComp:addLight(self.mo.unitDir + 45)
end

return ExploreDichroicPrismUnit

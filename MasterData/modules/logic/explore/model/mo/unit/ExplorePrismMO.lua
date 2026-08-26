-- chunkname: @modules/logic/explore/model/mo/unit/ExplorePrismMO.lua

module("modules.logic.explore.model.mo.unit.ExplorePrismMO", package.seeall)

local ExplorePrismMO = class("ExplorePrismMO", ExploreBaseUnitMO)

function ExplorePrismMO:initTypeData()
	self.fixItemId = tonumber(self.specialDatas[1])
end

function ExplorePrismMO:getUnitClass()
	return ExplorePrismUnit
end

return ExplorePrismMO

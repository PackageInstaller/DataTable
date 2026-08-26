-- chunkname: @modules/logic/explore/model/mo/unit/ExploreLightReceiverMO.lua

module("modules.logic.explore.model.mo.unit.ExploreLightReceiverMO", package.seeall)

local ExploreLightReceiverMO = class("ExploreLightReceiverMO", ExploreBaseUnitMO)

function ExploreLightReceiverMO:initTypeData()
	self.isPhoticDir = tonumber(self.specialDatas[1]) == 1
end

function ExploreLightReceiverMO:getUnitClass()
	return ExploreLightReceiverUnit
end

return ExploreLightReceiverMO

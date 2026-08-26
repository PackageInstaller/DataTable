-- chunkname: @modules/logic/explore/model/mo/unit/ExploreResetUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreResetUnitMO", package.seeall)

local ExploreResetUnitMO = class("ExploreResetUnitMO", ExploreBaseUnitMO)

function ExploreResetUnitMO:initTypeData()
	local arr = string.splitToNumber(self.specialDatas[1], "#")

	self.targetX = arr[1] or 0
	self.targetY = arr[2] or 0
	self.targetDir = arr[3] or 0
end

return ExploreResetUnitMO

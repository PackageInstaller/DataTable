-- chunkname: @modules/logic/explore/model/mo/unit/ExploreDoorOnceUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreDoorOnceUnitMO", package.seeall)

local ExploreDoorOnceUnitMO = class("ExploreDoorOnceUnitMO", ExploreDoorUnitMO)

function ExploreDoorOnceUnitMO:getUnitClass()
	return ExploreDoorOnceUnit
end

return ExploreDoorOnceUnitMO

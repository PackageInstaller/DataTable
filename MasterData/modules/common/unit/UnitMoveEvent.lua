-- chunkname: @modules/common/unit/UnitMoveEvent.lua

module("modules.common.unit.UnitMoveEvent", package.seeall)

local UnitMoveEvent = _M

UnitMoveEvent.PosChanged = 1
UnitMoveEvent.Interrupt = 2
UnitMoveEvent.StartMove = 3
UnitMoveEvent.PassWayPoint = 4
UnitMoveEvent.Arrive = 5

return UnitMoveEvent

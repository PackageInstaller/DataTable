-- chunkname: @modules/logic/room/define/RoomVehicleEnum.lua

module("modules.logic.room.define.RoomVehicleEnum", package.seeall)

local RoomVehicleEnum = _M

RoomVehicleEnum.OwnerType = {
	TransportSite = 2,
	Building = 1,
	None = 0
}
RoomVehicleEnum.UseType = {
	Aircraft = 201,
	LandWater = 101
}
RoomVehicleEnum.ReplaceType = {
	Land = 1,
	Water = 2,
	None = 0
}

return RoomVehicleEnum

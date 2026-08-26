-- chunkname: @modules/logic/room/define/RoomTransportPathEnum.lua

module("modules.logic.room.define.RoomTransportPathEnum", package.seeall)

local RoomTransportPathEnum = _M

RoomTransportPathEnum.PathLineType = {
	Line14 = 4001,
	Line12 = 4002,
	Line00 = 4004,
	Line10 = 4000,
	Line13 = 4003
}
RoomTransportPathEnum.PathLineTypeRes = {
	[RoomTransportPathEnum.PathLineType.Line10] = "4000",
	[RoomTransportPathEnum.PathLineType.Line14] = "4001",
	[RoomTransportPathEnum.PathLineType.Line12] = "4002",
	[RoomTransportPathEnum.PathLineType.Line13] = "4003",
	[RoomTransportPathEnum.PathLineType.Line00] = "4004"
}
RoomTransportPathEnum.StyleId = {
	EditLink = 3,
	ObLink = 4,
	NoLink = 2,
	ObWater = 5,
	Normal = 1
}
RoomTransportPathEnum.TipLang = {
	[RoomBuildingEnum.BuildingType.Collect] = "notice_route_collect_process",
	[RoomBuildingEnum.BuildingType.Process] = "notice_route_process_manufacture",
	[RoomBuildingEnum.BuildingType.Manufacture] = "notice_route_collect_manufacture"
}

return RoomTransportPathEnum

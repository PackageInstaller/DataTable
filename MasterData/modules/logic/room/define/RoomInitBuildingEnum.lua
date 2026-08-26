-- chunkname: @modules/logic/room/define/RoomInitBuildingEnum.lua

module("modules.logic.room.define.RoomInitBuildingEnum", package.seeall)

local RoomInitBuildingEnum = _M

RoomInitBuildingEnum.InitBuildingId = {
	Market = 2,
	Spring = 3,
	BellTower = 1,
	Hall = 0
}
RoomInitBuildingEnum.InitRoomSkinId = {
	[RoomInitBuildingEnum.InitBuildingId.Hall] = 23100102,
	[RoomInitBuildingEnum.InitBuildingId.BellTower] = 23100101,
	[RoomInitBuildingEnum.InitBuildingId.Market] = 23100103,
	[RoomInitBuildingEnum.InitBuildingId.Spring] = 23100104
}
RoomInitBuildingEnum.InitBuildingSkinReddot = {
	[RoomInitBuildingEnum.InitBuildingId.Hall] = RedDotEnum.DotNode.RoomInitBuildingHall,
	[RoomInitBuildingEnum.InitBuildingId.BellTower] = RedDotEnum.DotNode.RoomInitBuildingBellTower,
	[RoomInitBuildingEnum.InitBuildingId.Market] = RedDotEnum.DotNode.RoomInitBuildingMarket,
	[RoomInitBuildingEnum.InitBuildingId.Spring] = RedDotEnum.DotNode.RoomInitBuildingSpring
}
RoomInitBuildingEnum.CanLevelUpErrorCode = {
	MaxLevel = -1,
	NotEnoughBlock = -3,
	NotEnoughItem = -2
}

return RoomInitBuildingEnum

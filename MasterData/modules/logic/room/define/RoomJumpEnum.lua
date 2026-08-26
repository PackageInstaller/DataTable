-- chunkname: @modules/logic/room/define/RoomJumpEnum.lua

module("modules.logic.room.define.RoomJumpEnum", package.seeall)

local RoomJumpEnum = _M

RoomJumpEnum.JumpView = {
	Critter = 2,
	RoomRecordView = 1,
	Manufacture = 3,
	CritterStore = 9,
	BuildingProcess = 7,
	Training = 10,
	Trade = 4,
	PlaceBuilding = 6,
	Backpack = 5,
	BuildingLevelUp = 8
}
RoomJumpEnum.ManufactureBuildingType = {
	Manufacture = 3,
	Collect = 1,
	Process = 2
}

return RoomJumpEnum

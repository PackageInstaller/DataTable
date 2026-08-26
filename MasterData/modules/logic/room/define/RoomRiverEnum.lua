-- chunkname: @modules/logic/room/define/RoomRiverEnum.lua

module("modules.logic.room.define.RoomRiverEnum", package.seeall)

local RoomRiverEnum = _M

RoomRiverEnum.RiverBlockType = {
	["4008"] = "4008",
	["4010"] = "4010",
	["4004"] = "4004",
	["4009"] = "4009",
	["4000"] = "4000",
	["4005"] = "4005",
	["4011"] = "4011",
	["4001"] = "4001",
	["4006"] = "4006",
	["4002"] = "4002",
	["4007"] = "4007",
	["4003"] = "4003"
}
RoomRiverEnum.LakeOutLinkType = {
	Floor = 4031,
	River = 4032,
	Right = 4033,
	RightLeft = 4036,
	HalfLake = 4037,
	Left = 4034,
	NoLink = 4035
}
RoomRiverEnum.LakeBlockType = {
	[RoomRiverEnum.LakeOutLinkType.Floor] = "4031",
	[RoomRiverEnum.LakeOutLinkType.River] = "4032",
	[RoomRiverEnum.LakeOutLinkType.Right] = "4033",
	[RoomRiverEnum.LakeOutLinkType.Left] = "4034",
	[RoomRiverEnum.LakeOutLinkType.NoLink] = "4035",
	[RoomRiverEnum.LakeOutLinkType.RightLeft] = "4036",
	[RoomRiverEnum.LakeOutLinkType.HalfLake] = "4037"
}
RoomRiverEnum.LakeFloorType = {
	[RoomRiverEnum.LakeOutLinkType.Floor] = "4031",
	[RoomRiverEnum.LakeOutLinkType.River] = "4032",
	[RoomRiverEnum.LakeOutLinkType.Right] = "4033",
	[RoomRiverEnum.LakeOutLinkType.Left] = "4034",
	[RoomRiverEnum.LakeOutLinkType.NoLink] = "4035",
	[RoomRiverEnum.LakeOutLinkType.RightLeft] = "4036"
}
RoomRiverEnum.LakeFloorBType = {
	[RoomRiverEnum.LakeOutLinkType.RightLeft] = "4036b"
}

return RoomRiverEnum

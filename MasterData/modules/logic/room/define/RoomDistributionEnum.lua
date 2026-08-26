-- chunkname: @modules/logic/room/define/RoomDistributionEnum.lua

module("modules.logic.room.define.RoomDistributionEnum", package.seeall)

local RoomDistributionEnum = _M

RoomDistributionEnum.DistributionType = {
	C3TA = "c3ta",
	C2TC = "c2tc",
	C4TC = "c4tc",
	C3TB = "c3tb",
	C2TB = "c2tb",
	C4TB = "c4tb",
	C3TC = "c3tc",
	C3TD = "c3td",
	C5TA = "c5ta",
	C4TA = "c4ta",
	C6TA = "c6ta",
	C1TA = "c1ta",
	C2TA = "c2ta"
}
RoomDistributionEnum.DistributionTypeValue = {
	[RoomDistributionEnum.DistributionType.C1TA] = {
		true,
		false,
		false,
		false,
		false,
		false
	},
	[RoomDistributionEnum.DistributionType.C2TA] = {
		true,
		true,
		false,
		false,
		false,
		false
	},
	[RoomDistributionEnum.DistributionType.C2TB] = {
		true,
		false,
		true,
		false,
		false,
		false
	},
	[RoomDistributionEnum.DistributionType.C2TC] = {
		true,
		false,
		false,
		true,
		false,
		false
	},
	[RoomDistributionEnum.DistributionType.C3TA] = {
		true,
		true,
		true,
		false,
		false,
		false
	},
	[RoomDistributionEnum.DistributionType.C3TB] = {
		true,
		true,
		false,
		true,
		false,
		false
	},
	[RoomDistributionEnum.DistributionType.C3TC] = {
		true,
		false,
		true,
		false,
		true,
		false
	},
	[RoomDistributionEnum.DistributionType.C3TD] = {
		true,
		true,
		false,
		false,
		true,
		false
	},
	[RoomDistributionEnum.DistributionType.C4TA] = {
		true,
		true,
		true,
		true,
		false,
		false
	},
	[RoomDistributionEnum.DistributionType.C4TB] = {
		true,
		true,
		true,
		false,
		true,
		false
	},
	[RoomDistributionEnum.DistributionType.C4TC] = {
		true,
		true,
		false,
		true,
		true,
		false
	},
	[RoomDistributionEnum.DistributionType.C5TA] = {
		true,
		true,
		true,
		true,
		true,
		false
	},
	[RoomDistributionEnum.DistributionType.C6TA] = {
		true,
		true,
		true,
		true,
		true,
		true
	}
}
RoomDistributionEnum.CountToTypeList = {
	{
		RoomDistributionEnum.DistributionType.C1TA
	},
	{
		RoomDistributionEnum.DistributionType.C2TA,
		RoomDistributionEnum.DistributionType.C2TB,
		RoomDistributionEnum.DistributionType.C2TC
	},
	{
		RoomDistributionEnum.DistributionType.C3TA,
		RoomDistributionEnum.DistributionType.C3TB,
		RoomDistributionEnum.DistributionType.C3TC,
		RoomDistributionEnum.DistributionType.C3TD
	},
	{
		RoomDistributionEnum.DistributionType.C4TA,
		RoomDistributionEnum.DistributionType.C4TB,
		RoomDistributionEnum.DistributionType.C4TC
	},
	{
		RoomDistributionEnum.DistributionType.C5TA
	},
	{
		RoomDistributionEnum.DistributionType.C6TA
	}
}

return RoomDistributionEnum

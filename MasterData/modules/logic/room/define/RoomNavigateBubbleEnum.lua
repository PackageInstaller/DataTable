-- chunkname: @modules/logic/room/define/RoomNavigateBubbleEnum.lua

module("modules.logic.room.define.RoomNavigateBubbleEnum", package.seeall)

local RoomNavigateBubbleEnum = _M

RoomNavigateBubbleEnum.CategoryType = {
	Factory = 1
}
RoomNavigateBubbleEnum.FactoryBubbleType = {
	FaithFull = 4,
	RoomGift = 5,
	Manufacture = 6,
	ProductProgress = 1,
	Critter = 7,
	FaithReward = 3,
	BuildingUpgrade = 2
}
RoomNavigateBubbleEnum.Bubble2ResPath = {
	[RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress] = "xw_bubbleicon_8",
	[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = "xw_bubbleicon_up",
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward] = "xw_bubbleicon_4",
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull] = "xw_bubbleicon_max",
	[RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift] = "xw_bubbleicon_7",
	[RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture] = "xw_bubbleicon_9",
	[RoomNavigateBubbleEnum.FactoryBubbleType.Critter] = "xw_bubbleicon_10"
}
RoomNavigateBubbleEnum.BubbleHideNum = {
	[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = true,
	[RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift] = true
}
RoomNavigateBubbleEnum.HallId = -1

return RoomNavigateBubbleEnum

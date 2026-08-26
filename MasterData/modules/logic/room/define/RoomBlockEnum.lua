-- chunkname: @modules/logic/room/define/RoomBlockEnum.lua

module("modules.logic.room.define.RoomBlockEnum", package.seeall)

local RoomBlockEnum = _M

RoomBlockEnum.BlockSize = 0.499
RoomBlockEnum.EmptyBlockDistanceStyleCount = 1
RoomBlockEnum.BlockState = {
	Water = 2,
	Inventory = 4,
	WaterReform = 6,
	Fake = 5,
	Temp = 3,
	Map = 1
}
RoomBlockEnum.OpState = {
	Back = 2,
	Normal = 1
}
RoomBlockEnum.UseState = {
	TransportPath = 2,
	Normal = 1
}
RoomBlockEnum.CleanType = {
	CleanLand = 1,
	Normal = 0
}
RoomBlockEnum.OwnType = {
	Special = 1,
	Package = 0
}
RoomBlockEnum.BlockType = {
	v2a6_Snow = 47,
	v1a8_Snow = 15,
	v1a8_Snow2 = 16,
	Green = 1,
	v2a6_Snow3 = 49,
	v2a6_Snow2 = 48,
	v2a8_Snow = 51
}
RoomBlockEnum.BlockLinkEffectGOPath = {
	[RoomBlockEnum.BlockType.Green] = "junsi"
}
RoomBlockEnum.FootPrintDict = {
	[RoomBlockEnum.BlockType.v1a8_Snow] = true,
	[RoomBlockEnum.BlockType.v1a8_Snow2] = true,
	[RoomBlockEnum.BlockType.v2a6_Snow] = true,
	[RoomBlockEnum.BlockType.v2a6_Snow2] = true,
	[RoomBlockEnum.BlockType.v2a6_Snow3] = true,
	[RoomBlockEnum.BlockType.v2a8_Snow] = true
}
RoomBlockEnum.EmptyDefineId = 1
RoomBlockEnum.PlaceEffectAnimatorCloseTime = 0.16666666666666666
RoomBlockEnum.InitBlockDegreeValue = 48
RoomBlockEnum.WaterReformCommonDefineId = 292
RoomBlockEnum.BlockColorReformCommonDefineId = 6

return RoomBlockEnum

-- chunkname: @modules/logic/room/define/RoomProductLineEnum.lua

module("modules.logic.room.define.RoomProductLineEnum", package.seeall)

local RoomProductLineEnum = _M

RoomProductLineEnum.ProductType = {
	Product = 1,
	Change = 2
}
RoomProductLineEnum.ProductItemType = {
	ProductGold = 2,
	ProductExp = 1,
	Change = 3
}
RoomProductLineEnum.Line = {
	Spring = 7
}
RoomProductLineEnum.AnimTime = {
	TreeAnim = 0.1
}
RoomProductLineEnum.AnimName = {
	TreeShow = "show",
	TreeIdle = "idle",
	TreeHide = "hide"
}

return RoomProductLineEnum

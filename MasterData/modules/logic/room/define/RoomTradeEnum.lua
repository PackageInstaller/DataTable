-- chunkname: @modules/logic/room/define/RoomTradeEnum.lua

module("modules.logic.room.define.RoomTradeEnum", package.seeall)

local RoomTradeEnum = _M

RoomTradeEnum.Mode = {
	Wholesale = 2,
	DailyOrder = 1
}
RoomTradeEnum.RefreshType = {
	ActiveRefresh = 3,
	DailyRefresh = 1,
	FinishRefresh = 2
}
RoomTradeEnum.BarrageType = {
	Dialogue = 2,
	DailyOrder = 3,
	Weather = 1
}
RoomTradeEnum.LevelUnlock = {
	GetBouns = 10,
	NewBuilding = 1,
	LevelBonus = 9,
	BuildingMaxLevel = 6,
	CritterIncubate = 12,
	BuildingLevelUp = 13,
	Order = 11,
	TrainsRoundCount = 14,
	BlockMax = 7,
	TransportSystemOpen = 8,
	TrainSlotCount = 4
}
RoomTradeEnum.ConstId = {
	DailyHighOrderAddRate = 7,
	DailyOrderFinishMaxCount = 6,
	DialogueBarrageOdds = 9,
	DailyOrderRefreshTime = 4
}
RoomTradeEnum.CameraId = 2233
RoomTradeEnum.TradeAnim = {
	Swicth = "swicth",
	DailyOrderOpen = "roomdailyorderview_open",
	Unlock = "unlock"
}
RoomTradeEnum.TradeDailyOrderAnim = {
	Delivery = "delivery",
	Update = "update",
	Idle = "idle",
	Open = "open"
}
RoomTradeEnum.TradeTaskAnim = {
	Swicth = "switch",
	Idle = "idle"
}
RoomTradeEnum.GuideUnlock = {
	Summon = 416
}

return RoomTradeEnum

-- chunkname: @modules/logic/roomfishing/define/FishingEnum.lua

module("modules.logic.roomfishing.define.FishingEnum", package.seeall)

local FishingEnum = _M

FishingEnum.Const = {
	DefaultMapId = 1,
	FishingBuilding = 13120
}
FishingEnum.ConstId = {
	MaxHasFishingCurrency = 17,
	ExchangeCostCurrency = 15,
	MaxCanGetShareRewardTimes = 4,
	FishOption = 13,
	GetFriendBonusMinCount = 5,
	StrangerPoint = 10,
	FishingActId = 19,
	FriendPoint = 9,
	UidInputCountLimit = 20,
	OneFishCost = 12,
	MaxExchangeCount = 1,
	PoolRefreshInterval = 18,
	MaxInFishingCount = 2,
	MyPoint = 11
}
FishingEnum.FriendListTag = {
	UnFishing = 1,
	Fishing = 2
}
FishingEnum.OtherPlayerBoatType = {
	Stranger = 2,
	Friend = 1
}
FishingEnum.FishingProgressType = {
	Myself = 1,
	Other = 2
}

return FishingEnum

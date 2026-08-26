-- chunkname: @modules/logic/activitywelfare/define/DestinyStoneGiftPickChoiceEnum.lua

module("modules.logic.activitywelfare.define.DestinyStoneGiftPickChoiceEnum", package.seeall)

local DestinyStoneGiftPickChoiceEnum = _M

DestinyStoneGiftPickChoiceEnum.HeroStoneType = {
	NotOwnHeroStone = 3,
	OwnHeroStoneCouldUp = 1,
	OwnHeroStoneLocked = 2,
	OwnHeroStoneMax = 4
}
DestinyStoneGiftPickChoiceEnum.V2a7ItemId = 642801
DestinyStoneGiftPickChoiceEnum.V3a8ItemId = 642802

return DestinyStoneGiftPickChoiceEnum

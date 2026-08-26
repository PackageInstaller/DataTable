-- chunkname: @modules/logic/versionactivity2_3/act174/define/Activity174Enum.lua

module("modules.logic.versionactivity2_3.act174.define.Activity174Enum", package.seeall)

local Activity174Enum = _M

Activity174Enum.GameState = {
	AfterFight = 4,
	Init = 1,
	BeforeFight = 3,
	ForceSelect = 999,
	Free = 2,
	EnterEndless = 998,
	None = 0
}
Activity174Enum.FightResult = {
	Win = 1,
	Lose = 2,
	Draw = 3,
	None = 0
}
Activity174Enum.BagType = {
	Collection = "collection",
	Enhance = "enhance",
	StartCareer = "startCareer",
	Endless = "endless",
	StartSpecial = "startSpecial",
	Hero = "hero",
	StartRare = "startRare"
}
Activity174Enum.WareType = {
	Collection = 2,
	Hero = 1
}
Activity174Enum.MaxWareItemSinglePage = 12
Activity174Enum.ConstKey = {
	BetHealth = 3,
	FreshRoundShopCost = 6,
	MatchTxt = 16,
	ChapterId = 8,
	InitHealth = 1,
	MatchWaitTime = 5,
	FightSpeed = 10,
	FreshShopCost = 4,
	ShopSlot = 2
}
Activity174Enum.PrefabPath = {
	BattleHero = "ui/viewres/versionactivity_2_3/act174/act174fightheroitem.prefab"
}
Activity174Enum.ItemTipType = {
	Character2 = 5,
	Buff = 3,
	Character1 = 4,
	Character3 = 6,
	Character = Activity174Enum.WareType.Hero,
	Collection = Activity174Enum.WareType.Collection
}
Activity174Enum.CollectionColor = {
	"587FA1",
	"8D6993",
	"B8945F"
}
Activity174Enum.heroBagIcon = {
	"act174_icon_1",
	"act174_icon_2",
	"act174_icon_3"
}
Activity174Enum.CharacterType = {
	Monster = "monster",
	Hero = "hero"
}
Activity174Enum.BadgeState = {
	Sp = 3,
	Light = 2,
	Normal = 1
}
Activity174Enum.EffectType = {
	Rebirth = 17,
	MaybeAddCoin = 18,
	BuyAddCoin = 3,
	AddHp = 5,
	DirectAddCoin = 1,
	DelayAddCoin = 2,
	EnhanceItem = 14,
	EnhanceRole = 11,
	ReduceHpAddCoin = 4
}

return Activity174Enum

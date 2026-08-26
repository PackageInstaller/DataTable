-- chunkname: @modules/logic/autochess/main/define/AutoChessStrEnum.lua

module("modules.logic.autochess.main.define.AutoChessStrEnum", package.seeall)

local AutoChessStrEnum = _M

AutoChessStrEnum.CostType = {
	Coin = "coin",
	Hp = "hp"
}
AutoChessStrEnum.SkillType = {
	Passive = "passive",
	Active = "active"
}
AutoChessStrEnum.ChessType = {
	Support = "Support",
	Attack = "Attack",
	Incubate = "Incubate",
	Boss = "Boss"
}
AutoChessStrEnum.SkillEffect = {
	GrowUpNow2 = "GrowUpNow2",
	AdditionalDamage = "AdditionalDamage",
	DigTreasure = "DigTreasure",
	MasterTransfigurationBuyChess = "MasterTransfigurationBuyChess",
	RoundAddCoin = "RoundAddCoin",
	DigTreasureSP = "DigTreasureSP"
}
AutoChessStrEnum.ResPath = {
	LeaderEntity = "ui/viewres/versionactivity_2_5/autochess/item/autochessleaderentity.prefab",
	ChessCard = "ui/viewres/versionactivity_2_5/autochess/item/autochesscard.prefab",
	ChessEntity = "ui/viewres/versionactivity_2_5/autochess/item/autochessentity.prefab",
	CollectionItem = "ui/viewres/versionactivity_2_5/autochess/item/autochesscollectionitem.prefab",
	CardPackItem = "ui/viewres/versionactivity_2_5/autochess/item/autochesscardpackitem.prefab",
	LevelItem = "ui/viewres/versionactivity_2_5/autochess/item/autochesslevelitem.prefab",
	BadgeItem = "ui/viewres/versionactivity_2_5/autochess/item/autochessbadgeitem.prefab",
	WarningItem = "ui/viewres/versionactivity_2_5/autochess/item/autochesswarningitem.prefab",
	LeaderItem = "ui/viewres/versionactivity_2_5/autochess/item/autochessleaderitem.prefab",
	LeaderCard = "ui/viewres/versionactivity_2_5/autochess/item/autochessleadercard.prefab"
}
AutoChessStrEnum.EffectPlayType = {
	Fly = "fly",
	Normal = "normal"
}
AutoChessStrEnum.ClientReddotKey = {
	Cardpack = "AutoChessCardpackReddot",
	Boss = "AutoChessBossReddot",
	SpecialCollection = "AutoChessSpecialCollectionReddot",
	SpecialLeader = "AutoChessSpecialLeaderReddot"
}

return AutoChessStrEnum

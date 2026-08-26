-- chunkname: @modules/logic/sp01/act205/define/Act205Enum.lua

module("modules.logic.sp01.act205.define.Act205Enum", package.seeall)

local Act205Enum = _M

Act205Enum.ActId = ActivityEnum.Activity.V2a9_Act205
Act205Enum.GameStageId = {
	Ocean = 2,
	Chase = 3,
	Card = 1
}
Act205Enum.ConstId = {
	CardGameEnemyCardCount = 9,
	CardGamePlayerCardCount = 8,
	MinimumGuaranteeCard = 10,
	OceanGameAddWinWeight = 6,
	CardGameBasePoint = 7,
	OceanGameFailTimesToWin = 5
}
Act205Enum.CardGameFailPoint = 1
Act205Enum.CardGameCacheDataPrefsKey = "Act205CardGameCacheDataKey"
Act205Enum.SpEffType = {
	All = 1,
	Half = 2
}
Act205Enum.CardType = {
	Role = 1,
	Weapon = 2
}
Act205Enum.CardPKResult = {
	BeRestrained = -1,
	Draw = 0,
	Restrain = 1
}
Act205Enum.CardGameCacheKey = {
	PlayerCard = "Act205CardGamePlayerCard",
	EnemyCard = "Act205CardGameEnemyCard"
}
Act205Enum.saveLocalOceanGoldKey = "Act205OceanGameGold"
Act205Enum.saveLocalOceanDiceKey = "Act205OceanGameDice"
Act205Enum.oceanGoldHardType = {
	Hard = 2,
	Normal = 1
}
Act205Enum.oceanDiceMaxCount = 3

return Act205Enum

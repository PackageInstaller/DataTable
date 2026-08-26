-- chunkname: @modules/logic/versionactivity1_6/act147/define/FurnaceTreasureEnum.lua

module("modules.logic.versionactivity1_6.act147.define.FurnaceTreasureEnum", package.seeall)

local FurnaceTreasureEnum = _M

FurnaceTreasureEnum.RareBgName = "v1a6_secretstore_rare"
FurnaceTreasureEnum.DEFAULT_BUY_COUNT = 1
FurnaceTreasureEnum.ActGoodsPool = {
	Great = 2,
	Normal = 1
}
FurnaceTreasureEnum.Pool2GoodsId = {
	[FurnaceTreasureEnum.ActGoodsPool.Normal] = "1#520001#1",
	[FurnaceTreasureEnum.ActGoodsPool.Great] = "1#520002#1"
}
FurnaceTreasureEnum.BeginnerViewSpinePlayData = "daoju#0#-1"
FurnaceTreasureEnum.Pool2SpinePlayData = {
	[FurnaceTreasureEnum.ActGoodsPool.Normal] = "bigai#0#-1",
	[FurnaceTreasureEnum.ActGoodsPool.Great] = "kaigai#0"
}
FurnaceTreasureEnum.StoreId2CostItem = {
	[150] = 21,
	[160] = 22,
	[111] = CurrencyEnum.CurrencyType.BlueSoul,
	[114] = CurrencyEnum.CurrencyType.OrangeSoul
}

return FurnaceTreasureEnum

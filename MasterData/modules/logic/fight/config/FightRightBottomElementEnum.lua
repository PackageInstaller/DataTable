-- chunkname: @modules/logic/fight/config/FightRightBottomElementEnum.lua

module("modules.logic.fight.config.FightRightBottomElementEnum", package.seeall)

local FightRightBottomElementEnum = _M
local EnumIndex = 0

local function GetEnum()
	EnumIndex = EnumIndex + 1

	return EnumIndex
end

FightRightBottomElementEnum.Elements = {
	ASFD = GetEnum(),
	BloodPool = GetEnum(),
	HeatScale = GetEnum(),
	MeiLeiErExRound = GetEnum()
}
FightRightBottomElementEnum.Priority = {
	FightRightBottomElementEnum.Elements.BloodPool,
	FightRightBottomElementEnum.Elements.ASFD,
	FightRightBottomElementEnum.Elements.HeatScale,
	FightRightBottomElementEnum.Elements.MeiLeiErExRound
}
FightRightBottomElementEnum.ElementsSizeDict = {
	[FightRightBottomElementEnum.Elements.BloodPool] = Vector2(180, 170),
	[FightRightBottomElementEnum.Elements.ASFD] = Vector2(100, 170),
	[FightRightBottomElementEnum.Elements.HeatScale] = Vector2(180, 170),
	[FightRightBottomElementEnum.Elements.MeiLeiErExRound] = Vector2(180, 170, 170)
}
FightRightBottomElementEnum.ElementsNodeName = {
	[FightRightBottomElementEnum.Elements.BloodPool] = "bloodpool",
	[FightRightBottomElementEnum.Elements.ASFD] = "asfd",
	[FightRightBottomElementEnum.Elements.HeatScale] = "burngem",
	[FightRightBottomElementEnum.Elements.MeiLeiErExRound] = "meileiierexround"
}

return FightRightBottomElementEnum

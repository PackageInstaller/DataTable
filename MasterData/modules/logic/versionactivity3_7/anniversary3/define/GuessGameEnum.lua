-- chunkname: @modules/logic/versionactivity3_7/anniversary3/define/GuessGameEnum.lua

module("modules.logic.versionactivity3_7.anniversary3.define.GuessGameEnum", package.seeall)

local GuessGameEnum = _M

GuessGameEnum.ConstId = {
	DailyFirstBonusMulti = 8,
	DoubtUnMatchAdd = 2,
	TrustMatchAdd = 5,
	GameBaseScore = 7,
	DoubtMatchReduce = 3,
	TrustNpcNotSame3Probability = 11,
	EpisodeId = 1,
	GuideTimes = 6,
	TrustUnMatchReduce = 4,
	LieNpcNotSame3Probability = 12,
	NpcCardSameProbability = 10,
	NpcGiftCount = 9
}
GuessGameEnum.BtnType = {
	Search = 3,
	Trust = 1,
	Doubt = 2,
	None = 0
}
GuessGameEnum.GiftType = {
	Sp = 1,
	Normal = 0
}
GuessGameEnum.NpcType = {
	AllIn = 3,
	Truth = 1,
	Lie = 2
}
GuessGameEnum.DiscardType = {
	Same4 = 4,
	Same3 = 3,
	Same5 = 5,
	Random = 0
}

return GuessGameEnum

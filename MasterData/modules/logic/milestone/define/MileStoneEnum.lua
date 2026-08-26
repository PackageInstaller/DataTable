-- chunkname: @modules/logic/milestone/define/MileStoneEnum.lua

module("modules.logic.milestone.define.MileStoneEnum", package.seeall)

local MileStoneEnum = _M

MileStoneEnum.MileStoneType = {
	SP02OutSide = 1,
	V3a9Racing = 2,
	V3a9BossRush = 3
}
MileStoneEnum.BonusState = {
	HasGet = 3,
	CanGet = 1,
	CanNotGet = 2
}

return MileStoneEnum

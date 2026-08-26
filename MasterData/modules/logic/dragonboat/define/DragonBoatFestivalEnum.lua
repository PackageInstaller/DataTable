-- chunkname: @modules/logic/dragonboat/define/DragonBoatFestivalEnum.lua

module("modules.logic.dragonboat.define.DragonBoatFestivalEnum", package.seeall)

local DragonBoatFestivalEnum = _M

DragonBoatFestivalEnum.PuzzleState = {
	Lock = 0,
	RewardGet = 4,
	Answering = 2,
	UnAnswer = 1,
	Solved = 3
}
DragonBoatFestivalEnum.OptionState = {
	UnAnswer = 0,
	Wrong = 1,
	Right = 2
}

return DragonBoatFestivalEnum

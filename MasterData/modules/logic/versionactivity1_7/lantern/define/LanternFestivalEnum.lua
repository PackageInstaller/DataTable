-- chunkname: @modules/logic/versionactivity1_7/lantern/define/LanternFestivalEnum.lua

module("modules.logic.versionactivity1_7.lantern.define.LanternFestivalEnum", package.seeall)

local LanternFestivalEnum = _M

LanternFestivalEnum.PuzzleState = {
	Lock = 0,
	RewardGet = 4,
	Answering = 2,
	UnAnswer = 1,
	Solved = 3
}
LanternFestivalEnum.OptionState = {
	UnAnswer = 0,
	Wrong = 1,
	Right = 2
}

return LanternFestivalEnum

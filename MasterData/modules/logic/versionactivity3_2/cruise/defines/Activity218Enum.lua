-- chunkname: @modules/logic/versionactivity3_2/cruise/defines/Activity218Enum.lua

module("modules.logic.versionactivity3_2.cruise.defines.Activity218Enum", package.seeall)

local Activity218Enum = _M

Activity218Enum.CardType = {
	Rock = 1,
	Scissors = 2,
	Paper = 3
}
Activity218Enum.GameResultType = {
	Draw = 1,
	Victory = 2,
	Defeat = 0,
	None = -1
}
Activity218Enum.CardItemState = {
	PreSelect = 2,
	Normal = 4,
	UnFlipped = 3,
	Empty = 1
}

return Activity218Enum

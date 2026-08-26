-- chunkname: @modules/logic/partygame/view/guesswho/GuessWhoEnum.lua

module("modules.logic.partygame.view.guesswho.GuessWhoEnum", package.seeall)

local GuessWhoEnum = _M

GuessWhoEnum.GameState = {
	Ready = 1,
	Answer = 2,
	Settle = 3,
	None = 0
}

return GuessWhoEnum

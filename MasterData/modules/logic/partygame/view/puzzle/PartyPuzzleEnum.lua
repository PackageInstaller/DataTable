-- chunkname: @modules/logic/partygame/view/puzzle/PartyPuzzleEnum.lua

module("modules.logic.partygame.view.puzzle.PartyPuzzleEnum", package.seeall)

local PartyPuzzleEnum = _M

PartyPuzzleEnum.GameState = {
	Settle = 4,
	Ready = 1,
	Show = 2,
	Answer = 3,
	None = 0
}

return PartyPuzzleEnum

-- chunkname: @modules/logic/partygame/games/PuzzlePartyGame.lua

module("modules.logic.partygame.games.PuzzlePartyGame", package.seeall)

local PuzzlePartyGame = class("PuzzlePartyGame", PartyGameBase)

function PuzzlePartyGame:getGameViewName()
	return ViewName.PuzzleGameView
end

return PuzzlePartyGame

-- chunkname: @modules/logic/partygame/games/WhichMorePartyGame.lua

module("modules.logic.partygame.games.WhichMorePartyGame", package.seeall)

local WhichMorePartyGame = class("WhichMorePartyGame", PartyGameBase)

function WhichMorePartyGame:getGameViewName()
	return ViewName.WhichMoreGameView
end

return WhichMorePartyGame

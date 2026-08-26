-- chunkname: @modules/logic/partygame/games/GuessWhoPartyGame.lua

module("modules.logic.partygame.games.GuessWhoPartyGame", package.seeall)

local GuessWhoPartyGame = class("GuessWhoPartyGame", PartyGameBase)

function GuessWhoPartyGame:getGameViewName()
	return ViewName.GuessWhoGameView
end

return GuessWhoPartyGame

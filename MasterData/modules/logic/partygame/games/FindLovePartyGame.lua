-- chunkname: @modules/logic/partygame/games/FindLovePartyGame.lua

module("modules.logic.partygame.games.FindLovePartyGame", package.seeall)

local FindLovePartyGame = class("FindLovePartyGame", PartyGameBase)

function FindLovePartyGame:getGameViewName()
	return ViewName.FindLoveGameView
end

return FindLovePartyGame

-- chunkname: @modules/logic/partygame/games/PacManPartyGame.lua

module("modules.logic.partygame.games.PacManPartyGame", package.seeall)

local PacManPartyGame = class("PacManPartyGame", PartyGameBase)

function PacManPartyGame:getGameViewName()
	return ViewName.CoinGrabbingGameGameView
end

function PacManPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return (PartyGameCSDefine.PacManInterface.GetPlayerCoinBagValue(uid))
end

return PacManPartyGame

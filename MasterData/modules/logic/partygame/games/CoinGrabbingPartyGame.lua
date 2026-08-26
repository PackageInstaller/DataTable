-- chunkname: @modules/logic/partygame/games/CoinGrabbingPartyGame.lua

module("modules.logic.partygame.games.CoinGrabbingPartyGame", package.seeall)

local CoinGrabbingPartyGame = class("CoinGrabbingPartyGame", PartyGameBase)

function CoinGrabbingPartyGame:getGameViewName()
	return ViewName.CoinGrabbingGameGameView
end

function CoinGrabbingPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return PartyGameCSDefine.CoinGrabbingInterfaceCs.GetPlayerCoinBagValue(uid)
end

return CoinGrabbingPartyGame

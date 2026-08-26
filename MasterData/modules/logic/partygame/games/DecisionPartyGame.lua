-- chunkname: @modules/logic/partygame/games/DecisionPartyGame.lua

module("modules.logic.partygame.games.DecisionPartyGame", package.seeall)

local DecisionPartyGame = class("DecisionPartyGame", PartyGameBase)

function DecisionPartyGame:getGameViewName()
	return ViewName.DecisionGameView
end

function DecisionPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return (PartyGameCSDefine.DecisionGameInterfaceCs.GetPlayerScore(uid))
end

return DecisionPartyGame

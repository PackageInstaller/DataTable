-- chunkname: @modules/logic/partygame/games/SecurityPartyGame.lua

module("modules.logic.partygame.games.SecurityPartyGame", package.seeall)

local SecurityPartyGame = class("SecurityPartyGame", PartyGameBase)

function SecurityPartyGame:getGameViewName()
	return ViewName.SecurityGameView
end

function SecurityPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return (PartyGameCSDefine.SecurityGameInterfaceCs.GetPlayerScore(uid))
end

return SecurityPartyGame

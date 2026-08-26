-- chunkname: @modules/logic/partygame/games/SnatchPlaidPartyGame.lua

module("modules.logic.partygame.games.SnatchPlaidPartyGame", package.seeall)

local SnatchPlaidPartyGame = class("SnatchPlaidPartyGame", PartyGameBase)

function SnatchPlaidPartyGame:getGameViewName()
	return ViewName.SnatchPlaidGameView
end

function SnatchPlaidPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return (PartyGameCSDefine.SnatchPlaidGameInterfaceCs.GetPlayerScore(uid))
end

return SnatchPlaidPartyGame

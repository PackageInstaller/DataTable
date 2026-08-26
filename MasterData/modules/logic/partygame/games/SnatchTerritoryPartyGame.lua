-- chunkname: @modules/logic/partygame/games/SnatchTerritoryPartyGame.lua

module("modules.logic.partygame.games.SnatchTerritoryPartyGame", package.seeall)

local SnatchTerritoryPartyGame = class("SnatchTerritoryPartyGame", PartyGameBase)

function SnatchTerritoryPartyGame:getGameViewName()
	return ViewName.SnatchTerritoryGameView
end

function SnatchTerritoryPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return (PartyGameCSDefine.SnatchTerritoryGameInterfaceCs.GetPlayerScore(uid))
end

return SnatchTerritoryPartyGame

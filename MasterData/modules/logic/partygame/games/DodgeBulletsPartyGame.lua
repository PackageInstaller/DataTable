-- chunkname: @modules/logic/partygame/games/DodgeBulletsPartyGame.lua

module("modules.logic.partygame.games.DodgeBulletsPartyGame", package.seeall)

local DodgeBulletsPartyGame = class("DodgeBulletsPartyGame", PartyGameBase)

function DodgeBulletsPartyGame:getGameViewName()
	return ViewName.DodgeBulletsGameView
end

function DodgeBulletsPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	local hitCount, lastHitTime = PartyGameCSDefine.DodgeBulletsGameInterfaceCs.GetPlayerHitCount(uid, 0, 0)

	return (hitCount > 0 or nil) and (-hitCount or 0)
end

return DodgeBulletsPartyGame

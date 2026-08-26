-- chunkname: @modules/logic/partygame/games/JengaPartyGame.lua

module("modules.logic.partygame.games.JengaPartyGame", package.seeall)

local JengaPartyGame = class("JengaPartyGame", PartyGameBase)

function JengaPartyGame:getGameViewName()
	return ViewName.JengaGameView
end

function JengaPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return (PartyGameCSDefine.JengaGameInterfaceCs.GetPlayerScore(uid))
end

return JengaPartyGame

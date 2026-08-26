-- chunkname: @modules/logic/partygame/games/CollatingSortPartyGame.lua

module("modules.logic.partygame.games.CollatingSortPartyGame", package.seeall)

local CollatingSortPartyGame = class("CollatingSortPartyGame", PartyGameBase)

function CollatingSortPartyGame:onScenePrepared()
	local CollatingSortGameInterface = PartyGame.Runtime.Games.CollatingSort.CollatingSortGameInterface
	local list = PartyGameModel.instance:getCurGamePlayerList()

	CollatingSortGameInterface.InitEntryList(#list)

	for i, v in ipairs(list) do
		CollatingSortGameInterface.SetUid(i - 1, v.uid)
	end

	CollatingSortPartyGame.super.onScenePrepared(self)
end

function CollatingSortPartyGame:getGameViewName()
	return ViewName.CollatingSortGameView
end

function CollatingSortPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	return (PartyGameCSDefine.CollatingSortGameInterface.GetPlayerScore(uid))
end

return CollatingSortPartyGame

-- chunkname: @modules/logic/partygame/games/WayFindingPartyGame.lua

module("modules.logic.partygame.games.WayFindingPartyGame", package.seeall)

local WayFindingPartyGame = class("WayFindingPartyGame", PartyGameBase)

function WayFindingPartyGame:getGameViewName()
	return ViewName.WayFindingGameView
end

function WayFindingPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return luaLang("partygame_game2_unfinish")
	end

	local time = PartyGameCSDefine.WayFindingGameInterfaceCs.GetPlayerFinishTime(uid)

	if time <= 0 then
		return luaLang("partygame_game2_unfinish")
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_game2_finishtime"), self._gameTime - Mathf.Round(time * 10) / 10), true
end

return WayFindingPartyGame

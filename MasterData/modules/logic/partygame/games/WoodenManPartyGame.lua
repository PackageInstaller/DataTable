-- chunkname: @modules/logic/partygame/games/WoodenManPartyGame.lua

module("modules.logic.partygame.games.WoodenManPartyGame", package.seeall)

local WoodenManPartyGame = class("WoodenManPartyGame", PartyGameBase)

function WoodenManPartyGame:getGameViewName()
	return ViewName.WoodenManGameView
end

function WoodenManPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	local time, dis = PartyGameCSDefine.WoodenManGameInterfaceCs.GetPlayerTimeAndDis(uid, 0, 0)

	if time > 0 then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_game2_finishtime"), self._gameTime - Mathf.Round(time * 10) / 10), true
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_game4_dis"), math.ceil(dis))
end

return WoodenManPartyGame

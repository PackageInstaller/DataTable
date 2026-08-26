-- chunkname: @modules/logic/partygame/games/SplicingRoadPartyGame.lua

module("modules.logic.partygame.games.SplicingRoadPartyGame", package.seeall)

local SplicingRoadPartyGame = class("SplicingRoadPartyGame", PartyGameBase)

function SplicingRoadPartyGame:getGameViewName()
	return ViewName.SplicingRoadGameView
end

function SplicingRoadPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	local dis = PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetPlayerDis(uid)

	if dis == 0 then
		return luaLang("partygame_game19_finish"), true
	else
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_game19_dis"), dis)
	end
end

return SplicingRoadPartyGame

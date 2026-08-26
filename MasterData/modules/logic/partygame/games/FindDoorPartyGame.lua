-- chunkname: @modules/logic/partygame/games/FindDoorPartyGame.lua

module("modules.logic.partygame.games.FindDoorPartyGame", package.seeall)

local FindDoorPartyGame = class("FindDoorPartyGame", PartyGameBase)

function FindDoorPartyGame:getGameViewName()
	return ViewName.FindDoorGameView
end

function FindDoorPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	local finishTime = PartyGameCSDefine.FindDoorGameInterfaceCs.GetPlayerData(uid, 0, 0)

	if finishTime > 0 then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_game13_finishTime"), self._gameTime - math.ceil(finishTime)), true
	end

	local showLayer = PartyGameHelper.instance:getComponentData(uid, "PartyGame.Runtime.Games.FindDoor.Component.FindDoorPlayerDataComponent", "showLayer")

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_game13_layer"), showLayer)
end

return FindDoorPartyGame

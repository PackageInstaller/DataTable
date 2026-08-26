-- chunkname: @modules/logic/partygame/games/PartyGameUtils.lua

module("modules.logic.partygame.games.PartyGameUtils", package.seeall)

local PartyGameUtils = class("PartyGameUtils")
local idToCls

function PartyGameUtils.getGameDefineClass(gameId)
	idToCls = idToCls or {}

	local var_1_0 = idToCls[gameId]

	if not idToCls[gameId] then
		var_1_0 = PartyGameEnum.GameIdToName[gameId]

		if PartyGameEnum.GameIdToName[gameId] then
			local cls = _G[string.format("%sPartyGame", PartyGameEnum.GameIdToName[gameId])]

			if not cls then
				cls = PartyGameBase

				logError("未定义 " .. gameId .. "的游戏类")
			end

			return cls.New()
		end
	end
end

return PartyGameUtils

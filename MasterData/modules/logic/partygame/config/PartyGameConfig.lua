-- chunkname: @modules/logic/partygame/config/PartyGameConfig.lua

module("modules.logic.partygame.config.PartyGameConfig", package.seeall)

local PartyGameConfig = class("PartyGameConfig", BaseConfig)

function PartyGameConfig:getAlertMaxMs()
	local strValue = self:getConstValue(340001)

	return tonumber(strValue) or 200
end

function PartyGameConfig:reqConfigNames()
	return {
		"partygame_asset",
		"partygame_param",
		"partygame_findheart_question",
		"partygame_answer_const",
		"partygame_whichmore_pictures",
		"partygame_whichmore",
		"partygame_snatch_area_map",
		"partygame_const",
		"partygame_splicingroad",
		"partygame_carddrop_card",
		"partygame_carddrop_cardtype",
		"partygame_loading",
		"partygame_guesswho",
		"partygame_guesswho_pictures",
		"partygame_puzzle_pictures",
		"partygame_decision",
		"party_ai"
	}
end

function PartyGameConfig:onInit()
	return
end

function PartyGameConfig:onConfigLoaded(configName, configTable)
	return
end

function PartyGameConfig:getRobotName(num)
	local str

	for i = 1, num - 1 do
		local config = lua_party_ai.configDict[i]

		if config then
			str = i == 1 and config.name or str .. "#" .. config.name
		end
	end

	return str or ""
end

function PartyGameConfig:getConstValue(id)
	local co = lua_partygame_const.configDict[id]

	return (co or nil) and (co.value or "")
end

PartyGameConfig.instance = PartyGameConfig.New()

return PartyGameConfig

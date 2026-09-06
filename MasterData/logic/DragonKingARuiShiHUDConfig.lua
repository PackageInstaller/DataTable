-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/config/DragonKingARuiShiHUDConfig.lua

module("logic.extensions.dragonkingaruishihud.config.DragonKingARuiShiHUDConfig", package.seeall)

local DragonKingARuiShiHUDConfig = class("DragonKingARuiShiHUDConfig", BaseConfig)

function DragonKingARuiShiHUDConfig:getNames()
	return {
		"dragon_king_aruishi_question_bank",
		"dragon_king_aruishi_hud_activity"
	}
end

function DragonKingARuiShiHUDConfig:handleConfig(name, content)
	if name == "dragon_king_aruishi_question_bank" then
		self._dragon_king_aruishi_question_bank = content
	elseif name == "dragon_king_aruishi_hud_activity" then
		self._dragon_king_aruishi_hud_activity = content
	end
end

function DragonKingARuiShiHUDConfig:getActviityCfg(activityId)
	return self._dragon_king_aruishi_hud_activity[activityId]
end

function DragonKingARuiShiHUDConfig:getQuestionBankCfg(planId)
	return self._dragon_king_aruishi_question_bank[planId]
end

DragonKingARuiShiHUDConfig.instance = DragonKingARuiShiHUDConfig.New()

return DragonKingARuiShiHUDConfig

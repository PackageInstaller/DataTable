-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/config/DivineHaloGameConfig.lua

module("logic.extensions.divinehalogame.config.DivineHaloGameConfig", package.seeall)

local DivineHaloGameConfig = class("DivineHaloGameConfig", BaseConfig)

function DivineHaloGameConfig:onInit()
	DivineHaloGameConfig.super.onInit(self)
end

function DivineHaloGameConfig:getNames()
	return {
		"divine_halo_game_activity",
		"divine_halo_game_stage",
		"divine_halo_game_buy_times",
		"divine_halo_game_rule"
	}
end

function DivineHaloGameConfig:handleConfig(name, content)
	if name == "divine_halo_game_activity" then
		self._divine_halo_game_activity = content
	elseif name == "divine_halo_game_stage" then
		self._divine_halo_game_stage = content
	elseif name == "divine_halo_game_buy_times" then
		self._divine_halo_game_buy_times = content
	elseif name == "divine_halo_game_rule" then
		self._divine_halo_game_rule = content
	end
end

function DivineHaloGameConfig:getActData(activityId)
	return self._divine_halo_game_activity[activityId]
end

function DivineHaloGameConfig:getStageDatas(activityId)
	return self._divine_halo_game_stage[activityId]
end

function DivineHaloGameConfig:getStageDataById(activityId, stageId)
	return self._divine_halo_game_stage[activityId] and self._divine_halo_game_stage[activityId][stageId]
end

function DivineHaloGameConfig:getBuyTimeDataByBuyTime(activityId, buyTime)
	return self._divine_halo_game_buy_times[activityId] and self._divine_halo_game_buy_times[activityId][buyTime]
end

function DivineHaloGameConfig:getRuleDataById(ruleId)
	return self._divine_halo_game_rule[ruleId]
end

DivineHaloGameConfig.instance = DivineHaloGameConfig.New()

return DivineHaloGameConfig

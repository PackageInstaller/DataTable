-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/config/PlanetariumConfig.lua

module("logic.extensions.planetarium.config.PlanetariumConfig", package.seeall)

local PlanetariumConfig = class("PlanetariumConfig", BaseConfig)

function PlanetariumConfig:onInit()
	PlanetariumConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PlanetariumConfig:getNames()
	return {
		"planetarium_game_activity",
		"planetarium_game_prize",
		"planetarium_game_stage",
		"planetarium_game",
		"planetarium_game_rule"
	}
end

function PlanetariumConfig:handleConfig(name, content)
	if name == "planetarium_game_activity" then
		self._planetariumActCfg = content
	elseif name == "planetarium_game_prize" then
		self._planetariumGamePrizeCfg = content
	elseif name == "planetarium_game_stage" then
		self._planetariumStageCfg = content
	elseif name == "planetarium_game" then
		self._planetariumGameCfg = content
	elseif name == "planetarium_game_rule" then
		self._planetariumRuleCfg = content
	end
end

function PlanetariumConfig:getPrizeCfgById(activityId)
	return self._planetariumGamePrizeCfg[activityId]
end

function PlanetariumConfig:getGameCfgByStageId(activityId, stageId)
	return self._planetariumStageCfg[activityId][stageId]
end

function PlanetariumConfig:getStageCfgById(activityId)
	return self._planetariumStageCfg[activityId]
end

function PlanetariumConfig:getGameRingCfgById(stageId, ringId)
	return self._planetariumGameCfg[stageId][ringId]
end

function PlanetariumConfig:getRulePlanId(activityId)
	return self._planetariumActCfg[activityId].rulePlanId
end

function PlanetariumConfig:getGameRuleCfg(rulePlanId)
	return self._planetariumRuleCfg[rulePlanId]
end

PlanetariumConfig.instance = PlanetariumConfig.New()

return PlanetariumConfig

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/WaterLightHeroTowerConfig.lua

module("logic.extensions.timelimitedchallenge.config.WaterLightHeroTowerConfig", package.seeall)

local WaterLightHeroTowerConfig = class("WaterLightHeroTowerConfig", BaseConfig)

function WaterLightHeroTowerConfig:onInit()
	WaterLightHeroTowerConfig.super.onInit(self)
end

function WaterLightHeroTowerConfig:getNames()
	return {
		"water_light_hero_tower",
		"water_light_hero_tower_power",
		"water_light_hero_tower_wisdom",
		"water_light_hero_tower_support",
		"water_light_hero_tower_master",
		"water_light_hero_tower_creeps",
		"water_light_hero_tower_prize",
		"water_light_hero_tower_buff"
	}
end

function WaterLightHeroTowerConfig:handleConfig(name, content)
	if name == "water_light_hero_tower" then
		self._cfg = content
	elseif name == "water_light_hero_tower_power" then
		self._powerCfg = content
	elseif name == "water_light_hero_tower_wisdom" then
		self._wisdomCfg = content
	elseif name == "water_light_hero_tower_support" then
		self._supportCfg = content
	elseif name == "water_light_hero_tower_master" then
		self._masterCfg = content
	elseif name == "water_light_hero_tower_creeps" then
		self._creepsCfg = content
	elseif name == "water_light_hero_tower_prize" then
		self._prizeCfg = content
	elseif name == "water_light_hero_tower_buff" then
		self._buffCfg = content
	end
end

function WaterLightHeroTowerConfig:getCfgById(id)
	return self._cfg[id]
end

function WaterLightHeroTowerConfig:getPowerById(id)
	return self._powerCfg[id]
end

function WaterLightHeroTowerConfig:getWisdomById(id)
	return self._wisdomCfg[id]
end

function WaterLightHeroTowerConfig:getSupportById(id)
	return self._supportCfg[id]
end

function WaterLightHeroTowerConfig:getMasterById(id)
	return self._masterCfg[id]
end

function WaterLightHeroTowerConfig:getCreepsById(creepMasterId)
	return self._creepsCfg[creepMasterId]
end

function WaterLightHeroTowerConfig:getPrizeById(id)
	return self._prizeCfg[id]
end

function WaterLightHeroTowerConfig:getBuffById(challengeId, id)
	if self._buffCfg[challengeId] then
		return self._buffCfg[challengeId][id]
	end
end

WaterLightHeroTowerConfig.instance = WaterLightHeroTowerConfig.New()

return WaterLightHeroTowerConfig

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclemultiplied/config/MiracleMultipliedConfig.lua

module("logic.extensions.miraclemultiplied.config.MiracleMultipliedConfig", package.seeall)

local MiracleMultipliedConfig = class("MiracleMultipliedConfig", BaseConfig)

function MiracleMultipliedConfig:onInit()
	MiracleMultipliedConfig.super.onInit(self)
end

function MiracleMultipliedConfig:getNames()
	return {
		"miracle_multiplied_activity",
		"miracle_multiplied_race",
		"miracle_multiplied_collect"
	}
end

function MiracleMultipliedConfig:handleConfig(name, content)
	if name == "miracle_multiplied_activity" then
		self.miracle_multiplied_activity = content
	elseif name == "miracle_multiplied_race" then
		self.miracle_multiplied_race = content
	elseif name == "miracle_multiplied_collect" then
		self.miracle_multiplied_collect = content
	end
end

function MiracleMultipliedConfig:getActData(activityId)
	return self.miracle_multiplied_activity[activityId]
end

function MiracleMultipliedConfig:getRaceCfg(activityId)
	return self.miracle_multiplied_race[activityId]
end

function MiracleMultipliedConfig:getRaceData(activityId, raceId)
	if self.miracle_multiplied_race[activityId] then
		return self.miracle_multiplied_race[activityId][raceId]
	end
end

function MiracleMultipliedConfig:getCollectCfg(activityId)
	return self.miracle_multiplied_collect[activityId]
end

function MiracleMultipliedConfig:getCollectData(activityId, collectId)
	if self.miracle_multiplied_collect[activityId] then
		return self.miracle_multiplied_collect[activityId][collectId]
	end
end

MiracleMultipliedConfig.instance = MiracleMultipliedConfig.New()

return MiracleMultipliedConfig

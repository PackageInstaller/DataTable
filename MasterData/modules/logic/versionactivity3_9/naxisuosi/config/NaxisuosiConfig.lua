-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/config/NaxisuosiConfig.lua

module("modules.logic.versionactivity3_9.naxisuosi.config.NaxisuosiConfig", package.seeall)

local NaxisuosiConfig = class("NaxisuosiConfig", BaseConfig)

function NaxisuosiConfig:ctor()
	self._nxssMap = nil
	self._episodeList = nil
end

function NaxisuosiConfig:reqConfigNames()
	return {
		"activity220_nxss_map"
	}
end

function NaxisuosiConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_nxss_map" then
		self._nxssMap = configTable
	end
end

function NaxisuosiConfig:getMapCo(activityId, id)
	local episodeConfig = Activity220Config.instance:getEpisodeConfig(activityId, id)

	if not episodeConfig then
		return nil
	end

	if self._nxssMap and self._nxssMap.configDict[activityId] then
		return self._nxssMap.configDict[activityId][episodeConfig.gameId]
	end

	return nil
end

function NaxisuosiConfig:getEpisodeConfig(episodeId)
	local actId = VersionActivity3_9Enum.ActivityId.Naxisuosi

	return Activity220Config.instance:getEpisodeConfig(actId, episodeId)
end

function NaxisuosiConfig:getEpisodeConfigList()
	local actId = VersionActivity3_9Enum.ActivityId.Naxisuosi

	return Activity220Config.instance:getEpisodeConfigList(actId)
end

function NaxisuosiConfig:getEpisodeIndex(episodeId)
	local actId = VersionActivity3_9Enum.ActivityId.Naxisuosi

	return Activity220Config.instance:getEpisodeIndex(actId, episodeId)
end

NaxisuosiConfig.instance = NaxisuosiConfig.New()

return NaxisuosiConfig

-- chunkname: @modules/logic/stat/config/StatConfig.lua

module("modules.logic.stat.config.StatConfig", package.seeall)

local StatConfig = class("StatConfig", BaseConfig)

function StatConfig:reqConfigNames()
	return {
		"stat_event_ignore"
	}
end

function StatConfig:onConfigLoaded(configName, configTable)
	if configName == "stat_event_ignore" then
		self._statEventIgnoreConfig = configTable
	end
end

function StatConfig:getEventIgnoreList()
	return self._statEventIgnoreConfig and self._statEventIgnoreConfig.configList
end

StatConfig.instance = StatConfig.New()

return StatConfig

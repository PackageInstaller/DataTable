-- chunkname: @modules/logic/versionactivity2_8/act200/config/Activity2ndTakePhotosConfig.lua

module("modules.logic.versionactivity2_8.act200.config.Activity2ndTakePhotosConfig", package.seeall)

local Activity2ndTakePhotosConfig = class("Activity2ndTakePhotosConfig", BaseConfig)

function Activity2ndTakePhotosConfig:reqConfigNames()
	return {
		"activity200"
	}
end

function Activity2ndTakePhotosConfig:onInit()
	self._config = {}
end

function Activity2ndTakePhotosConfig:onConfigLoaded(configName, configTable)
	if configName == "activity200" then
		self._config = configTable
	end
end

function Activity2ndTakePhotosConfig:getConfigList()
	return self._config.configList
end

function Activity2ndTakePhotosConfig:getConfigById(id)
	return self._config.configList[id]
end

Activity2ndTakePhotosConfig.instance = Activity2ndTakePhotosConfig.New()

return Activity2ndTakePhotosConfig

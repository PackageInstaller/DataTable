-- chunkname: @modules/logic/antique/config/AntiqueConfig.lua

module("modules.logic.antique.config.AntiqueConfig", package.seeall)

local AntiqueConfig = class("AntiqueConfig", BaseConfig)

function AntiqueConfig:ctor()
	self._antiqueConfig = nil
end

function AntiqueConfig:reqConfigNames()
	return {
		"antique"
	}
end

function AntiqueConfig:onConfigLoaded(configName, configTable)
	if configName == "antique" then
		self._antiqueConfig = configTable
	end
end

function AntiqueConfig:getAntiquesCo()
	return self._antiqueConfig.configDict
end

function AntiqueConfig:getAntiqueCo(antiqueId)
	return self._antiqueConfig.configDict[antiqueId]
end

AntiqueConfig.instance = AntiqueConfig.New()

return AntiqueConfig

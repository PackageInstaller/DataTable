-- chunkname: @modules/logic/summonsimulationpick/config/SummonSimulationPickConfig.lua

module("modules.logic.summonsimulationpick.config.SummonSimulationPickConfig", package.seeall)

local SummonSimulationPickConfig = class("SummonSimulationPickConfig", BaseConfig)

SummonSimulationPickConfig.ACTIVITY_CONFIG_NAME = "activity221"

function SummonSimulationPickConfig:reqConfigNames()
	return {
		self.ACTIVITY_CONFIG_NAME
	}
end

function SummonSimulationPickConfig:onInit()
	self._summonSimulationPickConfig = nil
end

function SummonSimulationPickConfig:onConfigLoaded(configName, configTable)
	if configName == self.ACTIVITY_CONFIG_NAME then
		self._summonSimulationPickConfig = configTable
	end
end

function SummonSimulationPickConfig:getAllConfig()
	return self._summonSimulationPickConfig.configList
end

function SummonSimulationPickConfig:getSummonConfig()
	return self._summonSimulationPickConfig
end

function SummonSimulationPickConfig:getSummonConfigById(activityId)
	return self._summonSimulationPickConfig.configDict[activityId]
end

SummonSimulationPickConfig.instance = SummonSimulationPickConfig.New()

return SummonSimulationPickConfig

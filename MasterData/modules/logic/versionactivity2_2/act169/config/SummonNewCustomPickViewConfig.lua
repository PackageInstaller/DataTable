-- chunkname: @modules/logic/versionactivity2_2/act169/config/SummonNewCustomPickViewConfig.lua

module("modules.logic.versionactivity2_2.act169.config.SummonNewCustomPickViewConfig", package.seeall)

local SummonNewCustomPickViewConfig = class("SummonNewCustomPickViewConfig", BaseConfig)

SummonNewCustomPickViewConfig.ACTIVITY_CONFIG_169 = "activity169"

function SummonNewCustomPickViewConfig:reqConfigNames()
	return {
		self.ACTIVITY_CONFIG_169
	}
end

function SummonNewCustomPickViewConfig:onInit()
	self._summonNewPickConfig = nil
end

function SummonNewCustomPickViewConfig:onConfigLoaded(configName, configTable)
	if configName == self.ACTIVITY_CONFIG_169 then
		self._summonNewPickConfig = configTable
	end
end

function SummonNewCustomPickViewConfig:getAllConfig()
	return self._summonNewPickConfig.configList
end

function SummonNewCustomPickViewConfig:getSummonConfig()
	return self._summonNewPickConfig
end

function SummonNewCustomPickViewConfig:getSummonConfigById(activityId)
	return self._summonNewPickConfig.configDict[activityId]
end

SummonNewCustomPickViewConfig.instance = SummonNewCustomPickViewConfig.New()

return SummonNewCustomPickViewConfig

-- chunkname: @modules/logic/permanent/config/PermanentConfig.lua

module("modules.logic.permanent.config.PermanentConfig", package.seeall)

local PermanentConfig = class("PermanentConfig", BaseConfig)

function PermanentConfig:ctor()
	return
end

function PermanentConfig:reqConfigNames()
	return {
		"permanent"
	}
end

function PermanentConfig:onConfigLoaded(configName, configTable)
	if configName == "permanent" then
		self._permanentConfig = configTable
	end
end

function PermanentConfig:getKvIconName(actId)
	local perActCfg = self:getPermanentCO(actId)

	return perActCfg.kvIcon
end

function PermanentConfig:getPermanentDic()
	return self._permanentConfig.configDict
end

function PermanentConfig:getPermanentCO(actId)
	local config = self._permanentConfig.configDict[actId]

	if not config then
		logError("config permanent no activityId" .. actId)
	end

	return config
end

PermanentConfig.instance = PermanentConfig.New()

return PermanentConfig

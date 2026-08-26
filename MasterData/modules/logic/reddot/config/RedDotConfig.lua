-- chunkname: @modules/logic/reddot/config/RedDotConfig.lua

module("modules.logic.reddot.config.RedDotConfig", package.seeall)

local RedDotConfig = class("RedDotConfig", BaseConfig)

function RedDotConfig:ctor()
	self._dotConfig = nil
end

function RedDotConfig:reqConfigNames()
	return {
		"reddot"
	}
end

function RedDotConfig:onConfigLoaded(configName, configTable)
	if configName == "reddot" then
		self._dotConfig = configTable
	end
end

function RedDotConfig:getRedDotsCO()
	return self._dotConfig.configDict
end

function RedDotConfig:getRedDotCO(id)
	return self._dotConfig.configDict[id]
end

function RedDotConfig:getParentRedDotId(id)
	local CO = self:getRedDotCO(id)

	return (CO or nil) and (CO.parent or 0)
end

RedDotConfig.instance = RedDotConfig.New()

return RedDotConfig

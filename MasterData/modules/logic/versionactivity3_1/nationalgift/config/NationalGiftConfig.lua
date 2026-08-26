-- chunkname: @modules/logic/versionactivity3_1/nationalgift/config/NationalGiftConfig.lua

module("modules.logic.versionactivity3_1.nationalgift.config.NationalGiftConfig", package.seeall)

local NationalGiftConfig = class("NationalGiftConfig", BaseConfig)

function NationalGiftConfig:ctor()
	self._constConfig = nil
	self._bonusConfig = nil
end

function NationalGiftConfig:reqConfigNames()
	return {
		"activity212_const",
		"activity212_bonus"
	}
end

function NationalGiftConfig:onConfigLoaded(configName, configTable)
	if configName == "activity212_const" then
		self._constConfig = configTable
	elseif configName == "activity212_bonus" then
		self._bonusConfig = configTable
	end
end

function NationalGiftConfig:getConstCO(id, actId)
	actId = actId or NationalGiftModel.instance:getCurVersionActId()

	return self._constConfig.configDict[actId][id]
end

function NationalGiftConfig:getBonusCo(bonusId, actId)
	actId = actId or NationalGiftModel.instance:getCurVersionActId()

	return self._bonusConfig.configDict[actId][bonusId]
end

function NationalGiftConfig:getBonusCos(actId)
	actId = actId or NationalGiftModel.instance:getCurVersionActId()

	return self._bonusConfig.configDict[actId]
end

NationalGiftConfig.instance = NationalGiftConfig.New()

return NationalGiftConfig

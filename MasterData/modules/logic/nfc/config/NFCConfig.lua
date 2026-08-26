-- chunkname: @modules/logic/nfc/config/NFCConfig.lua

module("modules.logic.nfc.config.NFCConfig", package.seeall)

local NFCConfig = class("NFCConfig", BaseConfig)

function NFCConfig:reqConfigNames()
	return {
		"nfc_recognize"
	}
end

function NFCConfig:onInit()
	return
end

function NFCConfig:onConfigLoaded(configName, configTable)
	if configName == "nfc_recognize" then
		self._nfcRecognizeConfig = configTable
	end
end

function NFCConfig:getNFCRecognizeCo(id)
	return self._nfcRecognizeConfig.configDict[id]
end

NFCConfig.instance = NFCConfig.New()

return NFCConfig

-- chunkname: @modules/logic/currencyexchange/config/CurrencyExchangeConfig.lua

module("modules.logic.currencyexchange.config.CurrencyExchangeConfig", package.seeall)

local CurrencyExchangeConfig = class("CurrencyExchangeConfig", BaseConfig)

function CurrencyExchangeConfig:reqConfigNames()
	return {
		"same_currency_exchange"
	}
end

function CurrencyExchangeConfig:onInit()
	self._storeId2CurrencyIdDic = nil
	self._currencyExchangeConfig = nil
end

function CurrencyExchangeConfig:onConfigLoaded(configName, configTable)
	if configName == "same_currency_exchange" then
		self._currencyExchangeConfig = configTable
	end
end

function CurrencyExchangeConfig:getExchangeConfig(currencyId)
	if not self._currencyExchangeConfig then
		return
	end

	return self._currencyExchangeConfig.configDict[currencyId]
end

function CurrencyExchangeConfig:getExchangeCurrencyIdByStoreId(storeId)
	if not self._storeId2CurrencyIdDic then
		self._storeId2CurrencyIdDic = {}

		for _, config in ipairs(self._currencyExchangeConfig.configList) do
			self._storeId2CurrencyIdDic[tonumber(config.storeEntranceId)] = config.currencyId
		end
	end

	return self._storeId2CurrencyIdDic[storeId]
end

CurrencyExchangeConfig.instance = CurrencyExchangeConfig.New()

return CurrencyExchangeConfig
